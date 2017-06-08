//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		},

		'bootstrap.min':{
			deps:['jquery.min']
		}

	}

})

//departmentpage 脚本main函数
require(["jquery.min","overborwserEvent","bootstrap.min"],function main($,EventUntil){

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

	//获取浏览器最终样式的函数
	function getCurStyle(elem,pusedo,targetProperty){
		if (elem.currentStyle != undefined) {
			return elem.currentStyle[targetProperty];
			
		}else{
			return window.getComputedStyle(elem,pusedo)[targetProperty];
			
		}
	}

	//自定义获取滚动条位置函数
	function getScrollTop(){
		var scrollTop = 0;
		scrollTop = document.body.scrollTop || document.documentElement.scrollTop;

		return scrollTop;
	}
	

	// //面包屑导航点击事件调用函数
	// function curmOnclick(breadCurms){
	// 	for (var i = 0; i < breadCurms.length; i++) {
	// 		EventUntil.addHandler(breadCurms[i],"click",function(){
	// 			console.log(this);
	// 			//...ajaxcode
	// 		})
	// 	}
	// }


	function controlNavNums(navWrap,childnode,moreNavContain,icon){
		//获取父元素的宽度
		var parentWidth = parseInt(getCurStyle(navWrap,null,"width"));
		console.log('父元素总宽：' + parentWidth);

		//获取全部子元素的宽度
		var childWidthTotal = 0;
		for (var i = 0; i < childnode.length; i++) {
			//获取每一个子元素的实际宽度
			var curChildWidth = parseInt(getCurStyle(childnode[i],null,"width")) + 10;
			childWidthTotal += curChildWidth;
			//获取父元素与此时子元素总宽度的差值
			var diffWidth = parentWidth - childWidthTotal;
			
			//如果此时的差值不能容纳下子元素
			if (diffWidth < curChildWidth) {
				//将此时的子元素添加到溢出导航包裹层里面
				moreNavContain.appendChild(childnode[i]);
			}
			

			if (moreNavContain.childNodes.length != 0) {
				icon.style.display = "inline-block";
			}

		
		}
	}
	
	//调试
	controlNavNums(s("#breadcurmb-nav-wrap"),ss("#breadcurmb-nav-wrap li"),
			s("#overflow-item-wrap"),s("#breadcurmb-nav-wrap"));

	



	//------------- 调用层 ----------------

	//用户名栏鼠标移入事件
	EventUntil.addHandler(s("#user-name"),"mouseover",function(event){
		event = EventUntil.getEvent(event);
		var target = EventUntil.getTarget(event);
		var floor = document.querySelector("#user-operate");
		var top = getComputedStyle(s(".header")[0], null)["height"];
		floor.style.left = (target.offsetLeft - 50) + "px";
		floor.style.top = top;
		floor.style.visibility = "visible";
		
	});


	//隐藏导航点击按钮事件
	EventUntil.addHandler(s("#show-hidden-menu"),"click",function(){
		
		//获取按钮的宽度
		var curWidth = parseInt(getCurStyle(this,null,"width"));
		
		//获取按钮高度
		var curHeight = parseInt(getCurStyle(this,null,"height"));

		if (s("#overflow-item-wrap").style.display == "" || s("#overflow-item-wrap").style.display == "none") {

			s("#overflow-item-wrap").style.right = (curWidth / 2) + "px";
			
			s("#overflow-item-wrap").style.top = (curHeight + 20) + "px";

			s("#overflow-item-wrap").style.display = "block";

		}else{

			s("#overflow-item-wrap").style.display = "none";
		}

	})

	//用户操作下拉框鼠标移入事件
	EventUntil.addHandler(s("#user-operate"),"mouseover",function(){
		this.style.visibility = "visible";
	});

	//用户名栏鼠标移出事件
	EventUntil.addHandler(s("#user-name"),"mouseout",function(){
		s("#user-operate").style.visibility = "hidden";
	});

	//用户操作下拉框栏鼠标移出事件
	EventUntil.addHandler(s("#user-operate"),"mouseout",function(){
		this.style.visibility = "hidden";
	});


	//发布信息按钮点击事件
	EventUntil.addHandler(s("#release-msg"),"click",function(){
		s("#release-msg-content").style.visibility = "visible";
	});

	//发布信息弹窗关闭按钮点击事件
	EventUntil.addHandler(s("#close-btn"),"click",function(){
		s("#release-msg-content").style.visibility = "hidden";
	
	});


	
})