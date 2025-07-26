# Use official Python 3.10 image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential

# Copy requirements and install them
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the entire app code (including API and linear_regression folders)
COPY . .

# Set environment variables needed by the app (adjust MODEL_PATH if needed)
ENV MODEL_PATH=/app/linear_regression/saved_models
ENV HOST=0.0.0.0
ENV PORT=8000

# Expose the port your app will run on
EXPOSE 8000

# Run the FastAPI app, referencing the correct module path
CMD ["uvicorn", "API.main:app", "--host", "0.0.0.0", "--port", "8000"]
