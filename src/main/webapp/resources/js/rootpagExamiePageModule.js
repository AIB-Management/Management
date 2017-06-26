/*
	定义管理员页未审核用户分页模块
	此模块需要一下几个js 模块
	1、jq
	2、EventUntil




	所需要的自定义函数
	1、s(),ss()
	2、createElem(),
	3、
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


	//定义一个计算选中状态的多选框数量的函数
	function countCheckedBoxChecked(elem){
		var count = 0;
		for (var i = 0; i < elem.length; i++) {
			if (elem[i].checked == true) {
				count++;
			}
		}

		return count;
	}


	//输出专业元素
	//需要两个参数
	//第一个是系别的id ，第二个是设定特定专业为选中状态的专业id，可为空
	//第二个参数为空时 列表的选中状态会设为默认选中状态
	function createDepOptionForModifyUserSpec(data,targetSpec){
		var list = data.extend.pros;
		var frag = document.createDocumentFragment();

		//保存第一个option
		var firstOption = s("#user-spec").options[0].cloneNode(true);
		s("#user-spec").innerHTML = "";

		for (var i = 0; i < list.length; i++) {
			var option = createElem("option");
			option.value = list[i].uid;
			option.innerText = list[i].pro;
			if (targetSpec != "") {
				if (option.value == targetSpec) {
					option.selected = "selected";
				}
			}
			frag.appendChild(option);
		}
		s("#user-spec").appendChild(firstOption);
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

				}else{
					alert("获取专业列表失败，请尝试刷新网页");
				}
			},

			error: function(){
				alert("获取专业列表失败，请尝试刷新网页");
			}
		})
	}


	//定义表格多选框点击事件通用执行函数
	function selectAllCheckboxEvent(checkboxList,sellectAllCheckbox){
		//获取所有多选框元素
		var checkBoxs = checkboxList;
		//countCheckedBoxChecked 这个函数会返回当前监测的多选框选中被选中的个数
		var checkedNum = countCheckedBoxChecked(checkBoxs);


		//当全部多选框被选中的时候
		if (checkedNum == checkBoxs.length) {
			sellectAllCheckbox.checked = true;
		}else{
			sellectAllCheckbox.checked = false;
		}
	}

	//撤回按钮点击事件回调函数
	function examiedModuleRecall(){
		//获取注册用户姓名的单元格
		var parent = this.parentNode.parentNode;
		var nameTd = parent.querySelectorAll("td")[1];

		//获取弹出层
		var floor = s("#floor");
		//显示填写拒绝信息模块弹出层
		s("#refuse-info").style.display = 'none';
		//显示撤回用户模块弹出层
		s("#recall-user").style.display = 'block';
		//为提示文字中的姓名字段添加内容
		s("#recall-username").innerText = nameTd.innerText;
		s("#recall-username").title = nameTd.title;
		//显示弹出层
		floor.style.display = "block";
	}


	//已审核用户修改系别专业按钮点击事件回调函数
	//撤回按钮点击事件回调函数
	function examiedMouleModifyDep(){
		//获取注册用户姓名的单元格
		var parent = this.parentNode.parentNode;
		var depId = parent.querySelectorAll("td")[2].title,
			specId = parent.querySelectorAll("td")[3].title;

		var depOptions = ss("#user-dep option");

		//遍历修改系别的系别下拉框
		for (var i = 0; i < depOptions.length; i++) {
			//如果当前用户的系别与下拉框的系别匹配
			//把这个选项设置为选中状态
			if (depOptions[i].value == depId) {
				depOptions[i].selected = "selected";
			}
		}

		console.log(specId);
		//然后根据修改后的系别下拉框的值去获取对应的专业
		getModifyUserDepModuleSpec(s("#user-dep").value,specId);


		//显示弹出层
		s("#modify-user-department-floor").style.display = 'block';
	}


	var examiePage = {

		//初始化当前已审核用户表页码
		curExamieModulePage: 1,

		//初始化当前系别的id
		curDepartmentId: "",

		//创建已审核用户表格方法
		createExamiedTable: function(data){
			s("#examied-main-content").innerHTML = "";
			//创建元素碎片收集器
			var frag = document.createDocumentFragment();

			var dataList = data.extend.page.list;

			//创建多选框
			var checkBox = createElem("input");
			checkBox.type = "checkbox";
			checkBox.className = "examied-select";
			
			//创建撤回按钮
			var recallBtn = createElem("button");
			var recallBtnIcon = createElem("span");
			recallBtnIcon.innerText = " ";
			recallBtnIcon.className = "glyphicon glyphicon-erase";
			recallBtnIcon.setAttribute("aria-hidden", "true");
			//为撤回按钮添加图标
			recallBtn.appendChild(recallBtnIcon);
			

			recallBtn.className = "refuse btn btn-danger btn-sm";

			recallBtn.innerHTML += " 撤回";

			//创建撤回按钮
			var modifyBtn = createElem("button");
			var modifyBtnIcon = createElem("span");
			modifyBtnIcon.innerText = " ";
			modifyBtnIcon.className = "glyphicon glyphicon-edit";
			modifyBtnIcon.setAttribute("aria-hidden", "true");
			//为撤回按钮添加图标
			modifyBtn.appendChild(modifyBtnIcon);
			

			modifyBtn.className = "refuse btn btn-warning btn-sm";

			modifyBtn.innerHTML += " 修改教师系别";
			

			for (var i = 0; i < dataList.length; i++) {
				//每次遍历创建一个 tr
				var tr = createElem("tr");
				//创建一个多选框包裹元素 td
				var checkBoxTd = createElem("td");
				var btnClone = checkBox.cloneNode(true);
				checkBoxTd.appendChild(btnClone);

				//为每一个多选框绑定点击事件
				EventUntil.addHandler(btnClone,"click",function(){
					selectAllCheckboxEvent(ss(".examied-select"),s("#examied-select-all"));
				});
				//tr 添加checkBoxTd
				tr.appendChild(checkBoxTd);

				//创建一个教师姓名包裹 td
				var userTd = createElem("td");
				userTd.innerText = dataList[i].name;
				userTd.title = dataList[i].uid;
				tr.appendChild(userTd);

				//创建一个系别包裹 td
				var departmentTd = createElem("td");
				departmentTd.innerText = dataList[i].depContent;
				departmentTd.title = dataList[i].departmentId;
				tr.appendChild(departmentTd);

				//创建一个专业包裹 td
				var professionTd = createElem("td");
				professionTd.innerText = dataList[i].content;
				professionTd.title = dataList[i].professionId;
				tr.appendChild(professionTd);

				//创建一个按钮包裹 td
				var btnTd = createElem("td");
				var recallBtnClone = recallBtn.cloneNode(true);
				var modifyBtnClone = modifyBtn.cloneNode(true);

				//为按钮绑定事件
				EventUntil.addHandler(recallBtnClone,"click",examiedModuleRecall);
				EventUntil.addHandler(modifyBtnClone,"click",examiedMouleModifyDep);

				btnTd.appendChild(recallBtnClone);
				btnTd.appendChild(modifyBtnClone);
				

				tr.appendChild(btnTd);



				frag.appendChild(tr);
			}

			//表格元素添加数据
			s("#examied-main-content").appendChild(frag);
		},

		createExamiePageNav: function(data){
			var self = this;

			//每次执行都清空一次分页导航
			s("#examied-pagination-content").innerHTML = "";
			//获取分页导航输出分页数的数据
			var pageList = data.extend.page.navigatepageNums;
			//创建元素碎片收集器
			var frag = document.createDocumentFragment();

			//先创建首页，向前翻页，向后翻页，到末页按钮
			//1、创建回首页按钮
			var homePageBtn = createElem("li");
			var homePageBtnContent = createElem("a");
			homePageBtnContent.href = "#";
			homePageBtnContent.setAttribute("aria-label", "homepage");
			homePageBtnContent.innerText = "首页";
			homePageBtn.appendChild(homePageBtnContent);

			//2、创建向前翻页按钮
			var prevPageBtn = createElem("li");
			var prevPageBtnContent = createElem("a");
			

			prevPageBtnContent.href = "#";
			prevPageBtnContent.setAttribute("aria-label", "prevpage");
			prevPageBtnContent.innerHTML = "&laquo;";

			prevPageBtn.appendChild(prevPageBtnContent);

			//如果当前后台返回的信息表示没有首页
			//则禁用首页按钮和向前翻页按钮 并且不为他们绑定点击事件
			if (data.extend.page.hasPreviousPage == false) {
				homePageBtn.className = "disabled";
				prevPageBtn.className = "disabled";
			}else{

				//如果有前一页
				//点击上一页按钮的时候调用 toUnexamiePage 就是当前页 -1
				//data.extend.page.pageNum 表示当前页
				//页面跳转时还需要传入当前下拉框的值 以便知道目前是查看那个系的审核用户
				EventUntil.addHandler(prevPageBtn,"click",function(){
					self.toexamiedPage(data.extend.page.pageNum - 1,self.curDepartmentId);
				});

				//点击返回首页的时候调用 toUnexamiePage 就是跳到总页数的第一页
				//即传 1进去就可以了
				//页面跳转时还需要传入当前下拉框的值 以便知道目前是查看那个系的审核用户
				EventUntil.addHandler(homePageBtn,"click",function(){
					self.toexamiedPage(1,self.curDepartmentId);
				});
			}

			frag.appendChild(homePageBtn);
			frag.appendChild(prevPageBtn);



			//3、创建向后翻页按钮
			var nextPageBtn = createElem("li");
			var nextPageBtnContent = createElem("a");

			nextPageBtnContent.href = "#";
			nextPageBtnContent.setAttribute("aria-label", "homepage");
			nextPageBtnContent.innerHTML = "&raquo;";

			nextPageBtn.appendChild(nextPageBtnContent);


			//4、创建回到末页按钮
			var lastPageBtn = createElem("li");
			var lastPageBtnContent = createElem("a");

			lastPageBtnContent.href = "#";
			lastPageBtnContent.setAttribute("aria-label", "homepage");
			lastPageBtnContent.innerText = "末页";

			lastPageBtn.appendChild(lastPageBtnContent);

			//如果当前后台返回的信息表示没有末页
			//则禁用末页按钮和向后翻页按钮 并且不为他们绑定点击事件
			if (data.extend.page.hasNextPage == false) {
				nextPageBtn.className = "disabled";
				lastPageBtn.className = "disabled";
			}else{
				//否则给他们都绑定点击事件
				//下一页按钮就是当前页+1
				//调用 toUnexamiePage 传入data.extend.page.pageNum + 1
				//data.extend.page.pageNum 表示当前页
				//页面跳转时还需要传入当前下拉框的值 以便知道目前是查看那个系的审核用户
				EventUntil.addHandler(nextPageBtn,"click",function(){
					self.toexamiedPage(data.extend.page.pageNum + 1,self.curDepartmentId);
				})

				//末页按钮就直接跳到页数的总数位置
				//调用 toUnexamiePage 传入 data.extend.page.pages
				//data.extend.page.pageNum 表示当前页
				//data.extend.page.pages 表示页的总数 即最后一页
				//页面跳转时还需要传入当前下拉框的值 以便知道目前是查看那个系的审核用户
				EventUntil.addHandler(lastPageBtn,"click",function(){
					self.toexamiedPage(data.extend.page.pages,self.curDepartmentId);
				})
			}


			//5、遍历创建数字分页按钮
			for (var i = 0; i < pageList.length; i++) {
				var numLi = createElem("li");
				var numLiIcon = createElem("a");
				numLiIcon.href = "#";
				numLiIcon.innerText = pageList[i];
				numLi.appendChild(numLiIcon);

				if (pageList[i] == data.extend.page.pageNum) {

					numLi.className = "active";
				}
				//为每个分页数字按钮添加事件
				//调用 toexamiedPage 传入当前分页按钮数字 ‘num’ 
				//以及传入当前的筛选下拉框的值
				//页面跳转时还需要传入当前下拉框的值 以便知道目前是查看那个系的审核用户
				(function(num){
					EventUntil.addHandler(numLi,"click",function(){
						self.toexamiedPage(num,self.curDepartmentId);
					})
				})(pageList[i]);

				frag.appendChild(numLi);
			}

			frag.appendChild(nextPageBtn);
			frag.appendChild(lastPageBtn);
			
			//分页导航添加全部分页按钮元素
			s("#examied-pagination-content").appendChild(frag);
		},

		toexamiedPage: function(pn,id){
			var self = this;
			
			var result = "";
			//整理参数
			if (id != "") {
				result = "pn=" + pn + "&parent=" + id;
			}else{
				result = "pn=" + pn;
			}
			//页面跳转时发送ajax 请求获取后台的数据
			$.ajax({
				url: '/Management/admin/ajaxGetAccountInfoIsPass.action',
				type: 'GET',
				dataType: 'json',
				data: result,

				success: function(data){
					if (data.code == 100) {
						//输出已审核用户内容
						self.createExamiedTable(data);
						//输出分页导航栏
						self.createExamiePageNav(data);
						//为全局变量 curExamieModulePage （保存当前分页页码）
						self.curExamieModulePage = data.extend.page.pageNum;


					}else{
						alert(data.msg);
					}
				}
			})
		}
	}

	return examiePage;

})