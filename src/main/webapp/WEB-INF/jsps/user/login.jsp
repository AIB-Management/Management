<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/> 
	<title>登录</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/loginMain.js?t=170504-1"></script>
</head>
<body>
	<div id="warning">
		<p>促进互联网水平发展，你我共同有责 :)</p>
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
	<div class="bg">
		<div class="welcome-txt">
			<h1>欢迎登陆</h1>
			<p>AIB专业信息管理系统</p>
		</div>
		<form action="${pageContext.request.contextPath}/public/doLogin.action" method="post" class="login-wrap">
			<div class="form-content">
				<div class="input-wrap">
					<p id="login-hint">${error}</p>
					<span class="input-icon">账号</span>
					<input type="text" name="username" class="input-content" id="account" placeholder="请输入账号" value="${username}<c:if test="${empty username}">${cookie.username.value}</c:if>">
				</div>
				<div class="input-wrap">
					<span class="input-icon">密码</span>
					<input type="password" name="pwd" class="input-content" id="pwd" placeholder="请输入密码" >
				</div>
				<div class="vt-code-wrap">
					<input type="text" name="vtCode" id="vt-code">
					<img src="${pageContext.request.contextPath}/public/getCaptcha.action" id="vt-img">
					<a href="#" id="change-vt-code">换一个</a>
					<p id="vt-code-hint"></p>
				</div>
				<button id="log-in" type="submit">登录</button>
				<label class="remember-me-wrap"><input type="checkbox" id="remember-me">3天内记住账号</label>
				<div class="link-wrap">
					<a href="${pageContext.request.contextPath}/public/findPassword.action">忘记密码</a>
					<span>|</span>
					<a href="${pageContext.request.contextPath}/public/register.action">注册</a>
				</div>
			</div>
		</form>
	</div>
	

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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css">
</body>
</html>