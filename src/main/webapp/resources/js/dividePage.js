define(["jquery.min"],function($){
	var dividePage = {
		//整理未审核用户数据，将数据变成元素
		rangeUnexamieData: function(dataList){
			var checkBox = document.createElement("input");
			checkBox.type = "checkbox";

			var passBtn = document.createElement("button");
			var passBtnIcon = document.createElement("span");
			passBtnIcon.className = "glyphicon glyphicon-ok";

			var refuseBtn = document.createElement("button");
			var refuseBtnIcon = document.createElement("span");
			refuseBtnIcon.className = "glyphicon glyphicon-minus-sign";

			passBtn.className = "pass btn btn-success btn-sm";
			refuseBtn.className = "refuse btn btn-danger btn-sm";

			passBtn

			for (var i = 0; i < dataList.length; i++) {
				
			}
		},
		//创建表格方法，接收两个参数，原始数据和数据载体
		createTable: function(data,tableElem){
			//获取保存内容的数组
			var contentList = data.extend.list;
		}
	};

	return dividePage;
})