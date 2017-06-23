/*
	定义管理员页管理文件列表模块
	此模块需要一下几个js 模块
	1、jq
	2、EventUntil




	所需要的自定义函数
	1、s(),ss()
	2、createElem(),
	3、getCurStyle(), 获取当前样式
	4、

*/
define(["jquery.min","overborwserEvent"],function($,EventUntil){

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

	//自定义创建元素方法
	function createElem(elemName){
		return document.createElement(elemName);
	}


	//定义移除类名方法
	function removeClass(elem,classname){
		var allClass = elem.className.split(" ");
		var targetIndex = allClass.indexOf(classname);
		allClass.splice(targetIndex,1);
		elem.className = allClass.join(" ");
	}

	//获取浏览器最终样式的函数
	function getCurStyle(elem,pusedo,targetProperty){
		if (elem.currentStyle != undefined) {
			return elem.currentStyle[targetProperty];
			
		}else{
			return window.getComputedStyle(elem,pusedo)[targetProperty];
			
		}
	}

	//获取当前路径函数
	function getCurPath(){

		var overflowNavList = ss("#overflow-item-wrap li"),
			breadCrumbNavs = ss("#breadcurmb-nav-wrap li"),
			lastChild = null,
			curPath = "";

		if (overflowNavList.length != 0) {
				//如果溢出导航栏有元素
				//获取最后一个元素的a 元素的 data-path 属性
				lastChild = overflowNavList[overflowNavList.length - 1].querySelectorAll("a")[0];
				curPath = lastChild.getAttribute("data-path");
				return curPath;
			
			}else{
				//如果溢出导航栏没有元素
				//获取最后一个面包屑导航栏
				lastChild = breadCrumbNavs[breadCrumbNavs.length - 1].querySelectorAll("a")[0];
				curPath = lastChild.getAttribute("data-path");
				return curPath;
			}
	}


	//控制面包屑导航栏数量函数
	//多出的导航会被添加到溢出导航包裹层 并且绑定函数 overflowNavItemClick
	function controlNavNums(navWrap,childnode,moreNavContain,icon){
		//获取父元素的宽度
		var parentWidth = parseInt(getCurStyle(navWrap,null,"width"));

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
				//复制这个节点
				var temp = childnode[i].cloneNode(true);
				//先为复制过来的元素解除之前的事件绑定
				temp.onclick = null;
				//再为每个复制的节点绑定事件函数  overflowNavItemClick
				EventUntil.addHandler(temp,"click",overflowNavItemClick);
				//将此时的子元素添加到溢出导航包裹层里面
				moreNavContain.appendChild(temp);
				//面包屑导航栏移除子元素
				navWrap.removeChild(childnode[i]);
				
			}
			
		}

		if (moreNavContain.childNodes.length != 0) {
			icon.style.display = "inline-block";

		}else{
			icon.style.display = "none";
		}
	}

	//--------------- 上面是基本函数 ----------------


	//页面初始化的时候发送ajax 请求获取数据
	//然后调用 createElemForDepList 函数输出数据
	function createManageFloderDepList(){
		var depListWrap = s("#manage-side-item");

		$.ajax({
			url: '/Management/content/ajaxFindDepOrPro.action',
			type: 'GET',
			dataType: 'json',
			data: "parent=0",
			success: function(data){
				//如果没有部门数据
				if (data.extend.deps.length == 0) {
					//部门侧边栏更换提示背景
					depListWrap.className = "nodepartment-sidebar-bg";
				}else{
					//如果有部门就输出数据
					//先清空部门列表数据
					depListWrap.innerHTML = "";
					depListWrap.appendChild(createElemForDepList(data,selectDepClick));
				}
			}
		})
		
	}

	//从系别数据里面创建元素
	//被 createDepList 调用
	function createElemForDepList(data,handler){
		var frag = document.createDocumentFragment();
		var depListData = data.extend.deps;

		for (var i = 0; i < depListData.length; i++) {
			var li = createElem("li");
			li.innerText = depListData[i].dep;
			li.setAttribute("data-depId", depListData[i].uid);

			//为侧边栏的系别绑定点击事件
			EventUntil.addHandler(li,"click",handler);

			frag.appendChild(li);
		}

		return frag;
	}

	//侧边栏系别点击事件执行函数
	function selectDepClick(){
		var depList = ss("#manage-side-item li");
		var floderListWrap = s("#file-list-content");

		//获取面包屑导航栏包裹层
		var breadCrumb = s("#breadcurmb-nav-wrap");
		//清空面包屑导航栏元素
		breadCrumb.innerHTML = "";
		//清空li 的活动样式
		for (var i = 0; i < depList.length; i++) {
			if (depList[i].className.indexOf("filedep-item-active") != -1) {
				removeClass(depList[i],"filedep-item-active");
			}
		}

		this.className += "filedep-item-active";

		//创建面包屑导航元素
		var li = createElem("li"),
			a = createElem("a");

		a.href = "#";
		a.setAttribute("data-path",0);
		a.innerText = "根目录";
		li.appendChild(a);
		//为li 绑定点击事件
		EventUntil.addHandler(li,"click",breadCrumbItemClick);

		breadCrumb.appendChild(li);

		//清空和隐藏溢出导航包裹层并且隐藏包裹层显示的的按钮
		s("#overflow-item-wrap").innerHTML = "";
		s("#overflow-item-wrap").style.display = 'none';
		s("#show-hidden-menu").style.display = 'none';

		//调整完样式后发送ajax 到后台请求
		//取出数据
		//为成员变量赋值
		manageFloderModule.curManageFloderDepId = this.getAttribute("data-depId");
		//输出文件夹元素
		createFloderList(0,manageFloderModule.curManageFloderDepId);
	}


	//输出数据函数
	//文件夹名点击，面包屑导航点击，溢出导航点击，创建文件夹提交，修改文件名提交均调用此函数
	function createFloderList(path,depId){
		var floderList = s("#file-list-content");
		floderList.innerHTML = "";

		$.ajax({
			url: '/Management/content/ajaxFindNavAndFile.action',
			type: 'GET',
			dataType: 'json',
			data: "parent=" + path + "&depuid=" + depId,
			success: function(data){
				//请求成功的时候插入元素
				floderList.appendChild(ergFloderList(data));
			}
		})
		
	}


	//将数据转换为元素执行方法
	//被 createFloderList 调用
	function ergFloderList(data){
		var list = data.extend.navs;
		var frag = document.createDocumentFragment(),
			tr = createElem("tr"),
			td = createElem("td"),
			input = createElem("input"),
			span = createElem("span"),
			a = createElem("a"),
			button = createElem("button");

		input.type = "checkbox";
		a.href = "#";
		span.className = "glyphicon glyphicon-edit";
		button.appendChild(span);
		button.className = "btn btn-default btn-sm";
		button.innerHTML += "修改文件夹名";

		for (var i = 0; i < list.length; i++) {

			var row = tr.cloneNode(true),
				checkboxCol = td.cloneNode(true),
				floderNameCol = td.cloneNode(true),
				operateCol = td.cloneNode(true);

			var floderName = a.cloneNode(true);
			floderName.innerText = list[i].nav;
			floderName.setAttribute("data-path", list[i].uid);
			//为a 标签绑定点击事件
			EventUntil.addHandler(floderName,"click",createBradCurmbItem);

			var checkbox = input.cloneNode(true);
			checkboxCol.appendChild(checkbox);
			floderNameCol.className = "floder-name floder";
			floderNameCol.appendChild(floderName);
				
			//创建一个操作按钮
			var operateBtn = button.cloneNode(true);
			//为每一个按钮绑定点击事件
			EventUntil.addHandler(operateBtn,"click",modifyFloderName);
			operateCol.appendChild(operateBtn);

			row.appendChild(checkboxCol);
			row.appendChild(floderNameCol);
			row.appendChild(operateCol);

			frag.appendChild(row);
		}

		return frag;
	}


	//修改文件夹名字按钮点击事件执行函数
	function modifyFloderName(){
		//获取button 的父元素
		var parent = this.parentNode.parentNode,
			//获取文件的名字
			floderName = parent.querySelectorAll(".floder-name a")[0].innerText,
			//获取文件的路径
			floderPath = parent.querySelectorAll(".floder-name a")[0].getAttribute("data-path");
		//为修改名字弹出层的input输入框插入内容	
		s("#rename-file").value = floderName;
		s("#rename-file").title = floderPath;
		//显示修改文件夹名弹出层
		s("#modify-file-name-wrap").style.display = 'block';
	}


	//创建面包屑导航栏子元素 li的方法
	//此方法会调用 breadCrumbItemClick 和 controlNavNums
	//下面文件夹列表的a 标签点击事件会绑定这个函数
	function createBradCurmbItem(event){
		//获取面包屑导航栏外包裹层
		var curmbNav = s("#breadcurmb-nav-wrap");

		//阻止默认事件发生
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

		//创建元素碎片器 创建元素并添加到包裹层中
		var frag = document.createDocumentFragment();
		var li = createElem("li"),
			a = this.cloneNode(true);

		a.title = this.innerText;

		//为创建的 面包屑导航绑定点击事件
		EventUntil.addHandler(li,"click",breadCrumbItemClick);

		li.appendChild(a);

		frag.appendChild(li);

		curmbNav.appendChild(frag);

		//生成面包屑导航的同时也要刷新列表
		var path = event.target.getAttribute("data-path");
		createFloderList(path,manageFloderModule.curManageFloderDepId);

		//每一次添加都进行一次导航数量的控制
		controlNavNums(s("#breadcurmb-nav-wrap"),ss("#breadcurmb-nav-wrap li"),
			s("#overflow-item-wrap"),s("#show-hidden-menu"));

	}


	//面包屑导航栏每个导航标签点击事件
	function breadCrumbItemClick(event){
		//获取面包屑导航的外包裹层
		var breadCrumbWrap = s("#breadcurmb-nav-wrap");
		//获取所有面包屑导航的li
		var breadCrumbList = ss("#breadcurmb-nav-wrap li");

			
		var event = EventUntil.getEvent(event);
		//阻止其默认事件
		EventUntil.preventDefault(event);

		//获取当前元素在元素集里面的位置
		var index = Array.prototype.indexOf.call(breadCrumbList,this);

		//如果点击当前的元素不为最后一个
		if (index != breadCrumbList.length - 1) {
			//遍历删除这个元素后面的元素
			for (var i = index + 1; i < breadCrumbList.length; i++) {
				breadCrumbWrap.removeChild(breadCrumbList[i]);
			}
		}

		//无论如何 当点击面包屑导航栏处的导航栏
		//清空并且移除溢出导航包裹层的所有子元素并且将其和现实按钮隐藏
		s("#overflow-item-wrap").innerHTML = "";
		//隐藏显示溢出导航按钮
		s("#show-hidden-menu").style.display = 'none';
		s("#overflow-item-wrap").style.display = 'none';

		//整理完面包屑导航的样式后输出文件夹列表
		//depId 通过当前系别的全局变量获得
		var path = event.target.getAttribute("data-path");
		createFloderList(path,manageFloderModule.curManageFloderDepId);
		
		
	}


	//溢出导航包裹层里面的li 子元素点击事件
	function overflowNavItemClick(event){
		//获取event 对象并且组织默认事件
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);
		//获取溢出导航包裹层
		var overflowNavWrap = s("#overflow-item-wrap");
		//获取所有溢出导航层的li 子元素
		var overflowNavItemList = ss("#overflow-item-wrap li");
		
		//获取当前元素的索引
		var index = Array.prototype.indexOf.call(overflowNavItemList,this);
		//如果点击的溢出导航不为最后一个遍历删除它后面的所有导航
		if (index != overflowNavItemList.length - 1) {
			//遍历删除这个元素后面的元素
			for (var j = index + 1; j < overflowNavItemList.length; j++) {
				overflowNavWrap.removeChild(overflowNavItemList[j]);
			}
			//获取当前的路径
			var path = event.target.getAttribute("data-path");
			//输出数据
			createFloderList(path,manageFloderModule.curManageFloderDepId);
			
		}

		
			
		
	}



	//公有的数据对象 返回模块内部的公有方法及变量
	var manageFloderModule = {

		//保存当前点击的系别id 成员变量
		curManageFloderDepId: "",
		//初始化侧边栏部门列表
		createManageFloderDepList: createManageFloderDepList,
		//输出对应路径及对应系别的文件夹列表
		createFloderList: createFloderList
		
	}

	return manageFloderModule;

})