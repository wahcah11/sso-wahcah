from flask import Flask, request, jsonify
import requests
import os

app = Flask(__name__)

# --- Konfigurasi Keycloak ---
# Ambil dari environment variable atau gunakan default
# Ini lebih fleksibel daripada hardcoding
KEYCLOAK_URL = os.environ.get("KEYCLOAK_URL", "http://keycloak:8080")
REALM_NAME = os.environ.get("KEYCLOAK_REALM", "cakrawala")
CLIENT_ID = os.environ.get("KEYCLOAK_CLIENT_ID", "cakrawala_client")

TOKEN_ENDPOINT = f"{KEYCLOAK_URL}/realms/{REALM_NAME}/protocol/openid-connect/token"

@app.route('/authenticate', methods=['POST'])
def authenticate():
    """Endpoint untuk menerima dan memvalidasi kredensial dari FreeRADIUS."""
    data = request.json
    username = data.get('User-Name')
    password = data.get('User-Password')

    if not username or not password:
        # Jika username atau password tidak ada, kirim Bad Request
        return jsonify({"message": "Username or password missing"}), 400

    # Siapkan payload untuk meminta token ke Keycloak
    payload = {
        'client_id': CLIENT_ID,
        'client_secret': os.environ.get("KEYCLOAK_CLIENT_SECRET", "b7p3WOmBgpYPhGC0NYBzn7oPvZFyynoD"),
        'username': username,
        'password': password,
        'grant_type': 'password',
    }


    try:
        # Kirim permintaan ke Keycloak
        response = requests.post(TOKEN_ENDPOINT, data=payload)
        
        # Jika Keycloak memberikan status code 200, otentikasi berhasil
        if response.status_code == 200:
            print(f"Authentication successful for user: {username}")
            # Kode 200 (OK) akan dianggap sebagai Access-Accept oleh FreeRADIUS
            return jsonify({"message": "Authentication successful"}), 200
        else:
            print(f"Authentication failed for user: {username}, Status: {response.status_code}, Details: {response.text}")
            # Kode selain 200 akan dianggap sebagai Access-Reject
            return jsonify({"message": "Authentication failed"}), 401

    except requests.exceptions.RequestException as e:
        print(f"Error connecting to Keycloak: {e}")
        # Jika Keycloak tidak bisa dihubungi, kirim Service Unavailable
        return jsonify({"message": "Error connecting to Keycloak"}), 503

if __name__ == '__main__':
    # Jalankan server di port 5000 dan dengarkan di semua antarmuka jaringan
    app.run(host='0.0.0.0', port=5000, debug=True)