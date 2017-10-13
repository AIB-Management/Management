//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
  shim: {
    'jquery.min': {
      exports: '$'
    }
  }

})
//findpassword页 Main函数
require(["jquery.min", "checkInput", "overborwserEvent"], function main ($, checkBy, EventUntil) {
	//封装选择器函数
	function s(name){
		if (name.substring(0, 1) == "#") {
			return document.querySelector(name);
		}else if (name.substring(0, 1) == ".") {
			return document.querySelectorAll(name)[0];
		}else{
			return document.querySelectorAll(name)[0];
		}
	}

	//封装选择多个dom元素 选择器
	function ss(name){
		return document.querySelectorAll(name);
	}

	function confirmModify(){
		var status = checkBy.regWithoutLimit(s("#newUsername"),"p","#00C12B","#FB000D");

		if (status == true) {
			//清空错误提示
			s("#modify-new-name-hint").innerText = "";
			//如果新名字正确发送ajax
			$.ajax({
				url: '/Management/content/ajaxUpdateName.action',
				type: 'POST',
				dataType: 'json',
				data: "name=" + s("#newUsername").value,
				success: function(data){
					if (data.code == 100) {
						alert("修改成功!");
						s("#modify-personal-name-floor").style.display = 'none';
						//刷新页面
						window.location.reload(true);
					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						alert("修改失败！请稍后重试");
						s("#modify-personal-name-floor").style.display = 'none';

					}
				},
				error: function(){
					alert("修改失败！请稍后重试");
					s("#modify-personal-name-floor").style.display = 'none';
				}
			});
			
		}
	}

	//确认修改用户邮箱点击事件回调函数
	function confirmModifyEmail(){
		var status = checkBy.regWithoutLimit(s("#newEmail"),"p","#00C12B","#FB000D");

		if (status == true) {
			//清空错误提示
			s("#modify-new-email-hint").innerText = "";
			//认证成功发送ajax
			$.ajax({
				url: '/Management/public/ajaxDoModifyEmail.action',
				type: 'POST',
				dataType: 'json',
				data: "email=" + s("#newEmail").value,
				success: function(data){
					if (data.code == 100) {
						alert("修改成功!");
						s("#modify-personal-email-floor").style.display = 'none';
						//刷新页面
						window.location.reload(true);
					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");
						
					}else{
						alert("邮箱已被使用或网络错误");
						s("#modify-personal-email-floor").style.display = 'none';
					}
				},
				error: function(){
					alert("邮箱已被使用或网络错误");
					s("#modify-personal-email-floor").style.display = 'none';
				}
			});
		}
	}


	checkBy.init({
		newUsername:{hint:"长度为2~10位中文或英文字符,不能有数字",correct:"",error:"输入不正确"
		,reg: /^[\u4E00-\u9FA5\uF900-\uFA2D\w][^0-9]{1,9}$/},
		newEmail: {hint:"请填写正确的邮箱地址",correct:"",error:"输入不正确"
		,reg: /^([\d\w]+[_|\_|\.]?)*[\d\w]+@([\d\w]+[_|\_|\.]?)*[\d\w]+\.[\w]{2,3}$/}

	});

	//修改用户名按钮点击事件
	EventUntil.addHandler(s("#modify-btn"),"click",function(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

		var name = s("#personal-name").innerText;
		s("#newUsername").value = name;
		s("#modify-personal-name-floor").style.display = 'block';
	});

	//修改用户名对话框关闭按钮点击事件
	EventUntil.addHandler(s("#modifyname-close-btn"),"click",function(){
		s("#modify-personal-name-floor").style.display = 'none';
		s("#newUsername").style.border = "1px solid #337ab7";
		s("#newUsername").style.boxShadow = '0 0 0 rgba(0,0,0,0)';
		s("#modify-new-name-hint").innerText = "";
	})

	//新用户名输入框键盘输入事件
	EventUntil.addHandler(s("#newUsername"),"keyup",function(){
		if (this.value.length != 0) {
			s("#confirm-modify").removeAttribute("disabled");
		}else{
			s("#confirm-modify").disabled = "true";
		}
	})

	//确认修改用户名按钮点击事件
	EventUntil.addHandler(s("#confirm-modify"),"click",confirmModify);


	//修改邮箱按钮点击事件
	EventUntil.addHandler(s("#modify-email"),"click",function(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

		var name = s("#personal-email").innerText;
		s("#newEmail").value = name;
		s("#modify-personal-email-floor").style.display = 'block';
	});


	//修邮箱对话框关闭按钮点击事件
	EventUntil.addHandler(s("#modifyemail-close-btn"),"click",function(){
		s("#modify-personal-email-floor").style.display = 'none';
		s("#newEmail").style.border = "1px solid #337ab7";
		s("#newEmail").style.boxShadow = '0 0 0 rgba(0,0,0,0)';
		s("#modify-new-email-hint").innerText = "";
	})


	//新邮箱输入框键盘输入事件
	EventUntil.addHandler(s("#newEmail"),"keyup",function(){
		if (this.value.length != 0) {
			s("#confirm-modifyemail").removeAttribute("disabled");
		}else{
			s("#confirm-modifyemail").disabled = "true";
		}
	})

	//确认修改用户名按钮点击事件
	EventUntil.addHandler(s("#confirm-modifyemail"),"click",confirmModifyEmail);

})