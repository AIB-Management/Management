//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}
	}

})
//findpassword页 Main函数
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

	//封装去除空格函数
	function myTrim(x) {
    	return x.replace(/^\s+|\s+$/gm,'');
	}





	//--------- 调用层----------
	checkBy.init({
		mail:{hint:"请填写正确的邮箱地址",correct:"输入正确",error:"输入不正确"
		,reg:/^([\d\w]+[_|\_|\.]?)*[\d\w]+@([\d\w]+[_|\_|\.]?)*[\d\w]+\.[\w]{2,3}/}
	});

	//邮箱输入框聚焦事件
	EventUntil.addHandler(s("#mail"),"focus",function(){
		checkBy.onFocus(this,"span","#408DD2");
	})

	//邮箱输入框失焦事件
	EventUntil.addHandler(s("#mail"),"blur",function(){
		checkBy.regWithoutLimit(this,"span","#00C12B","#FB000D");
	})

	//下一步点击按钮点击事件
	//点击时重新让输入框执行聚焦和失焦事件
	//确认输入框的isCorrect 属性
	EventUntil.addHandler(s("#next-step"),"click",function(event){
		event = EventUntil.getEvent(event);
		//获取提交按钮元素
		var mailInput = s("#mail");
		//执行聚焦，失焦事件，进行二次验证
		mailInput.focus();
		mailInput.blur();

		if (mailInput.isCorrect == true) {
			//如果邮箱验证正确 执行提交按钮默认事件
			alert("请到跳转页面输入新的密码");
		}else{
			//如果有误 页面提示错误 阻止提交按钮的默认事件
			EventUntil.preventDefault(event);
		}
	})
})