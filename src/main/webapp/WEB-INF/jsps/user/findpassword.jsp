<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>找回密码</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/findpwdMain.js?t=170606-7"></script>


</head>
<body>
<div class="form-wrap">
    <div class="form-content">
        <h3 class="form-title">找回密码</h3>
        <form action="${pageContext.request.contextPath}/public/doFindPassword.action" method="post" id="forms">
            <p class="input-wrap">
                <label>帐号：</label>
                <input type="text" class="modify-input-style findpwdContent" id="username" name="username" value="${username}">
                <span class="hint">${error}</span>
            </p>
            <p class="input-wrap">
                <label>邮箱：</label>
                <input type="text" class="modify-input-style findpwdContent" id="mail" name="mail" value="${mail}">
                <span class="hint">${error}</span>
            </p>
            <p class="input-wrap">
                <input type="submit" id="next-step" value="下一步"/>
                <a href="${pageContext.request.contextPath}/public/login.action" class="link-login">返回登陆</a>
            </p>
        </form>
    </div>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findpassword.css">
</body>
</html>