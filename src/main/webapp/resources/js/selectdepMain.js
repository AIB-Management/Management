//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}
		
	}

})
//departmentpage 脚本main函数
require(["jquery.min","overborwserEvent"],function main($,EventUntil){

	//封装选择器函数
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


	//页面加载完成时填充系别下拉框
	function setDepartment(){
		$.ajax({
			url: '/Management/content/ajaxFindDepOrPro.action',
			type: 'GET',
			dataType: 'json',
			data: "parent=0",
			success: function(data){
				createOption(data);
			}
		})
		
	}

	function createOption(data){
		var list = data.extend.deps;
		var frag = document.createDocumentFragment();

		for (var i = 0; i < list.length; i++) {
			var option = createElem("option");
			option.value = list[i].uid;
			option.innerText = list[i].dep;

			frag.appendChild(option);
		}

		s("#department").appendChild(frag);
	}

	//跳转按钮点击事件执行函数
	function changeLocation(){
		if (s("#department").value == "") {

			alert("请先选择系别！");
		}else{
			var uid = s("#department").value;
			//发送ajax 到后台进行页面跳转
			$.ajax({
				url: '/Management/content/toLeaderFromDep.action',
				type: 'POST',
				dataType: 'json',
				data: "departmentId=" + uid,
				success: function(data){
					if (data.code == 200) {
						alert("未知错误请稍后重试！");
					}
				}
			})

			console.log(uid);
			console.log(depName);
			
		}
	}

	//跳转按钮点击事件
	EventUntil.addHandler(s("#enter"),"click",changeLocation);

	//初始化下拉框的值
	setDepartment();



})