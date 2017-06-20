//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}

	}

})

//departmentpage 脚本main函数
require(["jquery.min","overborwserEvent","checkInput"],function main($,EventUntil,checkBy){
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


	//定义表单认证的提示内容以及正则表达式
	checkBy.init({
		oldPwd: {hint: "请输入旧密码",correct:"等待验证",error:"此项不能为空",reg:/\S/},
		newPwd:{hint:"密码,长度为6~16位字符,包含字母和数字",correct:"输入正确",error:"输入不正确"
		,reg:/^\S[\S\w\d]{6,16}/, minLen: 6,maxLen: 16},
		confirmpwd:{hint:"必须和新密码一致",correct:"输入正确",error:"输入不正确"}

	});


	//输入框失焦时执行的函数
	//通过传进来的元素id 执行具体操作
	function inputOnblurFilter(args){
		if (args.id == "confirmpwd") {
			checkBy.sibling(args,"newPwd","span","#00C12B","#FB000D");

		}else if(args.id == "newPwd"){
			checkBy.regWithLimit(args,"span","#00C12B","#FB000D");

		}else if(args.id == "oldPwd"){
			checkBy.regWithoutLimit(args,"span","#00C12B","#FB000D");
		}

	}


	//input元素验证提示函数
	(function inputsOnCheck(allinput){
		var inputs = allinput;

		for (var i = 0; i < inputs.length; i++) {

			if (inputs[i].id != "vtCode") {

				EventUntil.addHandler(inputs[i],"focus",function(){
					checkBy.onFocus(this,"span","#408DD2");
				});
			}

		
			EventUntil.addHandler(inputs[i],"blur",function(){
				//因为失焦验证的元素有不同种类的验证方法
				//所以进行函数封装
				//做到具体元素具体实现
				inputOnblurFilter(this);
			});
		}
	}(ss(".form-content input")));


	//提交按钮点击事件
	EventUntil.addHandler(s("#modify"),"click",function(){
		var count = 0;
		var inputs = ss(".form-content input");
		for (var i = 0; i < inputs.length; i++) {
			//没循环一次 触发一次失焦事件
			inputs[i].blur();
			if (inputs[i].isCorrect == true) {
				count++;
			}
		}

		if (count == inputs.length) {
			//如果所有项正确提交表单
			s("#modifyPwdForm").submit();

		}else{
			alert("某选项有误请确认后重试");
		}
	})
})