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

logs:
sys.stderr.write(f"Wahyu {sys.stdin} Cahyo Utomo\n")


radtest testuser testing123 localhost 0 testing123


---
SETTING GRUP PENTING !!!
1. Login -> pilih realm -> Menu Clients Scope -> Create : name (openid)
2. Lanjutan langkah 1 -> tab Mapper -> add -> type : Group Membership, name : groups, Token Claim Name : groups
3. save
4. menu client -> pilih client yang dibuat -> tab client scopes -> add -> masukan openid yang dibuat dilagkah 1

reference :
https://keycloak.discourse.group/t/issue-on-userinfo-endpoint-at-keycloak-20/18461/12


---
Keycloack login : http://localhost:8080/realms/cakrawala/protocol/openid-connect/auth?client_id=cakrawala_client&response_type=code

Keycloack login + redirect : http://localhost:8080/realms/cakrawala/protocol/openid-connect/auth?client_id=cakrawala_client&response_type=code&redirect_uri=https://google.com

keycloack logout : http://localhost:8080/realms/cakrawala/protocol/openid-connect/logout

keycloack register : http://localhost:8080/realms/cakrawala/login-actions/registration?client_id=cakrawala_client&tab_id=TI8VivVTI1w


---
Setting client radius
1. nano /etc/freeradius/3.0/clients.conf
2. isi dengan
client laptopB {
    ipaddr = 172.18.0.0/16
    secret = testing123
    require_message_authenticator = no
}

3. restart radius

# Custom atribut
1. realm setting -> user profile -> isi name -> isi display name contoh : ${nim} -> pastikan centang semua permissions -> tambah validation

# spi auto disabled
docker cp target/spi-hello-1.0-SNAPSHOT.jar my-keycloak:/opt/keycloak/providers/
1. copy plugin yg dibuat dengan maven (script diatas)
2. aktifkan plugin dengan menu authenticate atau melalui event
3. event berada pada real setting -> events -> tuliskan auto-disable
