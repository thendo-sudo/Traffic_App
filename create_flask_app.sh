#!/bin/bash

# Create project directory and navigate into it
mkdir -p traffic-monitoring-app/backend
cd traffic-monitoring-app/backend

# Create app.py with the Flask API code
cat <<EOL > app.py
from flask import Flask, jsonify
import requests

app = Flask(__name__)

# TomTom API credentials (replace with your API key)
TOMTOM_API_KEY = "YOUR_TOMTOM_API_KEY"
TOMTOM_API_URL = "https://api.tomtom.com/traffic/services/4/flowSegmentData/absolute/10/json"

@app.route('/traffic', methods=['GET'])
def get_traffic_data():
    # Example coordinates (latitude, longitude)
    lat, lon = 37.7749, -122.4194  # San Francisco
    url = f"{TOMTOM_API_URL}?point={lat},{lon}&unit=KMPH&key={TOMTOM_API_KEY}"
    response = requests.get(url)
    return jsonify(response.json())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOL

# Create requirements.txt
echo "Flask==2.3.2" > requirements.txt
echo "requests==2.31.0" >> requirements.txt

# Create a virtual environment and install dependencies
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Print success message
echo "Backend setup complete! Files and folder structure created."
echo "Run the Flask app with: python app.py"