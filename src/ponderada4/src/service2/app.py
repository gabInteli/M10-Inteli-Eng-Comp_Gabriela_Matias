from flask import Flask, request, jsonify
from models import db, Event

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///events.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

@app.before_first_request
def create_tables():
    db.create_all()

@app.route('/events', methods=['GET'])
def get_events():
    events = Event.query.all()
    return jsonify([event.to_dict() for event in events])

@app.route('/events', methods=['POST'])
def add_event():
    data = request.get_json()
    new_event = Event(title=data['title'], description=data['description'])
    db.session.add(new_event)
    db.session.commit()
    return jsonify(new_event.to_dict()), 201

@app.route('/events/<int:id>', methods=['PUT'])
def update_event(id):
    data = request.get_json()
    event = Event.query.get(id)
    if event:
        event.title = data['title']
        event.description = data['description']
        db.session.commit()
        return jsonify(event.to_dict())
    return jsonify({'message': 'Event not found'}), 404

@app.route('/events/<int:id>', methods=['DELETE'])
def delete_event(id):
    event = Event.query.get(id)
    if event:
        db.session.delete(event)
        db.session.commit()
        return jsonify({'message': 'Event deleted'})
    return jsonify({'message': 'Event not found'}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)
