<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<%@ page import="java.util.List" %>
<%@ page import="com.gdaib.pojo.Department" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/> 
	<title>管理员页</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jsdist/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/jsdist/rootpageMain-min.js"></script>
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
	<div id="modify-admin-email-floor">
		<div class="modify-admin-email-wrap">
			<div class="close-btn clearfix">
				<button type="button" class="close" aria-label="Close" id="modifyadminemail-close-btn">×</button>
			</div>
			<h3>修改邮箱</h3>
			<div class="modifyemail-input-wrap">
				<label>新邮箱</label>
				<input type="text" name="email" id="newEmail">
				<p id="modify-new-email-hint"></p>
			</div>
			<div class="modifyemail-input-wrap">
				<button class="btn btn-primary" disabled="true" id="confirm-modifyemail">修改</button>
			</div>
		</div>
	</div>
	<!-- 修改已审核用户系别及专业对话框开始 -->
	<div id="modify-user-department-floor">
		<div class="modify-dep-dialog-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="modify-user-departmetn-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>修改用户系别专业</h3>
			<div class="select-wrap">
				<select id="user-dep">
					<option value="">请选择系别</option>
				</select>
				<select id="user-spec">
					<option value="">请选择专业</option>
				</select>
			</div>
			<div class="modify-dep-btn">
				<button class="btn btn-warning btn-sm" id="confirm-modify-dep">
					<span class="glyphicon glyphicon-erase"></span> 
					确认修改
				</button>
			</div>
		</div>
	</div>
	<!-- 修改已审核用户系别及专业对话框结束 -->
	<!-- 撤回管理员对话框开始 -->
	<div id="recall-admin-dialog-floor">
		<div class="manage-admin-dialog-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="recall-admin-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>撤回管理员</h3>
			<p class="recall-admin-hint">你确定要撤回<b id="recall-admin-name"></b>的管理员身份吗？</p>
			<div class="recall-admin-btn">
				<button class="btn btn-success btn-sm" id="cancel-recall-admin">
				<span class="glyphicon glyphicon-remove"></span> 
				取消
			</button>
			<button class="btn btn-danger btn-sm" id="confirm-recall-admin">
				<span class="glyphicon glyphicon-erase"></span> 
				确认
			</button>
			</div>
		</div>
	</div>
	<!-- 撤回管理员对话框结束 -->
	<!-- 撤回领导对话框开始 -->
	<div id="recall-leader-dialog-floor">
		<div class="manage-leader-dialog-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="recall-leader-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>撤回领导</h3>
			<p class="recall-leader-hint">你确定要撤回<b id="recall-leader-name"></b>的领导身份吗？</p>
			<div class="recall-leader-btn">
				<button class="btn btn-success btn-sm" id="cancel-recall-leader">
				<span class="glyphicon glyphicon-remove"></span> 
				取消
			</button>
			<button class="btn btn-danger btn-sm" id="confirm-recall-leader">
				<span class="glyphicon glyphicon-erase"></span> 
				确认
			</button>
			</div>
		</div>
	</div>
	<!-- 撤回领导员对话框结束 -->
	<!-- 管理部门模块模态框开始 -->
	<div id="manage-department-floor">
		<div id="new-department-dialog">
			<div class="close-btn clearfix">
				<button type="button" id="new-department-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>新建系别</h3>
			<div class="department-content">
				<label>系别名称</label>
				<input type="text" id="new-department-name">
				<p id="new-department-hint"></p>
			</div>
			<div class="department-content">
				<button class="btn btn-primary btn-sm" id="confirm-new-department">
					<span class="glyphicon glyphicon-ok"></span> 
					提交
				</button>
			</div>
		</div>
		<div id="new-specialy-dialog">
			<div class="close-btn clearfix">
				<button type="button" id="new-specialy-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>新建专业</h3>
			<div class="department-content">
				<label>专业名称</label>
				<input type="text" id="new-specialy-name">
				<p id="new-specialy-hint"></p>
			</div>
			<div class="department-content">
				<button class="btn btn-primary btn-sm" id="confirm-new-specialy">
					<span class="glyphicon glyphicon-ok"></span> 
					提交
				</button>
			</div>
		</div>
		<div id="modify-specialy-dialog">
			<div class="close-btn clearfix">
				<button type="button" id="modify-specialy-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>修改专业</h3>
			<div class="department-content">
				<label>专业名称</label>
				<input type="text" id="modify-specialy-name">
				<p id="modify-specialy-hint"></p>
			</div>
			<div class="department-content">
				<button class="btn btn-primary btn-sm" id="confirm-modify-specialy">
					<span class="glyphicon glyphicon-ok"></span> 
					提交
				</button>
			</div>
		</div>
		<div id="modify-department-dialog">
			<div class="close-btn clearfix">
				<button type="button" id="modify-department-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>修改系别</h3>
			<div class="department-content">
				<label>部门系别</label>
				<input type="text" id="modify-department-name">
				<p id="modify-department-hint"></p>
			</div>
			<div class="department-content">
				<button class="btn btn-primary btn-sm" id="confirm-modify-department">
					<span class="glyphicon glyphicon-ok"></span> 
					提交
				</button>
			</div>
		</div>
		<div id="drop-department-dialog">
			<h3 class="department-operate-title">删除系别</h3>
			<p class="department-operate-wraming">确定要删除<b id="drop-dep-name"></b>吗？如果此系别下有专业存在会出现异常</p>
			<div class="department-operate-btn">
				<button class="btn btn-success btn-sm" id="cancel-drop-dep">
					<span class="glyphicon glyphicon-remove"></span> 
					取消
				</button>
				<button class="btn btn-danger btn-sm" id="confirm-drop-dep">
					<span class="glyphicon glyphicon-trash"></span> 
					删除
				</button>
			</div>
		</div>
		<div id="drop-specialy-dialog">
			<h3 class="department-operate-title">删除专业</h3>
			<p class="department-operate-wraming">确定要删除<b id="drop-spec-name"></b>吗？如果此专业下有教师存在会出现异常</p>
			<div class="department-operate-btn">
				<button class="btn btn-success btn-sm" id="cancel-drop-spec">
					<span class="glyphicon glyphicon-remove"></span> 
					取消
				</button>
				<button class="btn btn-danger btn-sm" id="confirm-drop-spec">
					<span class="glyphicon glyphicon-trash"></span> 
					删除
				</button>
			</div>
		</div>
		<div class="manage-department-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="manage-department-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>管理系别及专业</h3>
			<div class="manage-department-toolbar">
				<button class="btn btn-primary btn-sm" id="add-department">
					<span class="glyphicon glyphicon-plus"></span> 
					新建系别
				</button>
				<button class="btn btn-success btn-sm" id="modify-department">
					<span class="glyphicon glyphicon-edit"></span> 
					修改系别
				</button>
				<button class="btn btn-danger btn-sm" id="drop-department">
					<span class="glyphicon glyphicon-trash"></span> 
					删除系别
				</button>
				<button class="btn btn-default btn-sm" id="add-speciality">
					<span class="glyphicon glyphicon-plus"></span> 
					增加专业
				</button>
			</div>
			<div class="manage-department-main clearfix">
				<div id="manage-dep-list-wrap">
					<ul class="manage-department-main-sidebar" id="manage-department-list"></ul>
				</div>
				<div class="manage-department-maincontent">
					<table class="table table-striped table-hover">
						<tbody class="speciality-list-wrap" id="speciality-list-content"></tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div id="manage-file-floor">
		<!-- 修改文件夹名模态框 -->
		<div id="modify-file-name-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="modify-flodername-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>修改文件夹名</h3>
			<div class="input-wrap">
				<div class="self-input-group">
					<label class="hint">文件名</label>
					<input type="text" id="rename-file">
				</div>
				<p id="modify-msg-hint"></p>
			</div>
			<div class="input-wrap">
				<div class="self-input-group btn-align">
					<button class="btn btn-primary disabled" id="rename-submit" disabled="true">重命名</button>
				</div>
			</div>
		</div>
		<div id="new-file-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="new-floder-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>新建文件夹</h3>
			<div class="input-wrap">
				<div class="self-input-group">
					<label class="hint">文件名</label>
					<input type="text" id="new-file-name">
				</div>
				<p id="newfloder-msg-hint"></p>
			</div>
			<div class="input-wrap">
				<div class="self-input-group btn-align">
					<button class="btn btn-primary disabled" id="newfloder-submit" disabled="true">新建</button>
				</div>
			</div>
		</div>
		<div id="drop-floder-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="drop-floder-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>删除文件夹</h3>
			<div class="drop-floder-msg">
				<p>你确认要删除如下：</p>
				<b id="target-floder-name"></b>
				<p>这（几个/个）文件夹吗？若当前文件夹下有子目录此操作会造成异常！</p>
			</div>
			<div class="drop-floder-btn">
				<button class="btn btn-success" id="cancel-drop-floder">
					<span class="glyphicon glyphicon-remove"></span> 
					取消
				</button>
				<button class="btn btn-danger" id="confirm-drop-floder">
					<span class="glyphicon glyphicon-trash"></span> 
					删除
				</button>
				<img src="${pageContext.request.contextPath}/resources/images/loading.gif" alt="" id="drop-floder-loading-icon">
			</div>
		</div>
		<div id="drop-file-wrap">
			<div class="close-btn clearfix">
				<button type="button" id="drop-file-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>删除文件</h3>
			<p class="drop-floder-msg">你确认要删除<b id="target-file-name"></b>这个文件吗？</p>
			<div class="drop-floder-btn">
				<button class="btn btn-success" id="cancel-drop-file">
					<span class="glyphicon glyphicon-remove"></span> 
					取消
				</button>
				<button class="btn btn-danger" id="confirm-drop-file">
					<span class="glyphicon glyphicon-trash"></span> 
					删除
				</button>
				<img src="${pageContext.request.contextPath}/resources/images/loading.gif" alt="" id="drop-file-loading-icon">
			</div>
		</div>
		<!-- 修改导航弹出层内容 -->
		<div class="filemanage-info">
			<div class="close-btn clearfix">
				<button type="button" id="filemanage-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<div class="manage-tool-bar">
				<button class="btn btn-primary btn-sm" id="newfloder-btn">
					<span class="glyphicon glyphicon-plus"></span> 
					新建文件夹
				</button>
				<button class="btn btn-default btn-sm" id="drop-floder-btn">
					<span class="glyphicon glyphicon-trash"></span> 
					删除文件夹
				</button>
			</div>
			<div class="crumb-nav">
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
			<div class="manage-nav-main clearfix">
				<div id="manage-side-bar">
					<h3>请选择系别</h3>
					<ul id="manage-side-item"></ul>
				</div>
				<div class="manage-main-content">
					<div class="content-title">
						<div class="title-1">选择</div>
						<div class="title-2">文件夹名</div>
						<div class="title-3">操作</div>
					</div>
					<div class="file-content-item">
						<table class="table table-striped table-hover">
							<tbody class="file-list-wrap" id="file-list-content"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="floor">
		<!-- 拒绝用户注册回馈信息弹出层 -->
		<div id="refuse-info">
			<div class="close-btn-wrap clearfix">
				<button type="button" id="refuse-close-btn" class="close" aria-label="Close">×</button>
			</div>
			<h3>拒绝信息填写</h3>
			<p class="refuse-info-wrap refuse-hint">
				<span class="operate-hint">你可以为<b id="refuse-username"></b>发送拒绝信息,以便用户可以获知账号的实时状态</span>
			</p>
			<p class="refuse-info-wrap">
				<label>拒绝理由</label>
				<textarea id="refuse-content"></textarea>
			</p>
			<p class="refuse-info-wrap">
				<button type="button" class="btn btn-success disabled" id="send-refuse-info" disabled="disabled">
					<span class="glyphicon glyphicon-send"></span> 
					发送
				</button>
				<button type="button" class="btn btn-danger" id="no-refuse-reason">
					<span class="glyphicon glyphicon-alert"></span>
					不发送拒绝消息
				</button>
				<img src="${pageContext.request.contextPath}/resources/images/loading.gif" alt="" id="refuse-user-loading-icon" class="loading-icon">
			</p>
		</div>

		<!-- 撤回用户弹出层 -->
		<div id="recall-user">
			<p class="recall-user-wrap">
				<span class="operate-hint">你确认要撤回<b id="recall-username">xxx</b>用户的使用权限吗？</span>
			</p>
			<p class="recall-user-wrap">
				<label>撤回理由</label>
				<textarea id="recall-content"></textarea>
			</p>
			<p class="recall-user-wrap">
				<button type="button" class="btn btn-success" id="cancel-recall-user">
					<span class="glyphicon glyphicon-remove"></span> 
					取消
				</button>
				<button type="button" class="btn btn-danger" id="confirm-recall-user" disabled="disabled">
					<span class="glyphicon glyphicon-erase"></span> 
					确认
				</button>
				<img src="${pageContext.request.contextPath}/resources/images/loading.gif" alt="" id="recall-user-loading-icon" class="loading-icon">
			</p>
		</div>
	</div>
	<!-- 弹出层结束 -->

	<div class="wrapper">
		<div class="header clearfix">
			<div class="title-wrap">
				<h3 title='<shiro:principal property="uid"/>' id="page-header-title">后台管理页</h3>
			</div>
			<div class="logout-btn-wrap">
				<a id="modify-email-btn" href="#">
					<span class="glyphicon glyphicon-glyphicon glyphicon-envelope"></span>
					修改注册邮箱
				</a>
				<a id="modify-pwd-btn" href="${pageContext.request.contextPath}/public/modifyPassword.action">
					<span class="glyphicon glyphicon-lock"></span>
					修改密码
				</a>
				<a id="logout-btn" href="${pageContext.request.contextPath}/shiro/logout">
					<span class="glyphicon glyphicon-off"></span>
					退出
				</a>
			</div>
		</div>
		<div class="mainbody">
			<div class="side-bar">
				<div class="item-wrap-1">
					<div id="tag-manage" class="sidebar-tag-header">各系信息管理</div>
					<ul class="child-tag-wrap">
						<li id="manage-floder">
							<span class="glyphicon glyphicon-folder-close"></span> 
							信息文档管理
						</li>
					</ul>
				</div>
				<div class="item-wrap-2">
					<div id="user-manage" class="sidebar-tag-header">系别及专业使用权限管理</div>
					<ul class="child-tag-wrap">
						<li id="manage-department">
							<span class="glyphicon glyphicon-home"></span> 
							管理系别及专业
						</li>
					</ul>
				</div>
				<div class="item-wrap-3">
					<div id="user-manage" class="sidebar-tag-header">用户审核</div>
					<ul class="child-tag-wrap">
						<li class="child-tag" id="unexamie-tag">
							<span class="glyphicon glyphicon-question-sign"></span> 
							待审核
							<span id="number-hints">15</span></li>
						<li class="child-tag" id="examied-tag">
							<span class="glyphicon glyphicon-ok-sign"></span> 
							已审核
						</li>
						<li class="child-tag" id="manage-leader-admin">
							<span class="glyphicon glyphicon-user"></span> 
							领导及管理员管理
						</li>
					</ul>
				</div>
			</div>
			<div class="content">
				<div class="welcome-hint">
					<p class="icon">
						<span class="glyphicon glyphicon-tasks"></span>
					</p>
					<p class="icon-text">你当前还没有选择操作项</p>
				</div>
				<!-- 右侧待审核用户列表模块 -->
				<div class="content-wrap">
					<div class="unexamie-wrap" id="unexamie-main-content-wrap">
						<table id="unexamie" class="message-list table table-striped table-hover" cellspacing="0">
							<thead>
								<tr class="list-selectbox">
									<th><input type="checkbox" id="unexamie-select-all">全选</th>
									<th>姓名</th>
									<th>账号</th>
									<th>系别</th>
									<th>专业</th>
									<th class="list-operate">操作</th>
								</tr>
							</thead>
							<tbody id="unexamie-main-content"></tbody>
						</table>

						<!-- 批量通过，批量拒绝按钮包裹层 -->
						<div class="batcn-opetate-btn-wrap">
							<button class="btn btn-success btn-md" id="unexamie-pass-all">
								<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 
								批量通过
							</button>
							<button class="btn btn-danger btn-md" id="unexamie-refuse-all">
								<span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span> 
								批量拒绝
							</button>
						</div>
						<!-- 待审核列表分页组建包裹层 -->
						<div class="divid-page-wrap">
							<nav aria-label="Page navigation">
							  <ul class="pagination" id="unexamie-pagination-content"></ul>
						</nav>
					</div>
				</div>
			</div>
			<!-- 右侧待审核用户列表模块结束 -->			
	
	
			<!-- 右侧已审核用户列表模块 -->
			<div class="content-wrap">
				<div class="examie-wrap">
					<span>筛选</span>
					<select id="examie-filter" class="filter-style">
						<option value="">全部</option>
					</select>
					<table id="examied" class="message-list table table-striped table-hover">
						<thead>
							<tr>
								<th class="list-selectbox">
									<input type="checkbox" id="examied-select-all">全选
								</th>
								<th>姓名</th>
								<th>账号</th>
								<th>系别</th>
								<th>专业</th>
								<th class="list-operate">操作</th>
							</tr>
						</thead>
						<tbody id="examied-main-content"></tbody>
					</table>
					<!-- 批量撤回按钮包裹层 -->
					<div class="batcn-opetate-btn-wrap">
						<button class="btn btn-danger btn-md" id="examie-recall-all">
							<span class="glyphicon glyphicon-erase" aria-hidden="true"></span> 
							批量撤回
						</button>
					</div>
					<!-- 已审核列表分页组建包裹层 -->
					<div class="divid-page-wrap">
						<nav aria-label="Page navigation">
						  <ul class="pagination" id="examied-pagination-content"></ul>
						</nav>
					</div>
				</div>
			</div>
			<!-- 右侧已审核用户列表模块 -->
			<!-- 右侧领导及管理员管理模块 -->
			<div class="content-wrap manage-leader-admin-content">
				<div class="admin-list-wrap">
					<h3>当前注册的管理员列表</h3>
					<div class="admin-list-title">
						<div>教师姓名</div>
						<div>所属系别</div>
						<div>所属专业</div>
						<div>操作</div>
					</div>
					<div class="admin-list-table-wrap">
						<table class="table table-striped table-hover">
							<tbody id="admin-list"></tbody>
						</table>
					</div>
				</div>
				<div class="leader-list-wrap">
					<h3>当前注册的领导列表</h3>
					<div class="leader-list-title">
						<div>教师姓名</div>
						<div>所属系别</div>
						<div>所属专业</div>
						<div>操作</div>
					</div>
					<div class="leader-list-table-wrap">
						<table class="table table-striped table-hover">
							<tbody id="leader-list"></tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- 右侧领导及管理员管理模块 -->
		 </div>
	  </div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mCustomScrollbar.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/rootpage-min.css">
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
