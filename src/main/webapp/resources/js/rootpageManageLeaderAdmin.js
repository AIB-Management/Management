//系主页权限管理模块
/*
	此模块依赖模块
	1、jq
	2、EventUntil


	所需基本函数：
	自定义选择器 s,ss
	创建元素函数 createElem

*/
define(["jquery.min","overborwserEvent"],function($,EventUntil){

	//自定义选择单一元素选择器
	function s(name){
		if (name.substring(0, 1) == "#") {
			return document.querySelector(name);
		}else if (name.substring(0, 1) == ".") {
			return document.querySelectorAll(name);
		}else{
			return document.querySelectorAll(name);
		}
	}

	//封装选择多个dom元素 选择器
	function ss(name){
		return document.querySelectorAll(name);
	}

	//自定义创建元素方法
	function createElem(elemName){
		return document.createElement(elemName);
	}

	
	//输出管理员列表
	function outputAdminList(){
		$.ajax({
			url: '/Management/admin/ajaxGetAccountInfoIsAdmin.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				//请求成功后 输出元素列表
				if (data.code == 100) {
					if (data.extend.accountInfo.length != 0) {
						//管理员列表清空内容
						s("#admin-list").innerHTML = "";
						//输出更新后的未授权列表
						createAdminList(data);
					}
				}else{
					alert("未知错误！");
				}
			}
		})
		
	}

	//输出领导列表
	function outputLeaderList(){
		$.ajax({
			url: '/Management/admin/ajaxGetAccountInfoIsLeader.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				//请求成功后 输出元素列表
				if (data.code == 100) {
					if (data.extend.accountInfo.length != 0) {
						//管理员列表清空内容
						s("#leader-list").innerHTML = "";
						//输出更新后的未授权列表
						createLeaderList(data);
					}
				}else{
					alert("未知错误！");
				}
			}
		})
	}


	//撤回管理员身份按钮点击事件回调函数
	function recallAdmin(){
		var parent = this.parentNode.parentNode;
		//获取第一个单元格的title 传值给后台
		var uid = parent.querySelectorAll("td")[0].title,
			//获取对应撤回管理员姓名
			adminName = parent.querySelectorAll("td")[0].innerText;

		//为对话框的被撤回管理员名字赋值
		s("#recall-admin-name").innerText = adminName;
		//为被撤回管理员名字元素的title 赋值
		s("#recall-admin-name").title = uid;
		s("#recall-admin-dialog-floor").style.display = 'block';
		
	}


	//创建未授权列表元素
	function createAdminList(data){

		var dataList = data.extend.accountInfo;
		//创建元素碎片收集器
		var frag = document.createDocumentFragment()
			col = createElem("td"),
			btnIcon = createElem("span"),
			button = createElem("button");

			btnIcon.className = "glyphicon glyphicon-remove";

		for (var i = 0; i < dataList.length; i++) {
			var row = createElem("tr"),
				nameCol = col.cloneNode(true),
				depCol = col.cloneNode(true),
				specCol = col.cloneNode(true),
				operateCol = col.cloneNode(true);
				


			nameCol.innerText = dataList[i].name;
			nameCol.title = dataList[i].uid;

			depCol.innerText = dataList[i].depContent;
			specCol.innerText = dataList[i].content;

			

			row.appendChild(nameCol);
			row.appendChild(depCol);
			row.appendChild(specCol);
			if (s("#page-header-title").title != dataList[i].uid) {
				//如果当前遍历的数据管理员uid 不是当前登陆的管理员
				//输出操作按钮
				var btnicon = btnIcon.cloneNode(true),
					btn = button.cloneNode(true);

				btn.appendChild(btnicon);
				btn.innerHTML = "撤回管理员";
				btn.className = "btn btn-danger btn-sm";
				//授权按钮绑定点击事件
				EventUntil.addHandler(btn,"click",recallAdmin);

				operateCol.appendChild(btn);
				row.appendChild(operateCol);
			}else{
				operateCol.innerText = "-";
				row.appendChild(operateCol);
			}
			

			frag.appendChild(row);

		}
		//未授权列表添加元素
		s("#admin-list").appendChild(frag);

	}

	//撤回领导按钮点击回调函数
	function recallLeader(){
		var parent = this.parentNode.parentNode,
			//获取已授权用户的uid
		 	uid = parent.querySelectorAll("td")[0].title,
		 	adminName = parent.querySelectorAll("td")[0].innerText;

		//为对话框的被撤回管理员名字赋值
		s("#recall-leader-name").innerText = adminName;
		//为被撤回管理员名字元素的title 赋值
		s("#recall-leader-name").title = uid;
		s("#recall-leader-dialog-floor").style.display = 'block';
		
	}


	//创建已授权列表
	function createLeaderList(data){
		var dataList = data.extend.accountInfo;
		//创建元素碎片收集器
		var frag = document.createDocumentFragment()
			col = createElem("td"),
			button = createElem("button"),
			btnIcon = createElem("span");

			btnIcon.className = "glyphicon glyphicon-remove";


		for (var i = 0; i < dataList.length; i++) {
			var row = createElem("tr"),
				nameCol = col.cloneNode(true),
				depCol = col.cloneNode(true),
				specCol = col.cloneNode(true),
				operateCol = col.cloneNode(true),
				btnicon = btnIcon.cloneNode(true),
				btn = button.cloneNode(true);

			nameCol.innerText = dataList[i].name;
			nameCol.title = dataList[i].uid;

			depCol.innerText = dataList[i].depContent;
			specCol.innerText = dataList[i].content

			btn.appendChild(btnicon);
			btn.innerHTML += "撤回领导";
			btn.className = "btn btn-danger btn-sm";
			//授权按钮绑定点击事件
			EventUntil.addHandler(btn,"click",recallLeader);

			operateCol.className = "operate-col";
			operateCol.appendChild(btn);

			row.appendChild(nameCol);
			row.appendChild(depCol);
			row.appendChild(specCol);
			row.appendChild(operateCol);

			frag.appendChild(row);

		}
		//未授权列表添加元素
		s("#leader-list").appendChild(frag);
	}

	//输出授权模块的所有列表
	return {
		outputAdminList: outputAdminList,
		outputLeaderList: outputLeaderList
	};
})