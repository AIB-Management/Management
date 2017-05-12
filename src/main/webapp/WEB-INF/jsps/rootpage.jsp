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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/rootpageMain.js?20170509-18"></script>
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

		<!-- 拒绝用户注册回馈信息弹出层 -->
		<div id="refuse-info">
			<p class="close-btn-wrap"><span id="refuse-close-btn">×</span></p>
			<h3>拒绝信息填写</h3>
			<p class="refuse-info-wrap refuse-hint">
				<span>你可以为<b id="refuse-username"></b>发送拒绝信息,以便用户可以获知账号的实时状态</span>
			</p>
			<p class="refuse-info-wrap">
				<label>拒绝理由</label>
				<textarea name="refuseContent" id="refuse-content"></textarea>
			</p>
			<p class="refuse-btn-wrap">
				<button type="button" id="send-refuse-info" disabled="disabled">发送</button>
				<button type="button" id="no-refuse-reason">不发送拒绝消息</button>
				<img src="" alt="" id="loading-icon">
			</p>
		</div>
	</div>
	<div class="wrapper">
		<div class="header clearfix">
			<div class="title-wrap">
				<h3>后台管理页</h3>
			</div>
			<div class="logout-btn-wrap">
				<span id="logout-btn">退出</span>
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
						<li class="child-tag">待审核<span id="number-hints">15</span></li>
						<li class="child-tag">已审核</li>
					</ul>
				</div>
			</div>
			<div class="content">
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
							<span id="add-tag-hint" type="button">已有此标签</span>
						</p>
					</div>
				</div>

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


				<div class="content-wrap">
					<div class="unexamie-wrap">
						<span>筛选</span>
						<select id="unexamie-filter" class="filter-style">
							<option value="全部">全部</option>
							<option value="计算机系">计算机系</option>
							<option value="管理系">管理系</option>
							<option value="商务系">商务系</option>
							<option value="财经系">财经系</option>
							<option value="热作系">热作系</option>
							<option value="机电系">机电系</option>
							<option value="BTEC国际交流学院">BTEC国际交流学院</option>
						</select>
						<table id="unexamie" class="message-list" cellspacing="0">
							<caption>待审核列表</caption>
							<thead>
								<tr>
									<th>姓名</th>
									<th>系别</th>
									<th>专业</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td title="1">老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="pass">通过</button>
										<button class="refuse">拒绝申请</button>
									</td>
								</tr>
								<tr>
									<td title="2">老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="pass">通过</button>
										<button class="refuse">拒绝申请</button>
									</td>
								</tr>
								<tr>
									<td title="3">老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="pass">通过</button>
										<button class="refuse">拒绝申请</button>
									</td>
								</tr>
								<tr>
									<td title="4">老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="pass" type="button">通过</button>
										<button class="refuse" type="button">拒绝申请</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="content-wrap">
					<div class="examie-wrap">
						<span>筛选</span>
						<select id="examie-filter" class="filter-style">
							<option value="全部">全部</option>
							<option value="计算机系">计算机系</option>
							<option value="管理系">管理系</option>
							<option value="商务系">商务系</option>
							<option value="财经系">财经系</option>
							<option value="热作系">热作系</option>
							<option value="机电系">机电系</option>
							<option value="BTEC国际交流学院">BTEC国际交流学院</option>
						</select>
						<table id="examied" class="message-list" cellspacing="0">
							<caption>已审核列表</caption>
							<thead>
								<tr>
									<th>姓名</th>
									<th>系别</th>
									<th>专业</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="reload">撤回</button>
									</td>
								</tr>
								<tr>
									<td>老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="reload">撤回</button>
									</td>
								</tr>
								<tr>
									<td>老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="reload">撤回</button>
									</td>
								</tr>
								<tr>
									<td>老师1</td>
									<td>计算机系</td>
									<td>移动互联应用技术</td>
									<td>
										<button class="reload" type="button">撤回</button>
									</td>
								</tr>
							</tbody>
					</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/rootPage.css?20170510-8">
</body>
</html>
