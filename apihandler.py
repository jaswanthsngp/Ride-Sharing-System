from dbhandler import db
from flask import Flask
from flask import request
from flask import jsonify
import json

app = Flask(__name__)
    
@app.route('/login', methods=['POST'])
def login():
    # login form for users, returns user id on succeess
    # request format email:emailID, pwd:password
    data = json.loads(request.data)
    print(data)
    status = db.validateLogin(data["email"], data["pwd"])
    if status is None:
        return jsonify({"id": "Invalid User"})
    return jsonify({"id":status})

@app.route("/signup", methods=['POST'])
def signup():
    # signup form for users, returns user id on success
    # name:name, email:email, pwd:password
    data = json.loads(request.data)
    print(data)
    status = db.signUpUser(data["name"], data["email"], data["pwd"], "traveler")
    if status is None:
        return jsonify({"id": "Please try again"})
    return jsonify({"id":status})

@app.route("/signupCompanion", methods=['POST'])
def signUpCompanion():
    # a special signup form for companion
    # name: name, email:email, pwd:password, cab:cabno
    data = json.loads(request.data)
    print(data)
    status = db.signUpCompanion(data["name"], data["email"], data["pwd"], "companion", data["cab"])
    if status is None:
        return jsonify({"id": "Please try again"})
    return jsonify({"id":status})

@app.route("/book", methods=['POST'])
def bookCab():
    # searches for nearby companion and assigns cab
    # id:user_id, source:sourceName, destination: destName
    data = json.loads(request.data)
    print(data)
    status = db.bookRide(data["id"], data["source"], data["destination"])
    if status is None:
        return jsonify({"id": "Please try again"})
    return jsonify({"id":status})

@app.route("/pay", methods=['POST'])
def pay():
    # doesn't do any payments, but terminates the ride
    # id:ride_id
    data = json.loads(request.data)
    print(data)
    status = db.finishRide(data["id"])
    return jsonify({"success":status})
