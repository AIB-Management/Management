define(["jquery.min","overborwserEvent"],function($,EventUntil){
	var dividePage = {
		//整理未审核用户数据
		//将后台 json 字符串转换为 dom 元素
		createUnexamieTable: function(dataList,obj){
			/*
				{
					tableElemForUnexamie: //未审核用户的表格
					passBtnHandler: //通过按钮点击执行的函数
					refuseBtnHandler: //拒绝按钮点击执行的函数
				}
			*/
			//清空元素
			obj.tableElemForUnexamie.innerHTML = "";
			//创建元素碎片收集器
			var frag = document.createDocumentFragment();
			//获取所有信息列
			var dataList = obj.dataList.extend.page.list;

			//创建多选框
			var checkBox = document.createElement("input");
			checkBox.type = "checkbox";

			//创建通过按钮
			var passBtn = document.createElement("button");
			var passBtnIcon = document.createElement("span");
			passBtnIcon.innerText = " ";
			passBtnIcon.className = "glyphicon glyphicon-ok";
			passBtnIcon.setAttribute("aria-hidden", "true");
			//为按钮添加图标
			passBtn.appendChild(passBtnIcon);
			
			//创建拒绝按钮
			var refuseBtn = document.createElement("button");
			var refuseBtnIcon = document.createElement("span");
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
				var tr = document.createElement("tr");
				//创建一个多选框包裹元素 td
				var checkBoxTd = document.createElement("td");
				var btnClone = checkBox.cloneNode(true);
				checkBoxTd.appendChild(btnClone);
				//tr 添加checkBoxTd
				tr.appendChild(checkBoxTd);

				//创建一个教师姓名包裹 td
				var userTd = document.createElement("td");
				userTd.innerText = dataList[i].username;
				userTd.title = dataList[i].id;
				tr.appendChild(userTd);

				//创建一个系别包裹 td
				var departmentTd = document.createElement("td");
				departmentTd.innerText = dataList[i].department;
				tr.appendChild(departmentTd);

				//创建一个专业包裹 td
				var professionTd = document.createElement("td");
				professionTd.innerText = dataList[i].profession;
				tr.appendChild(professionTd);

				//创建一个按钮包裹 td
				var btnTd = document.createElement("td");
				var passBtnClone = passBtn.cloneNode(true);
				var refuseBtnClone = refuseBtn.cloneNode(true);

				btnTd.appendChild(passBtnClone);
				btnTd.appendChild(refuseBtnClone);
				//为按钮绑定事件
				EventUntil.addHandler(passBtnClone,"click",obj.passBtnHandler);
				EventUntil.addHandler(refuseBtnClone,"click",obj.refuseBtnHandler);

				tr.appendChild(btnTd);



				frag.appendChild(tr);
			}

			obj.tableElemForUnexamie.appendChild(frag);
		},
		// //创建表格方法，接收两个参数，dom元素集以及dom元素的载体
		// createTable: function(elemList,tableElem){
		// 	//清空表格
		// 	tableElem.innerHTML = "";
		// 	//dom元素载体添加dom元素
		// 	tableElem.appendChild(elemList);
		// },

		// toPage: function(obj){
		// 	//toPage 方法，执行的时候需要调用创建表格方法和创建分页导航方法
		// 	/*
		// 		{
		// 			url: //点击分页导航的时候发送给后台的地址,
		// 			pn: //传入的分页数字,
		// 			createTableHandler: //创建表格方法引用,
		// 			createTableArgs: //创建表格所需的参数,
		// 			createPageNav: //创建分页导航方法引用,
		// 			createPageNavArgs: //创建分页导航所需的参数
					
		// 		}
		// 	*/
		// 	var that = this;
		// 	$.ajax({
		// 		url: obj.url,
		// 		type: 'GET',
		// 		async: false,
		// 		dataType: 'json',
		// 		data: "pn=" + obj.pn,
		// 		success: function(data){
		// 			//发送一个页面请求
		// 			//调用输出表格数据的方法引用
		// 			obj.createTableHandler.call(this, obj.createTableArgs);
		// 			//调用输出分页导航的方法引用
		// 			obj.createPageNav.call(this, obj.createPageNavArgs);

		// 		}
		// 	})
		// },


		//创建分页导航方法
		//传入原始数据，分页导航的载体
		//创建分页导航方法
		//传入原始数据，分页导航的载体
		//需要的数据：
		//原始的json 数据，分页导航的内容载体，分页导航点击触发的跳转页面方法
		//分页跳转的方法需(that.toPage)要参数（url,pn页数,loadingElem加载中显示的元素,contentElem加载完成之后显示的元素）
		createPageNav: function(orData,obj){
			//传入两个参数
			//orData: 当前数据
			/*	obj 参数里面的属性
				{
					paginationElem: //分页导航载体,

					createTableHandlerInTrunPage: //创建表格方法,

					createTableArgs: //创建表格所需的参数,

					createPageNavInTrunPage: //创建分页导航方法,

					createPageArgs: //创建分页导航所需参数
					
				}
			*/

			var that = this;

			obj.paginationElem.innerHTML = "";
			//获取参数的分页数的数据
			var pageList = obj.orData.extend.page.navigatepageNums;
			//创建元素碎片收集器
			var frag = document.createDocumentFragment();

			//先创建首页，向前翻页，向后翻页，到末页按钮
			//1、创建回首页按钮
			var homePageBtn = document.createElement("li");
			var homePageBtnContent = document.createElement("a");
			homePageBtnContent.href = "#";
			homePageBtnContent.setAttribute("aria-label", "homepage");
			homePageBtnContent.innerText = "首页";
			homePageBtn.appendChild(homePageBtnContent);

			//2、创建向前翻页按钮
			var prevPageBtn = document.createElement("li");
			var prevPageBtnContent = document.createElement("a");
			

			prevPageBtnContent.href = "#";
			prevPageBtnContent.setAttribute("aria-label", "homepage");
			prevPageBtnContent.innerHTML = "&laquo;";

			prevPageBtn.appendChild(prevPageBtnContent);

			//如果当前后台返回的信息表示没有首页
			//则禁用首页按钮和向前翻页按钮 并且不为他们绑定点击事件
			if (obj.orData.extend.page.hasPreviousPage == false) {
				homePageBtn.className = "disabled";
				prevPageBtn.className = "disabled";
			}else{

				//如果有前一页
				//点击上一页按钮的时候 就是当前页 -1
				//data.extend.page.pageNum 表示当前页
				EventUntil.addHandler(prevPageBtn,"click",function(){
					$.ajax({
						url: obj.url,
						type: 'GET',
						dataType: 'json',
						data: "pn=" + obj.pn,
						success: function(data){
							
						}
					})
					
				});

				//点击返回首页的时候 就是跳到总页数的第一页
				//即传 1进去就可以了
				EventUntil.addHandler(homePageBtn,"click",function(){
					
				});
			}

			frag.appendChild(homePageBtn);
			frag.appendChild(prevPageBtn);



			//3、创建向后翻页按钮
			var nextPageBtn = document.createElement("li");
			var nextPageBtnContent = document.createElement("a");

			nextPageBtnContent.href = "#";
			nextPageBtnContent.setAttribute("aria-label", "homepage");
			nextPageBtnContent.innerHTML = "&raquo;";

			nextPageBtn.appendChild(nextPageBtnContent);


			//4、创建回到末页按钮
			var lastPageBtn = document.createElement("li");
			var lastPageBtnContent = document.createElement("a");

			lastPageBtnContent.href = "#";
			lastPageBtnContent.setAttribute("aria-label", "homepage");
			lastPageBtnContent.innerText = "末页";

			lastPageBtn.appendChild(lastPageBtnContent);

			//如果当前后台返回的信息表示没有末页
			//则禁用末页按钮和向后翻页按钮 并且不为他们绑定点击事件
			if (obj.orData.extend.page.hasNextPage == false) {
				nextPageBtn.className = "disabled";
				lastPageBtn.className = "disabled";
			}else{
				//否则给他们都绑定点击事件
				//下一页按钮就是当前页+1
				//data.extend.page.pageNum 表示当前页
				EventUntil.addHandler(nextPageBtn,"click",function(){
					that.toPage({
						url: obj.url,
						pn: data.extend.page.pageNum + 1,
						//分页方法中的输出表格数据方法引用
						createTableHandler: obj.createTableHandlerForPageNav,
						createTableArgs: obj.createTableArgsForPageNav,
						createPageNav: obj.createPageNavForPageNav,
						createPageNavArgs: obj.createPageNavArgsForPageNav
					});
				})

				//末页按钮就直接跳到页数的总数位置
				//data.extend.page.pages 表示页的总数 即最后一页
				EventUntil.addHandler(lastPageBtn,"click",function(){
					that.toPage({
						url: obj.url,
						pn: data.extend.page.pages,
						//分页方法中的输出表格数据方法引用
						createTableHandler: obj.createTableHandlerForPageNav,
						createTableArgs: obj.createTableArgsForPageNav,
						createPageNav: obj.createPageNavForPageNav,
						createPageNavArgs: obj.createPageNavArgsForPageNav
					});
				})
			}


			//5、遍历创建数字分页按钮
			for (var i = 0; i < pageList.length; i++) {
				var numLi = document.createElement("li");
				var numLiIcon = document.createElement("a");
				numLiIcon.href = "#";
				numLiIcon.innerText = pageList[i];
				numLi.appendChild(numLiIcon);

				if (pageList[i] == obj.orData.extend.page.pageNum) {

					numLi.className = "active";
				}
				//为每个分页数字按钮添加事件
				(function(num){
					EventUntil.addHandler(numLi,"click",function(){

					})
				})(pageList[i]);

				frag.appendChild(numLi);
			}

			frag.appendChild(nextPageBtn);
			frag.appendChild(lastPageBtn);
			
			//分页导航添加全部分页按钮元素
			obj.paginationElem.appendChild(frag);
		}

		

		
	};

	return dividePage;
})