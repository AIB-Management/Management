<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv = "X-UA-Compatible" content ="IE=Edge"/> 
	<title>主页</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/departmentpageMain.js?20170605-2"></script>
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
				<h3><shiro:principal property="depContent"/>主页</h3>
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
			<ul class="breadcrumb" id="breadcurmb-nav-wrap">
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名1</a></li>
				<li><a href="#">文件名123456</a></li>
				<li><a href="#">文件名12345678</a></li>
				<li><a href="#">你敢再长一点吗</a></li>
				<li><a href="#">我就长给你看你看我够长吗够长吗够长吗</a></li>
				<li><a href="#">我也很长很长很长的</a></li>
				<li><a href="#">听说现在还不够长我来一发</a></li>
			</ul>

			<div class="hidden-meun-item-btn">
				<button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="show-hidden-menu">
				<span class="caret"></span>
				</button>
				<ul id="overflow-item-wrap"></ul>
			</div>
		</div>
		

		<div class="mainbody">
			<div class="content">
				<div class="main-tool-bar">
					<button class="btn btn-primary">
						<span class="glyphicon glyphicon-cloud-upload"></span>
						上传文件
					</button>
				</div>
				<div class="main-content-title">
					<div class="content-name">名称</div>
					<div class="content-author">上传者</div>
					<div class="content-publish-time">上传时间</div>
				</div>
				<ul id="main-content-wrap">
					<li>
						<div class="item-name floder"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name floder"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name floder"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name floder"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name floder"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
					<li>
						<div class="item-name file"><a href="#">文件1</a></div>
						<div class="item-author">xx老师</div>
						<div class="item-publish-time">2017-06-07 21:43</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/departmentpage.css?20170607-2">
</body>
</html>