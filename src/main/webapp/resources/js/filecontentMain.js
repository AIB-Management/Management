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

	function initPageNum(){
		var links = ss(".download-link a"),
        previewLinks = ss(".preview-content a"),
        previewCountNum = s("#review-count"),
        fileTotal = s("#all-file-count"),
        downloadcountNum = s("#downloadfile-count");


	    downloadcountNum.innerText = links.length;
	    previewCountNum.innerText = previewLinks.length;
	    fileTotal.innerText = links.length;
	}

    function previewLinkClick(event){
    	event = EventUntil.getEvent(event);
    	EventUntil.preventDefault(event);

    	//获得a 标签的href 内容
    	var src = this.href;

    	var frame = document.querySelector("#file-content");
    	frame.src = src;

    	$("#floor").fadeIn(300);
    }

    for (var i = 0; i < ss(".preview-content a").length; i++) {
    	EventUntil.addHandler(ss(".preview-content a")[i],"click",previewLinkClick);
    }


    EventUntil.addHandler(s("#filecontent-close-btn"),"click",function(){
    	$("#floor").fadeOut('300');
    })

})