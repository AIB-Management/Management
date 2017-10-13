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

	
	//输出授权模块所有列表
	function outputauthorityModuleList(){
		$.ajax({
			url: '/Management/runas/getRunasUser.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				//请求成功后 输出元素列表
				if (data.code == 100) {
					//未授权列表清空内容
					s("#can-authoritied-list").innerHTML = "";
					//已授权列表清空内容
					s("#has-authoritied-list").innerHTML = "";
					//输出更新后的未授权列表
					createUnauthorityList(data);
					//输出更新后的已授权列表
					createHasAuthorityList(data);

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("未能加载授权列表，请检查网络");
				}
			},
			error: function(){
				alert("未能加载授权列表，请检查网络");
			}
		})
		
	}


	//授权按钮点击事件回调函数
	function authoritiedThis(){
		var parent = this.parentNode.parentNode;
		//获取第一个单元格的title 传值给后台
		var uid = parent.querySelectorAll("td")[0].title;

		$.ajax({
			url: '/Management/runas/grant.action',
			type: 'POST',
			dataType: 'json',
			data: "uid=" + uid,
			success: function(data){
				if (data.code = 100) {
					//输出授权模块的列表内容
					outputauthorityModuleList();

					alert("授权成功！");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("授权失败！请检查网络或稍后重试");
				}
			}
		})
		
	}


	//创建未授权列表元素
	function createUnauthorityList(data){

		var dataList = data.extend.allAccount;
		//创建元素碎片收集器
		var frag = document.createDocumentFragment()
			col = createElem("td"),
			button = createElem("button");


		for (var i = 0; i < dataList.length; i++) {
			var row = createElem("tr"),
				nameCol = col.cloneNode(true),
				operateCol = col.cloneNode(true),
				btn = button.cloneNode(true);


			nameCol.innerText = dataList[i].name;
			nameCol.title = dataList[i].uid;

			btn.innerText = "授权";
			btn.className = "btn btn-success btn-sm";
			//授权按钮绑定点击事件
			EventUntil.addHandler(btn,"click",authoritiedThis);

			operateCol.className = "operate-col";
			operateCol.appendChild(btn);

			row.appendChild(nameCol);
			row.appendChild(operateCol);

			frag.appendChild(row);

		}
		//未授权列表添加元素
		s("#can-authoritied-list").appendChild(frag);

	}

	//撤回授权按钮点击回调函数
	function recallAuthority(){
		var parent = this.parentNode.parentNode;
		//获取已授权用户的uid
		var uid = parent.querySelectorAll("td")[0].title;

		$.ajax({
			url: '/Management/runas/retract.action',
			type: 'GET',
			dataType: 'json',
			data: "uid=" + uid,
			success: function(data){

				if (data.code == 100) {
					//请求成功更新未授权和已授权列表
					outputauthorityModuleList();
					alert("撤回授权成功！");
				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("撤回授权失败！请检查你的网络");
				}
			}
		});
		
	}


	//创建已授权列表
	function createHasAuthorityList(data){
		var dataList = data.extend.account;
		//创建元素碎片收集器
		var frag = document.createDocumentFragment()
			col = createElem("td"),
			button = createElem("button");


		for (var i = 0; i < dataList.length; i++) {
			var row = createElem("tr"),
				nameCol = col.cloneNode(true),
				operateCol = col.cloneNode(true),
				btn = button.cloneNode(true);

			nameCol.innerText = dataList[i].name;
			nameCol.title = dataList[i].uid;

			btn.innerText = "撤回";
			btn.className = "btn btn-danger btn-sm";
			//授权按钮绑定点击事件
			EventUntil.addHandler(btn,"click",recallAuthority);

			operateCol.className = "operate-col";
			operateCol.appendChild(btn);

			row.appendChild(nameCol);
			row.appendChild(operateCol);

			frag.appendChild(row);

		}
		//未授权列表添加元素
		s("#has-authoritied-list").appendChild(frag);
	}

	//输出授权模块的所有列表
	return outputauthorityModuleList;
})