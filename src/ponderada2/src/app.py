from flask import Flask, jsonify, request, make_response
from flask_restful import Api, Resource
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
from flask_swagger_ui import get_swaggerui_blueprint

app = Flask(__name__)
api = Api(app)
auth = HTTPBasicAuth()

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

# Usuários permitidos
users = {
    "gabriela": generate_password_hash("gabi"),
    "murilo": generate_password_hash("mumu")
}

tasks = []

@auth.verify_password
def verify_password(username, password):
    if username in users and check_password_hash(users.get(username), password):
        return username

class TaskList(Resource):
    @auth.login_required
    def get(self):
        return make_response(jsonify(tasks), 200)

    @auth.login_required
    def post(self):
        data = request.get_json()
        if not data or 'title' not in data:
            return make_response(jsonify({"message": "O título da tarefa é obrigatório"}), 400)

        task_id = len(tasks) + 1
        data['id'] = task_id
        tasks.append(data)
        return make_response(jsonify(data), 201)
    
class Task(Resource):
    @auth.login_required
    def get(self, task_id):
        task = next((task for task in tasks if task['id'] == task_id), None)
        if task:
            return make_response(jsonify(task), 200)
        else:
            return make_response(jsonify({"message": "Tarefa não encontrada"}), 404)

    @auth.login_required
    def put(self, task_id):
        task = next((task for task in tasks if task['id'] == task_id), None)
        if task:
            data = request.get_json()
            if 'title' in data:
                task['title'] = data['title']
            return make_response(jsonify(task), 200)
        else:
            return make_response(jsonify({"message": "Tarefa não encontrada"}), 404)

    @auth.login_required
    def delete(self, task_id):
        task = next((task for task in tasks if task['id'] == task_id), None)
        if task:
            tasks[:] = [task for task in tasks if task['id'] != task_id]
            return make_response(jsonify({"message": "Tarefa deletada"}), 200)
        else:
            return make_response(jsonify({"message": "Tarefa não encontrada"}), 404)

class Auth(Resource):
    def post(self):
        data = request.get_json()
        if not data or not 'username' in data or not 'password' in data:
            return make_response(jsonify({"message": "Nome de usuário e senha são obrigatórios"}), 400)

        username = data['username']
        password = data['password']

        if username in users and check_password_hash(users.get(username), password):
            return make_response(jsonify({"message": "Autenticado com sucesso"}), 200)
        else:
            return make_response(jsonify({"message": "Credenciais inválidas"}), 401)

# Adicionando rotas
api.add_resource(TaskList, '/tasks')
api.add_resource(Task, '/tasks/<int:task_id>')
api.add_resource(Auth, '/auth')

if __name__ == '__main__':
    app.run(debug=True)
