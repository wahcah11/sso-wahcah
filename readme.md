curl -X POST "http://keycloak:8080/realms/cakrawala/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=cakrawala_client" \
  -d "client_secret=b7p3WOmBgpYPhGC0NYBzn7oPvZFyynoD" \
  -d "grant_type=password" \
  -d "username=admin" \
  -d "password=admin"


  ---
  pada kontainer freeradius
  curl -X POST http://radius-bridge:5000/authenticate \
  -H "Content-Type: application/json" \
  -d '{"User-Name": "admin", "User-Password": "admin"}'


---
test manual radius
echo -e 'User-Name := "admin"\nUser-Password := "admin"' | /usr/bin/python3 /etc/freeradius/3.0/scripts/test_api_exec.py


sys.stderr.write(f"Wahyu {sys.stdin} Cahyo Utomo\n")


radtest testuser testing123 localhost 0 testing123