import os
from flask import Flask, render_template, request, redirect, url_for, flash
from models import db, Note
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')

app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get(
    'DATABASE_URL',
    'sqlite:///notes.db'
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

with app.app_context():
    db.create_all()

@app.route('/')
def index():
    search_query = request.args.get('q', '')
    if search_query:
        notes = Note.query.filter(
            (Note.title.ilike(f'%{search_query}%')) |
            (Note.content.ilike(f'%{search_query}%'))
        ).order_by(Note.created_at.desc()).all()
    else:
        notes = Note.query.order_by(Note.created_at.desc()).all()

    return render_template('index.html', notes=notes, search_query=search_query)

@app.route('/note/<int:note_id>')
def view_note(note_id):
    note = Note.query.get_or_404(note_id)
    return render_template('view_note.html', note=note)

@app.route('/add', methods=['GET', 'POST'])
def add_note():
    if request.method == 'POST':
        title   = request.form.get('title', '').strip()
        content = request.form.get('content', '').strip()

        if not title:
            flash('Title is required.', 'error')
            return render_template('add_note.html', title=title, content=content)
        if not content:
            flash('Content is required.', 'error')
            return render_template('add_note.html', title=title, content=content)

        note = Note(title=title, content=content)
        db.session.add(note)
        db.session.commit()
        flash('Note created successfully!', 'success')
        return redirect(url_for('index'))

    return render_template('add_note.html')

@app.route('/edit/<int:note_id>', methods=['GET', 'POST'])
def edit_note(note_id):
    note = Note.query.get_or_404(note_id)

    if request.method == 'POST':
        title   = request.form.get('title', '').strip()
        content = request.form.get('content', '').strip()

        if not title:
            flash('Title is required.', 'error')
            return render_template('edit_note.html', note=note)
        if not content:
            flash('Content is required.', 'error')
            return render_template('edit_note.html', note=note)

        note.title      = title
        note.content    = content
        note.updated_at = datetime.utcnow()
        db.session.commit()
        flash('Note updated successfully!', 'success')
        return redirect(url_for('index'))

    return render_template('edit_note.html', note=note)

@app.route('/delete/<int:note_id>', methods=['POST'])
def delete_note(note_id):
    note = Note.query.get_or_404(note_id)
    db.session.delete(note)
    db.session.commit()
    flash('Note deleted successfully!', 'success')
    return redirect(url_for('index'))

if __name__ == '__main__':
    host = os.environ.get('FLASK_RUN_HOST', 'localhost')
    debug = os.environ.get('FLASK_DEBUG', '0') == '1'
    app.run(host=host, port=5000, debug=debug)
