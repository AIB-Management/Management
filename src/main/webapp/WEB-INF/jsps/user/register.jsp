<%@ page import="java.util.List" %>
<%@ page import="com.gdaib.pojo.Department" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"> 
	<title>注册</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jsdist/require.min.js"
			defer async="true" data-main="${pageContext.request.contextPath}/resources/jsdist/registerMain-min.js?t=170612-23"></script>
</head>
<body>
	<div id="warning">
		<p>促进互联网水平发展，你我共同有责 :)</p>
		<p>导致这样的问题：<br>1、你使用的浏览器是兼容ie模式 请切换其兼容；<br>2、你的浏览器版本太旧，请点击下面两个图标下载新版本浏览器<br>感谢你的合作</p>
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
		<form action="${pageContext.request.contextPath}/public/doRegister.action " method="post" class="form-content" id="all-input">
			<h3 class="form-title">用户注册</h3>
			<p class="input-wrap">
				<label>教师姓名</label>
				<input type="text" class="reg-input-style" id="tname" name="name" value="${RegisterPojo.name}">
				<span class="hint"></span>
			</p>
			<p class="input-wrap">
				<label>账号</label>
				<input type="text" class="reg-input-style" id="account" name="username" value="${RegisterPojo.username}">
				<span class="hint"></span>
			</p>
			<p class="input-wrap">
				<label>密码</label>
				<input type="password" class="reg-input-style" id="password" name="pwd" value="${RegisterPojo.pwd}">
				<span class="hint"></span>
			</p>
			<p class="input-wrap">
				<label>确认密码</label>
				<input type="password" class="reg-input-style" name="confirmpwd" id="confirmpwd" value="${RegisterPojo.confirmpwd}">
				<span class="hint"></span>
			</p>
			<p class="input-wrap">
				<label class="select-spec-tag">选择专业</label>
				<select id="department" name="departmentId">

					<option value="">请选择系别</option>

					<c:forEach items="${department}" var="dp">
						<c:if test="${RegisterPojo.departmentId ==dp.uid}">
							<option value="${dp.uid}" selected>${dp.content}</option>
						</c:if>
						<c:if test="${RegisterPojo.departmentId !=dp.uid}">
							<option value="${dp.uid}" >${dp.content}</option>
						</c:if>
					</c:forEach>
				</select>
				<select id="special" name="depUid" >

					<option value="">请选择专业</option>

					<c:if test="${pros!=null}">
						<c:forEach items="${pros}" var="pro">
							<c:if test="${pro.uid == RegisterPojo.depUid}">
								<option value="${pro.uid}" selected>${pro.pro}</option>
							</c:if>
							<c:if test="${pro.uid != RegisterPojo.depUid}">
								<option value="${pro.uid}" >${pro.pro}</option>
							</c:if>
						</c:forEach>
					</c:if>
				</select>
			</p>
			<p class="input-wrap">
				<label>邮箱</label>
				<input type="text" class="reg-input-style" id="mail" name="email" value="${RegisterPojo.email}">
				<span class="hint"></span>
			</p>
			<p class="input-wrap">
				<label>验证码</label>
				<input type="text" id="vtCode" name="vtCode">
				<img src="${pageContext.request.contextPath}/public/getCaptcha.action" id="vt-img">
				<a href="#" id="change-vt-code">换一个</a>
				<span class="hint">${error}</span>
			</p>
		</form>
		<p class="btn-wrap">
			<button id="complete-reg">注册</button>
			<a href="${pageContext.request.contextPath}/public/login.action" class="link-login">已有账号，直接登陆</a>
		</p>
	</div>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/registerMain-min.css?20170508-2">
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