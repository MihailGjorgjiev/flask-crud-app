from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db'
db = SQLAlchemy(app)

class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    author = db.Column(db.String(80), nullable=False)
    description = db.Column(db.String(120), nullable=False)

@app.route('/books', methods=['GET'])
def get_books():
    books = Book.query.all()
    return jsonify([{'id': book.id, 'name': book.name, 'author': book.author, 'description': book.description} for book in books])

@app.route('/book/<int:id>', methods=['GET'])
def get_book(id):
    book = Book.query.get_or_404(id)
    return jsonify({'id': book.id, 'name': book.name, 'author': book.author, 'description': book.description})

@app.route('/book', methods=['POST'])
def create_book():
    data = request.get_json()
    new_book = Book(name=data['name'],author=data['author'], description=data['description'])
    db.session.add(new_book)
    db.session.commit()
    return jsonify({'id': new_book.id}), 201

@app.route('/book/<int:id>', methods=['PUT'])
def update_book(id):
    data = request.get_json()
    book = Book.query.get_or_404(id)
    book.name = data['name']
    book.author = data['author']
    book.description = data['description']
    db.session.commit()
    return jsonify({'id': book.id})

@app.route('/book/<int:id>', methods=['DELETE'])
def delete_book(id):
    book = Book.query.get_or_404(id)
    db.session.delete(book)
    db.session.commit()
    return '', 204

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0')
