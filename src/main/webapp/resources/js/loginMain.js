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
		}
	}

	//登陆按钮点击时进行输入框验证
	function checkInput(){
		var account = s("#account");
		var pwd = s("#pwd");
		var hint = s("#login-hint");


		if (account.value == "" || pwd.value == "") {
			hint.innerText = "账号或密码不能为空";
			account.isCorrect = false;

		}else if (account.value != "" && pwd.value != "") {
			//当账号和密码不为空时
			//账号和密码输入框isCorrect 属性设置为true
			//数据交给后台验证处理
			account.isCorrect = true;
			pwd.isCorrect = true;

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
			vtCode.isCorrect = false;

		}else{
			//不为空时把验证码输入框属性 isCorrect 设置为true
			//验证码交给后台处理
			vtCode.isCorrect = true;
	
		}

	}

	//登陆按钮点击事件执行事件回调函数
	function loginClick(event){
		checkInput();
		checkVtCode();
		var account = s("#account");
		var pwd = s("#pwd");
		var vtCode = s("#vt-code");

		if (account.isCorrect == false || pwd.isCorrect == false || vtCode.isCorrect == false) {
			EventUntil.preventDefault(event);

		}else if (account.isCorrect == true && pwd.isCorrect == true && vtCode.isCorrect == true) {
			saveCookie();
		}
	}

	//------调用层------


	//cookie自动输入方法
	//账号输入框页面加载完毕的时候就自动聚焦
	EventUntil.addHandler(s("#account"),"focus",function(){
		var account = s("#account");
		var pwd = s("#pwd");

		if (account.value == "" && pwd.value == "") {
			account.value = cookies.getCookie("account");
			pwd.value = cookies.getCookie("pwd");
		}
		console.log(account.value);
		console.log(cookies.getCookie("account") + "//" + cookies.getCookie("pwd"));
	});
	s("#account").focus();



	//切换验证码按钮点击事件
	EventUntil.addHandler(s("#change-vt-code"),"click",function(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

        		s("#vt-img").src = "/Management/public/getCaptcha.action?a="+new Date().getTime();
	})

    	//验证码图片点击事件
    	EventUntil.addHandler(s("#vt-img"),"click",function(event){
	        event = EventUntil.getEvent(event);
	        EventUntil.preventDefault(event);

	        s("#vt-img").src = "/Management/public/getCaptcha.action?a="+new Date().getTime();
	    })



	//登陆按钮点击事件
	EventUntil.addHandler(s("#log-in"),"click",loginClick);


	
	
	
})