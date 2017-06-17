//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		},

		'bootstrap.min':{
			deps:['jquery.min']
		},

		'fileinput':{
			deps: ['jquery.min','bootstrap.min']

		},

		'fileinput_locale_es':{
			deps: ['jquery.min','bootstrap.min','fileinput']
		},

		'fileinput_locale_zh':{
			deps: ['jquery.min','bootstrap.min','fileinput','fileinput_locale_es']
		}

	}

})

//departmentpage 脚本main函数
require(["jquery.min","overborwserEvent","authorityManage","bootstrap.min","fileinput","fileinput_locale_es","fileinput_locale_zh"],function main($,EventUntil,authorityModule){

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
		if (elem.currentStyle != undefined) {
			return elem.currentStyle[targetProperty];
			
		}else{
			return window.getComputedStyle(elem,pusedo)[targetProperty];
			
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
	//-------------------- 上面是自定义函数层 -------------------


	//控制面包屑导航栏数量函数
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
				//为每个复制的节点绑定事件函数  overflowNavItemClick
				EventUntil.addHandler(temp,"click",overflowNavItemClick);
				//将此时的子元素添加到溢出导航包裹层里面
				moreNavContain.appendChild(temp);
				//面包屑导航栏移除子元素
				navWrap.removeChild(childnode[i]);
				
			}
			
		}

		if (moreNavContain.childNodes.length != 0) {
			icon.style.display = "block";

		}else{
			icon.style.display = "none";
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



	//溢出导航包裹层里面的li 子元素点击事件回掉函数
	function overflowNavItemClick(event){
		//获取事件对象
		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);
		//如果点击的目标元素是 a 标签 执行如下操作
		if (event.target.tagName.toLowerCase() == "a") {
			
			//获取溢出导航包裹层
			var overflowNavWrap = s("#overflow-item-wrap");
			//获取所有溢出导航层的li 子元素
			var overflowNavItemList = ss("#overflow-item-wrap li");
			//获得点击当前元素的索引
			var index = Array.prototype.indexOf.call(overflowNavItemList,this);
			//如果点击的这个元素不是溢出导航栏的最后一个元素
			if (index != overflowNavItemList.length - 1) {
				//遍历删除这个元素后面的元素
				for (var i = index + 1; i < overflowNavItemList.length; i++) {
					overflowNavWrap.removeChild(overflowNavItemList[i]);
				}

				//获取当前点击元素的 data-path
				var path = event.target.getAttribute("data-path");
				//获取当前页面的部门id
				var depId = s("#departmentId").title;
				//然后发送ajax 刷新下面的内容
				createFileList(path,depId);
			}
		}
		
	}
	

	//面包屑导航栏每个导航标签点击事件
	//内部调用：createFileList
	function breadCrumbItemClick(event){
		event = EventUntil.getEvent(event);
		//阻止其默认事件
		EventUntil.preventDefault(event);
		//获取面包屑导航的外包裹层
		var breadCrumbWrap = s("#breadcurmb-nav-wrap");
		//获取所有面包屑导航的li
		var breadCrumbList = ss("#breadcurmb-nav-wrap li");
		//为每一个导航绑定点击事件
		for (var i = 0; i < breadCrumbList.length; i++) {
			EventUntil.addHandler(breadCrumbList[i],"click",function(event){
				//如果点击的目标是a 标签 那么进行如下操作
				if (event.target.tagName.toLowerCase() == "a") {
					//重新获取一次当前的li 个数
					breadCrumbList = ss("#breadcurmb-nav-wrap li");
					//再获取当前元素在元素集里面的位置
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
					s("#overflow-item-wrap").innerHTML = "";
					//隐藏显示溢出导航按钮
					s("#show-hidden-menu").style.display = 'none';
					s("#overflow-item-wrap").style.display = 'none';

					//调整完样式之后
					//...发送ajax 请求刷新下面的文件导航
					//调用 createFileList(path,depId) 函数刷新下面的文件夹内容
					//path 为这个面包屑导航的 data-path 属性
					//depId 为页面的系别的id 实际情况由登录页面的时候获取部门id
					var path = event.target.getAttribute("data-path");
					var depId = s("#departmentId").title;
					createFileList(path,depId);
				}

				
			})
			
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
			s("#overflow-item-wrap"),s("#show-hidden-menu"));

		//调整完样式之后就可以输出数据了
		var path = this.getAttribute("data-path");
		createFileList(path,s("#departmentId").title);
	}

	//文件点击事件回调函数
	function fileNameClick(event){

		var parent = this.parentNode.parentNode;
		var fileName = parent.querySelectorAll(".file-name")[0].innerText;

		//填充修改文件名输入框内容
		s("#new-filename").value = fileName;
		//显示修改文件名弹出层
		s("#modify-filename-floor").style.display = 'block';
	}

	//遍历输出文件夹数据函数
	//内部会为每一个保存文件夹名字的a 标签绑定点击事件函数floderNameClick
	function ergFloderList(list){
		var checkBox = createElem("input"),
			tr = createElem("tr"),
			td = createElem("td"),
			a = createElem("a"),
			frag = document.createDocumentFragment();

		checkBox.type = "checkbox";
		checkBox.className = "disabled";
		checkBox.disabled = true;

		for (var i = 0; i < list.length; i++) {
			var row = tr.cloneNode(true);

			var checkboxCol = td.cloneNode(true);
			checkboxCol.className = "item-selectbox";

			var floderNameCol = td.cloneNode(true);
			floderNameCol.className = "file-name floder";

			var authorCol = td.cloneNode(true);
			authorCol.className = "item-author";

			var timeCol = td.cloneNode(true);
			timeCol.className = "ite-publish-time";

			var operateCol = td.cloneNode(true);
			operateCol.className = "operate-btn";

			var checkbox = checkBox.cloneNode(true);

			var floderName = a.cloneNode(true);
			floderName.innerText = list[i].nav;
			floderName.href = "#";
			floderName.setAttribute("data-path", list[i].uid);
			//为a 元素绑定事件 回调函数是生成面包屑导航函数
			EventUntil.addHandler(floderName,"click",createBradCurmbItem);

			checkboxCol.appendChild(checkbox);
			floderNameCol.appendChild(floderName);
			authorCol.innerText = "管理员";
			timeCol.innerText = "-";
			operateCol.innerText = "无";

			row.appendChild(checkboxCol);
			row.appendChild(floderNameCol);
			row.appendChild(authorCol);
			row.appendChild(timeCol);
			row.appendChild(operateCol);

			frag.appendChild(row);
		}
		//返回文本碎片
		return frag;
	}

	//遍历文件函数
	//内部会为每一个保存文件夹名字的a 标签绑定点击事件函数fileNameClick
	function ergFileList(list){
		var checkBox = createElem("input"),
			button = createElem("button"),
			tr = createElem("tr"),
			td = createElem("td"),
			a = createElem("a"),
			span = createElem("span"),
			frag = document.createDocumentFragment();

		var curUsername = s("#user-name").title;
		
		span.className = "glyphicon glyphicon-edit";
		checkBox.type = "checkbox";
		button.className = "btn btn-default btn-sm";
		button.appendChild(span);
		button.innerHTML += "修改文件";
		

		for (var i = 0; i < list.length; i++) {
			var row = tr.cloneNode(true);

			var checkboxCol = td.cloneNode(true);
			checkboxCol.className = "item-selectbox";

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
			if (list[i].accuid == curUsername) {

				var checkbox = checkBox.cloneNode(true);
				checkbox.className = "disabled";
				operateCol.innerText = "无权限";
				checkboxCol.appendChild(checkbox);

			}else{
				var checkbox = checkBox.cloneNode(true);
				var operateBtn = button.cloneNode(true);
				checkboxCol.appendChild(checkbox);
				operateCol.appendChild(operateBtn);
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
			

			row.appendChild(checkboxCol);
			row.appendChild(filenameCol);
			row.appendChild(authorCol);
			row.appendChild(timeCol);
			row.appendChild(operateCol);

			frag.appendChild(row);
		}
		//返回文本碎片
		return frag;
	}

	//通过ajax获取导航栏 输出导航栏信息
	function createFileList(path,depId){
		//参数：path 导航栏的请求id 初始化页面的时候为0
		//之后的点击在导航栏名字的 data-path 里面获取
		//depId 当前页面的系别id
		//此方法 将会在表格里面的文件夹名点击，面包屑导航，溢出导航点击时调用
		//发送ajax 请求
		$.ajax({
			url: 'http://localhost:8080/Management/content/ajaxFindNavAndFile.action',
			type: 'GET',
			dataType: 'json',
			data: "parent=" + path + "&depuid=" + depId,
			success:function(data){
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
			}
		})
		
	}

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
		EventUntil.addHandler(li,"click",breadCrumbItemClick);
		frag.appendChild(li);
		crumbNav.appendChild(frag);

	}

	//初始化上传文件身份选择下拉列表
	function initAuthorityList(){
		$.ajax({
			url: 'http://localhost:8080/Management/runas/getbeAccount.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				if (data.code == 100) {
					var list = data.extend.beAccount;
					var frag = document.createDocumentFragment();
					for (var i = 0; i < list.length; i++) {
						var option = createElem("option");
						option.innerText = list[i].name;
						option.value = list[i].uid;
						frag.appendChild(option);
					}
					//下拉列表添加元素
					s("#all-identifies-list").appendChild(frag);
				}
			}
		})

	}

	//初始化页面函数
	function initPage(){
		//调试 输出导航栏数据函数由页面获得
		//var depuid = 由页面标题获得
		createFileList(0,s("#departmentId").title);
		//输出第一个面包屑导航
		initCrumbNav();
		//权限管理模块页面初始化的时候输出数据
		authorityModule();
		//初始化上传文件身份选择下拉框内容
		initAuthorityList();
	}
		


	//------------- 调用层 ----------------

	//初始化页面
	initPage();

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


	
	//溢出导航栏按钮点击事件回调函数
	function overFlowNavBtnClick(){
		//获取按钮的宽度
		var curWidth = parseInt(getCurStyle(this,null,"width"));
		
		//获取按钮高度
		var curHeight = parseInt(getCurStyle(this,null,"height"));

		if (s("#overflow-item-wrap").style.display == "" || s("#overflow-item-wrap").style.display == "none") {

			s("#overflow-item-wrap").style.right = (curWidth / 2) + "px";
			
			s("#overflow-item-wrap").style.top = (curHeight + 15) + "px";

			s("#overflow-item-wrap").style.display = "block";

		}else{

			s("#overflow-item-wrap").style.display = "none";
		}
	}





	//事件委托函数
	function entrustEvent(event){

		event = EventUntil.getEvent(event);
		//获取真正触发事件的对象
		var target = event.target;

		//隐藏溢出导航栏按钮事件
		if (target.id == "show-hidden-menu") {
			//执行溢出导航栏按钮点击事件回调函数
			overFlowNavBtnClick();

		}else if (target.id == "upload-file-btn") {
			//上传文件按钮点击事件
			var curPath = getCurPath();
			if (curPath == 0) {
				alert("不能够在根目录下发布文件！");

			}else{
				s("#upload-file-floor").style.display = 'block';
			}

		}else if (target.id == "uploadfile-close-btn") {
			//上传文件弹出层关闭按钮事件
			s("#upload-file-floor").style.display = 'none';

		}else if(target.id == "authority-manage-enter") {
			//权限管理选项点击事件
			//阻止默认事件
			EventUntil.preventDefault(event);
			s("#authority-manage-floor").style.display = "block";

		}else if(target.id == "authority-manage-close-btn") {
			//权限管理弹出层关闭按钮点击事件
			s("#authority-manage-floor").style.display = "none";

		}else if (target.id == "modify-filename-close-btn") {
			//修改文件标题弹出层关闭按钮点击事件
			s("#modify-filename-floor").style.display = 'none';
		}
	}


	EventUntil.addHandler(document,"click",entrustEvent);


	//初始化拖拽上传插件
	$("#fileupload").fileinput({
        language: 'zh', //设置语言
    	uploadUrl: "http://localhost:8080/Management/file/uploadFile.action", //上传的地址
	    allowedFileExtensions : ['docx','doc','jpg','png','flash','swf'],//接收的文件后缀,
	    maxFileCount: 3,
	   	dropZoneEnabled: true,
	    enctype: 'multipart/form-data',
	    showCaption: true,//是否显示标题
	    showUpload: true, //取消上传按钮
	    uploadAsync: false,//同步上传
	    uploadIcon: '', //取消文件下面的上传按钮
	    uploadExtraData: {
	    	title: s("#fileTitle").value,
	    	navuid: getCurPath(),
	    	accuid: s("#all-identifies-list").value
        }, 
	    browseClass: "btn btn-primary", //按钮样式             
	    previewFileIcon: "<i class='glyphicon glyphicon-file'></i>",
	    msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！"

    }).on("fileuploaded", function(event, data) {

       console.log(data);

    })


	
})