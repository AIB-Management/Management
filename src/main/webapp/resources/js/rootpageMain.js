require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}

	}

})

//管理页主函数
require(["jquery.min","checkInput","overborwserEvent"],function main($,checkBy,EventUntil){
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

	//定义移除类名方法
	function removeClass(elem,classname){
		var allClass = elem.className.split(" ");
		var targetIndex = allClass.indexOf(classname);
		allClass.splice(targetIndex,1);
		elem.className = allClass.join(" ");
	}

	//定义获取导航栏表格行内信息方法
	function getDetailInfo(elem){
		//获取按钮所在行
		var infoArr = [];
		var tr = elem.parentNode.parentNode;
		var td = tr.querySelectorAll("td");

		for (var i = 0; i < td.length - 1; i++) {
			infoArr.push(td[i].innerText);
		}

		return infoArr;
		
	}

	//定义弹出层填写内容方法
	function setFloorInfo(elemList,infoList){
		for (var i = 0; i < elemList.length; i++) {

			if ((elemList[i].tagName).toLowerCase() == "select") {
				var options = elemList[i].options;
				for (var j = 0; j < options.length; j++) {
					if (options[j].innerText == infoList[i]) {
						options[j].selected = "true";
					}
				}
			}else{
				elemList[i].value = infoList[i];
			}
		}
	}


	//修改导航栏模块按钮点击事件
	//真正调用此函数是当数据完全获取完毕后调用
	function modifyModuleBtn(){
		//获取导航栏信息表格中的全部按钮
		var btns = ss("#all-tag-list tbody tr td button");
		for (var i = 0; i < btns.length; i++) {
			EventUntil.addHandler(btns[i],"click",function(){
				//如果点击的按钮类名为 modify-tag
				//执行自定义的 getDetailInfo 方法
				//获取到所有信息后再将所有信息填入弹出层对应的输入框中
				if (this.className.indexOf("modify-tag") != -1) {
					//获取点击按钮对应的信息
					var infoList = getDetailInfo(this);
					//获取弹出层
					var floor = s("#floor");
					//执行自定义信息输入函数
					setFloorInfo(ss("#floor .modify-nav-info"),infoList);

					s("#refuse-info").style.display = 'none';
					s("#modify-nav-info").style.display = 'block';
					floor.style.visibility = "visible";

				}else if(this.className.indexOf("delete-tag") != -1){
					//如果按钮的类名为 delete-tag
					//....执行ajax操作
					//同时再重新获取数据库数据生成dom 元素

					//获取点击按钮的行
					var tr = this.parentNode.parentNode;
					//获取按钮包裹的 td
					var wrapBtnTd = this.parentNode;
					//获取点击按钮所在行的第一个td 元素（一级导航栏名）
					var td = tr.querySelectorAll("td")[0];
					//获取一级导航栏的id
					var tagId = td.title;
					$.ajax({
						url: '',
						type: 'POST',
						dataType: 'json',
						data: {firstNavId: tagId},
						beforeSend: function(){
							//发送请求之前先创建一个img
							var img = document.createElement("img");
							img.src = "../../resources/images/loading.gif";
							img.style.width = "25px";
							img.style.height = "25px";
							wrapBtnTd.appendChild(img);
						},

						success: function(data){
							//请求数据成功之后
							//进行遍历输出
						}
					});
					
					
				}
			})
		}

	}


	//待审核用户表格全部按钮点击事件
	function unexamieModuleBtn(){
		//获取待审核用户表格的全部按钮
		var btns = ss("#unexamie tbody tr td button");

		//遍历 为每一个按钮绑定事件
		for (var i = 0; i < btns.length; i++) {
			EventUntil.addHandler(btns[i],"click",function(){
				if (this.className.indexOf("pass") != -1) {
					//如果此时点击的按钮为通过按钮
					//发送一个ajax 给后台
					//然后刷新更新后的表格
					//...ajaxCode
				}else if (this.className.indexOf("refuse") != -1) {
					//如果点击的是拒绝的按钮
					//获取注册用户姓名的单元格
					var parent = this.parentNode.parentNode;
					var nameTd = parent.querySelectorAll("td")[0];


					//获取弹出层
					var floor = s("#floor");
					//隐藏修改导航模块
					s("#modify-nav-info").style.display = 'none';
					//显示填写拒绝信息模块
					s("#refuse-info").style.display = 'block';
					//为提示文字中的姓名字段添加内容
					s("#refuse-username").innerText = nameTd.innerText;
					s("#refuse-username").title = nameTd.title;
					//显示弹出层
					floor.style.visibility = "visible";

				}
			})
		}
	}



	//--------------定义层结束-------------





	//侧边栏多个tag 点击事件
	(function tagsClick(){
		var tags = ss(".child-tag");
		var contents = ss(".content-wrap");
		for (var i = 0; i < tags.length; i++) {
			tags[i].index = i;
			contents.index = i;

			EventUntil.addHandler(tags[i],"click",function(){
				var index = this.index;
				for (var i = 0; i < contents.length; i++) {
					if (tags[i].className.indexOf("sidebar-tag-active") != -1) {
						//调用自定义 removeClass 方法
						removeClass(tags[i],"sidebar-tag-active");
					}
					contents[i].style.display = "none";
				}
				this.className += " sidebar-tag-active";
				contents[index].style.display = "block";
			});
		}
	}());
	

	//初始化子导航栏提示信息
	checkBy.init({
		childTagContent: {hint:"多个子导航请用英文逗号分隔"},
		childTagInfo: {hint:"多个子导航请用英文逗号分隔"}
	})

	//增加导航栏模块---子导航选择框点击事件
	EventUntil.addHandler(s("#has-child-tag"),"click",function(){
		if (this.checked == true) {
			s("#child-tag-wrap").style.display = "block";
		}else{
			s("#child-tag-wrap").style.display = "none";
		}
	})

	//子导航输入框聚焦事件
	EventUntil.addHandler(s("#childTagContent"),"focus",function(){
		checkBy.onFocus(this,"span","#333333");
	})

	EventUntil.addHandler(s("#childTagContent"),"blur",function(){
		var parent = this.parentNode;
		var hintContent = parent.querySelectorAll("span")[0];
		hintContent.innerText = "";
	})

	//弹出层子导航栏信息框聚焦事件
	EventUntil.addHandler(s("#childTagInfo"),"focus",function(){
		checkBy.onFocus(this,"#modify-childNav-hint","#408DD2");
	})

	//弹出层子导航栏信息框失焦事件
	EventUntil.addHandler(s("#childTagInfo"),"blur",function(){

		var parent = this.parentNode;
		var hintContent = parent.querySelector("#modify-childNav-hint");
		hintContent.innerText = "";
		this.style.borderColor = "#000000";
	})

	//修改导航模块弹出层关闭按钮点击事件
	EventUntil.addHandler(s("#modify-nav-close-btn"),"click",function(){
		s("#floor").style.visibility = "hidden";
	})

	//修改模块弹出层提交按钮点击事件
	EventUntil.addHandler(s("#modify-btn"),"click",function(){
		s("#floor").style.visibility = "hidden";
	})

	//拒绝用户注册模块关闭按钮点击事件
	EventUntil.addHandler(s("#refuse-close-btn"),"click",function(){
		
		s("#floor").style.visibility = "hidden";
	})

	//拒绝理由信息输入框输入事件
	EventUntil.addHandler(s("#refuse-content"),"keyup",function(){

		var sendBtn = s("#send-refuse-info");

		if (this.value.length == 0) {
			sendBtn.disabled = "disabled";
			sendBtn.style.backgroundColor = "#999999"
		}else{
			sendBtn.removeAttribute("disabled");
			sendBtn.style.backgroundColor = "#05a828";
		}
	})

	//拒绝用户注册模块提交拒绝信息按钮点击事件
	EventUntil.addHandler(s("#send-refuse-info"),"click",function(){
		//ajax 提交用户的id （则xxx title属性）,拒绝理由 给后台处理
		//当处理完毕后再将包裹层隐藏

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//拒绝的理由
		var refuseVal = s("#refuse-content").value;
		//获取加载图片元素
		var icon = s("#loading-icon");
		$.ajax({
			url: '',
			type: 'POST',
			dataType: 'json',
			data: {deleteUserId: idVal,refuseText: refuseVal},
			beforesend: function(){
				icon.src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//接收到返回信息后
				//1、遍历更新后的信息 更新前端页面的内容
				//2、输出完信息之后调用 unexamieModuleBtn() 方法为新添加的内容绑定点击事件
				//3、loading图标隐藏（src = ""）
				//4、弹出层隐藏
			}
		});
		
		
	})

	//拒绝用户注册模块不填写拒绝信息按钮点击事件
	EventUntil.addHandler(s("#no-refuse-reason"),"click",function(){
		//ajax 提交用户的id 给后台，不提交拒绝理由
		//数据提交完成后将包裹层隐藏

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//获取加载图片元素
		var icon = s("#loading-icon");

		$.ajax({
			url: '',
			type: 'GET',
			dataType: 'json',
			data: {deleteUserId: idVal},
			beforesend: function(){
				icon.src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//接收到返回信息后
				//1、遍历更新后的信息 更新前端页面的内容
				//2、输出完信息之后调用 unexamieModuleBtn() 方法为新添加的内容绑定点击事件
				//3、loading图标隐藏（src = ""）
				//4、弹出层隐藏
			}
		});
		
		
	})

	//导航栏管理表格按钮点击方法
	modifyModuleBtn();

	//待审核用户表格所有按钮点击方法
	unexamieModuleBtn();
})