<!DOCTYPE html>
<html>
<head>
    <title>SSO - Universitas Nusantara Kediri</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
    <script>
        // Redirect ke halaman register
        window.location.href = "${url.registrationUrl}";
    </script>

    <script src="${url.resourcesPath}/js/custom.js"></script>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <img src="${url.resourcesPath}/img/logo.png" alt="MyApp Logo" class="logo"/>
                <h2>SSO Universitas Nusantara PGRI Kediri</h2>
            </div>
            
            <!-- Form login kita ambil dari file login-form.ftl -->
            <div class="login-form">
                <#include "login-form.ftl">
            </div>
        </div>
    </div>
</body>
</html>
