from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class Note(db.Model):
    __tablename__ = 'notes'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    content = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow, nullable=False)

    def __repr__(self):
        return f'<Note {self.id}: {self.title}>'

    def preview(self, length=120):
        if len(self.content) <= length:
            return self.content
        return self.content[:length].rsplit(' ', 1)[0] + '...'

    def word_count(self):
        return len(self.content.split())

    def formatted_created(self):
        return self.created_at.strftime('%B %d, %Y at %I:%M %p')

    def formatted_updated(self):
        return self.updated_at.strftime('%B %d, %Y at %I:%M %p')
