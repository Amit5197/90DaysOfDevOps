# Use the official Python 3.12 slim image as the base
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Install dependencies directly
COPY requirements.txt .

#run application
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY . .

# Run as a non-root user
RUN useradd -m appuser && chown -R appuser /app
USER appuser

# Document the port
EXPOSE 5000

# Start the Flask web server
CMD ["python", "app.py"]



