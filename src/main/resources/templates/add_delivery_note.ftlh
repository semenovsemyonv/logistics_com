<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Добавление накладной</Title>
</head>
<body>
<#include "/includes/header.ftlh">
<#include "/includes/nav.ftlh">
<main>
<div class="modal">
<div class="modal_container">
<div class="modal_header">
    <p>Добавление накладной</p>
    </div>
    <form action="/delivery_note/add" method="post">
        <table>
            <tr>
                <td><label for="id">id</label></td>
                <td><input id="modalId" name="id" readonly></td>
            </tr>
            <tr>
                <td><label for="user">Работник</label></td>
                <td>
                    <select name="user" required>
                        <option value="${user.id}">${user.name}</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="vehicle">Транспорт</label></td>
                <td>
                    <select id="modalVehicle" name="vehicle" required>
                        <#list vehicles as vehicle>
                              <option value="${vehicle.id}">${vehicle.registrationNumber} ${vehicle.model}</option>
                        </#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="order">Заказ</label></td>
                <td>
                    <select id="modalOrder" name="order" required>
                        <#list orders as order>
                              <option value="${order.id}">${order.number}</option>
                        </#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="date">Дата</label></td>
                <td><input type="date" id="modalDate" name="date" required></td>
            </tr>
            <tr>
                <td><label for="acceptance">Операция</label></td>
                <td>
                <select id="modalAcceptance" name="acceptance" required>
                    <option value="true">Приемка</option>
                    <option value="false">Отгрузка</option>
                </select>
                </td>
            </tr>
            <tr>
                <td><label for="commentary">Комментарий</label></td>
                <td><input id="modalCommentary" name="commentary"></td>
            </tr>
            <tr>
                <td><input type="hidden" name="_csrf" value="${_csrf.token}"></td>
                <td><button id="modalButton">Добавить накладную</button></td>
            </tr>
        </table>
    </form>
</div>
</div>
</main>
<#include "/includes/footer.ftlh">
</body>
</html>