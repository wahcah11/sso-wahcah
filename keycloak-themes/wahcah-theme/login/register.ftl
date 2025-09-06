<!DOCTYPE html>
<html>
<head>
    <title>Daftar Akun - MyApp</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style1.css" />
    <style>
      .alert-error {
        color: #fff;
        background: #e74c3c;
        padding: 10px;
        border-radius: 6px;
        margin-bottom: 15px;
        text-align: center;
      }

      .field-error {
        color: #e74c3c;
        font-size: 0.85em;
        margin-top: 4px;
        display: block;
      }
    </style>
</head>
<body>
  <!-- ✅ TAMBAHAN: Ruang atas sebelum login-box -->
  <div style="height: 60px; background: transparent;"></div>

  <div class="login-container">
    <div class="login-box">
      <div class="login-header">
        <img src="${url.resourcesPath}/img/keycloak-logo-text.svg" alt="MyApp Logo" class="logo"/>
        <h2>Buat Akun Baru</h2>
        <p>Isi data diri untuk melanjutkan</p>
      </div>
      
      <div class="login-form">
        
        <!-- Pesan error global -->
        <#if message?has_content>
          <div class="alert-error">
            ${kcSanitize(message.summary)?no_esc}
          </div>
        </#if>

        <!-- Form registrasi (dari register-form.ftl) -->
        <#include "register-form.ftl">

      </div>
    </div>
  </div>
</body>
</html>