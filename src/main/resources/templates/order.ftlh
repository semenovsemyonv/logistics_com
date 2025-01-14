<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Заказы</Title>
</head>
<body>
<#include "/includes/header.ftlh">
<#include "/includes/nav.ftlh">
<main>
    <div id="modal" class="modal" hidden>
        <div class="modal_container">
            <div class="modal_header">
                <p id="modalTitle"></p>
                <button onClick="hideModal()">X</button>
            </div>
            <div class="modal_form">
                <form action="/order" method="post">
                    <table>
                        <tr>
                            <td><label for="id">id</label></td>
                            <td><input id="modalId" name="id" readonly></td>
                        </tr>
                        <tr>
                            <td><label for="number">Номер заказа</label></td>
                            <td><input id="modalNumber" name="number" required></td>
                        </tr>
                        <tr>
                            <td><label for="name">Адрес доставки</label></td>
                            <td><input id="modalAddress" name="address" required></td>
                        </tr>
                        <tr>
                            <td><label for="weight">Вес</label></td>
                            <td><input id="modalWeight" name="weight" required></td>
                        </tr>
                        <tr>
                            <td><input type="hidden" name="_csrf" value="${_csrf.token}"></td>
                            <td><button id="modalButton">Создать запись</button></td>
                        </tr>
                    </table>
                </form>
           </div>
        </div>
    </div>

    <h1>Справочник: Заказы</h1>
    <#if user.roles?seq_contains("ROLE_ADMIN")><button onClick="showModal()">Добавить запись</button></#if>
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
                <#if user.roles?seq_contains("ROLE_ADMIN")><td>
                    <form action="/order/delete/${order.id}" onSubmit="return confirm('Вы действительно хотите удалить запись?')" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button>Удалить запись</button>
                   </form>
               </td>
               <td>
                    <button onClick = "editModal(${order.id}, ${order.number}, '${order.address}', ${order.weight})">Изменить запись</button>
               </td></#if>
           </tr>
        </#list>
    </table>
</main>
<#include "/includes/footer.ftlh">
</body>
<script>
    function showModal() {
        document.getElementById('modalId').value = null;
        document.getElementById('modalNumber').value = null;
        document.getElementById('modalAddress').value = null;
        document.getElementById('modalWeight').value = null;

        document.getElementById('modalTitle').innerText = "Добавление записи";
        document.getElementById('modalButton').innerHTML = "Добавить запись";

        document.getElementById('modal').hidden = false;
    }

    function hideModal() {
        document.getElementById("modal").hidden = true;
    }

    function editModal(id, number, address, weight) {
        document.getElementById('modalId').value = id;
        document.getElementById('modalNumber').value = number;
        document.getElementById('modalAddress').value = address;
        document.getElementById('modalWeight').value = weight;

        document.getElementById('modalTitle').innerText = "Изменение записи";
        document.getElementById('modalButton').innerHTML = "Изменить запись";

        document.getElementById('modal').hidden = false;
    }
</script>
</html>