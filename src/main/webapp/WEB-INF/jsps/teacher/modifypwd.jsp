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
<div id="warning">
        <p>促进互联网水平发展，你我共同有责 :)</p>
        <p>导致这样的问题：<br>1、你使用的浏览器是兼容ie模式 请切换其兼容；<br>2、你的浏览器版本太旧，请点击下面两个图标下载新版本浏览器<br>感谢你的合作</p>
        <p>请使用ie9以上 或 谷歌，360或火狐浏览器登陆此网页</p>
        <p>
            <a href="http://rj.baidu.com/soft/detail/14744.html?ald" class="link-chrome" title="下载谷歌浏览器" target="_blank">
                <img src="${pageContext.request.contextPath}/resources/images/chrome.png" alt="">
            </a>
            <a href="http://rj.baidu.com/soft/detail/11843.html?ald" class="link-firefox" title="下载火狐浏览器" target="_blank">
                <img src="${pageContext.request.contextPath}/resources/images/firefox.png" alt="">
            </a>
        </p>
    </div>
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
        <a href="${pageContext.request.contextPath}/" class="link-homepage">返回主页</a>
    </p>
</div>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/modifyPwd-min.css">
    <script type="text/javascript">
        
        (function checkBrownser(){
            var agent=navigator.appName //获取浏览器名字
            var version=navigator.appVersion.split(";"); //获取浏览器详细信息
            var trim_Version=version[1].replace(/[ ]/g,"");//获取浏览器版本号
            var floor = document.getElementById("warning");

            if(agent=="Microsoft Internet Explorer" && (trim_Version=="MSIE7.0" || trim_Version=="MSIE8.0")) { 
                floor.style.display = "block";
            }else{
                floor.style.display = "none";
            }
        }());
        
    </script>
</body>
</html>