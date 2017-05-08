<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>修改密码</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</head>
<body>
<div class="form-wrap">
    <form action="${pageContext.request.contextPath}/public/modifypwd.action" method="post">
        <input type="hidden" name="Code" value="${Code}">
        <input type="hidden" name="username" value="${username}">

        <div class="form-content">
            <h3 class="form-title">请输入新密码</h3>
            <%--错误信息--%>
            <div>${error}</div>
            <p class="input-wrap">
                <label>密码</label>
                <input type="password" class="reg-input-style" id="new-pwd" name="pwd">
                <span class="hint"></span>
            </p>
            <p class="input-wrap">
                <label>确认密码</label>
                <input type="password" class="reg-input-style"  id="confirmpwd" name="confirmpwd" >
                <span class="hint"></span>
            </p>
            <p class="input-wrap">
                <button id="modify" type="submit">确认修改</button>
            </p>

        </div>
    </form>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/modifypwd.css">
</body>
</html>