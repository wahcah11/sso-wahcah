<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
  <#if section = "title">
      Tunggu Verifikasi
  <#elseif section = "form">
      <h2>Akun Anda berhasil terdaftar</h2>
      <p>Silakan tunggu maksimal 24 jam untuk verifikasi dari admin.</p>
  </#if>
</@layout.registrationLayout>
