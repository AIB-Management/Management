<%@ page import="java.util.List" %>
<%@ page import="com.gdaib.pojo.Department" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/>
	<meta charset="UTF-8">
	<title>选择系别</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jsdist/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/jsdist/selectdepMain-min.js"></script>
</head>
<body>
	<div class="form-wrap">
		<form class="form-content" action="/Management/content/toLeaderFromDep.action" method="post" id="select-dep-form">
			<h3>请选择系别</h3>
			<select id="department" name="departmentId">
				<option value="">请选择系别</option>
			</select>
			<p class="input-wrap">
				<button id="enter">进入</button>
			</p>
		</form>
	</div>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/selectdepartment-min.css">
</body>
</html>