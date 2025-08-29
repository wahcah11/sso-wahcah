#!/usr/bin/env python3
import sys
import requests

def parse_radius_input():
    """Parse key-value pairs dari stdin FreeRADIUS."""
    attributes = {}
    for line in sys.stdin:
        line = line.strip()
        if not line or ':=' not in line:
            continue
        key, value = line.split(':=', 1)
        attributes[key.strip()] = value.strip().strip('"')
    return attributes

def main():
    attributes = parse_radius_input()
    username = attributes.get('User-Name')
    password = attributes.get('User-Password')

    if not username or not password:
        sys.stdout.write(f'Reply-Message := "Missing credentials"\n')
        sys.stdout.write('Auth-Type := Reject\n')
        sys.stdout.flush()
        sys.exit(1)

    # Konfigurasi Keycloak
    KEYCLOAK_URL = "http://keycloak:8080"
    REALM_NAME = "cakrawala"
    CLIENT_ID = "cakrawala_client"
    CLIENT_SECRET = "b7p3WOmBgpYPhGC0NYBzn7oPvZFyynoD"

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
            error = resp.json().get("error_description", "Unknown error")
            sys.stdout.write(f'Reply-Message := "Authentication failed: {error}"\n')
            sys.stdout.write('Auth-Type := Reject\n')
            sys.stdout.flush()
            sys.exit(1)
    except Exception as e:
        sys.stdout.write(f'Reply-Message := "Error connecting to Keycloak: {e}"\n')
        sys.stdout.write('Auth-Type := Reject\n')
        sys.stdout.flush()
        sys.exit(1)

if __name__ == '__main__':
    main()
