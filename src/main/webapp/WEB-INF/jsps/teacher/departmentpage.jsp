<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/> 
	<title><shiro:principal property="depContent"/>主页</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/departmentpageMain.js?20170615-13"></script>
</head>
<body>
	<div id="upload-file-floor">
		<div class="upload-file-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="uploadfile-close-btn" class="close" aria-label="Close">×</button>
			</div>
				<h3 class="upload-file-title">上传文件</h3>
			<div class="select-identify">
				<label>选择发布身份</label>
				<select id="all-identifies-list">
					<option value='<shiro:principal property="uid"/>'>本人</option>
				</select>
			</div>
			<div class="upload-file-input">
				<label>文件标题</label>
				<input type="text" id="fileTitle">

			</div>
			<div class="upload-file-dropzone">
				<input type="file" name="file" id="fileupload" multiple="true">
			</div>
			<div class="upload-file-btn">
				<p id="filetitle-hint"></p>
				<button class="btn btn-success disabled" disabled="true" id="upload-batchfile">
					<span class="glyphicon glyphicon-cloud-upload"></span> 
					上传
				</button>
			</div>
		</div>
	</div>
	<!-- 权限管理弹出层 -->
	<div id="authority-manage-floor">
		<div class="authority-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="authority-manage-close-btn" class="close" aria-label="Close">&times;</button>
			</div>
			<h3>权限管理</h3>
			<div class="authority-list-content">
				<div class="has-authoritied-list-wrap">
					<h4 class="table-title">未授权列表</h4>
					<div class="authoritied-list-head">
						<div class="authority-teacher-name">教师姓名</div>
						<div class="authority-operate">操作</div>
					</div>
					<div class="authoritied-tabel-wrap">
						<table class="table table-striped table-hover">
							<tbody id="can-authoritied-list"></tbody>
						</table>
					</div>
				</div>
				<div class="can-authoritied-list-wrap">
					<h4 class="table-title">已授权列表</h4>
					<div class="authoritied-list-head">
						<div class="authority-teacher-name">教师姓名</div>
						<div class="authority-operate">操作</div>
					</div>
					<div class="authoritied-tabel-wrap">
						<table class="table table-striped table-hover">
							<tbody id="has-authoritied-list"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="drop-file-floor">
		<div class="drop-file-dialog-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="drop-file-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>删除文件</h3>
			<p class="drop-file-content">
				你确定要删除<b id="drop-files-name"></b>这个文件吗？
			</p>
			<div class="drop-file-btn-wrap">
				<button class="btn btn-success btn-sm" id="cancel-drop-file">
					<span class="glyphicon glyphicon-remove"></span> 
					取消
				</button>
				<button class="btn btn-danger btn-sm" id="confirm-drop-file">
					<span class="glyphicon glyphicon-trash"></span> 
					删除
				</button>
			</div>
		</div>
	</div>
	<div id="modify-filename-floor">
		<div class="modify-filename-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="modify-filename-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>修改文件标题名称</h3>
			<div class="modify-filename-content">
				<label>文件名</label>
				<input type="text" id="new-filename">
				<p id="new-filename-hint"></p>
			</div>
			<div class="modify-filename-content">
				<button class="btn btn-primary btn-sm disabled" id="submit-newfilename" disabled="true">修改</button>
			</div>
		</div>
	</div>
	<div class="wrapper">
		<div class="header">
			<div class="title-wrap">
				<h3 id="departmentId" title='<shiro:principal property="departmentId"/>'><shiro:principal property="depContent"/>主页</h3>
			</div>
			
			<a href="${pageContext.request.contextPath}/shiro/logout" id="logout-btn">
				<span class="glyphicon glyphicon-off"></span> 
				退出
			</a>
			<span class="over-ride">|</span>
			<div class="header-tag" id="user-name-wrap">
				<span id="user-name" title='<shiro:principal property="uid"/>'><shiro:principal property="name"/></span>
			</div>
			<div id="user-operate">
				<ul>
					<li><a href="${pageContext.request.contextPath}/content/personalpage.action" id="link-modify-personalinfo">个人信息</a></li>
					<li><a href="${pageContext.request.contextPath}/public/modifyPassword.action">修改密码</a></li>
					<shiro:hasPermission name="runas:query">
						<li><a href="#" id="authority-manage-enter">权限管理</a></li>
					</shiro:hasPermission>

				</ul>
			</div>
		</div>
		<div id="bread-crumb">
			<b class="crumb-hint">当前路径：</b>
			<ul class="breadcrumb" id="breadcurmb-nav-wrap"></ul>
			<div id="hidden-meun-item-btn">
				<button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="show-hidden-menu">
					<span class="caret"></span>
				</button>
				<div id="overflow-item-wrap">
					<ul></ul>
				</div>
			</div>
		</div>
		

		<div class="mainbody">
			<div class="content">
				<div class="main-tool-bar">
					<shiro:hasPermission name="file:add">
					<button class="btn btn-primary btn-sm" id="upload-file-btn">
						<span class="glyphicon glyphicon-cloud-upload"></span>
						上传文件
					</button>
					</shiro:hasPermission>
				</div>
				<div class="main-content-title">
					<div class="content-select">选择</div>
					<div class="content-name">名称</div>
					<div class="content-author">上传者</div>
					<div class="content-publish-time">上传时间</div>
					<div class="content-edit-btn">操作</div>
				</div>
				<table class="table table-striped table-hover main-content-wrap">
					<tbody id="main-content-list"></tbody>
				</table>
			</div>
		</div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mCustomScrollbar.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fileinput.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/departmentpage.css?20170607-10">
</body>
</html>