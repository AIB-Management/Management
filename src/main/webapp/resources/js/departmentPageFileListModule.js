/*
	定义系主页文件列表模块
	此模块需要一下几个js 模块
	1、jq
	2、EventUntil




	所需要的自定义函数
	1、s(),ss()
	2、createElem(),
	3、getCurStyle(), 获取当前样式
	4、formateDate() 格式化后台数据时间

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

	//获取浏览器最终样式的函数
	function getCurStyle(elem,pusedo,targetProperty){
		
		//ie独有方法 兼容ie6 - 8 
		//但是返回的宽度属性会显示为auto 所以这里记一下 没有实际作用
		//return elem.currentStyle[targetProperty];
		
	
		//现代浏览器方法 ie9+
		return window.getComputedStyle(elem,pusedo)[targetProperty];
		
		
	}


	//每次刷新问价列表的时候都需要获取当前路径发送给后台
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

	function formateDate(dateStr){
		var date = new Date(dateStr);

		var year = date.getFullYear(),
			month = date.getMonth(),
			day = date.getDate(),
			h = date.getHours(),
			m = date.getMinutes(),
			sec = date.getSeconds();

			month<9? month = "0" + (month+1) : month = m+1;
			day<10? day = "0" + day : day;
			h<10 ? h = "0" + h : h;
			m<10 ? m = "0" + m : m;
			sec<10 ? sec = "0" + sec : sec;
			return year + "-" + month + "-" + day + "&nbsp;&nbsp;" + h + ":" + m + ":" + sec;
	}

	//------------------------ 上面是基本函数 ------------------

	//------------------------ 模块私有函数开始 -------------------


	//每次点击一个文件夹会增加一个面包屑导航
	//每增加一个面包屑导航就需要此函数控制面包屑导航的数量
	//多出部分会迁移到溢出导航包裹层
	//控制面包屑导航栏数量函数
	function controlNavNums(navWrap,childnode,moreNavContain,icon){
		//获取父元素的宽度
		var parentWidth = parseInt(getCurStyle(navWrap,null,"width"));

		//获取全部子元素的宽度
		var childWidthTotal = 0;
		if (navWrap.isFully == undefined || navWrap.isFully == false) {
			for (var i = 0; i < childnode.length; i++) {
				//获取每一个子元素的实际宽度
				var curChildWidth = parseInt(getCurStyle(childnode[i],null,"width"));

				childWidthTotal += curChildWidth;
				//获取父元素与此时子元素总宽度的差值
				var diffWidth = parentWidth - childWidthTotal;
				
				//如果此时的差值不能容纳下子元素
				if (diffWidth < curChildWidth) {
					//复制这个节点
					var temp = childnode[i].cloneNode(true);
					//为每个复制的节点绑定事件函数  overflowNavItemClick
					EventUntil.addHandler(temp,"click",overflowNavItemClick);
					//将此时的子元素添加到溢出导航包裹层里面
					moreNavContain.appendChild(temp);
					//面包屑导航栏移除子元素
					navWrap.removeChild(childnode[i]);
					//设置导航栏包裹层isFully 属性为true
					//留作给下一次文件夹点击时 对到面包屑导航栏是否已经容不下导航做判断
					navWrap.isFully = true;
					
				}
				
			}

		}else if(navWrap.isFully == true) {
			//如果面包屑导航栏曾经被填满过
			//把它最后一个li 放进去溢出导航栏里面
			var len = childnode.length;
			var temp = navWrap.querySelectorAll("li")[len-1].cloneNode(true);
			//消除原来的点击事件
			temp.onclick = null;
			//重新绑定点击事件
			EventUntil.addHandler(temp,"click",overflowNavItemClick);
			//将此时的子元素添加到溢出导航包裹层里面
			moreNavContain.appendChild(temp);
			//移除最后一个子元素
			navWrap.removeChild(navWrap.querySelectorAll("li")[len-1]);
				
		}
		

		

		if (moreNavContain.childNodes.length != 0) {
			icon.style.display = "block";

		}else{
			icon.style.display = "none";
		}
	}






	//溢出导航点击事件回调函数
	//溢出导航包裹层里面的li 子元素点击事件回掉函数
	function overflowNavItemClick(event){
		//获取事件对象
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);
		var target = EventUntil.getTarget(event);
		//如果点击的目标元素是 a 标签 执行如下操作
		if (target.tagName.toLowerCase() == "a") {
			
			//获取溢出导航包裹层
			var overflowNavWrap = ss("#overflow-item-wrap ul")[0];
			//获取所有溢出导航层的li 子元素
			var overflowNavItemList = ss("#overflow-item-wrap ul li");
			//获得点击当前元素的索引
			var index = Array.prototype.indexOf.call(overflowNavItemList,this);
			//如果点击的这个元素不是溢出导航栏的最后一个元素
			if (index != overflowNavItemList.length - 1) {
				//遍历删除这个元素后面的元素
				for (var i = index + 1; i < overflowNavItemList.length; i++) {
					overflowNavWrap.removeChild(overflowNavItemList[i]);
				}

				//获取当前点击元素的 data-path
				var path = target.getAttribute("data-path");
				//获取当前页面的部门id
				var depId = s("#departmentId").title;
				//然后发送ajax 刷新下面的内容
				createFileList(path,depId);
			}
		}
		
	}



	//点击文件名的时候会调用此方法
	//创建面包屑导航栏子元素 li的方法
	//内部调用：breadCrumbItemClick，controlNavNums
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
		li.appendChild(a);
		//创建面包屑导航栏的时候为li 元素绑定点击事件
		EventUntil.addHandler(li,"click",breadCrumbItemClick);


		frag.appendChild(li);

		curmbNav.appendChild(frag);

		//每一次添加都进行一次导航数量的控制
		controlNavNums(s("#breadcurmb-nav-wrap"),ss("#breadcurmb-nav-wrap li"),
			ss("#overflow-item-wrap ul")[0],s("#show-hidden-menu"));

		//调整完样式之后就可以输出数据了
		var path = this.getAttribute("data-path");
		createFileList(path,s("#departmentId").title);
	}



	//面包屑导航栏每个导航标签点击事件
	//没点击一次面包屑导航都会刷新下面的文件列表
	//内部调用：createFileList
	function breadCrumbItemClick(event){
		event = EventUntil.getEvent(event);
		//阻止其默认事件
		EventUntil.preventDefault(event);

		var target = EventUntil.getTarget(event);
		//获取面包屑导航的外包裹层
		var breadCrumbWrap = s("#breadcurmb-nav-wrap");
		//获取所有面包屑导航的li
		var breadCrumbList = ss("#breadcurmb-nav-wrap li");
		//获取当前元素在元素集里面的位置
		var index = Array.prototype.indexOf.call(breadCrumbList,this);
		//如果点击当前的元素不为最后一个
		if (index != breadCrumbList - 1) {
			//遍历删除这个元素后面的元素
			for (var i = index + 1; i < breadCrumbList.length; i++) {
				breadCrumbWrap.removeChild(breadCrumbList[i]);
			}

		}
		//无论面包屑导航点击的是哪个子元素
		//都要清空溢出导航包裹层的所有子元素
		ss("#overflow-item-wrap ul")[0].innerHTML = "";
		//隐藏显示溢出导航按钮
		s("#show-hidden-menu").style.display = 'none';
		s("#overflow-item-wrap").style.display = 'none';
		//调整完样式之后
		//...发送ajax 请求刷新下面的文件导航
		//调用 createFileList(path,depId) 函数刷新下面的文件夹内容
		//path 为这个面包屑导航的 data-path 属性
		//depId 为页面的系别的id 实际情况由登录页面的时候获取部门id
		var path = target.getAttribute("data-path");
		var depId = s("#departmentId").title;
		createFileList(path,depId);
		
		//重设面包屑导航栏isFully属性
		breadCrumbWrap.isFully = false;

		//如果点击的是根目录的面包屑导航
		//为其增加多一个功能 显示上传文件按钮
		if (this.id == "rootNav-breadCrumb") {
			//判断上传文件按钮是否有 display:none 的内联属性
			if (s("#upload-file-btn").style.display == "none") {
				//如果有 将它显示出来（因为搜索后 上传文件按钮会设置display:none 属性）
				//设置它为inline-block
				s("#upload-file-btn").style.display = "inline-block";
				//清空搜索框内容
				s("#serach-bar").value = "";
			}
		}
	}



	//遍历输出文件夹数据函数
	//内部会为每一个保存文件夹名字的a 标签绑定点击事件函数createBradCurmbItem
	function ergFloderList(list){
		var tr = createElem("tr"),
			td = createElem("td"),
			a = createElem("a"),
			frag = document.createDocumentFragment();
			//checkBox = createElem("input")

		// checkBox.type = "checkbox";
		// checkBox.className = "disabled";
		// checkBox.disabled = true;

		for (var i = 0; i < list.length; i++) {
			var row = tr.cloneNode(true);

			// var checkboxCol = td.cloneNode(true);
			// checkboxCol.className = "item-selectbox";

			var floderNameCol = td.cloneNode(true);
			floderNameCol.className = "file-name floder";

			var authorCol = td.cloneNode(true);
			authorCol.className = "item-author";

			var timeCol = td.cloneNode(true);
			timeCol.className = "item-publish-time";

			var operateCol = td.cloneNode(true);
			operateCol.className = "operate-btn";

			// var checkbox = checkBox.cloneNode(true);

			var floderName = a.cloneNode(true);
			floderName.innerText = list[i].nav;
			floderName.href = "#";
			floderName.setAttribute("data-path", list[i].uid);
			//为a 元素绑定事件 回调函数是生成面包屑导航函数
			EventUntil.addHandler(floderName,"click",createBradCurmbItem);

			//checkboxCol.appendChild(checkbox);
			floderNameCol.appendChild(floderName);
			authorCol.innerText = "管理员";
			timeCol.innerText = "-";
			operateCol.innerText = "无";

			//row.appendChild(checkboxCol);
			row.appendChild(floderNameCol);
			row.appendChild(authorCol);
			row.appendChild(timeCol);
			row.appendChild(operateCol);

			frag.appendChild(row);
		}
		//返回文本碎片
		return frag;
	}




	//文件名点击事件回调函数
	function fileNameClick(event){
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

		var path = this.getAttribute("data-path");

		window.open("/Management/content/filecontent.action?uid=" + path,"_blank");
			
	}



	//修改文件名按钮点击事件回调函数
	function modifyFilenameBtnClick(event){

		var parent = this.parentNode.parentNode;
		var fileName = parent.querySelectorAll(".file-name a")[0].innerText;
		var fileId = parent.querySelectorAll(".file-name a")[0].getAttribute("data-path");
		//填充修改文件名输入框内容
		s("#new-filename").value = fileName;
		//获取对应的文件id
		s("#new-filename").title = fileId;
		//显示修改文件名弹出层
		s("#modify-filename-floor").style.display = 'block';
	}


	//删除文件按钮点击事件回调函数
	function dropFileBtnClick(){

		var parent = this.parentNode.parentNode;
		var curFileName = parent.querySelectorAll(".file-name a")[0].innerText;
		var curPath = parent.querySelectorAll(".file-name a")[0].getAttribute("data-path");


		s("#drop-files-name").innerText = curFileName;
		s("#drop-files-name").title = curPath;
		s("#drop-file-floor").style.display = 'block';
	}

	//遍历文件函数
	//内部会为每一个保存文件夹名字的a 标签绑定点击事件函数fileNameClick
	//为每一个编辑文件标题按钮绑定 modifyFilenameBtnClick
	//为每一个删除文件按钮绑定 dropFileBtnClick
	function ergFileList(list){
		var button = createElem("button"),
			tr = createElem("tr"),
			td = createElem("td"),
			a = createElem("a"),
			span = createElem("span"),
			frag = document.createDocumentFragment();
			//checkBox = createElem("input")

		var curUsername = s("#user-name").title;

		var modifyBtnIcon = span.cloneNode(true),
			dropBtnIcon = span.cloneNode(true),
			modifyBtn = button.cloneNode(true),
			dropBtn = button.cloneNode(true);
		
		// checkBox.type = "checkbox";
		// checkBox.disabled = "true";

		modifyBtnIcon.className = "glyphicon glyphicon-edit";
		modifyBtn.className = "btn btn-default btn-sm";
		modifyBtn.appendChild(modifyBtnIcon);
		modifyBtn.innerHTML += "修改文件";

		dropBtnIcon.className = "glyphicon glyphicon-trash";
		dropBtn.className = "btn btn-danger btn-sm";
		dropBtn.appendChild(dropBtnIcon);
		dropBtn.innerHTML += "删除文件";
		

		for (var i = 0; i < list.length; i++) {
			var row = tr.cloneNode(true);

			// var checkboxCol = td.cloneNode(true);
			// checkboxCol.className = "item-selectbox";

			var filenameCol = td.cloneNode(true);
			filenameCol.className = "file-name file";

			var authorCol = td.cloneNode(true);
			authorCol.className = "item-author";

			var timeCol = td.cloneNode(true);
			timeCol.className = "ite-publish-time";

			var operateCol = td.cloneNode(true);
			operateCol.className = "operate-btn";

			//实际输出时应该获得登陆的用户名做匹配
			//判断是否给checkbox 加上 disabled 类名
			if (list[i].accuid != curUsername) {

				// var checkbox = checkBox.cloneNode(true);
				// checkbox.className = "disabled";
				// checkbox.disabled = "true";
				operateCol.innerText = "无权限";
				//checkboxCol.appendChild(checkbox);

			}else{
				//var checkbox = checkBox.cloneNode(true);
				var modifyFileBtn = modifyBtn.cloneNode(true),
					dropFileBtn = dropBtn.cloneNode(true);


				//为修改文件按钮绑定点击事件
				EventUntil.addHandler(modifyFileBtn,"click",modifyFilenameBtnClick);
				//为删除文件按钮绑定点击事件
				EventUntil.addHandler(dropFileBtn,"click",dropFileBtnClick);

				//checkboxCol.appendChild(checkbox);
				operateCol.appendChild(modifyFileBtn);
				operateCol.appendChild(dropFileBtn);

				
			}

			
			var filename = a.cloneNode(true);
			filename.href = "#";
			filename.setAttribute("data-path", list[i].uid);
			filename.innerText = list[i].title;
			//为文件名绑定点击事件
			EventUntil.addHandler(filename,"click",fileNameClick);
	
			filenameCol.appendChild(filename);
			authorCol.innerText = list[i].author;

			timeCol.innerHTML = formateDate(list[i].upTime);
			

			//row.appendChild(checkboxCol);
			row.appendChild(filenameCol);
			row.appendChild(authorCol);
			row.appendChild(timeCol);
			row.appendChild(operateCol);

			frag.appendChild(row);
		}
		//返回文本碎片
		return frag;
	}



	//公有方法1 模块出口在此函数
	//通过ajax获取导航栏 输出导航栏信息
	function createFileList(path,depId){
		//参数：path 导航栏的请求id 初始化页面的时候为0
		//之后的点击在导航栏名字的 data-path 里面获取
		//depId 当前页面的系别id
		//此方法 将会在表格里面的文件夹名点击，面包屑导航，溢出导航点击时调用
		//发送ajax 请求
		$.ajax({
			url: '/Management/content/ajaxFindNavAndFile.action?',
			type: 'GET',
			dataType: 'json',
			data: "parent=" + path + "&depuid=" + depId,
			beforeSend: function(){
				s("#loading-file-floor").style.display = 'block';
			},
			success:function(data){
				if (data.code == 100) {
					//第一步 清空文件列表
					s("#main-content-list").innerHTML = "";
					//第二步 获取文件夹和文件数据
					var floderList = data.extend.navs;
					var fileList = data.extend.files;
					//第三步 判断后台文件夹列表是否为空
					if (floderList.length != 0) {
						s("#main-content-list").appendChild(ergFloderList(floderList));
					}
					//判断后台文件列表是否为空
					if (fileList.length != 0) {
						s("#main-content-list").appendChild(ergFileList(fileList));
					}
				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("加载数据失败，请检查网络");
				}

				//隐藏加载弹出层
				s("#loading-file-floor").style.display = 'none';
			},
			error: function(){
				//隐藏加载弹出层
				s("#loading-file-floor").style.display = 'none';
				alert("无法加载文件列表，请检查你的网络或稍后重试");
			}
		})
		
	}



	//公有方法2 页面初始化时需要调用此函数初始化面包屑导航
	//页面加载完成时初始化面包屑导航栏
	//为其添加第一个导航栏
	function initCrumbNav(){
		var crumbNav = s("#breadcurmb-nav-wrap");

		var frag = document.createDocumentFragment(),
			li = createElem("li"),
			a = createElem("a");

		a.href = "#";
		a.setAttribute("data-path", 0);
		//此处还应该获取当前页面的 depId 这里先写死
		a.innerText = "根目录";
		li.appendChild(a);
		li.id = "rootNav-breadCrumb";
		EventUntil.addHandler(li,"click",breadCrumbItemClick);
		frag.appendChild(li);
		crumbNav.appendChild(frag);

	}

	return {
		initFileList: createFileList,
		initBreadCrumbNav: initCrumbNav,
		outputFiles: ergFileList
	}

})	