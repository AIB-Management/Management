require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		},

		'jquery.mousewheel.min': {
			deps: ['jquery.min']
		},

		'mCustomScrollbar.min': {
			deps: ['jquery.min','jquery.mousewheel.min']
		}

	}

})

//管理页主函数
require(["domReady","jquery.min","overborwserEvent",
	"rootpageUnexamiePageModule","rootpagExamiePageModule",
	"rootpageManageFloderListModule","rootpageManageDepartmentModule",
	"rootpageManageLeaderAdmin","jquery.mousewheel.min","mCustomScrollbar.min"],function main(domready,$,EventUntil,unexamiePage,examiePage,manageDepFloder,manageDep,manageAdminLeader){

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

	//定义移除类名方法
	function removeClass(elem,classname){
		var allClass = elem.className.split(" ");
		var targetIndex = allClass.indexOf(classname);
		allClass.splice(targetIndex,1);
		elem.className = allClass.join(" ");
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



	//用户表 "选择全部" 多选框点击事件执行函数
	function selectAllBtnHandler(checkboxList){
		//获取未审核用户当前页的所有多选框
		var checkBoxs = checkboxList;
		//用户列表 "选择全部" 多选框点击时为选中状态
		if (this.checked == true) {
			for (var i = 0; i < checkBoxs.length; i++) {
				checkBoxs[i].checked = true;
			}
		}else{
			for (var i = 0; i < checkBoxs.length; i++) {
				checkBoxs[i].checked = false;
			}
		}
		
	}


	//清空多选框选择状态函数
	function clearCheckBoxChecked(checkboxList){
		for (var i = 0; i < checkboxList.length; i++) {
			checkboxList[i].checked = false;
		}
	}


	//页面加载完成时 填充修改用户部门下拉列表option
	function getModifyUserDepModuleDep(){
		$.ajax({
			url: '/Management/content/ajaxFindDepOrPro.action?parent=0',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				if (data.code == 100) {

					createDepOptionForModifyUserDep(data);
				}else{
					alert("获取修改用户信息系别列表失败，请尝试刷新网页");
				}
			},

			error: function(){
				alert("获取修改用户信息系别列表失败，请尝试刷新网页");
			}
		})
		
	}

	//输出系别元素
	function createDepOptionForModifyUserDep(data){
		var list = data.extend.deps;
		var frag = document.createDocumentFragment();
		//清空系别下拉框内容
		s("#user-dep").innerHTML = "";

		for (var i = 0; i < list.length; i++) {
			var option = createElem("option");
			option.value = list[i].uid;
			option.innerText = list[i].dep;
			frag.appendChild(option);
		}

		s("#user-dep").appendChild(frag);
	}

	//输出专业元素
	//需要两个参数
	//第一个是系别的id ，第二个是设定特定专业为选中状态，可为空
	//第二个参数为空时 列表的选中状态会设为默认选中状态
	function createDepOptionForModifyUserSpec(data,targetSpec){
		var list = data.extend.pros;
		var frag = document.createDocumentFragment();

		//清空专业下拉框内容
		s("#user-spec").innerHTML = "";

		for (var i = 0; i < list.length; i++) {
			var option = createElem("option");
			option.value = list[i].uid;
			option.innerText = list[i].pro;
			if (targetSpec != undefined) {
				if (option.value == targetSpec) {
					option.selected = "selected";
				}
			}
			frag.appendChild(option);
		}
		s("#user-spec").appendChild(frag);
	}

	//发送请求 获取专业信息
	function getModifyUserDepModuleSpec(depId,targetOption){
		$.ajax({
			url: '/Management/content/ajaxFindDepOrPro.action?',
			type: 'GET',
			dataType: 'json',
			data: "parent=" + depId,
			success: function(data){
				if (data.code == 100) {

					createDepOptionForModifyUserSpec(data,targetOption);
				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("获取专业列表失败，请检查网络");
				}
			},

			error: function(){
				alert("获取专业列表失败，请检查网络");
			}
		})
	}


	//修改用户部门下拉框改变事件回调函数
	function modifyUserDepChange(){

		var val = this.value;
		
		getModifyUserDepModuleSpec(val);
		
	}

	//修改用户部门系别弹出层下拉列表改变事件
	EventUntil.addHandler(s("#user-dep"),"change",modifyUserDepChange);


	//修改用户系别弹出层提交按钮点击事件回调函数
	function confirmModifyUserDep(){
		
		//如果部门选择框的值合法
		if (s("#user-spec").value != "" && s("#user-dep").value != "") {
			//获取部门id 用户id
			var depId = s("#user-spec").value,
				userId = s("#user-spec").getAttribute("data-userid");
			//发送ajax 提交给后台
			$.ajax({
				url: '/Management/admin/ajaxUpdateTeacherDep.action',
				type: 'POST',
				dataType: 'json',
				data: "uid=" + userId + "&departmentUid=" + depId,
				success: function(data){
					if (data.code == 100) {
						alert("修改成功！");
						//重新刷新已审核列表信息
						examiePage.toexamiedPage(examiePage.curExamieModulePage,examiePage.curDepartmentId);
						s("#modify-user-department-floor").style.display = 'none';
					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						alert("修改失败！请检查网络或稍后重试");
					}
				},
				error: function(){
					alert("修改失败！请检查网络或稍后重试");
				}
			})
			

		}else{
			alert("请选择有效的系别或专业！");
		}
	}

	//取消多选框选中状态
	function clearCheckboxChecked(){
		var checkboxList = ss("#file-list-content input:checked");
		for (var i = 0; i < checkboxList.length; i++) {
			checkboxList[i].checked = false;
		}
	}


	//页面加载完成时 显示新增未注册用户数量
	function showUnexamieUserNums(){
		$.ajax({
			url: '/Management/admin/ajaxGetCountIsNotPass.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				//如果数量不为0 就输出
				if (data.extend.num != 0) {
					s("#number-hints").innerText = data.extend.num;
					s("#number-hints").style.display = 'inline-block';
				}
				
			}
		})
		
		
	}
	
	//定义检测创建文件名或修改文件名时 文件名是否有重复
	function nameIsRepeat(elem,val){
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
	

	//删除文件夹按钮点击事件回调函数
	function dropFloder(){
		
		//如果当前选择了系别
		if (manageDepFloder.curManageFloderDepId != "") {
			var checkboxList = ss(".floder-select:checked"),
				//定义保存选中多选框的数组
				dropFloderName = [],
				dropFloderUid = [];

			//检测是否有选中的多选框
			if (checkboxList.length != 0) {
				for (var i = 0; i < checkboxList.length; i++) {
					//获取同辈a 元素的文本内容
					var name = checkboxList[i].parentNode.parentNode.
								querySelectorAll("a")[0].innerText;

					var uid = checkboxList[i].parentNode.parentNode.
								querySelectorAll("a")[0].getAttribute("data-path");

					//将内容推进数组
					dropFloderName.push(name);
					dropFloderUid.push(uid);
				}

				//将保存的要删除文件夹的内容输出到确认弹出窗口中显示
				s("#target-floder-name").innerText = dropFloderName.join(",");
				s("#target-floder-name").title = dropFloderName.join(",");
				s("#target-floder-name").setAttribute("data-floderUid",dropFloderUid.join(","));
				s("#drop-floder-wrap").style.display = 'block';

			}else{
				alert("你还没有选择要删除的文件夹");
			}
			
		}else{
			//如果还没选择系别 提示错误
			alert("请先选择系别");
		}
	}

	

	//溢出导航隐藏按钮点击事件
	function overflowNavBtnClick(target){
		
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


	function submitNewFloder(){
		//遍历文件夹列表的所有a 标签文本判断是否与新建文件夹同名
		//有就提示错误 不允许创建
		//没有 创建成功 刷新文件夹列表

		//新建文件夹的必要参数
		//parent == data-path; depuid == curManageFloderDepId; title == 输入框的value
		
		//获取输入框的内容
		var val = s("#new-file-name").value;
		//调用 nameIsRepeat 函数判断文件名是否合法
		var floderNameIsCorrect = nameIsRepeat(ss("#file-list-content tr td a"),val);

		//根据filenameStatus 判断文件名的合法性
		if (floderNameIsCorrect == false) {

			s("#newfloder-msg-hint").style.color = "red";
			s("#newfloder-msg-hint").innerText = "已有同名的文件夹";

		}else if (floderNameIsCorrect == true) {

			//调用自定义方法获取当前的操作路径
			var curPath = getCurPath();

			//赋值完毕后发送ajax 到后台
			$.ajax({
				url: '/Management/admin/ajaxAddNav.action',
				type: 'POST',
				dataType: 'json',
				data: "parent=" + curPath + "&title=" + val + "&depuid=" + manageDepFloder.curManageFloderDepId,
				success: function(data){
					if (data.code == 100) {
						alert("创建成功！");
						//请求成功之后查询数据
						manageDepFloder.createFloderList(curPath,manageDepFloder.curManageFloderDepId);
						//清空输入框的内容
						s("#new-file-name").value = "";
						//清空提示信息内容
						s("#newfloder-msg-hint").innerText = "";
						//重置提交按钮 设置其属性为 disabled
						s("#newfloder-submit").disabled = "true";
						//重置提交按钮样式
						s("#newfloder-submit").className = "btn btn-primary disabled";
						//关闭创建文件夹弹出层
						s("#new-file-wrap").style.display = "none";

					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						alert("创建失败，请检查网络或稍后重试");
					}
				},
				error: function(){
					alert("创建失败，请检查网络或稍后重试");
				}
			})
			

		}

		
	}



	function submitModifyFloderName(){
		//发送ajax 给后台
		//先检测是否为空 不为空发送给后台
		//如果有同名 后台发送回数据提示错误
		//如果没有 后台发送会数据提示修改成功
		//前端获取修改名字的文件夹对象
		//将对象的名字在前端修改
		//最后修改名字的弹出层关闭


		var val = s("#rename-file").value;
			

		var floderNameIsCorrect = nameIsRepeat(ss("#file-list-content tr td a"),val);

		//根据filenameStatus 判断文件名的合法性
		if (floderNameIsCorrect == false) {
			s("#modify-msg-hint").style.color = "red";
			s("#modify-msg-hint").innerText = "已有同名的文件夹";
		}else if (floderNameIsCorrect == true) {

			//如果名字合法且输入框内容不为空创建两个变量：文件夹的id，
			//获取输入框的内容以及title 的值
			var uid = s("#rename-file").title,
				curPath = getCurPath();
			

			//赋值完毕后发送ajax 到后台
			$.ajax({
				url: '/Management/admin/ajaxUpdateNav.action?',
				type: 'POST',
				dataType: 'json',
				data: "uid=" + uid + "&title=" + val,
				success: function(data){
					if (data.code == 100) {
						alert("修改成功！");
						//请求成功之后查询数据
						manageDepFloder.createFloderList(curPath,manageDepFloder.curManageFloderDepId);
						//清空输入框的内容
						s("#rename-file").value = "";
						//清空提示信息内容
						s("#modify-msg-hint").innerText = "";
						//重置提交按钮 设置其属性disabled 为 true
						s("#rename-submit").disabled = "true";
						//重置提交按钮样式
						s("#rename-submit").className = "btn btn-primary disabled";
						//关闭创建文件夹弹出层
						s("#modify-file-name-wrap").style.display = "none";

					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");
					}else{

						s("#modify-file-name-wrap").style.display = "none";
						alert("修改失败，请检查网络或稍后重试");
					}
				},
				error: function(){

					s("#modify-file-name-wrap").style.display = "none";
					alert("修改失败，请检查网络或稍后重试");
				}
			})
			

		}

	}

	//删除文件夹弹出层删除按钮点击事件回调函数
	function doDropFloder(){
		//获取要删除文件夹的uid
		var uids = s("#target-floder-name").getAttribute("data-floderUid");
		$.ajax({
			url: '/Management/admin/ajaxDeleteNav.action',
			type: 'POST',
			dataType: 'json',
			data: "uids=" + uids,
			beforeSend: function(){
				//发送之前显示加载图标
				s("#drop-floder-loading-icon").style.visibility = 'visible';
			},
			success: function(data){
				//发送成功之后显示提示
				//隐藏加载图标
				//关闭弹窗
				//输出操作后的文件夹列表
				if (data.code == 100) {
					//保存最后一个子元素和当前路径
					var	curPath = getCurPath();

					//输出删除文件夹后的数据
					manageDepFloder.createFloderList(curPath,manageDepFloder.curManageFloderDepId);
					
					s("#drop-floder-loading-icon").style.visibility = 'hidden';
					s("#drop-floder-wrap").style.display = 'none';
					alert("删除成功");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("删除文件夹失败，此文件夹下存在子目录或请检查网络稍后重试");
				}
			

			},

			error: function(){
				alert("此文件夹下存在目录不能删除！");
				s("#drop-floder-wrap").style.display = 'none';
				//隐藏加载图标
				s("#drop-floder-loading-icon").style.visibility = 'hidden';
			}
			
		})
		
	}




	//删除文件对话框删除按钮点击事件执行函数
	function doDropFile(){
		var uid = s("#target-file-name").title,
			accuid = s("#page-header-title").title;

		//获取当前删除文件所在路径以及当前页面的系别id 为刷新列表时候所用
		var curPath = getCurPath();
		var curDepId = manageDepFloder.curManageFloderDepId;

		//发送ajax
		$.ajax({
			url: '/Management/file/ajaxDeleteFile.action',
			type: 'POST',
			dataType: 'json',
			data: "accuid=" + accuid + "&uid=" + uid,
			beforeSend: function(){
				//发送之前显示加载图标
				s("#drop-file-loading-icon").style.visibility = 'visible';
			},
			success: function(data){
				if (data.code == 100) {
					//请求成功后刷新文件列表
					manageDepFloder.createFloderList(curPath,curDepId);
					//关闭对话框
					s("#drop-file-wrap").style.display = 'none';
					//隐藏加载图标
					s("#drop-file-loading-icon").style.visibility = 'hidden';
					alert("删除成功");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					//隐藏加载图标
					s("#drop-file-loading-icon").style.visibility = 'hidden';
					//关闭对话框
					s("#drop-file-wrap").style.display = 'none';
					alert("删除文件失败，请检查网络或稍后重试");
				}
			},
			error: function(){
				//隐藏加载图标
				s("#drop-file-loading-icon").style.visibility = 'hidden';
				//关闭对话框
				s("#drop-file-wrap").style.display = 'none';
				alert("删除文件失败，请检查网络或稍后重试");
			}
		})
		
	}





	// ---------------- 文件夹管理模块结束 -------------------

	//----------------- 可用部门管理模块开始 -----------------

	//专业名修改按钮点击事件
	function editSpecBtnClick(){
		//找出tr 元素
		var parent = this.parentNode.parentNode;
		//获取当前点击按钮对应的专业名
		var specName = parent.querySelectorAll("td")[0].innerText;
		//获取当前点击按钮对应的专业id
		var specId = parent.querySelectorAll("td")[0].title;
		//为对话框的输入框赋值
		s("#modify-specialy-name").value = specName;
		s("#modify-specialy-name").title = specId;
		s("#modify-specialy-dialog").style.display = 'block';

	}

	//专业名删除按钮点击事件
	function dropSpecBtnClick(){
		//找出tr 元素
		var parent = this.parentNode.parentNode;
		//获取当前点击按钮对应的专业名
		var specName = parent.querySelectorAll("td")[0].innerText;
		//获取当前点击按钮对应的专业id
		var specId = parent.querySelectorAll("td")[0].title;
		//为对话框的输入框赋值
		s("#drop-spec-name").innerText = specName;
		s("#drop-spec-name").title = specId;
		s("#drop-specialy-dialog").style.display = 'block';
	}



	//删除专业对话框提交按钮点击回调函数
	function dropSpec(){
		var id = s("#drop-spec-name").title;
		$.ajax({
			url: '/Management/admin/ajaxDeleteDep.action',
			type: 'POST',
			dataType: 'json',
			data: "uids=" + id,
			success: function(data){
				if (data.code == 100) {
					//修改成功之后刷新右侧专业栏
					manageDep.outputSpeciality(manageDep.curManageDepDepId);
					s("#drop-specialy-dialog").style.display = 'none';
					alert("删除成功");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else {
					s("#drop-specialy-dialog").style.display = 'none';
					alert("删除失败！此专业下存在教师！");
				}

				
			},
			error: function(){
				s("#drop-specialy-dialog").style.display = 'none';
				alert("删除失败！此专业下存在教师！");
			}
		})
		
	}


	//修改专业对话框提交按钮点击回调函数
	function submitModifySpec(){
		//修改后的值
		var val = s("#modify-specialy-name").value,
			id = s("#modify-specialy-name").title
			valIsCorrect = nameIsRepeat(ss("#speciality-list-content tr td"),val);

		if (val != "" && valIsCorrect == true) {
			//发送ajax
			$.ajax({
				url: '/Management/admin/ajaxUpdateDep.action',
				type: 'POST',
				dataType: 'json',
				data: "uid=" + id + "&content=" + val,
				success: function(data){
					if (data.code == 100) {
						//修改成功之后刷新右侧专业栏
						manageDep.outputSpeciality(manageDep.curManageDepDepId);
						//清空提示信息
						s("#modify-specialy-hint").innerText = "";
						//关闭对话框
						s("#modify-specialy-dialog").style.display = 'none';
						alert("修改成功！");

					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						//清空提示信息
						s("#modify-specialy-hint").innerText = "";
						//关闭对话框
						s("#modify-specialy-dialog").style.display = 'none';
						alert("修改失败，请检查网络或稍后重试");
					}

					
				},

				error: function(){
					//清空提示信息
					s("#modify-specialy-hint").innerText = "";
					//关闭对话框
					s("#modify-specialy-dialog").style.display = 'none';
					alert("修改失败，请检查网络或稍后重试");
				}
			})
			
		}else if(valIsCorrect == false) {
			s("#modify-specialy-hint").style.color = "red";
			s("#modify-specialy-hint").innerText = "已有此专业";

		}else if(val == ""){
			s("#modify-specialy-hint").style.color = "red";
			s("#modify-specialy-hint").innerText = "专业名名称不能为空";
		}
	}

	//删除系别按钮点击的回调函数
	function confirmDropDep(){
		//发送ajax
		$.ajax({
			url: '/Management/admin/ajaxDeleteDep.action',
			type: 'POST',
			dataType: 'json',
			data: "uids=" + manageDep.curManageDepDepId,
			success: function(data){
				if (data.code == 100) {
					//更新系别列表
					manageDep.createManageDepDepsList();
					//删除系别对话框关闭
					s("#drop-department-dialog").style.display = 'none';
					//隐藏增加专业按钮
					s("#add-speciality").style.display = 'none';
					//清空记录的系别id
					manageDep.curManageDepDepId = "";
					alert("删除成功！");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else {
					//删除系别对话框关闭
					s("#drop-department-dialog").style.display = 'none';
					alert("删除失败！此系别下存在教师！");
				}

				
			},
			error: function(){
				//删除系别对话框关闭
				s("#drop-department-dialog").style.display = 'none';
				alert("删除失败，此系别下存在专业！");
			}
		})
		
	}

	//修改系别对话框提交按钮点击事件回调函数
	function submitModifyDepartment(){
		var modifyVal = s("#modify-department-name").value;
		var modifyValIsCorrect = nameIsRepeat(ss("#manage-department-list li"),modifyVal);

		if (modifyVal != "" && modifyValIsCorrect == true) {
			//如果修改后的部门名称不为空且正确
			$.ajax({
				url: '/Management/admin/ajaxUpdateDep.action',
				type: 'POST',
				async: false,
				dataType: 'json',
				data: "uid=" + manageDep.curManageDepDepId + "&parent=0&content=" +  modifyVal,
				success: function(data){
					if (data.code == 100) {
						//请求成功后
						//刷新左侧部门列表
						manageDep.createManageDepDepsList();
						//清空输入框的值
						s("#modify-department-name").value = manageDep.curManageDepDepName;
						//清空提示信息
						s("#modify-department-hint").innerText = "";
						//清空右侧专业内容
						s("#speciality-list-content").innerHTML = "";
						//关闭对话框
						s("#modify-department-dialog").style.display = 'none';
						alert("修改成功");
						//回滚修改操作前的数据
						var depList = ss("#manage-department-list li");
						//遍历查找修改系别之前的系别项
						for (var i = 0; i < depList.length; i++) {
							var temp = depList[i].getAttribute("data-depid");
							if (temp == manageDep.curManageDepDepId) {
								//为修改前的系别项添加样式
								depList[i].className = "filedep-item-active";
								//输出对应系别的专业
								manageDep.outputSpeciality(manageDep.curManageDepDepId);
								//修改保存的当前系别名的成员变量
								manageDep.curManageDepDepName = depList[i].innerText;
								break;
							}
						}

					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						//关闭对话框
						s("#modify-department-dialog").style.display = 'none';
						alert("修改失败，请检查网络或稍后重试");
					}

				},
				error: function(){
					//关闭对话框
					s("#modify-department-dialog").style.display = 'none';
					alert("修改失败，请检查网络或稍后重试");
				}
				
			})

			
		}else if(modifyValIsCorrect == false){
			s("#modify-department-hint").style.color = "red";
			s("#modify-department-hint").innerText = "此系别名已存在";

		}else if(modifyVal == ""){
			s("#modify-department-hint").style.color = "red";
			s("#modify-department-hint").innerText = "系别名不能为空";
		}

	}
	


	//新建系别对话框提交按钮点击事件回调函数
	function submitNewDepartment(){
		var newDepName = s("#new-department-name").value;
		var depNameIsCorrect = nameIsRepeat(ss("#manage-department-list li"),newDepName);
		
		//如果新系别名不为空且不重复发送数据给后台
		if (newDepName != "" && depNameIsCorrect == true) {
			$.ajax({
				url: '/Management/admin/ajaxAddDep.action',
				type: 'POST',
				dataType: 'json',
				data: "parent=0&content=" + newDepName,
				success: function(data){
					if (data.code == 100) {
						//输出数据
						manageDep.createManageDepDepsList();
						//清空右侧专业内容
						s("#speciality-list-content").innerHTML = "";
						//清空输入框内容
						s("#new-department-name").value = "";
						//清空提示框信息
						s("#new-department-hint").innerText = "";
						//清空保存的系别id
						manageDep.curManageDepDepId = "";
						//隐藏增加专业按钮
						s("#add-speciality").style.display = 'none';
						//关闭对话框
						s("#new-department-dialog").style.display = 'none';
						alert("创建成功");
					
					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else {
						//关闭对话框
						s("#new-department-dialog").style.display = 'none';
						alert("创建失败，请检查网络或稍后重试");
					}
				},

				error: function(){
					//关闭对话框
					s("#new-department-dialog").style.display = 'none';
					alert("创建失败，请检查网络或稍后重试");
				}
			});

			
		}else if(depNameIsCorrect == false){
			s("#new-department-hint").style.color = "red";
			s("#new-department-hint").innerText = "已有此系别";

		}else if(newDepName == ""){
			s("#new-department-hint").style.color = "red";
			s("#new-department-hint").innerText = "系别名称不能为空";
		}
	}


	//新建专业对话框提交按钮点击事件回调函数
	function submitNewSpecialy(){
		var newSpecName = s("#new-specialy-name").value;
		var specNameIsCorrect = nameIsRepeat(ss("#speciality-list-content tr td"),newSpecName);

		//如果新系别名不为空且不重复发送数据给后台
		if (newSpecName != "" && specNameIsCorrect == true) {
			$.ajax({
				url: '/Management/admin/ajaxAddDep.action',
				type: 'POST',
				dataType: 'json',
				data: "parent=" + manageDep.curManageDepDepId + "&content=" + newSpecName,
				success: function(data){
					if (data.code == 100) {
						//输出专业数据
						manageDep.outputSpeciality(manageDep.curManageDepDepId);
						//清空输入框
						s("#new-specialy-name").value = "";
						//清空提示框
						s("#new-specialy-hint").innerText = "";
						//关闭对话框
						s("#new-specialy-dialog").style.display = 'none';
						alert("创建成功");

					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						//关闭对话框
						s("#new-specialy-dialog").style.display = 'none';
						alert("新建失败，请检查网络稍后重试");
					}
				},
				error: function(){
					//关闭对话框
					s("#new-specialy-dialog").style.display = 'none';
					alert("新建失败，请检查网络稍后重试");
				}
			});

			
		}else if(specNameIsCorrect == false){
			s("#new-specialy-hint").style.color = "red";
			s("#new-specialy-hint").innerText = "已有此专业名称";

		}else if(newSpecName == ""){
			s("#new-specialy-hint").style.color = "red";
			s("#new-specialy-hint").innerText = "专业名不能为空";
		}
	}

	//----------------- 可用部门管理模块结束 -----------------

	//--------------  未审核模块的操作事件 ------------


	function countCheckedBoxChecked(checkboxList){
		var count = 0;
		for (var i = 0; i < checkboxList.length; i++) {
			if (checkboxList[i].checked == true) {
				count++;
			}
		}

		return count;
	}

	//未审核列表批量通过按钮点击事件调用函数
	function unexamiePassAll(){
		//点击批量通过按钮时 首先要判断当前有没有多选框选中
		//获取所有多选框元素
		var checkboxs = ss(".unexamie-select");
		//定义计算变量
		var checkedCount = countCheckedBoxChecked(checkboxs);
		
		if (checkedCount != 0) {
			//如果当前有选中多选框
			//创建保存多个id 值得数组
			var idList = [];
			//遍历所有复选框
			for (var i = 0; i < checkboxs.length; i++) {
				//把多选框对应的用户名列的 data-userid值（即id 值）推进数组
				if (checkboxs[i].checked == true) {
					var idVal = checkboxs[i].parentNode.parentNode.querySelectorAll("td")[1].getAttribute("data-userid");
					idList.push(idVal);
				}
			}
			//将保存多个id 的数组转换为字符串
			var list = idList.join(",");

			//发送ajax
			$.ajax({
				url: '/Management/admin/ajaxPassAccount.action',
				type: 'POST',
				dataType: 'json',
				data: "uid=" + list,
				success: function(data){
					if (data.code == 100) {
						unexamiePage.toUnexamiePage(unexamiePage.curUnexamieModulePage);
						//如果当前操作是拒绝此页的全部用户申请
						//点击完弹出层拒绝按钮之后 全选多选框还是会 checked
						//所以每次点击完之后都要把多选框的 checked 取消掉
						s("#unexamie-select-all").checked = false;
						alert("操作成功！");
					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						alert("操作失败！请检查网络或稍后重试");
					}
				},

				error: function(){
					alert("操作失败！请检查网络或稍后重试");
				}
			});
			
			
		}else{
			alert("没有选中的用户");
		}
		
	}


	//未审核用户列表批量拒绝点击事件调用函数
	function unexamieRefuseAll(){
		var checkedNum = countCheckedBoxChecked(ss(".unexamie-select"));
		if (checkedNum != 0) {
			//创建保存多个 id 的数组
			var idList = [];
			//创建保存多个用户名的数组
			var usernameList = [];
			//获取所有多选框元素
			var checkboxs = ss(".unexamie-select");
			//遍历这一页每一个多选框
			for (var i = 0; i < checkboxs.length; i++) {
				if (checkboxs[i].checked == true) {
						//如果有选中的
						//获取选中多选框所在行的第二列的 data-userid 值
						var idVal = checkboxs[i].parentNode.parentNode.querySelectorAll("td")[1].getAttribute("data-userid");
						//获取选中多选框所在行的第二列的 文本 值
						var usernameVal = checkboxs[i].parentNode.parentNode.querySelectorAll("td")[1].innerText;
						//保存id 值数组推入对应的id
						idList.push(idVal);
						//保存用户名数组推入对应的用户名
						usernameList.push(usernameVal);
					}
				}

					//将保存到的id 和 用户名 传递给提示弹出层拒绝用户申请模块那里
					s("#refuse-username").innerText = usernameList.join(",");
					s("#refuse-username").title = idList.join(",");

					//获取提示弹出层
					var floor = s("#floor");
					//隐藏撤回用户模块弹出层
					s("#recall-user").style.display = 'none';
					//显示填写拒绝信息模块弹出层
					s("#refuse-info").style.display = 'block';
					//显示弹出层
					floor.style.display = "block";
		}else{
			alert("没有选中的用户");
		}
		
		
	}



	//未审核列表模块方法
	//拒绝用户发送拒绝理由
	function sendRefuseMsg(){
		

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//拒绝的理由
		var refuseVal = s("#refuse-content").value;
		//获取加载图片元素
		var icon = s("#refuse-user-loading-icon");

		$.ajax({
			url: '/Management/admin/ajaxRejectAccount.action',
			type: 'POST',
			dataType: 'json',
			data: "uid=" + idVal + "&content=" + refuseVal,
			beforeSend: function(){
				s("#send-refuse-info").disabled = "true";
				s("#no-refuse-reason").disabled = "true";
				s("#refuse-content").disabled = "true";
				icon.style.visibility = 'visible';
			},

			success: function(data){
				if (data.code == 100) {
					//输出操作前停留页码处的未审核用户数据
					unexamiePage.toUnexamiePage(unexamiePage.curUnexamieModulePage);
					//隐藏加载图标
					icon.style.visibility = 'hidden';
					//如果当前操作是拒绝此页的全部用户申请
					//点击完弹出层拒绝按钮之后 全选多选框还是会 checked
					//所以每次点击完之后都要把多选框的 checked 取消掉
					s("#unexamie-select-all").checked = false;
					//取消拒绝发送信息按钮disabled 属性
					s("#no-refuse-reason").removeAttribute("disabled");
					s("#refuse-content").removeAttribute("disabled");
					//清空拒绝信息内容
					s("#refuse-content").value = "";
					//隐藏弹出层
					s("#floor").style.display = "none";
					alert("操作成功！");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					icon.style.visibility = 'hidden';
					//隐藏弹出层
					s("#floor").style.display = "none";
					alert("发送失败，请检查网络或稍后重试");
				}
			},
			error: function(){
				icon.style.visibility = 'hidden';
				//隐藏弹出层
				s("#floor").style.display = "none";
				alert("发送失败，请检查网络或稍后重试");
			}
		});
		
		
	}


	//拒绝用户申请但不发送拒绝信息按钮点击事件回调函数
	function notsendRefuseMsg(){
		//ajax 提交用户的id 给后台，不提交拒绝理由
		//数据提交完成后将包裹层隐藏

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//获取加载图片元素
		var icon = s("#refuse-user-loading-icon");

		$.ajax({
			url: '/Management/admin/ajaxRejectAccount.action',
			type: 'POST',
			dataType: 'json',
			data: "uid=" + idVal,
			beforeSend: function(){
				s("#no-refuse-reason").disabled = "true";
				s("#send-refuse-info").disabled = "true";
				s("#refuse-content").disabled = "true";
				icon.style.visibility = 'visible';
			},

			success: function(data){
				if (data.code == 100) {
					unexamiePage.toUnexamiePage(unexamiePage.curUnexamieModulePage);
					//隐藏加载图标
					icon.style.visibility = 'hidden';
					//如果当前操作是拒绝此页的全部用户申请
					//点击完弹出层拒绝按钮之后 全选多选框还是会 checked
					//所以每次点击完之后都要把多选框的 checked 取消掉
					s("#unexamie-select-all").checked = false;
					//消除发送按钮的disabled 属性
					s("#no-refuse-reason").removeAttribute("disabled");
					//消除输入框的disabled 属性
					s("#refuse-content").removeAttribute("disabled");
					//消除发送拒绝信息按钮 disabled 属性
					s("#send-refuse-info").removeAttribute("disabled");
					//清空拒绝信息内容
					s("#refuse-content").value = "";
					//隐藏弹出层
					s("#floor").style.display = "none";
					alert("操作成功！");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else {
					//隐藏加载图标
					icon.style.visibility = 'hidden';
					//隐藏弹出层
					s("#floor").style.display = "none";
					alert("操作失败！请检查网络或稍后重试");
				}
			},

			error: function(){
				//隐藏加载图标
				icon.style.visibility = 'hidden';
				//消除发送按钮的disabled 属性
				s("#no-refuse-reason").removeAttribute("disabled");
				//消除输入框的disabled 属性
				s("#refuse-content").removeAttribute("disabled");
				//消除发送拒绝信息按钮 disabled 属性
				s("#send-refuse-info").removeAttribute("disabled");
				//隐藏弹出层
				s("#floor").style.display = "none";
				alert("未知错误，请稍后重试！");
			}
		});
		
		
	}


	
	

	//------------- 未审核模块操作事件结束 -------------------------
	

	//----------------- 已审核模块操作事件开始 -----------------------
	//为筛选系别下拉框填充内容
	function initDepFilter(){
		var select = s("#examie-filter");
		var frag = document.createDocumentFragment();
		$.ajax({
			url: '/Management/admin/ajaxGetAllDepartment.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
 				//请求成功后
 				//遍历返回结果 填充下拉选择框
 				//填充完毕之后把下拉框第一个值附给全局变量 "curDepartmentId"
 				var result = data.extend.Department;
 				for (var i = 0; i < result.length; i++) {
 					var option = createElem("option");
 					option.value = result[i].uid;
 					option.innerText = result[i].content;
 					frag.appendChild(option);
 				}

 				select.appendChild(frag);
 				//为全局变量 curDepartmentId 赋值
 				curDepartmentId = select.value;
			}
		});
		
		
	}

	//当下拉框发生改变的时候执行函数
	function filterOnChange(){
		//获取下拉框改变后的value
		var curVal = this.value;
		//为全局变量 curDepartmentId 赋值
		//这里的改变也应该赋值给模块的属性
		examiePage.curDepartmentId = curVal;
		//根据部门id 输出该部门注册用户列表的第一页
		//这里需要修改为模块引用函数
		examiePage.toexamiedPage(1,examiePage.curDepartmentId);
	}


	//批量撤回按钮点击事件回调函数
	function examiedModuleRecallAll(){
		var checkboxList = ss(".examied-select");
		//获取当前选中的多选框数量
		var checkedNums = countCheckedBoxChecked(checkboxList);
		//如果有选中
		if(checkedNums != 0){
			//创建一个保存id 和 一个保存用户名的数组
			var idValList = [],usernameList = [];
			
			//遍历所有多选框 如果选中将用户名信息和id 值推入数组
			for (var i = 0; i < checkboxList.length; i++) {
				if (checkboxList[i].checked == true) {
					//找到对应的内容
					var username = checkboxList[i].parentNode.parentNode.querySelectorAll("td")[1].innerText;
					var userId = checkboxList[i].parentNode.parentNode.querySelectorAll("td")[1].getAttribute("data-userid");

					//保存用户id 和 用户名
					idValList.push(userId);
					usernameList.push(username);
				}
			}

			//获取弹出层
			var floor = s("#floor");
			//显示填写拒绝信息模块弹出层
			s("#refuse-info").style.display = 'none';
			//显示撤回用户模块弹出层
			s("#recall-user").style.display = 'block';
			//为提示文字中的姓名字段添加内容
			s("#recall-username").innerText = usernameList.join(",");
			s("#recall-username").title = idValList.join(",");
			//显示弹出层
			floor.style.display = "block";

		}else{
			alert("当前没有选中项！");
		}
		
	}

	//发送撤回信息按钮点击事件
	function sendRecallMsg(){
		//点击时 和上面一样 获取提示元素的 title值
		//将title值 传给后台
		var idVal = s("#recall-username").title;

		//获取撤回理由内容
		var reason = s("#recall-content").value;

		//获取撤回用户模块加载图标
		var icon = s("#recall-user-loading-icon");

		$.ajax({
			url: '/Management/admin/ajaxWithdrawAccount.action',
			type: 'GET',
			dataType: 'json',
			data: "uid=" + idVal + "&content=" + reason,
			beforeSend: function(){
				//发送按钮变成disabled
				s("#confirm-recall-user").disabled = "true";
				//取消撤回按钮设置disabled
				s("#cancel-recall-user").disabled = "true";
				//撤回理由输入框设置disabled
				s("#recall-content").disabled = "true";
				icon.style.visibility = 'visible';
			},

			success: function(data){
				if (data.code == 100) {
					//数据返回成功后
					//根据当前筛选下拉框的部门id 输出操作前页码处的内容
					examiePage.toexamiedPage(examiePage.curExamieModulePage,examiePage.curDepartmentId);
					//loading 图标隐藏
					icon.style.visibility = 'hidden';
					//弹出层隐藏
					s("#floor").style.display = 'none';
					//清空撤回理由输入框内容
					s("#recall-content").value = "";
					//撤回内容输入框消除disabled 属性
					s("#recall-content").removeAttribute("disabled");
					//取消撤回按钮消除disabled 属性
					s("#cancel-recall-user").removeAttribute("disabled");
					//取消全选多选按钮选中样式
					s("#examied-select-all").checked = false;
					alert("撤回成功");

				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					//隐藏加载图标
					icon.style.visibility = 'hidden';
					//清空撤回理由输入框内容
					s("#recall-content").value = "";
					//撤回内容输入框消除disabled 属性
					s("#recall-content").removeAttribute("disabled");
					//取消撤回按钮消除disabled 属性
					s("#cancel-recall-user").removeAttribute("disabled");
					//隐藏弹出层
					s("#floor").style.display = "none";
					alert("发送失败，请检查网络或稍后重试");
				}
			},

			error: function(){
				//隐藏加载图标
				icon.style.visibility = 'hidden';
				//清空撤回理由输入框内容
				s("#recall-content").value = "";
				//撤回内容输入框消除disabled 属性
				s("#recall-content").removeAttribute("disabled");
				//取消撤回按钮消除disabled 属性
				s("#cancel-recall-user").removeAttribute("disabled");
				//隐藏弹出层
				s("#floor").style.display = "none";
				alert("发送失败，请检查网络或稍后重试");
			}
		});
		
	}




	//---------------- 已审核模块操作事件结束 ----------------------


	//侧边栏除管理文件夹和管理系别专业标签意外的元素点击事件
	function tagsClick(){
		var tags = ss(".child-tag");
		var contents = ss(".content-wrap");

		for (var i = 0; i < tags.length; i++) {
			tags[i].index = i;

			EventUntil.addHandler(tags[i],"click",function(){
				var index = this.index;

				//调整左侧tag 激活样式
				for (var i = 0; i < tags.length; i++) {
					if (tags[i].className.indexOf("sidebar-tag-active") != -1) {
						//调用自定义 removeClass 方法
						removeClass(tags[i],"sidebar-tag-active");
					}
					contents[i].style.display = "none";
				}

				ss(".welcome-hint")[0].style.display = 'none';
				contents[index].style.display = 'block';

				//为当前点击的 tag增加激活状态样式
				this.className += " sidebar-tag-active";
				
				//如果当前点击的tag 为未审核列表
				//读取未审核用户数据的第一页内容
				if (this.id == "unexamie-tag") {
					s("#number-hints").style.display = 'none';
					
					unexamiePage.toUnexamiePage(unexamiePage.curUnexamieModulePage);
					//已审核列表全选按钮取消选中
					s("#examied-select-all").checked = false;
		
				}else if(this.id == "examied-tag"){
					//如果当前点击的tag 为未审核列表
					//读取已审核用户数据的第一页，且部门筛选为 "全部" 的内容
					examiePage.toexamiedPage(1,examiePage.curDepartmentId);
					//未审核列表全选按钮取消选中
					s("#unexamie-select-all").checked = false;

				}else if(this.id == "manage-leader-admin") {
					//点击管理员领导管理标签时更新两个列表的内容
					manageAdminLeader.outputAdminList();
					manageAdminLeader.outputLeaderList();
				}
			});
		}
	};

	//撤回管理员事件函数
	function doRecallAdmin(){
		var uid = s("#recall-admin-name").title;
		$.ajax({
			url: '/Management/admin/ajaxWithdrawAdmin.action',
			type: 'POST',
			dataType: 'json',
			data: "uid=" + uid,
			success: function(data){
				if (data.code == 100) {
					alert("撤回管理员成功！");
					//输出更新后的管理员表
					manageAdminLeader.outputAdminList();
				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("撤回失败，请检查网络或稍后重试！");
				}
			},

			error: function(){
				alert("撤回失败，请检查网络或稍后重试！");
			}
		})
		
	}


	//撤回领导事件函数
	function doRecallLeader(){
		var uid = s("#recall-leader-name").title;
		$.ajax({
			url: '/Management/admin/ajaxWithdrawAdmin.action',
			type: 'POST',
			dataType: 'json',
			data: "uid=" + uid,
			success: function(data){
				if (data.code == 100) {
					alert("撤回领导成功！");
					//输出更新后的领导表
					manageAdminLeader.outputLeaderList();
				}else if(data.code == 300) {
					//后台状态码为300 表示这个账号在另一个浏览器或终端登录
					//返回错误信息并跳转到登陆页
					alert(data.message);
					window.location.replace("/Management/public/login.action");

				}else{
					alert("撤回失败，请检查网络或稍后重试！");
				}
			},

			error: function(){
				alert("撤回失败，请检查网络或稍后重试！");
			}
		})
	}


	//修改注册邮箱提交按钮点击事件回调函数
	function modifyCofimEmail(){
		//定义正则表达式验证输入邮箱的内容
		var reg = /^([\d\w]+[_|\_|\.]?)*[\d\w]+@([\d\w]+[_|\_|\.]?)*[\d\w]+\.[\w]{2,3}$/;
		var status = reg.test(s("#newEmail").value);

		if (status == true) {
			//隐藏错误提示
			s("#modify-new-email-hint").innerText = "";
			//认证成功发送ajax
			$.ajax({
				url: '/Management/public/ajaxDoModifyEmail.action',
				type: 'POST',
				dataType: 'json',
				data: "email=" + s("#newEmail").value,
				success: function(data){
					if (data.code == 100) {
						alert("修改成功!");
						s("#modify-admin-email-floor").style.display = 'none';
						//刷新页面
						window.location.reload(true);
					}else if(data.code == 300) {
						//后台状态码为300 表示这个账号在另一个浏览器或终端登录
						//返回错误信息并跳转到登陆页
						alert(data.message);
						window.location.replace("/Management/public/login.action");

					}else{
						alert("邮箱已被使用或网络错误");
						s("#modify-admin-email-floor").style.display = 'none';
					}
				},
				error: function(){
					alert("邮箱已被使用或网络错误");
					s("#modify-admin-email-floor").style.display = 'none';
				}
			});

		}else{
			s("#modify-new-email-hint").style.color = "red";
			s("#modify-new-email-hint").innerText = "邮箱格式错误";
		}
	}


	//事件委托函数
	function entrustEvent(event){
		event = EventUntil.getEvent(event);
		var target = EventUntil.getTarget(event);

		if (target.id == "manage-floder") {
			//部门管理侧栏点击事件
			manageDepFloder.createManageFloderDepList();
			
			s("#manage-file-floor").style.display = 'block';

		}else if(target.id == "show-hidden-menu") {
			//溢出导航隐藏按钮点击事件
			overflowNavBtnClick(target);

		}else if(target.id == "newfloder-btn") {
			//新建文件夹按钮点击事件
			if (manageDepFloder.curManageFloderDepId == "") {
				alert("请先选择系别");
			}else{
				s("#new-file-wrap").style.display = "block";
			}

		}else if(target.id == "new-floder-close-btn") {
			//清空输入框的值
			s("#new-file-name").value = "";
			//清空错误提示信息
			s("#newfloder-msg-hint").innerText = "";
			//新建文件夹弹出层关闭按钮点击事件
			s("#new-file-wrap").style.display = 'none';

		}else if(target.id == "newfloder-submit") {
			//新建文件夹弹出层提交按钮点击事件
			submitNewFloder();

		}else if(target.id == "modify-flodername-close-btn"){
			//清空错误提示信息
			s("#modify-msg-hint").innerText = "";
			//修改按钮的不可用状态
			s("#rename-submit").disabled = "true";
			//修改文件夹名弹出层关闭按钮点击事件
			s("#modify-file-name-wrap").style.display = 'none';

		}else if(target.id == "rename-submit"){
			//修改文件名弹出层提交按钮点击事件
			submitModifyFloderName();

		}else if(target.id == "drop-floder-btn") {
			//删除文件夹按钮点击事件
			dropFloder();

		}else if(target.id == "cancel-drop-floder"){
			//清空多选框选中状态
			clearCheckboxChecked();
			
			s("#drop-floder-wrap").style.display = "none";

		}else if(target.id == "drop-floder-close-btn") {
			//清空多选框选中状态
			clearCheckboxChecked();
			//删除文件夹弹出层关闭按钮点击事件
			s("#drop-floder-wrap").style.display = "none";

		}else if(target.id == "confirm-drop-floder") {
			//删除文件夹确认按钮点击事件
			doDropFloder();
			//清空多选框选中状态
			clearCheckboxChecked();

		}else if(target.id == "drop-file-close-btn") {
			//清空多选框选中状态
			clearCheckboxChecked();
			//删除文件弹出层关闭按钮点击事件
			s("#drop-file-wrap").style.display = "none";

		}else if(target.id == "cancel-drop-file") {
			//清空多选框选中状态
			clearCheckboxChecked();
			//删除文件弹出层取消删除按钮点击事件
			s("#drop-file-wrap").style.display = "none";


		}else if(target.id == "confirm-drop-file") {
			//删除文件弹出层确认删除按钮点击事件
			doDropFile();

		}else if(target.id == "filemanage-close-btn") {
			//管理文件弹出层关闭按钮点击事件
			//获取所有多选框
			var checkboxList = ss("#file-list-content tr td input:checked");
			//将他们全部取消选中
			clearCheckBoxChecked(checkboxList);
			//关闭弹出层
			s("#manage-file-floor").style.display = 'none';

		}else if(target.id == "manage-department") {
			if (s("#manage-department-list").childNodes.length == 0) {
				//如果部门列表为空则发送ajax 请求数据
				//侧边栏管理系别标签点击事件
				//输出系别的信息
				manageDep.createManageDepDepsList();
			}
			
			//再显示
			s("#manage-department-floor").style.display = 'block';

		}else if(target.id == "manage-department-close-btn") {
			//点击管理系别弹出层关闭按钮事件
			s("#manage-department-floor").style.display = 'none';

		}else if(target.id == "add-department") {
			//新建系别按钮点击事件
			s("#new-department-dialog").style.display = 'block';

		}else if(target.id == "new-department-close-btn") {
			//新建系别对话框关闭按钮点击事件
			s("#new-department-dialog").style.display = 'none';
			s("#new-department-hint").innerText = "";

		}else if(target.id == "confirm-new-department") {
			//新建系别对话框提交按钮点击事件
			submitNewDepartment();
			

		}else if(target.id == "add-speciality") {
			//新建专业按钮点击事件
			s("#new-specialy-dialog").style.display = 'block';

		}else if(target.id == "new-specialy-close-btn") {
			//新建专业对话框关闭按钮点击事件
			s("#new-specialy-dialog").style.display = 'none';
			s("#new-specialy-hint").innerText = "";

		}else if(target.id == "confirm-new-specialy") {
			//新建专业对话框提交按钮点击事件
			submitNewSpecialy();

		}else if(target.id == "modify-department") {
			//修改系别对话框按钮点击事件
			if (manageDep.curManageDepDepId  != "") {
				//有选中的系别就显示修改系别对话框
				s("#modify-department-name").value = manageDep.curManageDepDepName;
				s("#modify-department-dialog").style.display = 'block';

			}else{
				alert("你当前还没有选择系别");
			}

		}else if(target.id == "modify-department-close-btn") {
			//修改系别对话框关闭按钮点击事件
			s("#modify-department-dialog").style.display = 'none';
			s("#modify-department-name").value = "";
			s("#modify-department-hint").innerText = "";

		}else if(target.id == "confirm-modify-department") {
			//修改系别对话框提交按钮点击事件
			submitModifyDepartment();

		}else if(target.id == "drop-department") {
			//删除系别按钮点击事件
			if (manageDep.curManageDepDepId != "") {
				//如果当前选择了系别 弹出对话框
				var depName = manageDep.curManageDepDepName;
				s("#drop-dep-name").innerText = depName;
				s("#drop-department-dialog").style.display = 'block';
			}else{
				alert("你当前还没选择系别");
			}

		}else if(target.id == "confirm-drop-dep") {
			//删除系别对话框确认删除按钮点击事件
			confirmDropDep();

		}else if(target.id == "cancel-drop-dep") {
			//删除系别对话框取消按钮点击事件
			s("#drop-department-dialog").style.display = 'none';

		}else if(target.id == "confirm-modify-specialy") {
			//修改专业提交按钮点击事件
			submitModifySpec();

		}else if(target.id == "modify-specialy-close-btn") {
			//修改专业关闭按钮点击事件
			s("#modify-specialy-dialog").style.display = 'none';
			s("#modify-specialy-hint").innerText = "";

		}else if(target.id == "cancel-drop-spec") {
			//删除专业对话框取消按钮点击事件
			s("#drop-specialy-dialog").style.display = 'none';
			s("#modify-specialy-hint").innerText = "";

		}else if(target.id == "confirm-drop-spec") {
			//删除专业对话框确认按钮点击事件
			dropSpec();

		}else if(target.id == "unexamie-select-all") {
			//未审核用户 "选择全部多选框" 点击事件
			selectAllBtnHandler.call(target,ss(".unexamie-select"));

		}else if(target.id == "unexamie-pass-all") {
			//未审核用户 "批量通过按钮" 点击事件
			unexamiePassAll();

		}else if(target.id == "unexamie-refuse-all") {
			//未审核用户 "批量拒绝按钮" 点击事件
			unexamieRefuseAll();

		}else if(target.id == "refuse-close-btn") {
			//拒绝用户弹出层功能
			//拒绝用户注册模块关闭按钮点击事件
			//清空拒绝内容输入框内容
			s("#refuse-content").value = "";
			//设置发送拒绝信息按钮为disabled
			s("#send-refuse-info").disabled = "true";
			//清空多选框选择状态
			clearCheckBoxChecked(ss("#unexamie-main-content tr td input:checked"));
			s("#unexamie-select-all").checked = false;
			s("#floor").style.display = "none";

		}else if(target.id == "send-refuse-info") {
			//拒绝用户注册模块 "提交拒绝信息" 按钮点击事件
			//ajax 提交用户的id （即title属性）,拒绝理由 给后台处理
			//当处理完毕后再将弹出层包裹层隐藏
			sendRefuseMsg();

		}else if(target.id == "no-refuse-reason") {
			//拒绝用户注册模块 "不填写拒绝信息" 按钮点击事件
			notsendRefuseMsg();

		}else if(target.id == "examied-select-all"){
			//已审核列表 "选择全部" 多选框点击事件
			selectAllBtnHandler.call(target,ss(".examied-select"));

		}else if(target.id == "examie-recall-all") {
			//批量撤回按钮点击事件
			examiedModuleRecallAll();

		}else if(target.id == "cancel-recall-user") {
			//取消撤回按钮点击事件
			//取消多选框选中状态
			clearCheckBoxChecked(ss("#examied-main-content tr td input:checked"));
			//撤回信息输入框内容清空
			s("#recall-content").value = "";
			//确认撤回按钮变成disabled
			s("#confirm-recall-user").disabled = "true";
			s("#examied-select-all").checked = false;
			s("#floor").style.display = "none";

		}else if(target.id == "confirm-recall-user") {
			//确认撤回按钮点击事件但 "不发送信息" 点击事件
			sendRecallMsg();

		}else if(target.id == "cancel-recall-admin") {
			//撤回管理员对话框取消按钮点击事件
			s("#recall-admin-dialog-floor").style.display = 'none';

		}else if(target.id == "recall-admin-close-btn") {
			//撤回管理员对话框关闭按钮点击事件
			s("#recall-admin-dialog-floor").style.display = 'none';

		}else if(target.id == "confirm-recall-admin") {
			//撤回管理员对话框确认撤回管理员按钮点击事件
			doRecallAdmin();
			s("#recall-admin-dialog-floor").style.display = 'none';
			
		}else if(target.id == "cancel-recall-leader") {
			//撤回领导对话框取消按钮点击事件
			s("#recall-leader-dialog-floor").style.display = 'none';

		}else if(target.id == "recall-leader-close-btn") {
			//撤回领导对话框关闭按钮点击事件
			s("#recall-leader-dialog-floor").style.display = 'none';

		}else if(target.id == "confirm-recall-leader") {
			//撤回领导对话框确认撤回按钮点击事件
			doRecallLeader();
			s("#recall-leader-dialog-floor").style.display = 'none';


		}else if(target.id == "modify-user-departmetn-close-btn"){
			//清空错误提示框内容
			//s("#new-account-hint").innerText = "";
			//修改用户部门弹出层关闭按钮点击事件
			s("#modify-user-department-floor").style.display = "none";

		}else if(target.id == "confirm-modify-dep"){
			//修改用户部门弹出层提交按钮点击事件
			confirmModifyUserDep();

		}else if(target.id == "modify-email-btn") {
			//修改注册邮箱按钮点击事件
			EventUntil.preventDefault(event);
			s("#modify-admin-email-floor").style.display = 'block';

		}else if (target.id == "modifyadminemail-close-btn") {
			//修改邮箱对话框关闭按钮点击事件
			s("#modify-admin-email-floor").style.display = 'none';
			s("#modify-new-email-hint").innerText = "";
			s("#newEmail").value = "";

		}else if(target.id == "confirm-modifyemail"){
			//修改邮箱对话框提交按钮点击事件
			modifyCofimEmail();
		}
	}

 
	

	//页面加载完成时要做的预处理
	function init(){
		//为侧边栏的除管理文件夹标签意外的元素绑定点击事件
		tagsClick();
		//显示未审核用户数量
		showUnexamieUserNums();
		//赋值下拉框
		initDepFilter();
		//赋值修改系别对话框中的下拉框
		getModifyUserDepModuleDep();

		//下拉选择框改变事件
		EventUntil.addHandler(s("#examie-filter"),"change",filterOnChange);

		//2、撤回理由输入框键盘输入事件
		EventUntil.addHandler(s("#recall-content"),"keyup",function(){
			//获取提交按钮
			var sendBtn = s("#confirm-recall-user");

			if (this.value.length != 0) {
				sendBtn.removeAttribute("disabled");
			}else{
				sendBtn.disabled = "true";
			}
		})

		//拒绝理由信息输入框输入事件
		EventUntil.addHandler(s("#refuse-content"),"keyup",function(){

			var sendBtn = s("#send-refuse-info");

			if (this.value.length == 0) {
				sendBtn.disabled = "disabled";
			}else{
				sendBtn.removeAttribute("disabled");
				sendBtn.className = "btn btn-success";
			}
		})


		//修改文件夹输入框键盘输入事件
		EventUntil.addHandler(s("#rename-file"),"keyup",function(){
			if (this.value.length != 0) {
				s("#rename-submit").removeAttribute("disabled");
				s("#rename-submit").className = "btn btn-primary";
			}else{
				s("#rename-submit").disabled = "true";
				s("#rename-submit").className = "btn btn-primary disabled";
			}
		})


		//新建文件夹输入框键盘输入事件
		EventUntil.addHandler(s("#new-file-name"),"keyup",function(){
			if (this.value.length != 0) {
				s("#newfloder-submit").removeAttribute("disabled");
				s("#newfloder-submit").className = "btn btn-primary";
			}else{
				s("#newfloder-submit").disabled = "true";
				s("#newfloder-submit").className = "btn btn-primary disabled";
			}
		})
	}


	//修改邮箱输入框键盘输入事件
	EventUntil.addHandler(s("#newEmail"),"keyup",function(){
		if (this.value.length != 0) {
			s("#confirm-modifyemail").removeAttribute("disabled");
			s("#confirm-modifyemail").className = "btn btn-primary";

		}else{
			s("#confirm-modifyemail").disabled = "true";
			s("#confirm-modifyemail").className = "btn btn-primary disabled";
		}
	})

	//--------------定义层结束-------------

	//加载完成dom元素时
	domready(function(){
		//初始化页面
		init();
		//事件委托
		EventUntil.addHandler(document,"click",function(event){
			entrustEvent(event);
		});
		//初始化管理员和领导管理模块滚动条
		$(".admin-list-table-wrap").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});
		
		//领导管理内容包裹层设置自定义滚动条
		$(".leader-list-table-wrap").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		})

		//管理文件夹弹出层内容包裹层设置自定义滚动条
		$(".file-content-item").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		})


		//管理系别弹出层内容包裹层设置自定义滚动条
		$(".manage-department-maincontent").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});

		$("#overflow-item-wrap").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});

		//管理系别 专业侧边栏调用自定义滚动条插件
		$("#manage-dep-list-wrap").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});

		//管理文件夹侧边栏调用自定义滚动条插件
		$("#manage-side-bar").mCustomScrollbar({
			axis: "y",
			theme: "minimal-dark",
			autoHideScrollbar: true,
			mouseWheel: {
				enable: true
			}
		});
	})

	


	

	


})