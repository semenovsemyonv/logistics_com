<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/normalize.css">
    <link rel="stylesheet" href="/static/css/style.css">
    <Title>Пользователи</Title>
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
                <form action="/user" method="post">
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
                            <td><label for="email">Email</label></td>
                            <td><input type="email" id="modalEmail" name="email" required></td>
                        </tr>
                        <tr>
                            <td><label for="password">Временный пароль</label></td>
                            <td><input id="modalPassword" name="password" type="password"></td>
                        </tr>
                        <tr>
                            <td><label for="contactNumber">Контактный номер</label></td>
                            <td><input id="modalContactNumber" name="contactNumber" required></td>
                        </tr>
                        <tr>
                            <td><label for="warehouse">Место работы</label></td>
                            <td>
                                <select id="modalWarehouse" name="warehouse">
                                    <#list warehouses as warehouse>
                                          <option value="${warehouse.id}">${warehouse.address}</option>
                                    </#list>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="roles">Права</label></td>
                            <td>
                                <select id="modalRoles" name="roles" required>
                                    <#list roles as role>
                                          <option value="${role}">${role}</option>
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

    <h1>Справочник: Пользователи</h1>
    <#if user.roles?seq_contains("ROLE_ADMIN")><button onClick="showModal()">Добавить запись</button></#if>
    <table class="dicTable">
        <tr>
            <th>ФИО</th>
            <th>Email</th>
            <th>Контактный номер</th>
            <th>Место работы</th>
            <th>Права</th>
        </tr>
        <#list users as usr>
            <tr>
                <td>${usr.name}</td>
                <td>${usr.email}</td>
                <td>${usr.contactNumber}</td>
                <td>${(usr.warehouse.address)!}</td>
                <td><#list usr.roles as r>${r} </#list></td>
                <#if user.roles?seq_contains("ROLE_ADMIN")><td>
                    <form action="/user/delete/${usr.id}" onSubmit="return confirm('Вы действительно хотите удалить запись?')" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button>Удалить запись</button>
                   </form>
               </td>
               <td>
                    <button onClick = "editModal(${usr.id}, '${usr.name}', '${usr.email}', '${usr.contactNumber}', '${(usr.warehouse.id)!}', '<#list usr.roles as r>${r}</#list>')">Изменить запись</button>
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
        document.getElementById('modalEmail').value = null;
        document.getElementById('modalContactNumber').value = null;
        document.getElementById('modalWarehouse').value = null;
        document.getElementById('modalRoles').value = null;

        document.getElementById('modalTitle').innerText = "Добавление записи";
        document.getElementById('modalButton').innerHTML = "Добавить запись";

        document.getElementById('modal').hidden = false;
    }

    function hideModal() {
        document.getElementById("modal").hidden = true;
    }

    function editModal(id, name, email, contactNumber, warehouse, roles) {
        document.getElementById('modalId').value = id;
        document.getElementById('modalName').value = name;
        document.getElementById('modalEmail').value = email;
        document.getElementById('modalContactNumber').value = contactNumber;
        document.getElementById('modalWarehouse').value = warehouse;
        document.getElementById('modalRoles').value = roles;

        document.getElementById('modalTitle').innerText = "Изменение записи";
        document.getElementById('modalButton').innerHTML = "Изменить запись";

        document.getElementById('modal').hidden = false;
    }
</script>
</html>