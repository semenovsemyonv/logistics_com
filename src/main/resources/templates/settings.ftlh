<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Настройки</Title>
</head>
<body>
<#include "/includes/header.ftlh">
<#include "/includes/nav.ftlh">
<main>
<div class="modal">
<div class="modal_container">
<div class="modal_header">
<p>Смена пароля</p>
</div>
<form action="/settings" method="post">
    <table>
        <tr>
            <td><label for="oldPassword">Старый пароль</label></td>
            <td><input type="password" name="oldPassword" required></td>
        </tr>
        <tr>
            <td><label for="newPassword">Новый пароль</label></td>
            <td><input type="password" name="newPassword" required></td>
        </tr>
        <tr>
            <td><input type="hidden" name="_csrf" value="${_csrf.token}"></td>
            <td><button id="modalButton">Изменить пароль</button></td>
        </tr>
    </table>
</form>
</div>
</div>
</main>
<#include "/includes/footer.ftlh">
</body>
</html>