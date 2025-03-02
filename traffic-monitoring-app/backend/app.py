from flask import Flask, jsonify, request,send_from_directory
import requests
import os
from flask_cors import CORS

app = Flask(__name__, static_folder='frontend')
CORS(app) 

# TomTom API credentials (replace with your API key)
TOMTOM_API_KEY = "WOqIBWeRcxJmkHO0xoGCiCJCx53KkRsl"
TOMTOM_API_URL = "https://api.tomtom.com/traffic/services/4/flowSegmentData/absolute/10/json"

@app.route('/traffic', methods=['GET'])
def get_traffic_data():
    city = request.args.get('city', 'johannesburg')  # Default to Johannesburg
    city_coords = {
        'johannesburg': {'lat': -26.2041, 'lon': 28.0473},
        'pretoria': {'lat': -25.7479, 'lon': 28.2293},
        'capetown': {'lat': -33.9249, 'lon': 18.4241},
        'newyork': {'lat': 40.7128, 'lon': -74.0060},
        'vienna': {'lat': 48.2082, 'lon': 16.3738},
    }
    lat, lon = city_coords.get(city, city_coords['johannesburg']).values()
    url = f"{TOMTOM_API_URL}?point={lat},{lon}&unit=KMPH&key={TOMTOM_API_KEY}"
    response = requests.get(url)
    return jsonify(response.json())

@app.route('/', methods=['GET'])
def serve_frontend():
    return send_from_directory('frontend', 'index.html')

@app.route('/<path:path>', methods=['GET'])
def serve_static_files(path):
    return send_from_directory('frontend', path)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000)


#testing    test   CI/CD