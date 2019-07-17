from app import app
from flask import Flask, request, render_template, make_response, flash, redirect, url_for

@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html')