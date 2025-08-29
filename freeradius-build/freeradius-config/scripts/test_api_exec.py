#!/usr/bin/env python3
import os
import sys
import requests

username = os.environ.get("USER_NAME", "").strip('"')
password = os.environ.get("USER_PASSWORD", "").strip('"')

if not username or not password:
    sys.stdout.write('Reply-Message := "Missing credentials"\n')
    sys.stdout.write('Auth-Type := Reject\n')
    sys.stdout.flush()
    sys.exit(1)

# Konfigurasi Keycloak
KEYCLOAK_URL = os.environ.get("KEYCLOAK_URL", "http://keycloak:8080")
REALM_NAME = os.environ.get("KEYCLOAK_REALM", "cakrawala")
CLIENT_ID = os.environ.get("KEYCLOAK_CLIENT_ID", "cakrawala_client")
CLIENT_SECRET = os.environ.get("KEYCLOAK_CLIENT_SECRET", "b7p3WOmBgpYPhGC0NYBzn7oPvZFyynoD")

token_url = f"{KEYCLOAK_URL}/realms/{REALM_NAME}/protocol/openid-connect/token"
payload = {
    'client_id': CLIENT_ID,
    'client_secret': CLIENT_SECRET,
    'username': username,
    'password': password,
    'grant_type': 'password'
}

try:
    resp = requests.post(token_url, data=payload, timeout=5)
    if resp.status_code == 200:
        sys.stdout.write('Reply-Message := "Authentication successful"\n')
        sys.stdout.write('Auth-Type := Accept\n')
        sys.stdout.flush()
        sys.exit(0)
    else:
        sys.stdout.write(f'Reply-Message := "Authentication failed: {resp.json().get("error_description", "Unknown error")}"\n')
        sys.stdout.write('Auth-Type := Reject\n')
        sys.stdout.flush()
        sys.exit(1)
except Exception as e:
    sys.stdout.write(f'Reply-Message := "Error connecting to Keycloak: {e}"\n')
    sys.stdout.write('Auth-Type := Reject\n')
    sys.stdout.flush()
    sys.exit(1)
