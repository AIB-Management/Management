require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}

	}

})

//管理页主函数
require(["jquery.min","checkInput","overborwserEvent"],function main($,checkBy,EventUntil){
	//--------- 全局变量 --------
	//增加、删除、修改导航栏模块当前页码
	var curNavModulePage = 0;
	//未审核用户模块当前页码
	var curUnexamieModulePage = 0;
	//已审核用户模块当前页码
	var curExamieModulePage = 0
	//------------

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

	//定义获取导航栏表格行内信息方法
	function getDetailInfo(elem){
		//获取按钮所在行
		var infoArr = [];
		var tr = elem.parentNode.parentNode;
		var td = tr.querySelectorAll("td");

		for (var i = 0; i < td.length - 1; i++) {
			infoArr.push(td[i].innerText);
		}

		return infoArr;
		
	}



	//修改导航栏模块按钮点击事件
	//真正调用此函数是当数据完全获取完毕后调用
	// function modifyModuleBtn(){
	// 	//获取导航栏信息表格中的全部按钮
	// 	var btns = ss("#all-tag-list tbody tr td button");
	// 	for (var i = 0; i < btns.length; i++) {
	// 		EventUntil.addHandler(btns[i],"click",function(){
	// 			//如果点击的按钮类名为 modify-tag
	// 			//执行自定义的 getDetailInfo 方法
	// 			//获取到所有信息后再将所有信息填入弹出层对应的输入框中
	// 			if (this.className.indexOf("modify-tag") != -1) {
	// 				//获取点击按钮对应的信息
	// 				var infoList = getDetailInfo(this);
	// 				//获取弹出层
	// 				var floor = s("#floor");
	// 				//执行自定义信息输入函数
	// 				setFloorInfo(ss("#floor .modify-nav-info"),infoList);
	// 				//拒绝用户注册弹出层隐藏
	// 				s("#refuse-info").style.display = 'none';
	// 				//撤回用户弹出层隐藏
	// 				s("#recall-user").style.display = 'none';
	// 				//删除导航弹出层隐藏
	// 				s("#delete-nav").style.display = 'none';
	// 				//修改导航明细弹出层显示
	// 				s("#modify-nav-info").style.display = 'block';
	// 				//弹出层背景显示
	// 				floor.style.visibility = "visible";

	// 			}else if(this.className.indexOf("delete-tag") != -1){
	// 				//点击删除导航按钮的时候
	// 				//显示删除导航提示框隐藏其他弹出层
	// 				//获取要删除导航的名字和id
	// 				//向提示框传递此时要删除导航栏的 id和名字参数

	// 				//获取父元素
	// 				var parent = this.parentNode.parentNode;
	// 				var tagNameTd = parent.querySelectorAll("td")[0];

	// 				//获取提示标签名的元素
	// 				var deleteTagName = s("#delete-navname");

	// 				//获取弹出层
	// 				var floor = s("#floor");
	// 				//拒绝用户注册弹出层隐藏
	// 				s("#refuse-info").style.display = 'none';
	// 				//撤回用户弹出层隐藏
	// 				s("#recall-user").style.display = 'none';
	// 				//修改导航明细弹出层显示
	// 				s("#modify-nav-info").style.display = 'none';
	// 				//删除导航弹出层隐藏
	// 				s("#delete-nav").style.display = 'block';
	// 				//向提示字符元素填充内容
	// 				deleteTagName.innerText = tagNameTd.innerText;
	// 				deleteTagName.title = tagNameTd.title;

	// 				//弹出层背景显示
	// 				floor.style.visibility = "visible";
	// 			}
	// 		})
	// 	}

	// }



	//页面加载完成时 显示新增未注册用户数量
	function showUnexamieUserNums(){
		$.ajax({
			url: 'http://localhost:8080/Management/admin/ajaxGetCountIsNotPass.action',
			type: 'GET',
			dataType: 'json',
			success: function(data){
				s("#number-hints").innerText = data.extend.num;
				s("#number-hints").style.display = 'inline-block';
			}
		})
		
		
	}


	//--------------  未审核模块的操作事件 ------------

	//待审核用户列表 "通过" 按钮点击事件执行的方法
	//直接将用户的id 传给后台做处理
	function unexamieModulePass(){
		//获取注册用户姓名的单元格
		//用作向后台传值及向弹出层传值
		var parent = this.parentNode.parentNode;
		var nameTd = parent.querySelectorAll("td")[1];
		var id = nameTd.title;
		//发送一个ajax 给后台
		//然后刷新更新后的表格
		//...ajaxCode
		$.ajax({
			url: 'http://localhost:8080/Management/admin/ajaxPassAccount.action',
			type: 'POST',
			dataType: 'json',
			data: "id=" + id,
			success: function(data){
				alert("提交成功");
				//返回数据的时候重新加载未审核用户第一页的数据
				toUnexamiePage(1);
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
		//隐藏修改导航模块弹出层
		s("#modify-nav-info").style.display = 'none';
		//隐藏撤回用户模块弹出层
		s("#recall-user").style.display = 'none';
		//隐藏删除导航弹出层
		s("#delete-nav").style.display = 'none';
		//显示填写拒绝信息模块弹出层
		s("#refuse-info").style.display = 'block';
		//为提示文字中的姓名字段添加内容
		s("#refuse-username").innerText = nameTd.innerText;
		//为提示文字中的名字字段属性 title添加内容
		s("#refuse-username").title = nameTd.title;
		//显示弹出层
		floor.style.display = "block";
	}


	//未审核用户列表 多选框 点击事件执行函数
	function unexamieSelected(){
		//获取所有多选框元素
		var checkBoxs = ss(".unexamie-select");
		//定义当前点击多选框时 "被选择多选框数量" 计算变量
		var checkedNum = 0;

		for (var i = 0; i < checkBoxs.length; i++) {
			//点击多选框的时候遍历一次全部多选框
			//有选中的 checkedNum +1
			if (checkBoxs[i].checked == true) {
				checkedNum++;
			}
		}

		//当全部多选框被选中的时候
		//"多选按钮 #unexamie-select-all" 状态为选中
		if (checkedNum == checkBoxs.length) {
			s("#unexamie-select-all").checked = true;
		}
	}



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
		passBtnIcon.setAttribute("aria-hidden", "true");
		//为按钮添加图标
		passBtn.appendChild(passBtnIcon);
		

		var refuseBtn = createElem("button");
		var refuseBtnIcon = createElem("span");
		refuseBtnIcon.innerText = " ";
		refuseBtnIcon.className = "glyphicon glyphicon-minus-sign";
		refuseBtnIcon.setAttribute("aria-hidden", "true");
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
			EventUntil.addHandler(btnClone,"click",unexamieSelected);
			//tr 添加checkBoxTd
			tr.appendChild(checkBoxTd);

			//创建一个教师姓名包裹 td
			var userTd = createElem("td");
			userTd.innerText = dataList[i].username;
			userTd.title = dataList[i].id;
			tr.appendChild(userTd);

			//创建一个系别包裹 td
			var departmentTd = createElem("td");
			departmentTd.innerText = dataList[i].department;
			tr.appendChild(departmentTd);

			//创建一个专业包裹 td
			var professionTd = createElem("td");
			professionTd.innerText = dataList[i].profession;
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
			//点击上一页按钮的时候调用 toUnexamiePage 就是当前页 -1
			//data.extend.page.pageNum 表示当前页
			EventUntil.addHandler(prevPageBtn,"click",function(){
				toUnexamiePage(data.extend.page.pageNum - 1);
			});

			//点击返回首页的时候调用 toUnexamiePage 就是跳到总页数的第一页
			//即传 1进去就可以了
			EventUntil.addHandler(homePageBtn,"click",function(){
				toUnexamiePage(1);
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
				toUnexamiePage(data.extend.page.pageNum + 1);
			})

			//末页按钮就直接跳到页数的总数位置
			//调用 toUnexamiePage 传入 data.extend.page.pages
			//data.extend.page.pageNum 表示当前页
			//data.extend.page.pages 表示页的总数 即最后一页
			EventUntil.addHandler(lastPageBtn,"click",function(){
				toUnexamiePage(data.extend.page.pages);
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
					toUnexamiePage(num);
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

					createUnexamieTable(data);
					createUnexamiePageNav(data);
					curUnexamieModulePage = data.extend.page.pageNum;


				}else{
					alert(data.msg);
				}
			}
		})
		
		
	}


	//未审核用户表 "选择全部多选框" 点击事件执行函数
	function unexamieSelectAllBtn(){
		//获取未审核用户当前页的所有多选框
		var checkBoxs = ss(".unexamie-select");
		//如果未审核用户列表 "选择全部" 多选框点击时为选中状态
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

	//未审核列表批量通过按钮点击事件
	function unexamiePassAll(){
		//创建保存多个 id 的数组
		var idList = [];
		//获取所有多选框元素
		var checkBoxs = ss(".unexamie-select");

		//遍历这一页每一个多选框
		//如果有选中的
		//获取选中多选框所在行的第二列的 title 值
		for (var i = 0; i < checkBoxs.length; i++) {
			if (checkBoxs[i].checked == true) {
				var idVal = checkBoxs[i].parentNode.parentNode.querySelectorAll("td")[1].title;
				idList.push(idVal);
			}
		}

		//将获取到的值发送到后台处理页面
		$.ajax({
			url: 'http://localhost:8080/Management/admin/ajaxPassAccount.action',
			type: 'POST',
			dataType: 'json',
			data: "id=" + idList.join(","),
			success: function(data){
				toUnexamiePage(curUnexamieModulePage);
				alert("操作成功");
			}
		});
		
		
	}

	//未审核用户 "选择全部多选框" 点击事件
	EventUntil.addHandler(s("#unexamie-select-all"),"click",unexamieSelectAllBtn);

	//未审核用户 "批量通过按钮" 点击事件
	EventUntil.addHandler(s("#unexamie-pass-all"),"click",unexamiePassAll);

	//------------- 未审核模块操作事件结束 -------------------------


	//----------------- 已审核模块操作事件开始 -----------------------
	function examieModuleRecall(){
		//获取注册用户姓名的单元格
		var parent = this.parentNode.parentNode;
		var nameTd = parent.querySelectorAll("td")[1];

		//获取弹出层
		var floor = s("#floor");
		//隐藏修改导航模块弹出层
		s("#modify-nav-info").style.display = 'none';
		//隐藏删除导航弹出层
		s("#delete-nav").style.display = 'none';
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

	//侧边栏多个tag 点击事件
	function tagsClick(){
		var tags = ss(".child-tag");
		var contents = ss(".content-wrap");
		var loadingIcon = ss(".loading-icon-wrap");

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
				contents[index].style.display = 'block';

				//为当前点击的 tag增加激活状态样式
				this.className += " sidebar-tag-active";
				
				//如果当前点击的tag 为未审核列表
				//执行如下处理
				if (this.id == "unexamie-tag") {
					s("#number-hints").style.display = 'none';
					$.ajax({
						url: 'http://localhost:8080/Management/admin/ajaxGetAccountInfoIsNotPass.action',
						type: 'GET',
						async: false,
						dataType: 'json',
						success: function(data){
							toUnexamiePage(1);
						}

					})
					
					
				}
			});
		}
	};

	


	function createUnexamieTabel(elemList,tableElem){
		//清空表格
		tableElem.innerHTML = "";

		tableElem.appendChild(elemList);
	}

	

	

	//页面加载完成时要做的预处理
	function init(){
		tagsClick();
		showUnexamieUserNums();
	}

	//--------------定义层结束-------------

	init();


	
	

	//初始化子导航栏提示信息
	checkBy.init({
		childTagContent: {hint:"多个子导航请用英文逗号分隔"},
		childTagInfo: {hint:"多个子导航请用英文逗号分隔"}
	})




	//-----------右侧内容增加导航栏模块功能-------
	//子导航选择框点击事件
	EventUntil.addHandler(s("#has-child-tag"),"click",function(){
		if (this.checked == true) {
			s("#child-tag-wrap").style.display = "block";
		}else{
			s("#child-tag-wrap").style.display = "none";
		}
	})

	//子导航输入框聚焦事件
	EventUntil.addHandler(s("#childTagContent"),"focus",function(){
		checkBy.onFocus(this,"span","#333333");
	})
	//子导航栏输入框失焦事件
	EventUntil.addHandler(s("#childTagContent"),"blur",function(){
		var parent = this.parentNode;
		var hintContent = parent.querySelectorAll("span")[0];
		//增加子导航栏输入框失焦时 输入框border颜色为 #999
		s("#childTagContent").style.borderColor = "#999999";
		hintContent.innerText = "";
	})

	//-------------右侧内容增加导航栏模块功能结束-------------



	//------------ 弹出层事件 ----------------


	//修改导航栏弹出层功能
	//1、弹出层子导航栏内容修改输入框事件
	EventUntil.addHandler(s("#childTagInfo"),"focus",function(){
		checkBy.onFocus(this,"#modify-childNav-hint","#408DD2");
	})

	//2、弹出层子导航栏信息框失焦事件
	EventUntil.addHandler(s("#childTagInfo"),"blur",function(){

		var parent = this.parentNode;
		var hintContent = parent.querySelector("#modify-childNav-hint");
		hintContent.innerText = "";
		this.style.borderColor = "#000000";
	})

	//3、修改导航弹出层关闭按钮点击事件
	EventUntil.addHandler(s("#modify-nav-close-btn"),"click",function(){
		s("#floor").style.display = "none";
	})

	//4、修改弹出层提交按钮点击事件
	EventUntil.addHandler(s("#modify-btn"),"click",function(){
		s("#floor").style.display = "none";
	})

	//----------------- 修改导航栏弹出层功能结束 -------------------



	//删除导航栏弹出层功能
	//1、取消删除导航按钮点击事件
	EventUntil.addHandler(s("#cancel-delete-nav"),"click",function(){
		//整个弹出层直接隐藏
		s("#floor").style.display = "none";
	})

	//2、确认删除导航按钮点击事件
	EventUntil.addHandler(s("#confirm-delete-nav"),"click",function(){
		//确认删除导航栏按钮点击时
		//获取此时提示元素的 title 值，将id 传给后台
		//loading 图标显示
		//后台返回更新后的数据
		//前端更新新的数据
		//loading图标隐藏 (src = "")
		//弹出层隐藏

		//获取提示元素的title 值
		var navId = s("#delete-navname").title;
		$.ajax({
			url: '',
			async: false,
			type: 'GET',
			dataType: 'json',
			//发送title 值给后台
			data: {deleteNavId: navId},
			beforeSend: function(){
				//发送请求之前先显示加载图标
				s("#deleteNav-loading-icon").src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//1、遍历后台数据
				//2、输出元素
				//3、调用modifyModuleBtn() 方法为新加载的元素绑定事件
				//4、loading图标隐藏（src = ""）
				//5、弹出层隐藏
				toUnexamiePage(1);
				s("#deleteNav-loading-icon").src = "";
				s("#floor").style.display = 'none';
			}
		});
		
		
	});

	//---------------------- 删除导航弹出层功能结束 ------------------




	//拒绝用户弹出层功能
	//1、拒绝用户注册模块关闭按钮点击事件
	EventUntil.addHandler(s("#refuse-close-btn"),"click",function(){
		
		s("#floor").style.display = "none";
	})

	//2、拒绝理由信息输入框输入事件
	EventUntil.addHandler(s("#refuse-content"),"keyup",function(){

		var sendBtn = s("#send-refuse-info");

		if (this.value.length == 0) {
			sendBtn.disabled = "disabled";
			sendBtn.style.backgroundColor = "#999999"
		}else{
			sendBtn.removeAttribute("disabled");
			sendBtn.style.backgroundColor = "#05a828";
		}
	})

	//3、拒绝用户注册模块提交拒绝信息按钮点击事件
	EventUntil.addHandler(s("#send-refuse-info"),"click",function(){
		//ajax 提交用户的id （则xxx title属性）,拒绝理由 给后台处理
		//当处理完毕后再将包裹层隐藏

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//拒绝的理由
		var refuseVal = s("#refuse-content").value;
		//获取加载图片元素
		var icon = s("#loading-icon");
		$.ajax({
			url: 'http://localhost:8080/Managementadmin/ajaxRejectAccount.action',
			async: false,
			type: 'GET',
			dataType: 'json',
			data: "id=" + idVal + "&content=" + refuseVal,
			beforesend: function(){
				icon.src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//接收到返回信息后
				//1、遍历更新后的信息 更新前端页面的内容
				//2、输出完信息之后调用 unexamieModuleBtn() 方法为新添加的内容绑定点击事件
				//3、loading图标隐藏（src = ""）
				//4、弹出层隐藏
				//输出第一页未审核用户数据
				toUnexamiePage(1);
				//隐藏加载图标
				icon.src = "";
				//隐藏弹出层
				s("#floor").style.display = "none";
			}
		});
		
		
	})

	//3、拒绝用户注册模块不填写拒绝信息按钮点击事件
	EventUntil.addHandler(s("#no-refuse-reason"),"click",function(){
		//ajax 提交用户的id 给后台，不提交拒绝理由
		//数据提交完成后将包裹层隐藏

		//获取当前拒绝用户的后台 id 值
		var idVal = s("#refuse-username").title;
		//获取加载图片元素
		var icon = s("#loading-icon");

		$.ajax({
			url: 'http://localhost:8080/Managementadmin/ajaxRejectAccount.action',
			async: false,
			type: 'GET',
			dataType: 'json',
			data: "id=" + idVal,
			beforesend: function(){
				icon.src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//接收到返回信息后
				//1、遍历更新后的信息 更新前端页面的内容
				//2、输出完信息之后调用 unexamieModuleBtn() 方法为新添加的内容绑定点击事件
				//3、loading图标隐藏（src = ""）
				//4、弹出层隐藏

				toUnexamiePage(1);
				//隐藏加载图标
				icon.src = "";
				//隐藏弹出层
				s("#floor").style.display = "none";
			}
		});
		
		
	})
	//----------------- 拒绝用户弹出层功能结束 -------------------


	//撤回用户弹出层功能
	//1、取消撤回按钮点击事件
	EventUntil.addHandler(s("#cancel-recall-user"),"click",function(){
		s("#floor").style.display = "none";
	})

	//2、撤回理由输入框键盘输入事件
	EventUntil.addHandler(s("#recall-content"),"keyup",function(){
		//获取提交按钮
		var sendBtn = s("#confirm-recall-user");

		if (this.value.length != 0) {
			sendBtn.removeAttribute("disabled");
			sendBtn.style.backgroundColor = "#E61A1A";
		}else{
			sendBtn.disabled = "disabled";
			sendBtn.style.backgroundColor = "#999999";
		}
	})

	//3、确认撤回按钮点击事件
	EventUntil.addHandler(s("#confirm-recall-user"),"click",function(){
		//点击时 和上面一样 获取提示元素的 title值
		//将title值 传给后台
		var idVal = s("#recall-username").title;

		$.ajax({
			url: '',
			async: false,
			type: 'GET',
			dataType: 'json',
			data: {recallUserId: idVal},
			beforeSend: function(){
				s("#recall-loading-icon").src = "../../resources/images/loading.gif";
			},

			success: function(data){
				//数据返回成功后
				//前端遍历后台数据输出到页面
				//调用 recallUser()
				//loading 图标隐藏（src = ""）
				//弹出层隐藏
			}
		});
		
	})

	//----------------- 撤回用户弹出层功能结束 -------------------

})