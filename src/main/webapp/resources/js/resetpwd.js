//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}

	}

})

//login页 Main函数
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






	//--------- 调用层----------
	checkBy.init({
		newpwd:{hint:"必填，长度为6~16位字符,包含字母和数字",correct:"输入正确",error:"输入不正确"
		,reg:/^\S[\S\d\w.]{5,16}/,minLen: 6,maxLen: 16},
		confirmpwd:{hint:"必须和密码一致",correct:"输入正确",error:"输入不正确"}
	});

	//密码输入框聚焦事件
	EventUntil.addHandler(s("#newpwd"),"focus",function(){
		checkBy.onFocus(this,"span","#408DD2");
	})

	//确认密码输入框聚焦事件
	EventUntil.addHandler(s("#confirmpwd"),"focus",function(){
		checkBy.onFocus(this,"span","#408DD2");
	})

	//密码输入框失焦事件
	EventUntil.addHandler(s("#newpwd"),"blur",function(){
		checkBy.regWithLimit(this,"span","#00C12B","#FB000D");
	})

	//确认密码输入框失焦事件
	EventUntil.addHandler(s("#confirmpwd"),"blur",function(){
		checkBy.sibling(this,"newpwd","span","#00C12B","#FB000D");
	})

	//下一步点击按钮点击事件
	//点击时重新让输入框执行聚焦和失焦事件
	//确认输入框的isCorrect 属性
	EventUntil.addHandler(s("#reset"),"click",function(event){
		event = EventUntil.getEvent(event);
		//获取提交按钮元素
		var allInputs = s(".input-wrap input");
		//计算变量
		var count = 0;
		//执行聚焦，失焦事件，进行二次验证
		for (var i = 0; i < allInputs.length; i++) {
			allInputs[i].focus();
			allInputs[i].blur();

			if (allInputs[i].isCorrect == true) {
				count++;
			}
		}

		if (count == allInputs.length) {
			//如果密码输入框和确认密码框都正确
			//提交按钮触发默认事件 提交给后台
			alert("修改成功！数据已交给后台处理");
		}else{
			//否则不提交 显示错误信息给用户
			EventUntil.preventDefault(event);
		}
	})
})