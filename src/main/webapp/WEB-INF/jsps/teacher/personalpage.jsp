<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
				<span id="personal-name">${AccountInfo.name}</span>
			</p>
			<p class="personal-info-wrap">
				<span>账号</span>
				<span id="personal-account">${AccountInfo.username}</span>
			</p>
			<p class="personal-info-wrap">
				<span>系别</span>
				<span id="personal-department">${AccountInfo.department}</span>
			</p>
			<p class="personal-info-wrap">
				<span>专业</span>
				<span id="personal-specified">${AccountInfo.profession}</span>
			</p>
			<p class="personal-info-wrap">
				<span>邮箱</span>
				<span id="personal-email">${AccountInfo.mail}</span>
			</p>
		</div>
	</div>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/personalpage.css">
</body>
</html>