<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/> 
	<title>主页</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/departmentpageMain.js?20170605-1"></script>
</head>
<body>
	<div id="release-msg-content">
		<form action=" " method="post" enctype="multipart/form-data">
			<div id="close-btn">×</div>

			<h3>上传文件</h3>
			<p class="release-msg-wrap">
				<span>文件标题</span>
				<input type="text" id="release-msg-title" name="file-title">
			</p>
			<p class="release-msg-wrap">
				<span>选择文件所属的导航栏</span>
				<select name="first-nav" id="first-nav-select">
					<option value="">请选择一级导航栏</option>
					<option value="1">一级导航栏</option>
					<option value="1">一级导航栏</option>
					<option value="1">一级导航栏</option>
					<option value="1">一级导航栏</option>
					<option value="1">一级导航栏</option>
				</select>
				<select name="second-nav" id="second-nav-select">
					<option value="">请选择二级导航栏</option>
					<option value="null">无</option>
					<option value="1">二级导航栏</option>
					<option value="1">二级导航栏</option>
					<option value="1">二级导航栏</option>
					<option value="1">二级导航栏</option>
					<option value="1">二级导航栏</option>
				</select>
				
			</p>
			<p class="release-msg-wrap">
				<input type="file" name="release-file" id="select-file">
			</p>
			<p class="release-msg-wrap">
				<input type="submit" value="提交" id="upload-file">
			</p>
		</form>
	</div>
	<div class="wrapper">
		<div class="header">
			<div class="title-wrap">
				<h3><shiro:principal property="department"/>主页</h3>
			</div>
			<div class="header-tag">
				<a href="${pageContext.request.contextPath}/content/toId.action" id="manage-msg">管理信息</a>
			</div>
			<div class="header-tag" id="add-file">
				<span id="release-msg">发布信息</span>
			</div>
			<div class="header-tag overide">
				<span>|</span>
			</div>
			<div class="header-tag" id="user-name-wrap">
				<span id="user-name"><shiro:principal property="name"/></span>
			</div>
			<div id="user-operate">
				<ul>
					<li><a href="${pageContext.request.contextPath}/content/personalpage.action">个人信息</a></li>
					<li><a href="${pageContext.request.contextPath}/public/modifyPassword.action">修改密码</a></li>
					<li id="logout-btn"><a href="${pageContext.request.contextPath}/shiro/logout">退出</a></li>
				</ul>
			</div>
		</div>
		<div id="bread-crumb">
			<b class="crumb-hint">当前路径：</b>
			<ol class="breadcrumb">
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
			</ol>
		</div>
		<div class="mainbody">
			<div class="content">
				<div id="main-content-wrap">
					<div class="file-wrap">
						<div class="file-icon floder"></div>
						<p class="file-name">文件夹名1</p>
					</div>
					<div class="file-wrap">
						<div class="file-icon file"></div>
						<p class="file-name">文件名1</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/departmentpage.css">
</body>
</html>