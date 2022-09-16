from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/', methods = ['GET'])
def index():
    return "Hello World!"


if __name__ == "__main__":
    app.run(threaded=True, port=5000, debug=True)