<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    * {
      padding: 0;
      margin: 0;
    }

    body {
      font-family: Arial, Tahoma, Serif;
      color: #263238;
      background-color: #FFD29D;
    }

    .modal {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
    }

    td {
        width: 100px;
        height: 30px;
    }

    input {
        border: 0;
        margin: 0 0 15px;
        padding: 15px;
        box-sizing: border-box;
        font-size: 14px;
    }

    /* CSS */
    button {
      background-color: #fbeee0;
      border: 2px solid #422800;
      border-radius: 30px;
      box-shadow: #422800 1px 1px 0 0;
      color: #422800;
      cursor: pointer;
      display: inline-block;
      font-weight: 600;
      font-size: 14px;
      padding: 0 18px;
      line-height: 30px;
      text-align: center;
      text-decoration: none;
      user-select: none;
      -webkit-user-select: none;
      touch-action: manipulation;
      margin: 5px;
    }

    button:hover {
      background-color: #fff;
    }

    button:active {
      box-shadow: #422800 2px 2px 0 0;
      transform: translate(2px, 2px);
    }

    @media (min-width: 768px) {
      button {
        min-width: 120px;
        padding: 0 25px;
      }
    }

    h1 {
        margin: 20px 5px;
    }

    footer {
        position: fixed;
        background-color: #AFBC88;
        bottom: 0;
        width: 100%;
    }

    .footer_info {
        margin: 5px 50px;
    }
    </style>
    <Title>Вход</Title>
</head>
<body>
<main>
    <div class="modal">
        <form action="/login" method="post">
            <h1>Вход</h1>
            <table>
            <tr>
                <td><input type="email" placeholder="Введите Email" name="username" required></td>
            </tr>
            <tr>
                <td><input type="password" placeholder="Введите пароль" name="password" required></td>
            </tr>
            <tr>
            <td><button type="submit" class="registration__button">Войти</button></td>
            </tr>
            </table>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        </form>
    </div>
</main>
<#include "/includes/footer.ftlh">
</body>
</html>
