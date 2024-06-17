from flask import Flask, request, jsonify
from models import db, BlogPost

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///blog.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

@app.before_first_request
def create_tables():
    db.create_all()

@app.route('/posts', methods=['GET'])
def get_posts():
    posts = BlogPost.query.all()
    return jsonify([post.to_dict() for post in posts])

@app.route('/posts', methods=['POST'])
def add_post():
    data = request.get_json()
    new_post = BlogPost(title=data['title'], content=data['content'])
    db.session.add(new_post)
    db.session.commit()
    return jsonify(new_post.to_dict()), 201

@app.route('/posts/<int:id>', methods=['PUT'])
def update_post(id):
    data = request.get_json()
    post = BlogPost.query.get(id)
    if post:
        post.title = data['title']
        post.content = data['content']
        db.session.commit()
        return jsonify(post.to_dict())
    return jsonify({'message': 'Post not found'}), 404

@app.route('/posts/<int:id>', methods=['DELETE'])
def delete_post(id):
    post = BlogPost.query.get(id)
    if post:
        db.session.delete(post)
        db.session.commit()
        return jsonify({'message': 'Post deleted'})
    return jsonify({'message': 'Post not found'}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
