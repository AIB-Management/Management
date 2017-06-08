<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>个人信息</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</head>
<body>
	<div class="wrapper">
		<div class="main-content">
			<h3>个人信息列表</h3>
			<p class="personal-info-wrap">
				<span>姓名</span>
				<span id="personal-name">${AccountInfo.name}<shiro:principal property="name"/></span>
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
			</p>
		</div>
	</div>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/personalpage.css">
</body>
</html>