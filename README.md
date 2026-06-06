# Face-Based Mid Day Meal System

[![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.68+-009688.svg)](https://fastapi.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-2496ED.svg)](https://www.docker.com/)
[![Gemini AI](https://img.shields.io/badge/AI-Gemini%201.5%20Flash-8E75B2.svg)](https://deepmind.google/technologies/gemini/)

A modern, biometric-enabled Meal Management System designed for efficiency and nutritional tracking. This application combines **Face Recognition** authentication with **AI-Powered Nutrition Analysis** to streamline mid-day meal distribution in schools.

## 🌟 Key Features

*   **🛡️ Biometric Authentication**: Secure and fast user verification using state-of-the-art face recognition (`dlib`).
*   **📱 QR & Face Dual-Verify**: Robust 2-step verification process (Scan QR -> Match Face) to prevent identity fraud.
*   **🥗 AI Nutrition Analysis**: Instantly analyzes food images using **Google Gemini 1.5 Flash** to provide a detailed breakdown of Carbohydrates, Proteins, Vitamins, Fats, and Calories.
*   **📊 Automated Logging**: Automatically logs every meal with student details, timestamp, and nutritional data into CSV and Excel formats.
*   **🐳 Dockerized**: Fully containerized backend and frontend for effortless deployment.
*   **🌓 Modern UI**: Clean, responsive, and user-friendly interface.

---

## 🏗️ Architecture

The project is built as a microservices architecture:

*   **Backend**: Python FastAPI server handling face encodings, image processing, and Gemini API tracking.
*   **Frontend**: Static HTML/CSS/JS client serving the user interface and handling camera logic.
*   **Storage**: 
    *   **User Data**: lightweight JSON store (`data.json`).
    *   **Face Encodings**: NumPy binaries (`.npy`).
    *   **Logs**: CSV files for easy export and analysis.

```text
/
├── backend/
│   ├── main.py              # FastAPI Application & Endpoints
│   ├── face_utils.py        # Face Recognition Logic
│   ├── data/                # Persistent Storage (Mapped Volume)
│   └── ...
├── frontend/
│   ├── index.html           # Dashboard
│   ├── register.html        # Registration Portal
│   ├── recognize.html       # Recognition & Nutrition Cam
│   └── ...
├── docker-compose.yaml      # Container Orchestration
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

*   **Docker Desktop** (Recommended) OR **Python 3.9+**
*   A working **Webcam**
*   **Google Gemini API Key** (for Nutrition Analysis features) - [Get it here](https://aistudio.google.com/app/apikey)

### Option A: Quick Start with Docker (Recommended)

1.  **Clone the repository**
    ```bash
    git clone <repository-url>
    cd face-based-mid-day-meal
    ```

2.  **Configure API Key**
    Create a `.env` file in the `backend/` directory:
    ```bash
    echo "GEMINI_API_KEY=your_actual_api_key_here" > backend/.env
    ```

3.  **Run with Docker Compose**
    ```bash
    docker-compose up --build -d
    ```

4.  **Access the App**
    *   Frontend: [http://localhost](http://localhost)
    *   Backend API: [http://localhost:8000/docs](http://localhost:8000/docs)

### Option B: Manual Installation

If you prefer running without Docker:

**1. Backend Setup**
```bash
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies (requires cmake installed for dlib)
pip install -r requirements.txt

# Create .env file with your API Key
echo "GEMINI_API_KEY=your_key" > .env

# Run Server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**2. Frontend Setup**
You can serve the frontend using a simple HTTP server:
```bash
cd frontend
python -m http.server 8080
```
Visit [http://localhost:8080](http://localhost:8080) in your browser.

---

## 📖 Usage Guide

### 1. Registration Phase
1.  Go to the **Register** page.
2.  Enter details: **Name, Class, Roll Number**.
3.  Click **Capture Photo** to register your face.
4.  System generates a unique **QR Code**. Save this QR code (it acts as your digital ID card).

### 2. Meal Distribution & Recognition
1.  Go to the **Recognize** page.
2.  **Scan QR Code**: Show your generated QR code to the camera.
3.  **Verify Face**: Once the QR is scanned, the system asks you to look at the camera to verify it's really you.
4.  **Success**: On match, student details are shown.

### 3. Nutrition Analysis
1.  After successful verification, aim the camera at your meal.
2.  Click **Capture Food**.
3.  The system sends the image to Gemini AI and displays the nutritional content (Carbs, Protein, etc.) alongside the student's log.

### 4. Admin / Logs
1.  Go to the **Logs** page.
2.  View real-time entries of students who have taken meals.
3.  **Export to Excel**: Download the daily report.

---

## 🔧 Troubleshooting

*   **`dlib` Installation Errors**: Dlib requires CMake.
    *   *Mac*: `brew install cmake`
    *   *Windows*: Install CMake from [cmake.org](https://cmake.org) and ensure C++ build tools are installed.
*   **Camera Permission**: ensure your browser has permission to access the webcam. Use `localhost` or `HTTPS`.
*   **Gemini API Error**: If nutrition analysis fails, check your API quota or ensure key is correct in `backend/.env`.

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).
