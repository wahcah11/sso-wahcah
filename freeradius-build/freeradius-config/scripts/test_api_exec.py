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

# Keycloak config
KEYCLOAK_URL = os.environ.get("KEYCLOAK_URL", "http://keycloak:8080")
REALM_NAME = os.environ.get("KEYCLOAK_REALM", "cakrawala")
CLIENT_ID = os.environ.get("KEYCLOAK_CLIENT_ID", "cakrawala_client")
CLIENT_SECRET = os.environ.get("KEYCLOAK_CLIENT_SECRET", "b7p3WOmBgpYPhGC0NYBzn7oPvZFyynoD")

# Token request
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
    if resp.status_code != 200:
        sys.stdout.write(f'Reply-Message := "Login failed: {resp.json().get("error_description", "Unknown error")}"\n')
        sys.stdout.write('Auth-Type := Reject\n')
        sys.stdout.flush()
        sys.exit(1)

    access_token = resp.json().get("access_token")

    # Get userinfo (which includes groups)
    userinfo_resp = requests.get(
        f"{KEYCLOAK_URL}/realms/{REALM_NAME}/protocol/openid-connect/userinfo",
        headers={"Authorization": f"Bearer {access_token}"},
        timeout=5
    )
    # sys.stderr.write(f"Wahyu {userinfo_resp.status_code} Cahyo Utomo\n")
    if userinfo_resp.status_code != 200:
        sys.stdout.write('Reply-Message := "Failed to retrieve user info"\n')
        sys.stdout.write('Auth-Type := Reject\n')
        sys.stdout.flush()
        sys.exit(1)

    userinfo = userinfo_resp.json()
    groups = userinfo.get("groups", [])  # ← dari Keycloak

    rate_limit = None
    group_mapping = {
        "/mahasiswa": "5M/5M",
        "/dosen": "10M/10M",
        "/karyawan": "8M/8M"
    }

    # Cek apakah user ada di salah satu grup
    for group in groups:
        if group in group_mapping:
            rate_limit = group_mapping[group]
            break

    sys.stdout.write('Reply-Message := "Authentication successful"\n')
    if rate_limit:
        sys.stdout.write(f'Mikrotik-Rate-Limit := "{rate_limit}"\n')
    else:
        sys.stdout.write('Reply-Message += " (No rate limit applied)"\n')
    sys.stdout.write('Auth-Type := Accept\n')
    sys.stdout.flush()
    sys.exit(0)

except Exception as e:
    sys.stdout.write(f'Reply-Message := "Error: {e}"\n')
    sys.stdout.write('Auth-Type := Reject\n')
    sys.stdout.flush()
    sys.exit(1)
