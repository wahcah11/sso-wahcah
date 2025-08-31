<form id="kc-register-form" action="${url.registrationAction}" method="post">
    <div class="form-group">
        <label for="firstName">Nama Depan</label>
        <input type="text" id="firstName" name="firstName" value="${(register.formData.firstName!'')}" required />
    </div>

    <div class="form-group">
        <label for="lastName">Nama Belakang</label>
        <input type="text" id="lastName" name="lastName" value="${(register.formData.lastName!'')}" required />
    </div>

    <div class="form-group">
        <label for="email">Email</label>
        <input type="text" id="email" name="email" value="${(register.formData.email!'')}" required />
    </div>

    <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" value="${(register.formData.username!'')}" required />
    </div>

    <!-- Tambahan custom field -->
    <div class="form-group">
        <label for="nim">NIM</label>
        <input type="text" id="nim" name="nim" value="${(register.formData.nim!'')}" required />
    </div>

    <div class="form-group">
        <label for="phone">Nomor HP</label>
        <input type="text" id="phone" name="phone" value="${(register.formData.phone!'')}" />
    </div>

    <div class="form-group">
        <label for="password">Kata Sandi</label>
        <input type="password" id="password" name="password" required />
    </div>

    <div class="form-group">
        <label for="password-confirm">Ulangi Kata Sandi</label>
        <input type="password" id="password-confirm" name="password-confirm" required />
    </div>

    <div class="form-actions">
        <input type="submit" class="btn btn-login" value="Daftar" />
    </div>

    <div class="form-links">
        <a href="${url.loginUrl}">Sudah punya akun? Masuk di sini</a>
    </div>
</form>
