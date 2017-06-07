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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/rootpageMain.js?20170518-3"></script>
</head>
<body>
	<div id="floor">
		<!-- 修改导航弹出层内容 -->
		<form action="" method="post" id="modify-nav-info">
			<p class="close-btn-wrap"><span id="modify-nav-close-btn">×</span></p>
			<h3>修改导航信息</h3>
			<p class="modify-info-wrap">
				<label>导航名：</label>
				<input type="text" id="tag-name" class="modify-nav-info">
			</p>
			<p class="modify-info-wrap">
				<label>所属系别：</label>
				<select name="modifyDepartment" id="belong-department" class="modify-nav-info">
					<option value="0">财经系</option>
					<option value="1">计算机系</option>
					<option value="2">管理系</option>
					<option value="3">商务系</option>
					<option value="4">艺术系</option>
				</select>
			</p>
			<p class="modify-info-wrap">
				<label>二级导航明细：</label>
				<textarea name="second-childNav-content" id="childTagInfo" class="modify-nav-info"></textarea>
				<span id="modify-childNav-hint"></span>
			</p>
			<p class="modify-btn-wrap">
				<button id="modify-btn">确认修改</button>
			</p>
		</form>
		

		<!-- 删除导航栏提示信息弹出层 -->
		<div id="delete-nav">
			<p class="delete-nav-wrap">
				<span class="operate-hint">你确认要删除<b id="delete-navname">xxx</b>一级导航吗？此操作将不可回撤</span>
			</p>
			<p class="delete-nav-wrap">
				<button type="button" id="cancel-delete-nav">取消</button>
				<button type="button" id="confirm-delete-nav">确认</button>
				<img src="" alt="" id="deleteNav-loading-icon">
			</p>
		</div>


		<!-- 拒绝用户注册回馈信息弹出层 -->
		<div id="refuse-info">
			<p class="close-btn-wrap"><span id="refuse-close-btn">×</span></p>
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
					<div id="tag-manage" class="sidebar-tag-header">导航栏管理</div>
					<ul class="child-tag-wrap">
						<li class="child-tag sidebar-tag-active">添加导航栏</li>
						<li class="child-tag">修改/删除导航栏</li>
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

				<!-- 右侧添加导航栏模块 -->
				<div class="content-wrap">
					<div class="add-tag-wrap">
						<h3 class="add-tag-title">添加导航栏</h3>
						<p>导航名：<input type="text" id="father-tag-content"></p>
						<p>
							系别选择：
							<select id="add-tag-department" name="departmentId">
								<option value="">请选择系别</option>
								<c:forEach items="${department}" var="dp">
									<option value="${dp.id}">${dp.department}</option>
								</c:forEach>
							</select>
						</p>
						<p><input type="checkbox" id="has-child-tag">二级导航</p>
						<p id="child-tag-wrap">
							二级导航名：
							<input type="text" id="childTagContent">
							<span class="chile-tag-hint"></span>
						</p>
						<p>
							<button id="add-tag-btn" type="button">添加导航</button>
							<span id="add-tag-hint">已有此标签</span>
						</p>
					</div>
				</div>
				<!-- 右侧添加导航栏模块结束 -->

				<!-- 右侧删除/修改导航栏模块 -->
				<div class="content-wrap">
					<div class="modify-tag-wrap">
						<span>筛选</span>
						<select id="modify-tag-filter" class="filter-style" name="departmentId">
							<option value="全部">全部</option>
							<option value="计算机系">计算机系</option>
							<option value="管理系">管理系</option>
							<option value="商务系">商务系</option>
							<option value="财经系">财经系</option>
							<option value="热作系">热作系</option>
							<option value="机电系">机电系</option>
							<option value="BTEC国际交流学院">BTEC国际交流学院</option>
						</select>


						<table id="all-tag-list" class="message-list" cellspacing="0">
							<caption>已存在的导航栏</caption>
							<thead>
								<tr>
									<th>导航名</th>
									<th>系别</th>
									<th>二级导航栏</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td title="1">标签1</td>
									<td>计算机系</td>
									<td>二级导航栏,二级导航栏,二级导航栏,二级导航栏</td>
									<td>
										<button class="modify-tag">修改</button>
										<button class="delete-tag">删除</button>
									</td>
								</tr>
								<tr>
									<td title="2">标签1</td>
									<td>管理系</td>
									<td>二级导航栏,二级导航栏,二级导航栏,二级导航栏</td>
									<td>
										<button class="modify-tag">修改</button>
										<button class="delete-tag">删除</button>
									</td>
								</tr>
								<tr>
									<td title="3">标签1</td>
									<td>计算机系</td>
									<td>二级导航栏,二级导航栏,二级导航栏,二级导航栏</td>
									<td>
										<button class="modify-tag">修改</button>
										<button class="delete-tag">删除</button>
									</td>
								</tr>
								<tr>
									<td title="4">标签1</td>
									<td>计算机系</td>
									<td>二级导航栏,二级导航栏,二级导航栏,二级导航栏</td>
									<td>
										<button class="modify-tag">修改</button>
										<button class="delete-tag">删除</button>
									</td>
								</tr>
								<tr>
									<td title="5">标签1</td>
									<td>计算机系</td>
									<td>无</td>
									<td>
										<button class="modify-tag">修改</button>
										<button class="delete-tag">删除</button>
									</td>
								</tr>
								<tr>
									<td title="6">标签1</td>
									<td>计算机系</td>
									<td>无</td>
									<td>
										<button class="modify-tag">修改</button>
										<button class="delete-tag">删除</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>	
				</div>
				<!-- 右侧删除/修改导航栏模块结束 -->
				
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
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/rootPage.css?20170510-37">
</body>
</html>
