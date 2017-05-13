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
					//拒绝用户注册弹出层隐藏
					s("#refuse-info").style.display = 'none';
					//撤回用户弹出层隐藏
					s("#recall-user").style.display = 'none';
					//删除导航弹出层隐藏
					s("#delete-nav").style.display = 'none';
					//修改导航明细弹出层显示
					s("#modify-nav-info").style.display = 'block';
					//弹出层背景显示
					floor.style.visibility = "visible";

				}else if(this.className.indexOf("delete-tag") != -1){
					//点击删除导航按钮的时候
					//显示删除导航提示框隐藏其他弹出层
					//获取要删除导航的名字和id
					//向提示框传递此时要删除导航栏的 id和名字参数

					//获取父元素
					var parent = this.parentNode.parentNode;
					var tagNameTd = parent.querySelectorAll("td")[0];

					//获取提示标签名的元素
					var deleteTagName = s("#delete-navname");

					//获取弹出层
					var floor = s("#floor");
					//拒绝用户注册弹出层隐藏
					s("#refuse-info").style.display = 'none';
					//撤回用户弹出层隐藏
					s("#recall-user").style.display = 'none';
					//修改导航明细弹出层显示
					s("#modify-nav-info").style.display = 'none';
					//删除导航弹出层隐藏
					s("#delete-nav").style.display = 'block';
					//向提示字符元素填充内容
					deleteTagName.innerText = tagNameTd.innerText;
					deleteTagName.title = tagNameTd.title;

					//弹出层背景显示
					floor.style.visibility = "visible";
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
				//获取注册用户姓名的单元格
				//用作向后台传值及向弹出层传值
				var parent = this.parentNode.parentNode;
				var nameTd = parent.querySelectorAll("td")[0];

				if (this.className.indexOf("pass") != -1) {
					//如果此时点击的按钮为通过按钮
					//发送一个ajax 给后台
					//然后刷新更新后的表格
					//...ajaxCode
					$.ajax({
						url: '',
						type: 'GET',
						dataType: 'json',
						data: {passUser: nameTd.title},
					});
					
					 

				}else if (this.className.indexOf("refuse") != -1) {

					//获取弹出层
					var floor = s("#floor");
					//隐藏修改导航模块弹出层
					s("#modify-nav-info").style.display = 'none';
					//隐藏撤回用户模块弹出层
					s("#recall-user").style.display = 'none';
					//隐藏删除导航弹出层
					s("#delete-nav").style.display = 'none';
					//显示填写拒绝信息模块弹出层
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


	//撤回用户使用权限方法
	function recallUser(){
		//获取已审核用户表格的全部按钮
		var btns = ss(".recall");

		for (var i = 0; i < btns.length; i++) {
			EventUntil.addHandler(btns[i],"click",function(){
					//获取注册用户姓名的单元格
					var parent = this.parentNode.parentNode;
					var nameTd = parent.querySelectorAll("td")[0];

					//获取弹出层
					var floor = s("#floor");
					//隐藏修改导航模块弹出层
					s("#modify-nav-info").style.display = 'none';
					//隐藏删除导航弹出层
					s("#delete-nav").style.display = 'none';
					//显示填写拒绝信息模块弹出层
					s("#refuse-info").style.display = 'none';
					//显示撤回用户模块弹出层
					s("#recall-user").style.display = 'block';
					//为提示文字中的姓名字段添加内容
					s("#recall-username").innerText = nameTd.innerText;
					s("#recall-username").title = nameTd.title;
					//显示弹出层
					floor.style.visibility = "visible";
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
		//初始化时 第一个字标签模拟点击
		tags[0].click();
	}());
	

	//初始化子导航栏提示信息
	checkBy.init({
		childTagContent: {hint:"多个子导航请用英文逗号分隔"},
		childTagInfo: {hint:"多个子导航请用英文逗号分隔"}
	})




	//-----------右侧内容增加导航栏模块功能-------
	//子导航选择框点击事件
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
	//子导航栏输入框失焦事件
	EventUntil.addHandler(s("#childTagContent"),"blur",function(){
		var parent = this.parentNode;
		var hintContent = parent.querySelectorAll("span")[0];
		//增加子导航栏输入框失焦时 输入框border颜色为 #999
		s("#childTagContent").style.borderColor = "#999999";
		hintContent.innerText = "";
	})

	//-------------右侧内容增加导航栏模块功能结束-------------



	//------------ 弹出层事件 ----------------


	//修改导航栏弹出层功能
	//1、弹出层子导航栏内容修改输入框事件
	EventUntil.addHandler(s("#childTagInfo"),"focus",function(){
		checkBy.onFocus(this,"#modify-childNav-hint","#408DD2");
	})

	//2、弹出层子导航栏信息框失焦事件
	EventUntil.addHandler(s("#childTagInfo"),"blur",function(){

		var parent = this.parentNode;
		var hintContent = parent.querySelector("#modify-childNav-hint");
		hintContent.innerText = "";
		this.style.borderColor = "#000000";
	})

	//3、修改导航弹出层关闭按钮点击事件
	EventUntil.addHandler(s("#modify-nav-close-btn"),"click",function(){
		s("#floor").style.visibility = "hidden";
	})

	//4、修改弹出层提交按钮点击事件
	EventUntil.addHandler(s("#modify-btn"),"click",function(){
		s("#floor").style.visibility = "hidden";
	})

	//----------------- 修改导航栏弹出层功能结束 -------------------



	//删除导航栏弹出层功能
	//1、取消删除导航按钮点击事件
	EventUntil.addHandler(s("#cancel-delete-nav"),"click",function(){
		//整个弹出层直接隐藏
		s("#floor").style.visibility = "hidden";
	})

	//2、确认删除导航按钮点击事件
	EventUntil.addHandler(s("#confirm-delete-nav"),"click",function(){
		//确认删除导航栏按钮点击时
		//获取此时提示元素的 title 值，将id 传给后台
		//loading 图标显示
		//后台返回更新后的数据
		//前端更新新的数据
		//loading图标隐藏 (src = "")
		//弹出层隐藏

		//获取提示元素的title 值
		var navId = s("#delete-navname").title;
		$.ajax({
			url: '',
			async: false,
			type: 'GET',
			dataType: 'json',
			//发送title 值给后台
			data: {deleteNavId: navId},
			beforeSend: function(){
				//发送请求之前先显示加载图标
				s("#deleteNav-loading-icon").src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//1、遍历后台数据
				//2、输出元素
				//3、调用modifyModuleBtn() 方法为新加载的元素绑定事件
				//4、loading图标隐藏（src = ""）
				//5、弹出层隐藏

			}
		});
		
		
	});

	//---------------------- 删除导航弹出层功能结束 ------------------




	//拒绝用户弹出层功能
	//1、拒绝用户注册模块关闭按钮点击事件
	EventUntil.addHandler(s("#refuse-close-btn"),"click",function(){
		
		s("#floor").style.visibility = "hidden";
	})

	//2、拒绝理由信息输入框输入事件
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

	//3、拒绝用户注册模块提交拒绝信息按钮点击事件
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
			async: false,
			type: 'GET',
			dataType: 'json',
			data: {refuseUserId: idVal,refuseText: refuseVal},
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

	//3、拒绝用户注册模块不填写拒绝信息按钮点击事件
	EventUntil.addHandler(s("#no-refuse-reason"),"click",function(){
		//ajax 提交用户的id 给后台，不提交拒绝理由
		//数据提交完成后将包裹层隐藏

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//获取加载图片元素
		var icon = s("#loading-icon");

		$.ajax({
			url: '',
			async: false,
			type: 'GET',
			dataType: 'json',
			data: {refuseUserId: idVal},
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
	//----------------- 拒绝用户弹出层功能结束 -------------------


	//撤回用户弹出层功能
	//1、取消撤回按钮点击事件
	EventUntil.addHandler(s("#cancel-recall-user"),"click",function(){
		s("#floor").style.visibility = "hidden";
	})

	//2、撤回理由输入框键盘输入事件
	EventUntil.addHandler(s("#recall-content"),"keyup",function(){
		//获取提交按钮
		var sendBtn = s("#confirm-recall-user");

		if (this.value.length != 0) {
			sendBtn.removeAttribute("disabled");
			sendBtn.style.backgroundColor = "#E61A1A";
		}else{
			sendBtn.disabled = "disabled";
			sendBtn.style.backgroundColor = "#999999";
		}
	})

	//3、确认撤回按钮点击事件
	EventUntil.addHandler(s("#confirm-recall-user"),"click",function(){
		//点击时 和上面一样 获取提示元素的 title值
		//将title值 传给后台
		var idVal = s("#recall-username").title;

		$.ajax({
			url: '',
			async: false,
			type: 'GET',
			dataType: 'json',
			data: {recallUserId: idVal},
			beforeSend: function(){
				s("#recall-loading-icon").src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//数据返回成功后
				//前端遍历后台数据输出到页面
				//调用 recallUser()
				//loading 图标隐藏（src = ""）
				//弹出层隐藏
			}
		});
		
	})

	//----------------- 撤回用户弹出层功能结束 -------------------

	//导航栏管理表格按钮点击方法
	modifyModuleBtn();

	//待审核用户表格所有按钮点击方法
	unexamieModuleBtn();

	//已审核用户表格所有按钮点击方法
	recallUser();
})