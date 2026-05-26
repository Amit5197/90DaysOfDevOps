from flask import Flask
import psycopg2
import redis

app = Flask(__name__)

db_conn = psycopg2.connect(
    host="db",
    database="mydb",
    user="postgres",
    password="postgres"
)

cache = redis.Redis(host="redis", port=6379)

@app.route("/")
def hello():
    cur = db_conn.cursor()
    cur.execute("SELECT 'Hello from PostgreSQL!'")
    db_msg = cur.fetchone()[0]

    cache.set("message", "Hello from Redis Cache!")
    redis_msg = cache.get("message").decode("utf-8")

    return f"{db_msg} | {redis_msg}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
