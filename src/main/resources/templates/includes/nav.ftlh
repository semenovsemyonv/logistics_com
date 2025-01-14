<nav>
    <b><p>Справочники:</p></b>
    <ul>
        <li><a href="/user">Пользователи</a></li>
        <li><a href="/driver">Водители</a></li>
        <li><a href="/vehicle">Транспорт</a></li>
        <li><a href="/status">Статусы</a></li>
        <li><a href="/warehouse">Склады</a></li>
        <li><a href="/order">Заказы</a></li>
        <li><a href="/delivery_note">Накладные</a></li>
    </ul>
    <b><p>Основное меню :</p></b>
    <ul>
        <li><a href="/warehouse/my">Мой склад</a></li>
        <li><a href="/delivery_note/add">Добавить накладную</a></li>
        <li><a href="/settings">Настройки</a></li>
    </ul>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Выйти" id="exit_button">
    </form>
</nav>