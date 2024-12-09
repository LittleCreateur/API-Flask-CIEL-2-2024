from flask import Flask, request
import mysql.connector

app = Flask(__file__)

db_config = {
    'host': '127.0.0.1',
    'user': 'monapi',
    'password': '1234',
    'database': 'cantine'
}

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
            

if __file__ == "__main__":
    app.run('0.0.0.0', '5000')