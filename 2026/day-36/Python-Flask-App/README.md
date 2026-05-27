# Notes App

## What the app does
This is a simple web application for taking notes. You can create new notes, edit them, delete them, and search through your existing notes. It is built using Python, Flask, and PostgreSQL for the database.

## Environment variables needed
You need to create a `.env` file in the same folder as `docker-compose.yml`. Add these variables to it:

```
POSTGRES_DB=notes_database
POSTGRES_USER=amit
POSTGRES_PASSWORD=amit123
DATABASE_URL=postgresql://amit:amit123@db:5432/notes_database
SECRET_KEY=long-random-string
```

## How to run it with Docker Compose
Make sure you have Docker installed and running.

1. Open your terminal in the project folder.
2. Build and start the containers by running:
   ```
   docker compose up -d --build
   ```
3. Open your web browser and go to `http://localhost:5000` to use the app.

   To stop the app, run:
   ```
   docker compose down
   ```
