<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
    <title>找回密码</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jsdist/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/jsdist/findpwdMain-min.js"></script>


</head>
<body>
<div id="warning">
        <p>促进互联网水平发展，你我共同有责 :)</p>
        <p<p>导致这样的问题：<br>1、你使用的浏览器是兼容ie模式 请切换其兼容；<br>2、你的浏览器版本太旧，请点击下面两个图标下载新版本浏览器<br>感谢你的合作</p>
        <p>请使用ie10以上 或 谷歌，360或火狐浏览器登陆此网页</p>
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
        </form>
        <p class="btn-wrap">
            <input type="submit" id="next-step" value="下一步"/>
            <a href="${pageContext.request.contextPath}/public/login.action" class="link-login">返回登陆</a>
        </p>
    </div>
</div>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/findpassword-min.css">
    <script type="text/javascript">
        
        (function checkBrownser(){
            var agent=navigator.appName //获取浏览器名字
            var version=navigator.appVersion.split(";"); //获取浏览器详细信息
            var trim_Version=version[1].replace(/[ ]/g,"");//获取浏览器版本号
            var model = document.documentMode;
            var floor = document.getElementById("warning");
            var loadingFloor = document.getElementById("loading-file-floor");

            if(agent=="Microsoft Internet Explorer" && (trim_Version=="MSIE7.0" || trim_Version=="MSIE8.0" || trim_Version=="MSIE9.0") || model < 10) { 
                floor.style.display = "block";
            }else{
                floor.style.display = "none";
            }
        }());
        
    </script>
</body>
</html>