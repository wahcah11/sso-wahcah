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

