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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</head>
<body>
	<div class="form-wrap">
		<div class="form-content">
			<h3>请选择系别</h3>
			<select id="department" name="">
				<option value="">请选择系别</option>
				<c:forEach items="${department}" var="dp">
					<option value="${dp.id}">${dp.department}</option>
				</c:forEach>
			</select>
			<p class="input-wrap">
				<button id="enter">进入</button>
			</p>
		</div>
	</div>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/selectdepartment.css">
</body>
</html>