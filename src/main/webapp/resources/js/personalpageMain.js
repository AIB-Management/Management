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
			//如果新名字正确发送ajax
			// $.ajax({
			// 	url: '/path/to/file',
			// 	type: 'default GET (Other values: POST)',
			// 	dataType: 'default: Intelligent Guess (Other values: xml, json, script, or html)',
			// 	data: {param1: 'value1'},
			// });
			
		}
	}


	//定义表单认证的提示内容以及正则表达式
	checkBy.init({
		newUsername:{hint:"长度为2~10位中文或英文字符,不能有数字",correct:"",error:"输入不正确"
		,reg: /^\S[\u4E00-\u9FA5\uF900-\uFA2D\w][^0-9]{1,10}$/}

	});

	EventUntil.addHandler(s("#modify-btn"),"click",function(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

		var name = s("#personal-name").innerText;
		s("#newUsername").value = name;
		s("#modify-personal-name-floor").style.display = 'block';
	});

	EventUntil.addHandler(s("#modifyname-close-btn"),"click",function(){
		s("#modify-personal-name-floor").style.display = 'none';
	})

	EventUntil.addHandler(s("#newUsername"),"keyup",function(){
		if (this.value.length != 0) {
			s("#confirm-modify").removeAttribute("disabled");
		}else{
			s("#confirm-modify").disabled = "true";
		}
	})

	EventUntil.addHandler(s("#confirm-modify"),"click",confirmModify);
})