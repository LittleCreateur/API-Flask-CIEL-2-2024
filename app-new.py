from random import randint
from flask import Flask, request, jsonify 
import mariadb
from _mysql_connector import *

from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity, get_jwt
from flask_jwt_extended import jwt_required
from flask_jwt_extended import JWTManager

# Connect to MariaDB Platform
conn = mariadb.connect(
    user="monapi",
    password="1234",
    host="10.40.1.31",
    port=3306,
    database="cantine"
)

@app.route("/conso")

def identification(num_carte) :
        with mariadb.connect(**conn_params) as ma_connexion :
            with ma_connexion.cursor() as cursor :
                params = (num_carte,)
                requete = 'SELECT Affectation_carte.id_personne FROM Affectation_carte WHERE Affectation_carte.id_carte = ? and Affectation_carte.date_fin = null;'
                cursor.execute(requete.params)
                resultat = cursor.fetchone()
            return("rep" : str(resultat[0]))
                

app = Flask(__name__)

def login():
    # Récupération des paramètres
    username = request.json.get("email", None)
    password = request.json.get("password", None)
    if username != "test" or password != "test":
        try :
            cursor.execute(requete,params)
            if 

@app.route("/conso/num_cartes")
def conso(num_carte):
    #return("rep" : str(num_carte))
    
@app.route('/conso/<num_carte>')
def show_user_profile(username):
    # show the user profile for that user
    return f'User {escape(username)}'

@app.route("/")
def hello():
    with mariadb.connect(**conn_params) as ma_connexion :
            with ma_connexion.cursor() as cursor :
                cursor.execute("SELECT * FROM Site;")
                resultats = cursor.fetchall()
                noms_sites = []
                for data_site in resultats :
                    noms_sites.append(data_site[1])
            return("rep" : str(noms_sites))

@app.route('/' , methods=['GET', 'POST'])
def helloworld():
    with mysql.connector.connect(**db_config) as conn:
        with conn.cursor(dictionary=True) as cursor:
            cursor.execute("SELECT * FROM Personne;")
            return cursor.fetchall()

@app.route('/test', methods=['GET', 'POST'])
def test():
    num_lecteur = request.args.get('num_lecteur', '')
    num_carte = request.args.get('num_carte', '')
    
    return {"id_lecteur": request.form.get("num_lecteur", ''), "id_carte": request.form.get("num_carte", '')}

@app.route('/transaction', methods=['GET', 'POST'])
def transaction():
    montant = request.args.get('num_lecteur', '')
    personnel = request.args.get('num_carte', '')
    client = request.args.get('num_carte', '')
    réf = request.args.get('num_carte', '')
    
    return {"id_lecteur": request.form.get("num_lecteur", ''), "id_carte": request.form.get("num_carte", '')}


@app.route('/conso_repas', methods=['GET', 'POST'])
def identification():
    num_lecteur = request.form.get('num_lecteur', '')
    num_carte = request.form.get('num_carte', '')

    with mysql.connector.connect(**db_config) as conn:
        with conn.cursor(dictionary=True) as cursor:
            
            query1 = """
                    START TRANSACTION;
                    
                    UPDATE 
                        Personne 
                    SET 
                        Personne.nb_credits = nb_credits - 1 
                    WHERE 
                        Personne.id_personne = (
                            SELECT 
                                Affectation_carte.id_personne 
                            FROM 
                                Affectation_carte 
                            WHERE 
                                Affectation_carte.id_carte = %s 
                                AND Affectation_carte.date_fin IS NULL) 
                    AND Personne.nb_credits > (-1)*(
                        SELECT seuil_découvert 
                        FROM Parametres);
                    
                    INSERT INTO Consomation_repas(id_carte, id_lecteur, date) VALUES (%s, %s, NOW());"""
            
            query_verif = """
                        """
            cursor.execute(query1, (num_carte,))
            
            if :
                cursor.execute(query2, (num_carte, num_lecteur))
                conn.commit()
                return {"rep" : True}
            return {"rep" : False}
        
@app.route("/testjwt", methods=["GET"])
@jwt_required()
def protected():
    # Access the identity of the current user with get_jwt_identity
    current_user = get_jwt_identity()
    data_jwt = get_jwt()
    return jsonify(current_user, data_jwt["id_role"]), 200

if __name__ == "__main__":
    app.run