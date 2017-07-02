<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>重置密码</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/resetpwdMain.js?t=170506-10"></script>
</head>
<body>
<div class="form-wrap">
    <form action="${pageContext.request.contextPath}/public/modifypwd.action" method="post" id="reset-content">
        <input type="hidden" name="Code" value="${Code}">
        <input type="hidden" name="username" value="${username}">

        <div class="form-content">
            <h3 class="form-title">重置密码</h3>
            <%--错误信息--%>
            <div>${error}</div>
            <p class="input-wrap">
                <label>密码</label>
                <input type="password" class="reg-input-style" id="newpwd" name="pwd">
                <span class="hint"></span>
            </p>
            <p class="input-wrap">
                <label>确认密码</label>
                <input type="password" class="reg-input-style"  id="confirmpwd" name="confirmpwd" >
                <span class="hint"></span>
            </p>
            <p class="input-wrap">
                <button id="reset" type="submit">重置</button>
            </p>
        </div>
    </form>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/resetpwd.css">
</body>
</html>