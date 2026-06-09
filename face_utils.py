import face_recognition
import numpy as np
import os
from PIL import Image
import io

# Default tolerance for face comparison (lower = more strict)
FACE_MATCH_TOLERANCE = 0.6

def encode_face(image_bytes):
    """
    Convert image bytes to face encoding.
    
    Args:
        image_bytes: Bytes of the image file
        
    Returns:
        numpy array: Face encoding, or None if no face found
    """
    try:
        # Load image from bytes
        image = face_recognition.load_image_file(io.BytesIO(image_bytes))
        
        # Find face locations
        face_locations = face_recognition.face_locations(image)
        
        if len(face_locations) == 0:
            return None
        
        # Get encoding for the first face found
        face_encodings = face_recognition.face_encodings(image, face_locations)
        
        if len(face_encodings) == 0:
            return None
        
        return face_encodings[0]
    except Exception as e:
        print(f"Error encoding face: {e}")
        return None

def compare_faces(encoding1, encoding2, tolerance=FACE_MATCH_TOLERANCE):
    """
    Compare two face encodings.
    
    Args:
        encoding1: First face encoding (numpy array)
        encoding2: Second face encoding (numpy array)
        tolerance: Matching tolerance (default 0.6)
        
    Returns:
        bool: True if faces match, False otherwise
    """
    if encoding1 is None or encoding2 is None:
        return False
    
    try:
        # Calculate face distance
        distance = face_recognition.face_distance([encoding1], encoding2)[0]
        
        # Check if distance is within tolerance
        return distance <= tolerance
    except Exception as e:
        print(f"Error comparing faces: {e}")
        return False

def save_encoding(user_id, encoding, encodings_dir="data/encodings"):
    """
    Save face encoding to file.
    
    Args:
        user_id: Unique user identifier
        encoding: Face encoding (numpy array)
        encodings_dir: Directory to save encodings
        
    Returns:
        bool: True if saved successfully, False otherwise
    """
    try:
        # Create directory if it doesn't exist
        os.makedirs(encodings_dir, exist_ok=True)
        
        # Save encoding to .npy file
        encoding_path = os.path.join(encodings_dir, f"{user_id}.npy")
        np.save(encoding_path, encoding)
        
        return True
    except Exception as e:
        print(f"Error saving encoding: {e}")
        return False

def load_encoding(user_id, encodings_dir="data/encodings"):
    """
    Load face encoding from file.
    
    Args:
        user_id: Unique user identifier
        encodings_dir: Directory containing encodings
        
    Returns:
        numpy array: Face encoding, or None if not found
    """
    try:
        encoding_path = os.path.join(encodings_dir, f"{user_id}.npy")
        
        if not os.path.exists(encoding_path):
            return None
        
        encoding = np.load(encoding_path)
        return encoding
    except Exception as e:
        print(f"Error loading encoding: {e}")
        return None

