<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Заказы на складе</Title>
</head>
<body>
<#include "/includes/header.ftlh">
<#include "/includes/nav.ftlh">
<main>
    <h1>Склад: ${warehouse.address}</h1>
    <div class="zContainer">
        <div class="zInner">
        <br>
        <h2>Заказы находящиеся на складе</h2>
        <br>
        <table class="dicTable">
            <tr>
                <th>Номер заказа</th>
                <th>Адрес доставки</th>
                <th>Вес</th>
            </tr>
            <#list orders as order>
                <tr>
                    <td>${order.number}</td>
                    <td>${order.address}</td>
                    <td>${order.weight}</td>
               </tr>
            </#list>
        </table>
        </div>
        <div class="zInner">
        <br>
        <h2>Накладные</h2>
        <br>
        <table class="dicTable">
            <tr>
                <th>Пользователь</th>
                <th>Транспорт</th>
                <th>Номер заказа</th>
                <th>Дата</th>
                <th>Операция</th>
                <th>Комментарий</th>
            </tr>
            <#list deliveryNotes as deliveryNote>
                <tr>
                    <td>${deliveryNote.user.name}</td>
                    <td>${deliveryNote.vehicle.registrationNumber} ${deliveryNote.vehicle.model}</td>
                    <td>${deliveryNote.order.number}</td>
                    <td>${deliveryNote.date?datetime?string('dd-MM-yyyy')}</td>
                    <td>${deliveryNote.acceptance?string('Приемка', 'Отгрузка')}</td>
                    <td>${deliveryNote.commentary}</td>
               </tr>
            </#list>
        </table>
        </div>
    </div>
</main>
<#include "/includes/footer.ftlh">
</body>
<script>

</script>
</html>