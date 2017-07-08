<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>修改密码</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
   <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jsdist/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/jsdist/modifyPwdMain-min.js"></script>
</head>
<body>
<div class="form-wrap">
    <form action="${pageContext.request.contextPath}/public/domodifyPassword.action" method="post" id="modifyPwdForm">
        <div class="form-content">
            <h3 class="form-title">修改密码</h3>
            <p class="input-wrap">
                <label>旧密码</label>
                <input type="password" class="reg-input-style" id="oldPwd" name="oldpwd">
                <span class="hint"></span>
            </p>
            <p class="input-wrap">
                <label>新密码</label>
                <input type="password" class="reg-input-style" id="newPwd" name="pwd">
                <span class="hint"></span>
            </p>
            <p class="input-wrap">
                <label>确认密码</label>
                <input type="password" class="reg-input-style" id="confirmpwd" name="confirmpwd">
                <span class="hint"></span>
            </p>
        </div>
    </form>
    <p class="input-wrap-btn">
        <button id="modify">确认修改</button>
        <a href="${pageContext.request.contextPath}/content/departmentpage.action" class="link-homepage">返回主页</a>
    </p>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/modifyPwd-min.css">
</body>
</html>