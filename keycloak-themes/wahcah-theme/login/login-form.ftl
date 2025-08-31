<form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
    <div class="form-group">
        <label for="username">Username atau Email</label>
        <input tabindex="1" id="username" name="username" type="text" autofocus value="${(login.username!'')}" />
    </div>

    <div class="form-group">
        <label for="password">Kata Sandi</label>
        <input tabindex="2" id="password" name="password" type="password" />
    </div>

    <#if realm.rememberMe && !usernameHidden??>
        <div class="form-group checkbox">
            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>>
            <label for="rememberMe">Ingat Saya</label>
        </div>
    </#if>

    <div class="form-actions">
        <input type="submit" class="btn btn-login" value="Masuk" />
    </div>

    <#if realm.resetPasswordAllowed>
        <div class="form-links">
            <a href="${url.loginResetCredentialsUrl}">Lupa Kata Sandi?</a>
        </div>
    </#if>

    <#if realm.registrationAllowed>
        <div class="form-links">
            <a href="${url.registrationUrl}">Daftar Akun Baru</a>
        </div>
    </#if>
</form>
