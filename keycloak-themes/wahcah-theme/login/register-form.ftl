<form id="kc-register-form" action="${url.registrationAction}" method="post">
    <div class="form-group">
        <label for="firstName">Nama Depan</label>
        <input type="text" id="firstName" name="firstName"
               value="${(register.formData.firstName!'')}" required />
        <#if messagesPerField.existsError('firstName')>
            <span class="error-message">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</span>
        </#if>
    </div>

    <div class="form-group">
        <label for="lastName">Nama Belakang</label>
        <input type="text" id="lastName" name="lastName"
               value="${(register.formData.lastName!'')}" required />
        <#if messagesPerField.existsError('lastName')>
            <span class="error-message">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</span>
        </#if>
    </div>

    <div class="form-group">
        <label for="email">Email</label>
        <input type="text" id="email" name="email"
               value="${(register.formData.email!'')}" required />
        <#if messagesPerField.existsError('email')>
            <span class="error-message">${kcSanitize(messagesPerField.get('email'))?no_esc}</span>
        </#if>
    </div>

    <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username"
               value="${(register.formData.username!'')}" required />
        <#if messagesPerField.existsError('username')>
            <span class="error-message">${kcSanitize(messagesPerField.get('username'))?no_esc}</span>
        </#if>
    </div>

    <#-- Field NIM -->
    <div class="form-group">
        <label for="nim">NIM</label>
        <input type="text" id="nim" name="nim"
               value="${(register.formData.nim!'')}" required />
        <#if messagesPerField.existsError('nim')>
            <span class="error-message">${kcSanitize(messagesPerField.get('nim'))?no_esc}</span>
        </#if>
    </div>

    <div class="form-group">
        <label for="password">Kata Sandi</label>
        <input type="password" id="password" name="password" required />
        <#if messagesPerField.existsError('password')>
            <span class="error-message">${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
        </#if>
    </div>

    <div class="form-group">
        <label for="password-confirm">Ulangi Kata Sandi</label>
        <input type="password" id="password-confirm" name="password-confirm" required />
        <#if messagesPerField.existsError('password-confirm')>
            <span class="error-message">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
        </#if>
    </div>

    <div class="form-actions">
        <input type="submit" class="btn btn-login" value="Daftar" />
    </div>

    <div class="form-links">
        <a href="${url.loginUrl}">Sudah punya akun? Masuk di sini</a>
    </div>
</form>
