from flask import Flask, request
from random import randint
import mariadb
#https://mariadb.com/docs/server/connect/programming-languages/python/transactions/

app = Flask(__name__)

conn_params= {
    "user" : "monapi",
    "password" : "1234",
    "host" : "10.40.1.31",
    "database" : "dumpcantine"
}

def login():
    # Récupération des paramètres
    username = request.json.get("email", None)
    password = request.json.get("password", None)
    if username != "test" or password != "test":
    
    try :
        cursor.execute(requete, params)
        if cursor.execute.rowcount == 1 :
            #recup depuis le résultat de la requête des infos sur l'utilisateur
            ligne = cursor.fetchone()
            id_personne = ligne[0]
    except:
        return jsonify({"msg": "Bad username or password"}), 401
        


@app.route("/test",methods=['POST'])
def test():
    num_lecteur = request.form.get('num_lecteur')
    num_carte = request.form.get('num_carte')
    return {"rep" : num_lecteur +" " + num_carte}    

def conso(num_lecteur, num_carte) :
    with mariadb.connect(**conn_params) as ma_connexion :
        with ma_connexion.cursor() as cursor :
            params1 = (num_carte,)
            requete1 = """ 
            UPDATE Personne
                SET
                    Personne.nb_credits = Personne.nb_credits -1
                WHERE
                    Personne.id_personne = 
                        (   SELECT 
                                Affectation_carte.id_personne
                            FROM 
                                Affectation_carte
                            WHERE
                                Affectation_carte.id_carte LIKE ? 
                                and
                                Affectation_carte.date_fin IS NULL
                        )
                    and
                    Personne.nb_credits > (-1)*(
                            SELECT
                                Parametres.seuil_découvert
                            FROM
                                Parametres
                            );
            """
            requete2 = """INSERT INTO Consomation_repas (id_carte, id_lecteur, date) VALUES (?, ?, NOW());"""
            params2 = (num_carte, num_lecteur)
            flag = True
            try :
                cursor.execute(requete1, params1)
                nb_lignes_modifiees = cursor.rowcount
                if nb_lignes_modifiees != 1 :
                    raise
                cursor.execute(requete2,params2)
                ma_connexion.commit()
            except Exception as e:
                ma_connexion.rollback()
                flag = False
            if flag :
                return {"rep" : "OK"}
            return {"rep" : "Pb"}

@app.route("/achat", methods = ['POST'])
def achat():
    id_client = request.form.get('id_client')
    id_personnel = request.form.get('id_personnel')
    montant = request.form.get('montant')
    nb_credits = int(request.form.get('nb_credits'))
    ref_paiement = request.form.get('ref_paiement')
    if nb_credits <= 0 :
        return {"rep" : "Problème prise en compte achat : crédits invalides"}
    #maj crédits dans la table personne   
    params1 = (nb_credits,id_client, id_personnel)
    requete1 = """UPDATE Personne 
                  SET nb_credits = nb_credits + ?
                  WHERE 
                    id_personne = ?
                    AND
                    ? IN (SELECT Personne.id_personne 
                            FROM Personne INNER JOIN Role ON Personne.id_role = Role.id_role
                            WHERE Role.nom LIKE 'personnel');"""                
    #insérer une nouvelle ligne dans la table transaction
    params2= (montant,id_personnel,id_client,ref_paiement,nb_credits)
    requete2 = """INSERT INTO Transaction (montant, personnel,client,ref_paiement,nb_credit_achetes) VALUES (?,?,?,?,?);"""
    params3 =(id_client,)
    requete3 = """SELECT nb_credits
                    FROM Personne
                    WHERE Personne.id_personne = ?"""
    with mariadb.connect(**conn_params) as ma_connexion :
        with ma_connexion.cursor() as cursor :
            flag = False
            new_credits = 0
            try :
                cursor.execute(requete1, params1)
                if cursor.rowcount !=1 :
                    raise
                cursor.execute(requete2,params2)
                if cursor.rowcount !=1 :
                    raise
                ma_connexion.commit()
                cursor.execute(requete3,params3)
                resultats = cursor.fetchall()
                new_credits = resultats[0][0] 
            except Exception as e:
                ma_connexion.rollback()
                flag = True
            if flag :
                return {"rep" : "Problème prise en compte achat"}
            return {"rep" : {"id_client": id_client, "nb_credits" : new_credits}}
            
    

@app.route("/lecteur", methods = ['POST'])
def lecteur():
    #il récupérer le numéro de lecteur et le numéro de la carte
    num_lecteur = request.form.get('num_lecteur')
    num_carte = request.form.get('num_carte')
    with mariadb.connect(**conn_params) as ma_connexion :
        with ma_connexion.cursor() as cursor :
            params = (num_lecteur,)
            requete = """SELECT
                    Type_site.designation_type 
                FROM
                    Affectation_lecteur_site INNER JOIN Site
                                    INNER JOIN Type_site ON Site.id_type = Type_site.id_type_site
                    ON Affectation_lecteur_site.id_site = Site.id_site
                WHERE
                    Affectation_lecteur_site.id_lecteur = ?
                    """
            cursor.execute(requete,params)
            if cursor.rowcount in (0,-1):
                #lecteur non affecté sur un site
                return {"rep" : {"cas": "lecteur non affecté", "num_lecteur" : num_lecteur}}           
            resultats = cursor.fetchall()
            designation_type= resultats[0][0]
            if designation_type == "conso" :
                return conso(num_lecteur, num_carte)
            #cas d'un lecteur admin
            requete = """
                SELECT 
                    Affectation_carte.id_affectation_carte,
                    Affectation_carte.id_personne
                FROM
                    Affectation_carte
                WHERE
                    Affectation_carte.id_carte = ?
                    AND
                    Affectation_carte.date_fin IS NULL
            
            """
            params = (num_carte,)
            cursor.execute(requete,params)
            if cursor.rowcount == 0 :
                #carte non affectée
                return {"rep" : {"cas" : "carte non affectée","num_carte" : num_carte}}
            #carte affectée  
            elif cursor.rowcount > 1 :
                return {"rep" : {"probleme" : "carte affectée à plusieurs personnes"}}
            #selon les cas, on peut avoir besoin de l'id_personne (achat de crédits) ou de l'id_affectation_carte (rendre une carte)
            resultats = cursor.fetchall()
            id_affaction_carte = resultats[0][0]
            id_personne = resultats[0][1]            
            return {"rep" : {"cas":"achat ou retour carte","id_affectation_carte" : id_affaction_carte, "id_personne" : id_personne}}         
        
@app.route("/")
def hello():
    with mariadb.connect(**conn_params) as ma_connexion :
        with ma_connexion.cursor() as cursor :
            cursor.execute("SELECT * FROM Site;")
            resultats = cursor.fetchall()
            noms_sites = []
            for data_site in resultats :
                noms_sites.append(data_site[1])
        return {"rep" : str(noms_sites)}