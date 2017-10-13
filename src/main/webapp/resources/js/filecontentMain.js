//jquery 1.9.1模块不符合 AMD 格式所以需要自定义
require.config({
	shim:{
		'jquery.min':{
			exports: '$'
		}

	}

})
//login页 Main函数
require(["jquery.min","overborwserEvent"],function main($,EventUntil){

	function s(elemStr){
		return document.querySelector(elemStr);
	}

	function ss(elemStr){
		return document.querySelectorAll(elemStr)
	}

	function initPage(){
		var links = ss(".download-link a"),
        previewLinks = ss(".boost-preview-file"),
        previewCountNum = s("#review-count"),
        fileTotal = s("#all-file-count"),
        downloadcountNum = s("#downloadfile-count");


	    downloadcountNum.innerText = links.length;
	    previewCountNum.innerText = previewLinks.length;
	    fileTotal.innerText = links.length;

        if (previewLinks.length == 0) {
            s("#review-area").style.display = 'none';
        }
	}

    function previewLinkClick(event){
        //先去除其他按钮的类名
        for (var i = 0; i < ss(".boost-preview-file").length; i++) {
            ss(".boost-preview-file")[i].className = "btn btn-default boost-preview-file";
        }
        //再为当前点击的按钮添加活动样式
        this.className = "btn btn-default boost-preview-file boost-preview-file-active";
        var path = this.getAttribute("data-src");
        s("#review-area").src = path

    }

    

    function initBtnClick(){
        if (ss(".boost-preview-file").length != 0) {
            //为每一个预览按钮绑定点击事件
            for (var i = 0; i < ss(".boost-preview-file").length; i++) {
                EventUntil.addHandler(ss(".boost-preview-file")[i],"click",previewLinkClick);
            }

             //初始化时 第一个按钮模拟点击
            ss(".boost-preview-file")[0].click();
        }
    }


    //初始化可预览和可下载数量
    initPage();
    initBtnClick();

})