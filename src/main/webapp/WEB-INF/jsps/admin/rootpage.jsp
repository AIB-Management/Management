<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="com.gdaib.pojo.Department" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/> 
	<title>管理员页</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/rootpageMain.js?20170518-8"></script>
</head>
<body>
	<div id="manage-file-floor">
		<!-- 修改文件夹名对话框 -->
		<div id="modify-file-name-wrap">
			<div class="close-btn clearfix">
				<button type="button" class="close" aria-label="Close" id="modify-flodername-close-btn"><span aria-hidden="true">&times;</span></button>
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
				<button type="button" class="close" aria-label="Close" id="new-floder-close-btn"><span aria-hidden="true">&times;</span></button>
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
				<button type="button" class="close" aria-label="Close" id="drop-floder-close-btn"><span aria-hidden="true">&times;</span></button>
			</div>
			<h3>删除文件夹</h3>
			<p class="drop-floder-msg">你确认要删除<b id="target-floder-name"></b>这（几个/个）文件夹吗？若当前文件夹下有子目录此操作会造成异常！</p>
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
		<!-- 修改导航弹出层内容 -->
		<div class="filemanage-info">
			<div class="close-btn clearfix">
				<button type="button" class="close" aria-label="Close" id="filemanage-close-btn"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="manage-tool-bar">
				<button class="btn btn-primary btn-sm" id="newfloder-btn">
					<span class="glyphicon glyphicon-plus"></span> 
					新建文件夹
				</button>
				<button class="btn btn-default btn-sm" id="drop-floder-btn">
					<span class="glyphicon glyphicon-trash" id="dropfloder-btn"></span> 
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
				<ul id="overflow-item-wrap"></ul>
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
				<button type="button" class="close" aria-label="Close" id="refuse-close-btn"><span aria-hidden="true">&times;</span></button>
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
				<button type="button" id="send-refuse-info" disabled="disabled">发送</button>
				<button type="button" id="no-refuse-reason">不发送拒绝消息</button>
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
				<button type="button" id="cancel-recall-user">取消</button>
				<button type="button" id="confirm-recall-user" disabled="disabled">确认</button>
				<img src="${pageContext.request.contextPath}/resources/images/loading.gif" alt="" id="recall-user-loading-icon" class="loading-icon">
			</p>
		</div>
	</div>
	<!-- 弹出层结束 -->

	<div class="wrapper">
		<div class="header clearfix">
			<div class="title-wrap">
				<h3>后台管理页</h3>
			</div>
			<div class="logout-btn-wrap">
				<a id="logout-btn" href="${pageContext.request.contextPath}/shiro/logout">退出</a>
			</div>
		</div>
		<div class="mainbody">
			<div class="side-bar">
				<div class="item-wrap-1">
					<div id="tag-manage" class="sidebar-tag-header">各系信息管理</div>
					<ul class="child-tag-wrap">
						<li id="manage-floder">信息文档管理</li>
					</ul>
				</div>
				<div class="item-wrap-2">
					<div id="user-manage" class="sidebar-tag-header">用户审核</div>
					<ul class="child-tag-wrap">
						<li class="child-tag" id="unexamie-tag">待审核<span id="number-hints">15</span></li>
						<li class="child-tag" id="examied-tag">已审核</li>
					</ul>
				</div>
			</div>
			<div class="content">
				<!-- 右侧待审核用户列表模块 -->
				<div class="content-wrap">
					<div class="unexamie-wrap" id="unexamie-main-content-wrap">
						<table id="unexamie" class="message-list table table-striped table-hover" cellspacing="0">
							<thead>
								<tr>
									<th><input type="checkbox" id="unexamie-select-all">全选</th>
									<th>姓名</th>
									<th>系别</th>
									<th>专业</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody id="unexamie-main-content">
								<tr>
									<td><input type="checkbox" class="unexamie-select"></td>
									<td title="1">老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="pass btn btn-success btn-sm">
											<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 	
											通过
										</button>
										<button class="refuse btn btn-danger btn-sm">
											<span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span> 
											拒绝申请
										</button>
									</td>
								</tr>
							</tbody>
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
							  <ul class="pagination" id="unexamie-pagination-content">
							  	<li>
							      <a href="#" aria-label="homepage">首页</a>
							    </li>
							    <li>
							      <a href="#" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							      </a>
							    </li>
							    <li><a href="#">1</a></li>
							    <li><a href="#">2</a></li>
							    <li><a href="#">3</a></li>
							    <li><a href="#">4</a></li>
							    <li><a href="#">5</a></li>
							    <li>
							      <a href="#" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
							      </a>
							    </li>
							    <li>
							      <a href="#" aria-label="lastpage">末页</a>
							    </li>
								</ul>
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
					<table id="examied" class="message-list table table-striped table-hover" cellspacing="0">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="examied-select-all">全选
								</th>
								<th>姓名</th>
								<th>系别</th>
								<th>专业</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="examied-main-content">
							<tr>
								<td>
									<input type="checkbox" class="examied-select">
								</td>
								<td title="1">老师1</td>
								<td>计算机系</td>
								<td>移动互联应用技术</td>
								<td>
									<button class="recall btn btn-danger btn-sm" type="button">
										<span class="glyphicon glyphicon-erase" aria-hidden="true"></span>
										撤回
									</button>
								</td>
							</tr>
						</tbody>
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
						  <ul class="pagination" id="examied-pagination-content">
						  	<li>
						      <a href="#" aria-label="Previous">首页</a>
						    </li>
						    <li>
						      <a href="#" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
						    <li><a href="#">1</a></li>
						    <li><a href="#">2</a></li>
						    <li><a href="#">3</a></li>
						    <li><a href="#">4</a></li>
						    <li><a href="#">5</a></li>
						    <li>
						      <a href="#" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
						    <li>
						      <a href="#" aria-label="Previous">末页</a>
						    </li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			<!-- 右侧已审核用户列表模块 -->
			</div>
		</div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/rootPage.css?20170510-38">
</body>
</html>
