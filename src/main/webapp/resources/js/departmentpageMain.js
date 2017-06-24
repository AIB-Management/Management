//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		},

		'bootstrap.min':{
			deps:['jquery.min']
		},

		'fileinput.min':{
			deps: ['jquery.min','bootstrap.min']

		},

		'es':{
			deps: ['jquery.min','bootstrap.min','fileinput.min']
		},

		'zh':{
			deps: ['jquery.min','bootstrap.min','fileinput.min','es']
		}

	}

})

//departmentpage 脚本main函数
require(["jquery.min","overborwserEvent","authorityManage","departmentPageFileListModule","bootstrap.min","fileinput.min","es","zh"],function main($,EventUntil,authorityModule,depFileListModule){

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
				url: '/Management/file/ajaxUpdateFile.action',
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
			success: function(data){
				if (data.code == 100) {
					//请求成功后刷新文件列表
					depFileListModule.initFileList(curPath,curDepId);
					//关闭对话框
					s("#drop-file-floor").style.display = 'none';
				}
			}
		})
		
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
		}
	}


	EventUntil.addHandler(document,"click",entrustEvent);


	//初始化拖拽上传插件
	$("#fileupload").fileinput({
        language: 'zh', //设置语言
    	uploadUrl: "/Management/file/doUploadFile.action", //上传的地址
	    allowedFileExtensions: null,//接收的文件后缀,
	    maxFileCount: 3,
	   	dropZoneEnabled: true,
	    enctype: 'multipart/form-data',
	    showCaption: true,//是否显示标题
	    showUpload: false, //取消上传按钮
	    uploadAsync: false,
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


    }).on('filebatchuploadcomplete', function(event, files, extra) {
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

    });

    function uploadFile(){
    	var isNoRepeat = checkFloderName(ss("#main-content-list tr td a"),s("#fileTitle").value);
    	if (isNoRepeat == true) {
    		//如果文件名没有重复
    		//清空错误提示字段文字
    		s("#filetitle-hint").innerText = "";
    		//再判断文件插件是否有文件存在
    		
    		if ($("#fileupload").fileinput("getFileStack").length != 0) {
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


	
})