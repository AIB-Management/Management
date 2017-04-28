//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}

	}

})

//login页 Main函数
require(["jquery.min","cookies","overborwserEvent"],function main($,cookies,EventUntil){
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

	//登陆按钮点击时根据需求保存cookie
	function saveCookie(){
		var account = s("#account");
		var pwd = s("#pwd");
		var rm = s("#remember-me");

		if (rm.checked == true) {
			cookies.setCookie("account",account.value,3);
			cookies.setCookie("pwd",pwd.value,3);
		}
	}

	//登陆按钮点击时进行输入框验证
	function checkInput(){
		var account = s("#account");
		var pwd = s("#pwd");
		var hint = s("#login-hint");


		if (account.value == "" || pwd.value == "") {
			hint.innerText = "账号或密码不能为空";
			hint.style.visibility = 'visible';
			account.isCorrect = false;

		}else if (account.value != "" && pwd.value != "") {
			//当账号和密码都不为空的时候
			//发送一个ajax 请求给后台
			//检测账号是否存在 密码是否与账号匹配
			var temp = {accountVal: account.value,pwdVal: pwd.value};
			var reqData = JSON.stringify(temp);

			$.ajax({
				url: 'test.php',
				type: 'post',
				dataType: 'json',
				async: false,
				data: reqData,
				success: function(data){
					/*
						接收返回数据的格式为：
						account: 账号是否存在
						pwd: 密码是否与账号匹配
					*/
					if (data.account == false) {
						//如果账号不存在
						hint.innerText = "账号不存在";
						hint.style.visibility = 'visible';
						account.isCorrect = false;

					}else if (data.account == true && data.pwd == false) {
						//如果账号存在但与密码不匹配
						hint.innerText = "密码错误";
						hint.style.visibility = 'visible';
						pwd.isCorrect = false;

					}else{
						account.isCorrect = true;
						pwd.isCorrect = true;

					}
				}
			})
			
			

			
		}

		
	}


	//验证码验证函数
	function checkVtCode(){
		var vtCode = s("#vt-code");
		var vtVal = s("#vt-code").value;
		var vtHint = s("#vt-code-hint");
		var changeBtn = s("#change-vt-code");

		//如果验证码为空提示错误信息
		if (vtVal == "") {
			vtHint.innerText = "验证码错误";
			vtHint.style.visibility = 'visible';
			vtCode.isCorrect = false;

		}else{
			//不为空时发送一个ajax 请求
			var temp = {"vtValue":vtVal};
			var reqData = JSON.stringify(temp);

			$.ajax({
				url: 'test.php',
				type: 'get',
				dataType: 'json',
				async: false,
				data: reqData,
				success: function(data){
					if (data.bool == "error") {
					 	//如果输入的验证码错误
					 	//清空验证码输入框的内容
					 	s("#vt-code").value = "";
					 	//提示错误信息
					 	vtHint.innerText = "验证码错误";
						vtHint.style.visibility = 'visible';
						//更换验证码按钮模拟点击一下
						changeBtn.click();

						vtCode.isCorrect = false;
					 }else{
					 	//如果验证码正确
					 	vtCode.isCorrect = true;
					 }
				}
			})
			
			
		}

	}

	//登陆按钮点击事件执行事件回调函数
	function loginClick(event){
		checkInput();
		checkVtCode();
		var account = s("#account");
		var pwd = s("#pwd");
		var vtCode = s("#vt-code");

		alert("account:" + account.isCorrect);
		alert("pwd:" + pwd.isCorrect)
		alert("vtCode:" + vtCode.isCorrect);

		if (account.isCorrect == false || pwd.isCorrect == false || vtCode.isCorrect == false) {
			EventUntil.preventDefault(event);

		}else if (account.isCorrect == true && pwd == true && vtCode == true) {
			saveCookie();
		}
	}


	//------调用层------


	//cookie自动输入方法
	//账号输入框页面加载完毕的时候就自动聚焦
	EventUntil.addHandler(s("#account"),"focus",function(){
		var account = s("#account");
		var pwd = s("#pwd");

		account.value = cookies.getCookie("account");
		pwd.value = cookies.getCookie("pwd");
	});
	s("#account").focus();



	//切换验证码按钮点击事件
	EventUntil.addHandler(s("#change-vt-code"),"click",function(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);
		console.log('点击了一下切换按钮');

		var img = s("#vt-img");
		var temp = {change: "changeVtCode"};
		//整理为json 字符串格式
		var reqData = JSON.stringify(temp);
		//通过ajax 获取后台图片的路径 再将图片路径赋值
		$.get("", reqData,function(data) {
			/*返回数据格式为：
				{"imgsrc":"图片路径"}
			 */
			 img.src = data.imgsrc;
		},"JSON");
		
	})



	//登陆按钮点击事件
	EventUntil.addHandler(s("#log-in"),"click",loginClick);


	
	
	
})