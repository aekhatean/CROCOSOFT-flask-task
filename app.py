from flask import Flask, request, jsonify
import mysql.connector

from constants import DB_CONF

app = Flask(__name__)


def connect_to_database():
    return mysql.connector.connect(**DB_CONF)


def execute_query(query, params=None, commit=False):
    with connect_to_database() as conn:
        with conn.cursor(dictionary=True) as cursor:
            cursor.execute(query, params)
            if commit:
                conn.commit()
                return cursor.lastrowid
            return cursor.fetchone()


@app.route('/')
def index():
    return "Welcome to Crocosoft Social!"


@app.route('/posts', methods=['POST'])
def create_post():
    data = request.json
    author_id = data.get('author_id')
    content = data.get('content')

    if not author_id or not content:
        return "please provide author_id and content fields", 400

    insert_query = "INSERT INTO posts (author_id, content) VALUES (%s, %s)"
    post_id = execute_query(insert_query, (author_id, content), commit=True)

    # Fetch the inserted post
    post_id = execute_query("SELECT * FROM posts WHERE id = %s", (post_id,))
    return jsonify(post_id), 201


@app.route('/posts/<int:post_id>', methods=['PUT'])
def update_post(post_id):
    data = request.json
    content = data.get('content')

    update_query = "UPDATE posts SET content = %s WHERE id = %s"
    execute_query(update_query, (content, post_id), commit=True)

    # Fetch the updated post
    updated_post = execute_query("SELECT * FROM posts WHERE id = %s", (post_id,))
    return jsonify(updated_post), 200


@app.route('/posts/<int:post_id>', methods=['GET'])
def get_post(post_id):
    post = execute_query("SELECT * FROM posts WHERE id = %s", (post_id,))
    if post:
        return jsonify(post), 200
    else:
        return "Post not found", 404


@app.route('/posts/<int:post_id>', methods=['DELETE'])
def delete_post(post_id):
    delete_query = "DELETE FROM posts WHERE id = %s"
    execute_query(delete_query, (post_id,), commit=True)
    return "Post deleted successfully", 200


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
