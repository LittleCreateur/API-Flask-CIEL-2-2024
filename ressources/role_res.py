from flask import request, Blueprint, jsonify
from db.database import get_session
from models import User
from flask_jwt_extended import jwt_required

# Point d'entrée de base : url/users/
user_bp = Blueprint(name="user_res", import_name = __name__, url_prefix="/user")

@user_bp.route("/user",methods=['POST']) # Point d'entrée : url/users/newuser
@jwt_required()
def create_user(): 
    pseudo_user = request.json.get('pseudo') 
    session = next(get_session())
    new_user = User(username = pseudo_user)
    session.add(new_user)
    session.commit()
    session.refresh(new_user)
    return {"rep" : f"User {str{pseudo_user}} ajouté avec succès"}

@user_bp.route("/all",methods=['GET']) 
@jwt_required() 
def get_users(): 
    session = next(get_session())
    users = session.query(User).all()   # Sorte de cursor.execute
    reponse = []
    for user in users :
        reponse.append(user.to_dict())
    return jsonify(reponse)

#role (model)
# id
# description
# User ajouter attribut rd_role