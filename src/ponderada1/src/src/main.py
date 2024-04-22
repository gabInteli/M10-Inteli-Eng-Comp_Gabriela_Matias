from flask import Flask
from flask_jwt_extended import JWTManager, set_access_cookies, create_access_token, jwt_required, get_jwt_identity
from database.database import db
from flask import jsonify, request, render_template, make_response
from database.models import User
from database.models import Task
import requests as http_request
import os 
from datetime import datetime
from sqlalchemy.orm.exc import UnmappedInstanceError

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__, template_folder="templates")
# configure the SQLite database, relative to the app instance folder
app.config['SQLALCHEMY_DATABASE_URI'] =\
        'sqlite:///' + os.path.join(basedir, 'db.db')
db.init_app(app)
# Setup the Flask-JWT-Extended extension
app.config["JWT_SECRET_KEY"] = "goku-vs-vegeta" 
# Seta o local onde o token será armazenado
app.config['JWT_TOKEN_LOCATION'] = ['cookies']
jwt = JWTManager(app)

# Verifica se o parâmetro create_db foi passado na linha de comando
import sys
if len(sys.argv) > 1 and sys.argv[1] == 'create_db':
    # cria o banco de dados
    with app.app_context():
        db.create_all()
    # Finaliza a execução do programa
    print("Database created successfully")
    sys.exit(0)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/token", methods=["POST"])
def create_token():
    email = request.json.get("email", None)
    password = request.json.get("password", None)
    # Query your database for username and password
    user = User.query.filter_by(email= email, password=password).first()
    if user is None:
        # the user was not found on the database
        return jsonify({"msg": "Bad username or password"}), 401
    
    # create a new token with the user id inside
    access_token = create_access_token(identity=user.id)
    return jsonify({ "token": access_token, "user_id": user.id })

@app.route("/user-login", methods=["GET"])
def user_login():
    return render_template("login.html")

@app.route("/login", methods=["POST"])
def login():
    email = request.form.get("email", None)
    password = request.form.get("password", None)
    # Verifica os dados enviados não estão nulos
    if email is None or password is None:
        # the user was not found on the database
        return render_template("error.html", message="Bad username or password")
    
    # faz uma chamada para a criação do token
    token_data = http_request.post("http://localhost:5000/token", json={"email": email, "password": password})
    if token_data.status_code != 200:
        return render_template("error.html", message="Bad username or password")
    # recupera o token
    response = make_response(render_template("content.html"))
    set_access_cookies(response, token_data.json()['token'])
    return response

# Código superior suprimido para facilitar a localização nos códigos
@app.route("/user-register", methods=["GET"])
def user_register():
    return render_template("register.html")

@app.route("/content", methods=["GET"])
@jwt_required()
def content():
    return render_template("content.html")

@app.route("/error", methods=["GET"])
def error():
    return render_template("error.html")

# Adicionando as rotas CRUD para a entidade User
@app.route("/users", methods=["GET"])
def get_users():
    users = User.query.all()
    return_users = []
    for user in users:
        return_users.append(user.serialize())
    return jsonify(return_users)

@app.route("/users/<int:id>", methods=["GET"])
def get_user(id):
    user = User.query.get(id)
    return jsonify(user.serialize())

@app.route("/users", methods=["POST"])
def create_user():
    name = request.form.get("name")
    email = request.form.get("email")
    password = request.form.get("password")
    # Criando um novo usuário com os dados recebidos
    user = User(name=name, email=email, password=password)
    
    db.session.add(user)
    db.session.commit()
    return jsonify(user.serialize())

@app.route("/users/<int:id>", methods=["PUT"])
def update_user(id):
    data = request.json
    user = User.query.get(id)
    user.name = data["name"]
    user.email = data["email"]
    user.password = data["password"]
    db.session.commit()
    return jsonify(user.serialize())

@app.route("/users/<int:id>", methods=["DELETE"])
def delete_user(id):
    user = User.query.get(id)
    db.session.delete(user)
    db.session.commit()
    return jsonify(user.serialize())

@app.route("/task-list", methods=["GET"])
def new_task_form():
    return render_template("tasks.html")

@app.route("/tasks", methods=["GET"])
def get_tasks():
    tasks = Task.query.all()
    return_tasks = []
    for task in tasks:
        return_tasks.append(task.serialize())
    return jsonify(return_tasks)

@app.route("/create", methods=["GET"])
def new_task_form():
    return render_template("newtask.html")

@app.route("/newtask", methods=["POST"])
def create_task():
    name = request.form.get("name")
    description = request.form.get("description")
    start_date_str = request.form.get("start_date")
    end_date_str = request.form.get("end_date")

    start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
    end_date = datetime.strptime(end_date_str, "%Y-%m-%d")

    # Criando uma nova tarefa com os dados recebidos
    task = Task(name=name, description=description, start_date=start_date, end_date=end_date)
    
    # Criando um novo usuário com os dados recebidos
    task = Task(name=name, description=description, start_date=start_date, end_date=end_date)
    
    db.session.add(task)
    db.session.commit()
    return jsonify(task.serialize())

@app.route("/task/<int:id>", methods=["DELETE"])
def delete_task(id):
    task = Task.query.get(id)
    if task:
        db.session.delete(task)
        db.session.commit()
        return jsonify({"message": "Task deleted successfully"})
    else:
        return jsonify({"message": "Task not found"}), 404

@app.route("/task/<int:id>", methods=["PUT"])
def update_task(id):
    task = Task.query.get(id)
    if task:
        # Atualiza os campos da tarefa com os novos valores, se fornecidos
        data = request.json
        updated = False  # Flag para indicar se algum campo foi atualizado

        # Atualiza o nome da tarefa, se fornecido
        if 'name' in data:
            task.name = data['name']
            updated = True

        # Atualiza a descrição da tarefa, se fornecido
        if 'description' in data:
            task.description = data['description']
            updated = True

        # Atualiza a data de início da tarefa, se fornecido
        if 'start_date' in data:
            task.start_date = datetime.strptime(data['start_date'], "%Y-%m-%d")
            updated = True

        # Atualiza a data de término da tarefa, se fornecido
        if 'end_date' in data:
            task.end_date = datetime.strptime(data['end_date'], "%Y-%m-%d")
            updated = True

        # Commit as mudanças no banco de dados se alguma atualização foi feita
        if updated:
            db.session.commit()
            return jsonify(task.serialize())
        else:
            return jsonify({"message": "No fields provided for update"}), 400
    else:
        return jsonify({"message": "Task not found"}), 404
