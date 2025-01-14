<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Водители</Title>
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
                <form action="/driver" method="post">
                    <table>
                        <tr>
                            <td><label for="id">id</label></td>
                            <td><input id="modalId" name="id" readonly></td>
                        </tr>
                        <tr>
                            <td><label for="name">ФИО</label></td>
                            <td><input id="modalName" name="name" required></td>
                        </tr>
                        <tr>
                            <td><label for="contactNumber">Контактный номер</label></td>
                            <td><input id="modalContactNumber" name="contactNumber" required></td>
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

    <h1>Справочник: Водители</h1>
    <#if user.roles?seq_contains("ROLE_ADMIN")><button onClick="showModal()">Добавить запись</button></#if>
    <table class="dicTable">
        <tr>
            <th>ФИО</th>
            <th>Контактный номер</th>
            <th>Закрепленный транспорт</th>
        </tr>
        <#list drivers as driver>
            <tr>
                <td>${driver.name}</td>
                <td>${driver.contactNumber}</td>
                <a href='/vehicle/${(driver.vehicle.id)!}'><td>${(driver.vehicle.registrationNumber)!"Нет закрепленного транспорта"} ${(driver.vehicle.model)!}</td></a>
                <#if user.roles?seq_contains("ROLE_ADMIN")><td>
                    <form action="/driver/delete/${driver.id}" onSubmit="return confirm('Вы действительно хотите удалить запись?')" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button>Удалить запись</button>
                   </form>
               </td>
               <td>
                    <button onClick = "editModal(${driver.id}, '${driver.name}', '${driver.contactNumber}')">Изменить запись</button>
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
        document.getElementById('modalName').value = null;
        document.getElementById('modalContactNumber').value = null;

        document.getElementById('modalTitle').innerText = "Добавление записи";
        document.getElementById('modalButton').innerHTML = "Добавить запись";

        document.getElementById('modal').hidden = false;
    }

    function hideModal() {
        document.getElementById("modal").hidden = true;
    }

    function editModal(id, name, contactNumber) {
        document.getElementById('modalId').value = id;
        document.getElementById('modalName').value = name;
        document.getElementById('modalContactNumber').value = contactNumber;

        document.getElementById('modalTitle').innerText = "Изменение записи";
        document.getElementById('modalButton').innerHTML = "Изменить запись";

        document.getElementById('modal').hidden = false;
    }
</script>
</html>