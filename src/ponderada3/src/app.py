from flask import Flask, jsonify, request, make_response
from flask_restful import Api, Resource
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
from flask_swagger_ui import get_swaggerui_blueprint
from models.models import db, User, Task

app = Flask(__name__)
api = Api(app)
auth = HTTPBasicAuth()

# Configuração do PostgreSQL
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:postgres@db:5432/ponderada3'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Inicializa o SQLAlchemy
db.init_app(app)

# Criação do banco de dados
@app.before_first_request
def create_tables():
    db.create_all()

# Configuração do Swagger
SWAGGER_URL = '/docs'
API_URL = '/static/swagger.yaml'
swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL,
    API_URL,
    config={
        'app_name': "List"
    }
)

app.register_blueprint(swaggerui_blueprint, url_prefix=SWAGGER_URL)

# Função de verificação de senha
@auth.verify_password
def verify_password(username, password):
    user = User.query.filter_by(username=username).first()
    if user and check_password_hash(user.password_hash, password):
        return username

# Rotas e Recursos
class TaskListResource(Resource):
    @auth.login_required
    def get(self):
        tasks = Task.query.all()
        return make_response(jsonify([task.to_dict() for task in tasks]), 200)

    @auth.login_required
    def post(self):
        data = request.get_json()
        if not data or 'title' not in data:
            return make_response(jsonify({"message": "O título da tarefa é obrigatório"}), 400)

        task = Task(title=data['title'])
        db.session.add(task)
        db.session.commit()
        return make_response(jsonify(task.to_dict()), 201)

class TaskResource(Resource):
    @auth.login_required
    def get(self, task_id):
        task = Task.query.get(task_id)
        if task:
            return make_response(jsonify(task.to_dict()), 200)
        else:
            return make_response(jsonify({"message": "Tarefa não encontrada"}), 404)

    @auth.login_required
    def put(self, task_id):
        task = Task.query.get(task_id)
        if task:
            data = request.get_json()
            if 'title' in data:
                task.title = data['title']
                db.session.commit()
            return make_response(jsonify(task.to_dict()), 200)
        else:
            return make_response(jsonify({"message": "Tarefa não encontrada"}), 404)

    @auth.login_required
    def delete(self, task_id):
        task = Task.query.get(task_id)
        if task:
            db.session.delete(task)
            db.session.commit()
            return make_response(jsonify({"message": "Tarefa deletada"}), 200)
        else:
            return make_response(jsonify({"message": "Tarefa não encontrada"}), 404)

class UserResource(Resource):
    def post(self):
        data = request.get_json()
        if not data or 'username' not in data or 'password' not in data:
            return make_response(jsonify({"message": "Nome de usuário e senha são obrigatórios"}), 400)

        username = data['username']
        password_hash = generate_password_hash(data['password'])
        user = User(username=username, password_hash=password_hash)
        db.session.add(user)
        db.session.commit()
        return make_response(jsonify({"message": "Usuário criado com sucesso"}), 201)

class UserConfirmation(Resource):
    def post(self):
        data = request.get_json()
        if not data or 'username' not in data or 'password' not in data:
            return make_response(jsonify({"message": "Nome de usuário e senha são obrigatórios"}), 400)

        username = data['username']
        password = data['password']
        user = User.query.filter_by(username=username).first()
        
        if user and check_password_hash(user.password_hash, password):
            return make_response(jsonify({"message": "Login realizado com sucesso"}), 200)
        else:
            return make_response(jsonify({"message": "Nome de usuário ou senha incorretos"}), 401)

class UserListResource(Resource):
    #@auth.login_required
    def get(self):
        users = User.query.all()
        return make_response(jsonify([user.to_dict() for user in users]), 200)

# Adicionando rotas
api.add_resource(TaskListResource, '/tasks')
api.add_resource(TaskResource, '/tasks/<int:task_id>')
api.add_resource(UserResource, '/user')
api.add_resource(UserConfirmation, '/userauth')
api.add_resource(UserListResource, '/users')

if __name__ == '__main__':
    app.run(debug=True)
