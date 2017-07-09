<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人信息</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/personalpageMain.js"></script>
</head>
<body>
	<div id="modify-personal-email-floor">
		<div class="modify-personal-email-wrap">
			<div class="close-btn clearfix">
				<button type="button" class="close" aria-label="Close"><span aria-hidden="true" id="modifyemail-close-btn">&times;</span></button>
			</div>
			<h3>修改邮箱</h3>
			<div class="input-wrap">
				<label>新邮箱</label>
				<input type="text" name="email" id="newEmail">
				<p id="modify-new-email-hint"></p>
			</div>
			<div class="input-wrap">
				<button class="btn btn-primary" disabled="true" id="confirm-modifyemail">修改</button>
			</div>
		</div>
	</div>
	<div id="modify-personal-name-floor">
		<div class="modify-personal-name-wrap">
			<div class="close-btn clearfix">
				<button type="button" class="close" aria-label="Close"><span aria-hidden="true" id="modifyname-close-btn">&times;</span></button>
			</div>
			<h3>修改用户名</h3>
			<div class="input-wrap">
				<label>用户名</label>
				<input type="text" id="newUsername">
				<p id="modify-new-name-hint"></p>
			</div>
			<div class="input-wrap">
				<button class="btn btn-primary" disabled="true" id="confirm-modify">修改</button>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<div class="main-content">
			<h3>个人信息列表</h3>
			<p class="personal-info-wrap">
				<span>姓名</span>
				<span id="personal-name">${AccountInfo.name}<shiro:principal property="name"/></span>
				<a href="#" id="modify-btn">修改</a>
			</p>
			<p class="personal-info-wrap">
				<span>账号</span>
				<span id="personal-account">${AccountInfo.username}<shiro:principal property="username"/></span>
			</p>
			<p class="personal-info-wrap">
				<span>系别</span>
				<span id="personal-department">${AccountInfo.depContent}<shiro:principal property="depContent"/></span>
			</p>
			<p class="personal-info-wrap">
				<span>专业</span>
				<span id="personal-specified">${AccountInfo.content}<shiro:principal property="content"/></span>
			</p>
			<p class="personal-info-wrap">
				<span>邮箱</span>
				<span id="personal-email">${AccountInfo.mail}<shiro:principal property="mail"/></span>
				<a href="#" id="modify-email">修改</a>
			</p>
			<p class="personal-info-wrap">
				<a href="/Management/" class="return-homepage">返回主页</a>
			</p>
		</div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/personalpage-min.css">
</body>
</html>