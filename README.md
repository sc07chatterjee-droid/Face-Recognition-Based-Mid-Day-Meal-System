# Face-Recognition-Based-Mid-Day-Meal-System
A modern, biometric-enabled Meal Management System designed for efficiency and nutritional tracking. This application combines Face Recognition authentication with AI-Powered Nutrition Analysis to streamline mid-day meal distribution in schools.
🌟 Key Features
🛡️ Biometric Authentication: Secure and fast user verification using state-of-the-art face recognition (dlib).
📱 QR & Face Dual-Verify: Robust 2-step verification process (Scan QR -> Match Face) to prevent identity fraud.
🥗 AI Nutrition Analysis: Instantly analyzes food images using Google Gemini 1.5 Flash to provide a detailed breakdown of Carbohydrates, Proteins, Vitamins, Fats, and Calories.
📊 Automated Logging: Automatically logs every meal with student details, timestamp, and nutritional data into CSV and Excel formats.
🐳 Dockerized: Fully containerized backend and frontend for effortless deployment.
🌓 Modern UI: Clean, responsive, and user-friendly interface.

🏗️ Architecture
The project is built as a microservices architecture:

Backend: Python FastAPI server handling face encodings, image processing, and Gemini API tracking.
Frontend: Static HTML/CSS/JS client serving the user interface and handling camera logic.
Storage:
User Data: lightweight JSON store (data.json).
Face Encodings: NumPy binaries (.npy).
Logs: CSV files for easy export and analysis.
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

🚀 Getting Started
Prerequisites
Docker Desktop (Recommended) OR Python 3.9+
A working Webcam
Google Gemini API Key (for Nutrition Analysis features) - Get it here
Option A: Quick Start with Docker (Recommended)
Clone the repository

git clone <repository-url>
cd face-based-mid-day-meal
Configure API Key Create a .env file in the backend/ directory:

echo "GEMINI_API_KEY=your_actual_api_key_here" > backend/.env
Run with Docker Compose

docker-compose up --build -d
Access the App

Frontend: http://localhost
Backend API: http://localhost:8000/docs
Option B: Manual Installation
If you prefer running without Docker:

1. Backend Setup

cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies (requires cmake installed for dlib)
pip install -r requirements.txt

# Create .env file with your API Key
echo "GEMINI_API_KEY=your_key" > .env

# Run Server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
2. Frontend Setup You can serve the frontend using a simple HTTP server:

cd frontend
python -m http.server 8080
Visit http://localhost:8080 in your browser.

📖 Usage Guide
1. Registration Phase
Go to the Register page.
Enter details: Name, Class, Roll Number.
Click Capture Photo to register your face.
System generates a unique QR Code. Save this QR code (it acts as your digital ID card).
2. Meal Distribution & Recognition
Go to the Recognize page.
Scan QR Code: Show your generated QR code to the camera.
Verify Face: Once the QR is scanned, the system asks you to look at the camera to verify it's really you.
Success: On match, student details are shown.
3. Nutrition Analysis
After successful verification, aim the camera at your meal.
Click Capture Food.
The system sends the image to Gemini AI and displays the nutritional content (Carbs, Protein, etc.) alongside the student's log.
4. Admin / Logs
Go to the Logs page.
View real-time entries of students who have taken meals.
Export to Excel: Download the daily report.

🔧 Troubleshooting
dlib Installation Errors: Dlib requires CMake.
Mac: brew install cmake
Windows: Install CMake from cmake.org and ensure C++ build tools are installed.
Camera Permission: ensure your browser has permission to access the webcam. Use localhost or HTTPS.
Gemini API Error: If nutrition analysis fails, check your API quota or ensure key is correct in backend/.env.