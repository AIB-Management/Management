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

		'jquery.mousewheel.min': {
			deps: ['jquery.min']
		},

		'mCustomScrollbar.min': {
			deps: ['jquery.min','jquery.mousewheel.min']
		}

	}

})

//departmentpage 脚本main函数
require(["domReady","jquery.min","overborwserEvent",
	"departmentpageauthorityManage","departmentPageFileListModule",
	"bootstrap.min","fileinput","jquery.mousewheel.min","mCustomScrollbar.min"],function main(domready,$,EventUntil,authorityModule,depFileListModule){

	//*******
	//全局变量
	//保存面包屑导航栏的导航和溢出导航栏的导航数组
	//用作回滚数据
	var saveBreadCrumbNav = [],
		saveOverflowNav = [];
	//*******

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
		
		//ie独有方法 兼容ie6 - 8且所有ie 浏览器都支持
		//但是返回的宽度属性会显示为auto失去计算意义
		//所以这里记一下 没有实际作用
		//return elem.currentStyle[targetProperty];

		return window.getComputedStyle(elem,pusedo)[targetProperty];
			
		
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

	//获取当前路径函数
	function getCurPath(){

		var overflowNavList = ss("#overflow-item-wrap ul li"),
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



	//定义检测创建文件名或修改文件名时 文件名是否有重复
	//提交修改文件名时会调用此函数
	function checkFloderName(elem,val){
		//获取相应的参照元素
		var floderNameList = elem,
			//定义文件夹名字状态初始值
			filenameStatus = false;

		//如果当前文件夹数不为0
		if (floderNameList.length != 0) {
			//遍历表格内的所有a 元素内容，如果有同名文件夹马上报错
			for (var i = 0; i < floderNameList.length; i++) {
				if (floderNameList[i].innerText == val) {
					filenameStatus = false;
					break;
				}else if (floderNameList[i].innerText != val && i == floderNameList.length - 1) {
					filenameStatus = true;
				}
			}
		}else{
			filenameStatus = true;
		}

		return filenameStatus;
	}
	//-------------------- 上面是自定义函数层 -------------------

	//初始化上传文件身份选择下拉列表
	function initAuthorityList(){
		$.ajax({
			url: '/Management/runas/getbeAccount.action',
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
		depFileListModule.initFileList(0,s("#departmentId").title);
		//输出第一个面包屑导航
		depFileListModule.initBreadCrumbNav();
		
	}
		


	//------------- 调用层 ----------------
	

	function uploadFile(){
    	
			//如果不是ie9
			var isNoRepeat = checkFloderName(ss("#main-content-list tr td a"),s("#fileTitle").value);
	    	if (isNoRepeat == true) {
	    		//如果文件名没有重复
	    		//清空错误提示字段文字
	    		s("#filetitle-hint").innerText = "";

	    		//再判断文件插件是否有文件存在
	    		if ($("#fileupload").fileinput("getFileStack").length != 0 || s("#fileupload").value != "") {
	    			//如果有文件
					//触发文件上传插件上传事件
	    			$("#fileupload").fileinput("upload");
	    		}else{
	    			alert("请选择文件");
	    		}
	    		

	    	}else{
	    		s("#filetitle-hint").style.color = "red";
	    		s("#filetitle-hint").innerText = "已存在此文件名";
	    	}
    	
    }
	
	//溢出导航栏按钮点击事件回调函数
	function overFlowNavBtnClick(target){
		//获取按钮的宽度
		var curWidth = parseInt(getCurStyle(target,null,"width"));
		
		//获取按钮高度
		var curHeight = parseInt(getCurStyle(target,null,"height"));

		if (s("#overflow-item-wrap").style.display == "" || s("#overflow-item-wrap").style.display == "none") {

			s("#overflow-item-wrap").style.right = (curWidth / 2) + "px";
			
			s("#overflow-item-wrap").style.top = (curHeight + 10) + "px";

			s("#overflow-item-wrap").style.display = "block";

		}else{

			s("#overflow-item-wrap").style.display = "none";
		}
	}


	//删除文件对话框删除按钮点击事件执行函数
	function doDropFile(){
		var uid = s("#drop-files-name").title;
		var accuid = s("#user-name").title;

		//获取当前删除文件所在路径以及当前页面的系别id 为刷新列表时候所用
		var curPath = getCurPath();
		var curDepId = s("#departmentId").title;

		//发送ajax
		$.ajax({
			url: '/Management/file/ajaxDeleteFile.action',
			type: 'POST',
			dataType: 'json',
			data: "accuid=" + accuid + "&uid=" + uid,
			cache: false,
			success: function(data){
				if (data.code == 100) {
					//请求成功后刷新文件列表
					depFileListModule.initFileList(curPath,curDepId);
					//关闭对话框
					s("#drop-file-floor").style.display = 'none';
					alert("删除成功");
				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("删除失败，遇到未知错误请重试");
				}
			}
		})
		
	}

	//回滚数据函数
	function reloadBeforeSearchData(event){

		event = EventUntil.getEvent(event);
		EventUntil.preventDefault(event);

		var breadCrumbNavsFrag = document.createDocumentFragment(),
			overFlowNavFrag = document.createDocumentFragment();
		
		//获取当前系别
		var depId = s("#departmentId").title;

		
		//点击回滚数据导航的时候先判断溢出导航栏数组有没有元素
		if (saveBreadCrumbNav.length != 1 && saveOverflowNav.length != 0) {
			//如果有且面包屑导航栏也有元素
			//清空路径上的元素
			s("#breadcurmb-nav-wrap").innerHTML = "";
			//遍历数组 将元素推入碎片器
			for (var i = 0; i < saveBreadCrumbNav.length; i++) {
				breadCrumbNavsFrag.appendChild(saveBreadCrumbNav[i]);
			}

			for (var j = 0; j < saveOverflowNav.length; j++) {

				overFlowNavFrag.appendChild(saveOverflowNav[j]);
			}
			//然后输出面包屑导航的元素
			s("#breadcurmb-nav-wrap").appendChild(breadCrumbNavsFrag);
			//再输出溢出导航栏的元素
			ss("#overflow-item-wrap ul")[0].appendChild(overFlowNavFrag);
			//显示溢出导航点击按钮
			s("#show-hidden-menu").style.display = 'inline-block';
			//获取当前的路径
			var path = getCurPath();
			//输出文件列表
			depFileListModule.initFileList(path,depId);
			//显示上传文件按钮
			s("#upload-file-btn").style.display = 'inline-block';
			//清空搜索输入框内容
			s("#serach-bar").value = "";

		}else if(saveBreadCrumbNav.length != 0 && saveOverflowNav.length == 0) {
			//如果面包屑导航栏有元素 但是溢出导航栏没有元素
			//先清空包屑导航栏
			s("#breadcurmb-nav-wrap").innerHTML = "";

			//把数组元素推进碎片器
			for (var i = 0; i < saveBreadCrumbNav.length; i++) {
				breadCrumbNavsFrag.appendChild(saveBreadCrumbNav[i]);
			}
			//然后输出面包屑导航的元素
			s("#breadcurmb-nav-wrap").appendChild(breadCrumbNavsFrag);

			//获取当前的路径
			var path = getCurPath();
			//输出文件列表
			depFileListModule.initFileList(path,depId);
			//显示上传文件按钮
			s("#upload-file-btn").style.display = 'inline-block';
			//清空搜索输入框内容
			s("#serach-bar").value = "";
		}
		


	}

	//调整面包屑导航栏的内容
	function adjustBreadCrumb(){
		var breadCrumbList = ss("#breadcurmb-nav-wrap li"),
			overflowNavList = ss("#overflow-item-wrap ul li");

		//每次执行函数都要清空一次面包屑导航栏数组
		saveBreadCrumbNav.splice(0, saveBreadCrumbNav.length);
		//清空溢出导航栏的数组
		saveOverflowNav.splice(0, saveOverflowNav.length);

		//如果面包屑导航栏个数不为0
		if (breadCrumbList.length != 0) {
			
			//遍历清空面包屑导航的子元素
			for (var i = 0; i < breadCrumbList.length; i++) {
				//在删除之前先保存 用作回滚用
				saveBreadCrumbNav.push(breadCrumbList[i]);
				s("#breadcurmb-nav-wrap").removeChild(breadCrumbList[i]);
				
			}
		}

		//清空溢出导航栏元素
		//如果溢出导航栏有元素
		if (overflowNavList.length != 0) {
			
			//遍历保存溢出导航层元素
			for (var j = 0; j < overflowNavList.length; j++) {
				saveOverflowNav.push(overflowNavList[j]);
				ss("#overflow-item-wrap ul")[0].removeChild(overflowNavList[j]);

			}

			//隐藏溢出导航栏
			s("#overflow-item-wrap").style.display = 'none';
			//隐藏溢出导航点击按钮
			s("#show-hidden-menu").style.display = 'none';
		}

		//然后添加搜索内容导航
		var li = createElem("li"),
			a = createElem("a")
			spanIcon = createElem("span");

		spanIcon.className = "glyphicon glyphicon-chevron-left";
		spanIcon.style.color = "#337ab7";

		var returnFileListNav = li.cloneNode(),
			returnFileListNavText = a.cloneNode(),
			searchTitleNav = li.cloneNode(),
			searchTitleNavText = a.cloneNode();

		returnFileListNav.appendChild(spanIcon);
		returnFileListNavText.innerText+= "返回文件列表";
		returnFileListNavText.href = "#";
		returnFileListNav.appendChild(returnFileListNavText);
		//为返回文件列表的导航项绑定点击事件
		EventUntil.addHandler(returnFileListNav,"click",reloadBeforeSearchData);

		searchTitleNavText.innerText = "搜索内容";
		searchTitleNavText.href = "#";
		searchTitleNav.appendChild(searchTitleNavText);

		s("#breadcurmb-nav-wrap").appendChild(returnFileListNav);
		s("#breadcurmb-nav-wrap").appendChild(searchTitleNav);

	}


	//搜索按钮点击事件回调函数
	function doSearch(){
		//判断搜索内容是否为空
		if (s("#serach-bar").value != "") {
			//不为空发送ajax 获取搜索数据
			$.ajax({
				url: '/Management/content/ajaxGetFileByKeyWord.action',
				type: 'GET',
				dataType: 'json',
				data: "keyWord=" + s("#serach-bar").value,
				beforeSend: function(){
					s("#loading-file-floor").style.display = 'block';
				},
				success: function(data){
					if (data.code == 100) {
						//如果处理成功
						//获取搜索文件数据
						var list = data.extend.files;
						//如果文件搜索内容不为空
						if (list.length != 0) {
							//清空文件列表
							s("#main-content-list").innerHTML = "";
							//添加输出搜索的内容
							s("#main-content-list").appendChild(depFileListModule.outputFiles(list));
							//隐藏上传文件按钮
							s("#upload-file-btn").style.display = 'none';
							//隐藏加载层
							s("#loading-file-floor").style.display = 'none';
							//调整面包屑导航栏的元素
							adjustBreadCrumb();
						}else{
							//隐藏加载层
							s("#loading-file-floor").style.display = 'none';
							alert("没有匹配的文件内容");
						}

					}else if(data.code == 200) {
						//隐藏加载层
						s("#loading-file-floor").style.display = 'none';
						alert("未知错误，请稍后重试");

					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");
					}
					
					
				}
			})
			
		}else{
			alert("搜索内容不能为空");
		}
	}

	//事件委托函数
	function entrustEvent(event){
		event = EventUntil.getEvent(event);
		//获取真正触发事件的对象
		var target = EventUntil.getTarget(event);
		

		//隐藏溢出导航栏按钮事件
		if (target.id == "show-hidden-menu") {
			//执行溢出导航栏按钮点击事件回调函数
			overFlowNavBtnClick(target);

		}else if(target.id == "link-modify-personalinfo") {
			EventUntil.preventDefault(event);
			//个人信息修改栏点击事件
			window.location.replace("/Management/content/personalpage.action");

		}else if (target.id == "upload-file-btn") {
			//上传文件按钮点击事件
			var curPath = getCurPath();
			if (curPath == 0) {
				alert("不能够在根目录下发布文件！");

			}else{
				//初始化上传文件身份选择下拉框内容
				initAuthorityList();
				s("#upload-file-floor").style.display = 'block';
			}

		}else if (target.id == "uploadfile-close-btn") {
			//清空文件上传插件内的文件缓存
        	$("#fileupload").fileinput("clear");
        	//清空上传文件标题
        	s("#fileTitle").value = "";
			//上传文件弹出层关闭按钮事件
			s("#upload-file-floor").style.display = 'none';

		}else if(target.id == "authority-manage-enter") {
			//权限管理选项点击事件
			//阻止默认事件
			EventUntil.preventDefault(event);
			//权限管理模块页面初始化的时候输出数据
			authorityModule();
			s("#authority-manage-floor").style.display = "block";

		}else if(target.id == "authority-manage-close-btn") {
			//权限管理弹出层关闭按钮点击事件
			s("#authority-manage-floor").style.display = "none";

		}else if (target.id == "modify-filename-close-btn") {
			//修改文件标题弹出层关闭按钮点击事件
			s("#modify-filename-floor").style.display = 'none';

		}else if(target.id == "drop-file-close-btn"){
			//删除文件对话框关闭按钮点击事件
			s("#drop-file-floor").style.display = 'none';

		}else if(target.id == "cancel-drop-file") {
			//删除文件对话框取消按钮点击事件
			s("#drop-file-floor").style.display = 'none';

		}else if(target.id == "confirm-drop-file") {
			//删除文件弹出层确认删除按钮点击事件
			doDropFile();

		}else if(target.id == "upload-batchfile") {
			//上传按钮点击事件
			uploadFile();

		}else if(target.id == "search-action-btn") {
			//搜索按钮点击事件
			doSearch();
		}
	}


	


	domready(function(){
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

		//修改文件名对话框输入框键盘输入事件
		EventUntil.addHandler(s("#new-filename"),"keyup",function(){
			if (this.value != "") {
				s("#submit-newfilename").className = "btn btn-primary btn-sm";
				s("#submit-newfilename").removeAttribute("disabled");

			}else{
				s("#submit-newfilename").className = "btn btn-primary btn-sm disabled";
				s("#submit-newfilename").disabled = "true";
			}
		});


		//修改文件名对话框提交按钮点击事件
		EventUntil.addHandler(s("#submit-newfilename"),"click",function(){
			//获取输入内容是否正确
			var newNameStatus = checkFloderName(ss("#main-content-list tr td a"),s("#new-filename").value);

			if (newNameStatus == true) {
				s("#new-filename-hint").innerText = "";
				//获取相应的后台参数
				var accuid = s("#user-name").title,
				 	uid = s("#new-filename").title,
				 	title = s("#new-filename").value;

				//获取当前删除文件所在路径以及当前页面的系别id 为刷新列表时候所用
				var curPath = getCurPath(),
					curDepId = s("#departmentId").title;

				$.ajax({
					url: '/Management/file/ajaxUpdateFile.action?',
					type: 'POST',
					dataType: 'json',
					data: "accuid=" + accuid + "&uid=" + uid + "&title=" + title,
					success: function(data){
						if (data.code == 100) {
							//请求成功后刷新文件列表
							depFileListModule.initFileList(curPath,curDepId);
							//清空错误提示信息
							s("#new-filename-hint").innerText = "";
							//关闭对话框
							s("#modify-filename-floor").style.display = 'none';
							alert("修改成功！");
						}else if(data.code == 300) {
							//后台状态码为300 表示这个账号在另一个浏览器或终端登录
							//返回错误信息并跳转到登陆页
							alert(data.message);
							window.location.replace("/Management/public/login.action");
							
						}else{
							alert("修改失败，遇到未知错误，请重试");
						}
					}
				})
				

			}else{
				s("#new-filename-hint").style.color = "red";
				s("#new-filename-hint").innerText = "已有相同的文件名";
			}
		})


		//文件标题输入框输入事件
		EventUntil.addHandler(s("#fileTitle"),"keyup",function(){
			if (this.value.length != 0) {
				s("#upload-batchfile").className = "btn btn-success";
				s("#upload-batchfile").removeAttribute("disabled");

			}else{
				s("#upload-batchfile").className = "btn btn-success disabled";
				s("#upload-batchfile").disabled = "true";

			}
		})

		//事件委托
		EventUntil.addHandler(document,"click",entrustEvent);


		//初始化授权管理模块列表滚动条
		$(".authoritied-tabel-wrap").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});

		//溢出导航栏包裹层设置滚动条
		$("#overflow-item-wrap").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});


		//初始化拖拽上传插件
		$("#fileupload").fileinput({
	        language: 'zh', //设置语言
	    	uploadUrl: "/Management/file/doUploadFile.action", //上传的地址
		    allowedFileExtensions: null,//接收的文件后缀,
		    maxFileCount: 100,
		   	dropZoneEnabled: true,
		    enctype: 'multipart/form-data',
		    showCaption: true,//是否显示标题
		    showUpload: false, //取消上传按钮
		    uploadAsync: false,//取消异步上传
		    uploadIcon: '', //取消文件下面的上传按钮
		    uploadExtraData: function (){
		    	return {
		    		title: s("#fileTitle").value,
			    	navuid: getCurPath(),
			    	accuid: s("#all-identifies-list").value
		    	}
	        }, 
		    browseClass: "btn btn-primary", //按钮样式             
		    previewFileIcon: "<i class='glyphicon glyphicon-file'></i>",
		    msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！"

	    }).on('filebatchpreupload', function(event, data, previewId, index) {
	    	//文件上传前禁用上传按钮
	    	s("#upload-batchfile").className = "btn btn-success disabled";
			s("#upload-batchfile").disabled = "true";


	    }).on('filebatchuploadsuccess', function(event, data, previewId, index) {

	        if (data.response.code == 300) {
	        	alert(data.response.message);
	        	window.location.replace("/Management/public/login.action");

	        }else{
	        	var curPath = getCurPath();
		    	var curDepId = s("#departmentId").title;
		       
		       	alert("上传成功！");

		    	//更新下面的文件列表
		        depFileListModule.initFileList(curPath,curDepId);
		        //清空文件上传插件内的文件缓存
		        $("#fileupload").fileinput("clear");
		        //清空文件标题
		        s("#fileTitle").value = "";
		        //关闭弹出层
		        s("#upload-file-floor").style.display = 'none';
	        }


	    }).on('filebatchuploaderror', function(event, data, msg) {
		    
		   alert("不可以上传js,java,php 等可操作性的文件！");
			

		}).on('filecleared', function(event) {
			//清空文件触发事件
			//清空文件标题
			s("#fileTitle").value = "";
			//禁用按钮
			s("#upload-batchfile").className = "btn btn-success disabled";
			s("#upload-batchfile").disabled = "true";

		});



	});


	
})