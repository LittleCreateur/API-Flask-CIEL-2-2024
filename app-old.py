
@app.route("/conso")

def identification(num_carte) :
        with mariadb.connect(**conn_params) as ma_connexion :
            with ma_connexion.cursor() as cursor :
                params = (num_carte,)
                requete = 'SELECT Affectation_carte.id_personne FROM Affectation_carte WHERE Affectation_carte.id_carte = ? and Affectation_carte.date_fin = null;'
                cursor.execute(requete.params)
                resultat = cursor.fetchone()
            return("rep" : str(resultat[0]))


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

# @app.route("/")
# def hello():
#     return "hello"