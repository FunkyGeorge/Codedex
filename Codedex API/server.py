from flask import Flask, request, render_template, jsonify,redirect
from mysqlconnection import MySQLConnector

app = Flask(__name__)

app.secret_key = 'secret'

mysql = MySQLConnector(app, 'Codedex')

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/name')
def get():
	sql = "SELECT * FROM users WHERE name = :name"
	data = {
		'name': request.form['name']
		# 'name': "test"
	}
	results = mysql.query_db(sql, data)

	return jsonify({"response": results})

@app.route('/add', methods=['POST'])
def add():
	sql = "INSERT INTO users (name, status, level, specialty) VALUES (:name, :status, :level, :specialty)"
	data = {
		'name': request.form['name'],
		'status': request.form['status'],
		'level': request.form['level'],
		'specialty': request.form['specialty']
	}
	return jsonify({"response": "success"})

app.run(debug=True)