<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>找回密码</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>

</head>
<body>
<div class="form-wrap">
    <div class="form-content">
        <h3 class="form-title">找回密码</h3>
        <form action="${pageContext.request.contextPath}/public/doFindPassword.action" method="post">
            <!--
            <p class="input-wrap">
                <label>账号</label>
                <input type="text" class="modify-input-style" id="username">
            </p>
            -->
            <p class="input-wrap">
                <label>帐号</label>
                <input type="text" class="modify-input-style" id="username" name="username">
                <span class="hint">${error}</span>
            </p>

            <p class="input-wrap">
                <label>邮箱</label>
                <input type="text" class="modify-input-style" id="mail" name="mail">
                <span class="hint">${error}</span>
            </p>

            <p class="input-wrap">
                <button id="find-password">下一步</button>
                <a href="${pageContext.request.contextPath}/public/login.action" class="link-login">返回登陆</a>
            </p>
        </form>
    </div>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findpassword.css">
</body>
</html>