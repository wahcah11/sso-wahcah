<!DOCTYPE html>
<html>
<head>
    <title>Daftar Akun - MyApp</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
</head>
<body>
  <div class="login-container">
    <div class="login-box">
      <div class="login-header">
        <img src="${url.resourcesPath}/img/keycloak-logo-text.svg" alt="MyApp Logo" class="logo"/>
        <h2>Buat Akun Baru</h2>
        <p>Isi data diri untuk melanjutkan</p>
      </div>
      
      <div class="login-form">
        <#include "register-form.ftl">
      </div>
    </div>
  </div>
</body>
</html>
