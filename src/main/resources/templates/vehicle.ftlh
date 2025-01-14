<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Транспорт</Title>
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
                <form action="/vehicle" method="post">
                    <table>
                        <tr>
                            <td><label for="id">id</label></td>
                            <td><input id="modalId" name="id" readonly></td>
                        </tr>
                        <tr>
                            <td><label for="registrationNumber">Рег. номер</label></td>
                            <td><input id="modalRegistrationNumber" name="registrationNumber" required></td>
                        </tr>
                        <tr>
                            <td><label for="model">Модель</label></td>
                            <td><input id="modalModel" name="model" required></td>
                        </tr>
                        <tr>
                            <td><label for="status">Статус</label></td>
                            <td>
                                <select id="modalStatus" name="status" required>
                                    <#list statuses as status>
                                          <option value="${status.id}">${status.name}</option>
                                    </#list>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="driver">Водитель</label></td>
                            <td>
                                <select id="modalDriver" name="driver">
                                    <#list freeDrivers as driver>
                                          <option value="${driver.id}">${driver.name}</option>
                                    </#list>
                                </select>
                            </td>
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

    <h1>Справочник: Транспорт</h1>
    <#if user.roles?seq_contains("ROLE_ADMIN")><button onClick="showModal()">Добавить запись</button></#if>
    <table class="dicTable">
        <tr>
            <th>Рег. номер</th>
            <th>Модель</th>
            <th>Статус</th>
            <th>Закрепленный водитель</th>
        </tr>
        <#list vehicles as vehicle>
            <tr>
                <td>${vehicle.registrationNumber}</td>
                <td>${vehicle.model}</td>
                <td>${(vehicle.status.name)!}</td>
                <td>${(vehicle.driver.name)!"Не назначен"}</td>
                <#if user.roles?seq_contains("ROLE_ADMIN")><td>
                    <form action="/vehicle/delete/${vehicle.id}" onSubmit="return confirm('Вы действительно хотите удалить запись?')" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button>Удалить запись</button>
                   </form>
               </td>
               <td>
                    <button onClick = "editModal(${vehicle.id}, '${vehicle.registrationNumber}', '${vehicle.model}', ${(vehicle.status.id)!}, ${(vehicle.driver.id)!})">Изменить запись</button>
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
        document.getElementById('modalRegistrationNumber').value = null;
        document.getElementById('modalModel').value = null;
        document.getElementById('modalStatus').value = null;
        document.getElementById('modalDriver').value = null;

        document.getElementById('modalTitle').innerText = "Добавление записи";
        document.getElementById('modalButton').innerHTML = "Добавить запись";

        document.getElementById('modal').hidden = false;
    }

    function hideModal() {
        document.getElementById("modal").hidden = true;
    }

    function editModal(id, registrationNumber, model, status, driver) {
        document.getElementById('modalId').value = id;
        document.getElementById('modalRegistrationNumber').value = registrationNumber;
        document.getElementById('modalModel').value = model;
        document.getElementById('modalStatus').value = status;
        document.getElementById('modalDriver').value = driver;

        document.getElementById('modalTitle').innerText = "Изменение записи";
        document.getElementById('modalButton').innerHTML = "Изменить запись";

        document.getElementById('modal').hidden = false;
    }
</script>
</html>