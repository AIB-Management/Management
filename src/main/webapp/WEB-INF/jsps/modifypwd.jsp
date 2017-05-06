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
    <div class="form-content">
        <h3 class="form-title">修改密码</h3>
        <p class="input-wrap">
            <label>旧密码</label>
            <input type="password" class="reg-input-style" id="old-pwd">
            <span class="hint">输入正确</span>
        </p>
        <p class="input-wrap">
            <label>密码</label>
            <input type="password" class="reg-input-style" id="new-pwd" name="pwd">
            <span class="hint"></span>
        </p>
        <p class="input-wrap">
            <label>确认密码</label>
            <input type="password" class="reg-input-style"  id="confirmpwd" name="confirmpwd">
            <span class="hint"></span>
        </p>
        <p class="input-wrap">
            <button id="modify">确认修改</button>
            <a href="#" class="link-homepage">返回主页</a>
        </p>
    </div>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/modifypwd.css">
</body>
</html>