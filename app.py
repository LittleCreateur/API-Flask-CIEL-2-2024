from random import randint
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World!"+str(randint(0,100))