
FROM python:3.11-slim-bookworm

WORKDIR /app

# Install system dependencies required for dlib and face_recognition
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    pkg-config \
    libx11-dev \
    libatlas-base-dev \
    libgtk-3-dev \
    libboost-python-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install python dependencies
# Install face_recognition_models directly from git first to avoid issues
# RUN pip install --no-cache-dir git+https://github.com/ageitgey/face_recognition_models
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create data directory if it doesn't exist (though volume will mount over it)
RUN mkdir -p data/encodings

# Expose the port
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
