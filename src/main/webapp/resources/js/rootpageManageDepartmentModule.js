/*
	定义管理员页管理文件列表模块
	此模块需要一下几个js 模块
	1、jq
	2、EventUntil




	所需要的自定义函数
	1、s(),ss()
	2、createElem(),

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


	//------------- 上面是基本函数 ----------------

	//保存当前选择的系别id
	//var curManageDepDepId = "";
	//保存当前选择的部门名字
	//var curManageDepDepName = "";




	//管理部门侧边栏系别点击执行函数
	//此函数被 createElemForDepList 函数调用
	function manageDepListSelect(){
		//调整样式
		var depList = ss("#manage-department-list li");

		//清空li 的活动样式
		for (var i = 0; i < depList.length; i++) {
			if (depList[i].className.indexOf("filedep-item-active") != -1) {
				removeClass(depList[i],"filedep-item-active");
			}
		}

		this.className = "filedep-item-active";
		//侧边栏系别点击时
		//获取这个系别的id
		manageDepModule.curManageDepDepId = this.getAttribute("data-depid");
		//获取这个系别的名字
		manageDepModule.curManageDepDepName = this.innerText;
		//输出数据
		outputSpeciality(manageDepModule.curManageDepDepId);

		//上面工具栏的增加专业按钮显示
		s("#add-speciality").style.display = 'inline-block';
	}

	//从系别数据里面创建元素
	//被 createManageDepDepsList 调用
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



	//创建系别管理弹出层侧边栏部门列表
	function createManageDepDepsList(){

		var depListWrap = s("#manage-department-list");
		//清空所有系别内容
		depListWrap.innerHTML = "";

		$.ajax({
			url: '/Management/content/ajaxFindDepOrPro.action',
			type: 'GET',
			dataType: 'json',
			data: "parent=0",
			success: function(data){
				if (data.code == 100) {
					//如果没有部门数据
					if (data.extend.deps.length == 0) {
						//部门侧边栏更换提示背景
						depListWrap.className = "nodepartment-sidebar-bg";
					}else{
						//如果有部门就输出数据
						depListWrap.appendChild(createElemForDepList(data,manageDepListSelect));
					}
				}else{
					alert("未知错误，请稍后重试");
				}
			}
		})
		
	}


	

	//根据系别id 输出对应专业
	function outputSpeciality(depId){
		//获取部门列表
		var specList = s("#speciality-list-content");
		//清空部门列表
		specList.innerHTML = "";

		$.ajax({
			url: '/Management/content/ajaxFindDepOrPro.action',
			type: 'GET',
			dataType: 'json',
			data: "parent=" + depId,
			success: function(data){
				if (data.code == 100) {
					specList.appendChild(createSpecialityElem(data));
				}else{
					alert("未知错误，请稍后重试");
				}
			}
		})
		
	}


	//将数据转换为元素的函数
	//构造专业名元素方法
	function createSpecialityElem(data){
		var frag = document.createDocumentFragment(),
			list = data.extend.pros;

		//创建表格内需要的元素
		var tr = createElem("tr"),
			td = createElem("td"),
			btn = createElem("button"),
			span = createElem("span");

		var editBtn = btn.cloneNode(true),
			editIcon = span.cloneNode(true),
			dropBtn = btn.cloneNode(true),
			dropIcon = span.cloneNode(true);


		editIcon.className = "glyphicon glyphicon-edit";
		editBtn.className = "btn btn-default btn-sm";
		dropIcon.className = "glyphicon glyphicon-trash";
		dropBtn.className = "btn btn-danger btn-sm";

		editBtn.appendChild(editIcon);
		editBtn.innerHTML += "修改专业";

		dropBtn.appendChild(dropIcon);
		dropBtn.innerHTML += "删除专业";



		for (var i = 0; i < list.length; i++) {

			var row = tr.cloneNode(true),
				specNamecol = td.cloneNode(true),
				operateCol = td.cloneNode(true),
				dropButton = dropBtn.cloneNode(true),
				editButton = editBtn.cloneNode(true);

			//修改部门按钮点事件
			EventUntil.addHandler(editButton,"click",editSpecBtnClick);

			//删除部门按钮点击事件
			EventUntil.addHandler(dropButton,"click",dropSpecBtnClick);

			specNamecol.className = "manage-department-td";
			specNamecol.innerText = list[i].pro;
			specNamecol.title = list[i].uid;

			operateCol.className = "manage-department-td";
			operateCol.appendChild(editButton);
			operateCol.appendChild(dropButton);

			row.appendChild(specNamecol);
			row.appendChild(operateCol);

			frag.appendChild(row);

		}

		return frag;
	}




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






	//返回的公有对象
	var manageDepModule = {

		//保存当前选择的系别id 公有成员变量
		curManageDepDepId: "",
		//保存当前选择部门名字 公有成员变量
		curManageDepDepName: "",
		//创建系别列表 公有方法
		createManageDepDepsList: createManageDepDepsList,
		//创建专业列表 公有方法
		outputSpeciality: outputSpeciality

	}

	return manageDepModule;

})