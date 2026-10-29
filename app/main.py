
from flask import Flask, jsonify

app = Flask(__name__)

APP_VERSION = "1.0.0"


@app.get("/health")
def health():
    return jsonify({"status": "healthy"}), 200


@app.get("/")
def index():
    return jsonify({
        "app": "devops-delivery-challenge",
        "version": APP_VERSION,
    }), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
