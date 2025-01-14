<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Накладные</Title>
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
                <form action="/delivery_note" method="post">
                    <table>
                        <tr>
                            <td><label for="id">id</label></td>
                            <td><input id="modalId" name="id" readonly></td>
                        </tr>
                        <tr>
                            <td><label for="user">Работник</label></td>
                            <td>
                                <select id="modalUser" name="user" required>
                                    <#list users as usr>
                                          <option value="${usr.id}">${usr.name}</option>
                                    </#list>
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
                            <td><input type="date" id="modalDate" name="date"></td>
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
                            <td><button id="modalButton">Создать запись</button></td>
                        </tr>
                    </table>
                </form>
           </div>
        </div>
    </div>

    <h1>Справочник: Накладные</h1>
    <#if user.roles?seq_contains("ROLE_ADMIN")><button onClick="showModal()">Добавить запись</button></#if>
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
                <#if user.roles?seq_contains("ROLE_ADMIN")><td>
                    <form action="/delivery_note/delete/${deliveryNote.id}" onSubmit="return confirm('Вы действительно хотите удалить запись?')" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button>Удалить запись</button>
                   </form>
               </td>
               <td>
                    <button onClick = "editModal(${deliveryNote.id}, ${deliveryNote.user.id}, ${deliveryNote.vehicle.id}, ${deliveryNote.order.id}, '${deliveryNote.date?datetime?string('yyyy-MM-dd')}', ${deliveryNote.acceptance?string('true', 'false')}, '${deliveryNote.commentary}')">Изменить запись</button>
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
        document.getElementById('modalUser').value = null;
        document.getElementById('modalVehicle').value = null;
        document.getElementById('modalOrder').value = null;
        document.getElementById('modalDate').value = null;
        document.getElementById('modalAcceptance').value = null;
        document.getElementById('modalCommentary').value = null;

        document.getElementById('modalTitle').innerText = "Добавление записи";
        document.getElementById('modalButton').innerHTML = "Добавить запись";

        document.getElementById('modal').hidden = false;
    }

    function hideModal() {
        document.getElementById("modal").hidden = true;
    }

    function editModal(id, user, vehicle, order, date, acceptance, commentary) {
        document.getElementById('modalId').value = id;
        document.getElementById('modalUser').value = user;
        document.getElementById('modalVehicle').value = vehicle;
        document.getElementById('modalOrder').value = order;
        document.getElementById('modalDate').value = date;
        document.getElementById('modalAcceptance').value = acceptance;
        document.getElementById('modalCommentary').value = commentary;

        document.getElementById('modalTitle').innerText = "Изменение записи";
        document.getElementById('modalButton').innerHTML = "Изменить запись";

        document.getElementById('modal').hidden = false;
    }
</script>
</html>