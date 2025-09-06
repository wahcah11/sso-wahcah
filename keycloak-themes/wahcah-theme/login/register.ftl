<!DOCTYPE html>
<html>
<head>
    <title>Daftar Akun - MyApp</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
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

        <!-- Form registrasi -->
        <form id="kc-register-form" action="${url.registrationAction}" method="post">
          
          <div class="form-group">
            <label for="firstName">Nama Depan</label>
            <input type="text" id="firstName" name="firstName" value="${(register.formData.firstName!'')}" required />
            <#if messagesPerField.existsError('firstName')>
              <span class="field-error">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
            </#if>
          </div>
      
          <div class="form-group">
            <label for="lastName">Nama Belakang</label>
            <input type="text" id="lastName" name="lastName" value="${(register.formData.lastName!'')}" required />
            <#if messagesPerField.existsError('lastName')>
              <span class="field-error">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
            </#if>
          </div>
      
          <div class="form-group">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" value="${(register.formData.email!'')}" required />
            <#if messagesPerField.existsError('email')>
              <span class="field-error">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
            </#if>
          </div>
      
          <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" value="${(register.formData.username!'')}" required />
            <#if messagesPerField.existsError('username')>
              <span class="field-error">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
            </#if>
          </div>
      
          <!-- ✅ FIELD NIM - DIPERBAIKI: name="nim" dan id="nim" -->
          <div class="form-group">
            <label for="nim">NIM (10 digit)</label>
            <input type="text" id="nim" name="nim"
                   value="${(register.formData.nim!'')}"
                   pattern="\d{10}"
                   title="Harus 10 digit angka"
                   required />
            <#if messagesPerField.existsError('nim')>
              <span class="field-error">${kcSanitize(messagesPerField.get('nim'))?no_esc}</span>
            </#if>
          </div>
      
          <div class="form-group">
            <label for="password">Kata Sandi</label>
            <input type="password" id="password" name="password" required />
            <#if messagesPerField.existsError('password')>
              <span class="field-error">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
            </#if>
          </div>
      
          <div class="form-group">
            <label for="password-confirm">Ulangi Kata Sandi</label>
            <input type="password" id="password-confirm" name="password-confirm" required />
            <#if messagesPerField.existsError('password-confirm')>
              <span class="field-error">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
            </#if>
          </div>
      
          <div class="form-actions">
            <input type="submit" class="btn-login" value="Daftar" />
          </div>
      
          <div class="form-links">
            <a href="${url.loginUrl}">Sudah punya akun? Masuk di sini</a>
          </div>
        </form>

      </div>
    </div>
  </div>
</body>
</html>