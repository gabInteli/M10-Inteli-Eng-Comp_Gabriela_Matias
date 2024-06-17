from flask import Flask, request
import requests

app = Flask(__name__)

@app.route('/posts', methods=['GET', 'POST'])
def handle_posts():
    if request.method == 'GET':
        response = requests.get('http://service1:5001/posts')
    else:
        response = requests.post('http://service1:5001/posts', json=request.json)
    return response.content, response.status_code

@app.route('/posts/<int:id>', methods=['PUT', 'DELETE'])
def handle_post(id):
    if request.method == 'PUT':
        response = requests.put(f'http://service1:5001/posts/{id}', json=request.json)
    else:
        response = requests.delete(f'http://service1:5001/posts/{id}')
    return response.content, response.status_code

@app.route('/events', methods=['GET', 'POST'])
def handle_events():
    if request.method == 'GET':
        response = requests.get('http://service2:5002/events')
    else:
        response = requests.post('http://service2:5002/events', json=request.json)
    return response.content, response.status_code

@app.route('/events/<int:id>', methods=['PUT', 'DELETE'])
def handle_event(id):
    if request.method == 'PUT':
        response = requests.put(f'http://service2:5002/events/{id}', json=request.json)
    else:
        response = requests.delete(f'http://service2:5002/events/{id}')
    return response.content, response.status_code

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
