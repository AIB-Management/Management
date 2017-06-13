/*
	定义管理员页未审核用户分页模块
	此模块需要一下几个js 模块
	1、jq
	2、EventUntil




	所需要的自定义函数
	1、s(),ss()
	2、createElem()
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


	//待审核用户列表 "通过" 按钮点击事件执行的方法
	//直接将用户的id 传给后台做处理
	function unexamieModulePass(){
		//获取注册用户姓名的单元格
		//用作向后台传值及向弹出层传值
		var parent = this.parentNode.parentNode;
		var nameTd = parent.querySelectorAll("td")[1];
		var uid = nameTd.title;
		//发送一个ajax 给后台
		//然后刷新更新后的表格
		//...ajaxCode
		$.ajax({
			url: 'http://localhost:8080/Management/admin/ajaxPassAccount.action',
			type: 'POST',
			dataType: 'json',
			data: "uid=" + uid,
			success: function(data){
				if (data.code == 100) {

					alert("操作成功");
					//返回数据的时候回到操作前停留的页码处
					//全局变量 curUnexamieModulePage
					unexamiePage.toUnexamiePage(unexamiePage.curUnexamieModulePage);
				}
			}
		});
	}


	//待审核用户列表 "拒绝" 按钮点击事件执行的方法
	//直接将值（用户名，id）传去弹出层
	function unexamieModuleRefuse(){
		//获取注册用户姓名的单元格
		//用作向后台传值及向弹出层传值
		var parent = this.parentNode.parentNode;
		var nameTd = parent.querySelectorAll("td")[1];

		//获取弹出层
		var floor = s("#floor");
		//隐藏撤回用户模块弹出层
		s("#recall-user").style.display = 'none';
		//显示填写拒绝信息模块弹出层
		s("#refuse-info").style.display = 'block';
		//为提示文字中的姓名字段添加内容
		s("#refuse-username").innerText = nameTd.innerText;
		//为提示文字中的名字字段属性 title添加内容
		s("#refuse-username").title = nameTd.title;
		//显示弹出层
		floor.style.display = "block";
	}



	//作为返回的对象
	//这个对象内有4个属性
	//curUnexamieModulePage "保存当前页码的成员变量"
	//createUnexamieTable "创建未审核用户表格函数"
	//createUnexamiePageNav "创建分页导航的函数"
	//toUnexamiePage "点击分页导航切换内容函数"
	var unexamiePage = {

		curUnexamieModulePage: 1,

		createUnexamieTable: function(data){
			s("#unexamie-main-content").innerHTML = "";
			//创建元素碎片收集器
			var frag = document.createDocumentFragment();

			var dataList = data.extend.page.list;

			var checkBox = createElem("input");
			checkBox.type = "checkbox";
			checkBox.className = "unexamie-select";


			var passBtn = createElem("button");
			var passBtnIcon = createElem("span");
			passBtnIcon.innerText = " ";
			passBtnIcon.className = "glyphicon glyphicon-ok";
			//为按钮添加图标
			passBtn.appendChild(passBtnIcon);
			

			var refuseBtn = createElem("button");
			var refuseBtnIcon = createElem("span");
			refuseBtnIcon.innerText = " ";
			refuseBtnIcon.className = "glyphicon glyphicon-minus-sign";
			//为按钮添加图标
			refuseBtn.appendChild(refuseBtnIcon);
			

			//为按钮添加class
			passBtn.className = "pass btn btn-success btn-sm";
			refuseBtn.className = "refuse btn btn-danger btn-sm";

			//为按钮添加文字
			passBtn.innerHTML += " 通过";
			refuseBtn.innerHTML += " 拒绝申请";


			

			for (var i = 0; i < dataList.length; i++) {
				//每次遍历创建一个 tr
				var tr = createElem("tr");
				//创建一个多选框包裹元素 td
				var checkBoxTd = createElem("td");
				var btnClone = checkBox.cloneNode(true);
				checkBoxTd.appendChild(btnClone);

				//为每一个多选框绑定点击事件
				EventUntil.addHandler(btnClone,"click",function(){
					selectAllCheckboxEvent(ss(".unexamie-select"),s("#unexamie-select-all"));
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
				tr.appendChild(departmentTd);

				//创建一个专业包裹 td
				var professionTd = createElem("td");
				professionTd.innerText = dataList[i].content;
				tr.appendChild(professionTd);

				//创建一个按钮包裹 td
				var btnTd = createElem("td");
				var passBtnClone = passBtn.cloneNode(true);
				var refuseBtnClone = refuseBtn.cloneNode(true);

				btnTd.appendChild(passBtnClone);
				btnTd.appendChild(refuseBtnClone);
				//为按钮绑定事件
				EventUntil.addHandler(passBtnClone,"click",unexamieModulePass);
				EventUntil.addHandler(refuseBtnClone,"click",unexamieModuleRefuse);

				tr.appendChild(btnTd);



				frag.appendChild(tr);
			}

			//表格元素添加数据
			s("#unexamie-main-content").appendChild(frag);
		},

		//创建分页导航方法
		createUnexamiePageNav: function(data){
			var self = this;

			s("#unexamie-pagination-content").innerHTML = "";
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
			prevPageBtnContent.setAttribute("aria-label", "homepage");
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
				EventUntil.addHandler(prevPageBtn,"click",function(){
					self.toUnexamiePage(data.extend.page.pageNum - 1);
				});

				//点击返回首页的时候调用 this.toUnexamiePage 就是跳到总页数的第一页
				//即传 1进去就可以了
				EventUntil.addHandler(homePageBtn,"click",function(){
					self.toUnexamiePage(1);
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
				EventUntil.addHandler(nextPageBtn,"click",function(){
					self.toUnexamiePage(data.extend.page.pageNum + 1);
				})

				//末页按钮就直接跳到页数的总数位置
				//调用 toUnexamiePage 传入 data.extend.page.pages
				//data.extend.page.pageNum 表示当前页
				//data.extend.page.pages 表示页的总数 即最后一页
				EventUntil.addHandler(lastPageBtn,"click",function(){
					self.toUnexamiePage(data.extend.page.pages);
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
				//调用 toUnexamiePage 传入当前分页按钮数字 ‘num’ 作为跳转页面的参数
				(function(num){
					EventUntil.addHandler(numLi,"click",function(){
						self.toUnexamiePage(num);
					})
				})(pageList[i]);

				frag.appendChild(numLi);
			}

			frag.appendChild(nextPageBtn);
			frag.appendChild(lastPageBtn);
			
			//分页导航添加全部分页按钮元素
			s("#unexamie-pagination-content").appendChild(frag);
		},

		toUnexamiePage: function(pn){
			var self = this;

			$.ajax({
				url: 'http://localhost:8080/Management/admin/ajaxGetAccountInfoIsNotPass.action',
				type: 'GET',
				dataType: 'json',
				data: "pn=" + pn,

				success: function(data){
					if (data.code == 100) {
						//每次请求成功之后
						//保存当前页面的页码数到 curUnexamieModulePage 成员变量中
						self.createUnexamieTable(data);
						self.createUnexamiePageNav(data);
						self.curUnexamieModulePage = data.extend.page.pageNum;


					}else{
						alert(data.msg);
					}
				}
			})
		}


	}














	



	/*
	//创建未审核用户表
	//将后台 json 字符串转换为 dom 元素
	function createUnexamieTable(data){
		s("#unexamie-main-content").innerHTML = "";
		//创建元素碎片收集器
		var frag = document.createDocumentFragment();

		var dataList = data.extend.page.list;

		var checkBox = createElem("input");
		checkBox.type = "checkbox";
		checkBox.className = "unexamie-select";


		var passBtn = createElem("button");
		var passBtnIcon = createElem("span");
		passBtnIcon.innerText = " ";
		passBtnIcon.className = "glyphicon glyphicon-ok";
		//为按钮添加图标
		passBtn.appendChild(passBtnIcon);
		

		var refuseBtn = createElem("button");
		var refuseBtnIcon = createElem("span");
		refuseBtnIcon.innerText = " ";
		refuseBtnIcon.className = "glyphicon glyphicon-minus-sign";
		//为按钮添加图标
		refuseBtn.appendChild(refuseBtnIcon);
		

		//为按钮添加class
		passBtn.className = "pass btn btn-success btn-sm";
		refuseBtn.className = "refuse btn btn-danger btn-sm";

		//为按钮添加文字
		passBtn.innerHTML += " 通过";
		refuseBtn.innerHTML += " 拒绝申请";


		

		for (var i = 0; i < dataList.length; i++) {
			//每次遍历创建一个 tr
			var tr = createElem("tr");
			//创建一个多选框包裹元素 td
			var checkBoxTd = createElem("td");
			var btnClone = checkBox.cloneNode(true);
			checkBoxTd.appendChild(btnClone);

			//为每一个多选框绑定点击事件
			EventUntil.addHandler(btnClone,"click",function(){
				selectAllCheckboxEvent(ss(".unexamie-select"),s("#unexamie-select-all"));
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
			tr.appendChild(departmentTd);

			//创建一个专业包裹 td
			var professionTd = createElem("td");
			professionTd.innerText = dataList[i].content;
			tr.appendChild(professionTd);

			//创建一个按钮包裹 td
			var btnTd = createElem("td");
			var passBtnClone = passBtn.cloneNode(true);
			var refuseBtnClone = refuseBtn.cloneNode(true);

			btnTd.appendChild(passBtnClone);
			btnTd.appendChild(refuseBtnClone);
			//为按钮绑定事件
			EventUntil.addHandler(passBtnClone,"click",unexamieModulePass);
			EventUntil.addHandler(refuseBtnClone,"click",unexamieModuleRefuse);

			tr.appendChild(btnTd);


			frag.appendChild(tr);
		}

		//表格元素添加数据
		s("#unexamie-main-content").appendChild(frag);
	}

	
	// 创建分页导航方法
	// 传入原始数据，分页导航的载体
	function createUnexamiePageNav(data){
		s("#unexamie-pagination-content").innerHTML = "";
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
		prevPageBtnContent.setAttribute("aria-label", "homepage");
		prevPageBtnContent.innerHTML = "&laquo;";

		prevPageBtn.appendChild(prevPageBtnContent);

		//如果当前后台返回的信息表示没有首页
		//则禁用首页按钮和向前翻页按钮 并且不为他们绑定点击事件
		if (data.extend.page.hasPreviousPage == false) {
			homePageBtn.className = "disabled";
			prevPageBtn.className = "disabled";
		}else{

			//如果有前一页
			//点击上一页按钮的时候调用 this.toUnexamiePage 就是当前页 -1
			//data.extend.page.pageNum 表示当前页
			EventUntil.addHandler(prevPageBtn,"click",function(){
				this.toUnexamiePage(data.extend.page.pageNum - 1);
			});

			//点击返回首页的时候调用 this.toUnexamiePage 就是跳到总页数的第一页
			//即传 1进去就可以了
			EventUntil.addHandler(homePageBtn,"click",function(){
				this.toUnexamiePage(1);
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
			//调用 this.toUnexamiePage 传入data.extend.page.pageNum + 1
			//data.extend.page.pageNum 表示当前页
			EventUntil.addHandler(nextPageBtn,"click",function(){
				this.toUnexamiePage(data.extend.page.pageNum + 1);
			})

			//末页按钮就直接跳到页数的总数位置
			//调用 this.toUnexamiePage 传入 data.extend.page.pages
			//data.extend.page.pageNum 表示当前页
			//data.extend.page.pages 表示页的总数 即最后一页
			EventUntil.addHandler(lastPageBtn,"click",function(){
				this.toUnexamiePage(data.extend.page.pages);
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
			//调用 this.toUnexamiePage 传入当前分页按钮数字 ‘num’ 作为跳转页面的参数
			(function(num){
				EventUntil.addHandler(numLi,"click",function(){
					this.toUnexamiePage(num);
				})
			})(pageList[i]);

			frag.appendChild(numLi);
		}

		frag.appendChild(nextPageBtn);
		frag.appendChild(lastPageBtn);
		
		//分页导航添加全部分页按钮元素
		s("#unexamie-pagination-content").appendChild(frag);
	}


	//分页按钮点击调用方法
	function toUnexamiePage(pn){
		$.ajax({
			url: 'http://localhost:8080/Management/admin/ajaxGetAccountInfoIsNotPass.action',
			type: 'GET',
			dataType: 'json',
			data: "pn=" + pn,

			success: function(data){
				if (data.code == 100) {

					this.createUnexamieTable(data);
					this.createUnexamiePageNav(data);
					this.curUnexamieModulePage = data.extend.page.pageNum;


				}else{
					alert(data.msg);
				}
			}
		})
		
		
	}
	*/

	return unexamiePage;


})