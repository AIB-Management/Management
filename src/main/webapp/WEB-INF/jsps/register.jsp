<%@ page import="java.util.List" %>
<%@ page import="com.gdaib.pojo.Department" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content = "IE=Edge" /> 
	<title>注册</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js"
			defer async="true" data-main="${pageContext.request.contextPath}/resources/js/registerMain"></script>
</head>
<body>
	<div class="form-wrap">
		<form action="${pageContext.request.contextPath}/public/doRegister.action " method="post" class="form-content" id="all-input">
			<h3 class="form-title">用户注册</h3>
			<p class="input-wrap">
				<label>教师姓名</label>
				<input type="text" class="reg-input-style" id="tname" name="name" value="${registerPojo.name}">
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
				<label>选择专业</label>
				<select id="department" name="departmentId">


					<%
						List<Department> departments = (List<Department>)session.getAttribute("department");
					    if(departments!=null){
					        for(Department department:departments) {
                                out.print("<option value=\""+department.getId()+"\">" + department.getDepartment() + "</option>");
                            }
                        }else{
					        out.print("<option value=\"1\"> 计算机系</option>");
                        }
                    %>
				</select>
				<select id="special" name="specialId" >

                    <!--
                    path:http://localhost:8080/Management/public/getProfessionJson.action?departmentID=1
                    param:departmentID
                    return :{"professionArr":[{"id":1,"profession":"软件技术","departmentId":1},{"id":2,"profession":"计算机应用基础","departmentId":1}]}
                    error:{"professionArr":"null"}
                    -->
					<option value="">请选择专业</option>
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
				<span class="hint"></span>
			</p>
			<p>${error}</p>
			<p class="input-wrap">
				<button id="complete-reg" type="submit">注册</button>
				<a href="${pageContext.request.contextPath}/public/login.action" class="link-login">已有账号，直接登陆</a>
			</p>
		</form>
	</div>

	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/register.css">
</body>
</html>