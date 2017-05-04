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

	//输入框失焦时执行的函数
	//通过传进来的元素id 执行具体操作
	function inputOnblurFilter(args){
		if (args.id == "confirmpwd") {
			checkBy.sibling(args,"password","span","#00C12B","#FB000D");

		}else if(args.id == "account") {

			var bool = checkBy.regWithLimit(args,"span","#00C12B","#FB000D");

			//如果通过正则表达式验证正确就发送ajax 数据
			if (bool == true) {

				checkBy.ajax({	
					elem: args,
					hintsContent: "span",
					errorColor: "#00C12B",
					//后台页面地址
					url:"",
					reqData: {accountVal: args.value},
					correctBool: "notExist",
					errorBool: "exist",
					//后台返回json 数据的键名
					result: "accountStatus"
				});
			}


		}else if(args.id == "mail") {

			var bool = checkBy.regWithoutLimit(args,"span","#00C12B","#FB000D");

			//如果通过正则表达式验证正确就发送ajax 数据
			if (bool == true) {

				checkBy.ajax({	
					elem: args,
					hintsContent: "span",
					errorColor: "#00C12B",
					//后台页面地址
					url:"",
					reqData: {mailVal: args.value},
					correctBool: "notExist",
					errorBool: "exist",
					//后台返回json 数据的键名
					result: "mailStatus"
				});
			}

		}else if(args.id == "vtCode") {
			checkBy.regWithoutLimit(args,"span","#00C12B","#FB000D");

		}else if(args.id == "tname") {
			var contain = checkBy.findHintsContain(args,"span");
			var errorHint = checkBy.hintsData[args.id]["error"];
			var tnameReg = /[0-9]/g;

			//先判断教师姓名内容是否存在数字
			//如果有就提示错误
			if (tnameReg.test(args.value)) {
				contain.innerText = "输入错误";
				contain.style.color = "#FB000D";
				contain.style.visibility = 'visible';
				args.isCorrect = false;

			}else{

				checkBy.regWithLimit(args,"span","#00C12B","#FB000D");
			}

		}else {
			checkBy.regWithLimit(args,"span","#00C12B","#FB000D");

		}
	}




	//---------调用层----------



	//定义表单认证的提示内容以及正则表达式
	checkBy.init({
		tname:{hint:"长度为2~10位中文或英文字符,不能有数字",correct:"输入正确",error:"输入不正确"
		,reg: /[\u4E00-\u9FA5\uF900-\uFA2D\w]{2,10}/,minLen: 2,maxLen: 10},
		account:{hint:"必填，长度为8~16位数字或英文字符",correct:"输入正确",error:"输入不正确"
		,reg:/[\S\w\d]{8,16}/,ajaxError: "此账号已被注册", minLen: 8,maxLen: 16},
		password:{hint:"必填，长度为6~16位字符,包含字母和数字",correct:"输入正确",error:"输入不正确"
		,reg:/[\S\d\w.]{6,16}/,minLen: 6,maxLen: 16},
		confirmpwd:{hint:"必须和密码一致",correct:"输入正确",error:"输入不正确"},
		mail:{hint:"请填写正确的邮箱地址",correct:"输入正确",error:"输入不正确"
		,reg:/^([\d\w]+[_|\_|\.]?)*[\d\w]+@([\d\w]+[_|\_|\.]?)*[\d\w]+\.[\w]{2,3}/,ajaxError: "此邮箱已被注册"},
		vtCode:{reg:/\S/,correct:"",error:"验证码不能为空"}

	});

	

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
	}(ss(".input-wrap input")));


	//下拉框联动
	(function unionChange(selector1,selector2){

		EventUntil.addHandler(selector1,"change",function(){

			//保存第二个选择框的提示信息
			var selectorHint = selector2.options[0];

			//创建一个文本碎片收集器
			var frag = document.createDocumentFragment();

			frag.appendChild(selectorHint);
			//清空第二个下拉框的option
			selector2.options.length = 0;

			//保存传输数据对象
			var arg = {departmentID:selector1.value};

			//如果第一个下拉框选择的option value 不为空
			//发送一个ajax 请求道后台获取数据
			if (selector1.value != "") {
				$.ajax({
					url: 'http://localhost:8080/Management/public/getProfessionJson.action',
					type: 'GET',
					async: true,
					dataType: 'json',
					data: arg,
					success: function(data){
						for (var i = 0; i < data.length; i++) {
							var option = document.createElement("option");
							option.value = data[i].id;
							option.innerText = data[i].profession;
							frag.appendChild(option);
						}

						//为第二个下拉框添加子元素
						selector2.appendChild(frag);
					},

					error: function(data){
						data = JSON.parse(data);

	                    var option = document.createElement("option");
	                    option.innerText = data["professionArr"];
	                    //清空第二个下拉框的option
	                    selector2.options.length = 0;
	             		//为第二个下拉框添加一个子元素 option
	                    selector2.appendChild(option);
					}
				})
			}else{

				//否则
				//第二个选择框变为默认的提示option
				selector2.options.length = 0;
				selector2.appendChild(selectorHint);
			}

			
		})
		
	}(s("#department"),s("#special")));


	//切换验证码按钮点击事件
	EventUntil.addHandler(s("#vt-img"),"click",function(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);
        s("#vt-img").src = "/Management/public/getCaptcha.action?a="+new Date();
	})

    //切换验证码按钮点击事件
    EventUntil.addHandler(s("#change-vt-code"),"click",function(event){
        event = EventUntil.getEvent(event);
        EventUntil.preventDefault(event);
        s("#vt-img").src = "/Management/public/getCaptcha.action?a="+new Date();
    })



    //提交按钮点击事件函数
	(function clickSubmit(elem){
		var submit = elem;
		var inputs = ss(".input-wrap input");
		var selectVal = ss(".input-wrap select");
		
		EventUntil.addHandler(submit,"click",function(event){
			event = EventUntil.getEvent(event);
			var count = 0;
			for (var i = 0; i < inputs.length; i++) {
				//提交按钮点击时
				//将所有的输入元素都执行一次失焦事件
				//防止数据回滚的时候没有被认证
				inputs[i].blur();

				if (inputs[i].isCorrect == true) {
					count++;
				}
			}

			if (count == inputs.length) {

				alert("提交成功");
			}else{
				EventUntil.preventDefault(event);
			}
		});
	}(s("#complete-reg")));






});