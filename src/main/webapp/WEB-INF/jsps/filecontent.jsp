<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>文件内容</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/websiteicon.ico" type="image/vnd.microsoft.icon">
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jsdist/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/jsdist/filecontentMain-min.js"></script>
</head>
<body>
<div id="warning">
        <p>促进互联网水平发展，你我共同有责 :)</p>
        <p>导致这样的问题：<br>1、你使用的浏览器是兼容ie模式 请切换其兼容；<br>2、你的浏览器版本太旧，请点击下面两个图标下载新版本浏览器<br>感谢你的合作</p>
        <p>请使用ie10以上 或 谷歌，360或火狐浏览器登陆此网页</p>
        <p>
            <a href="http://rj.baidu.com/soft/detail/14744.html?ald" class="link-chrome" title="下载谷歌浏览器" target="_blank">
                <img src="${pageContext.request.contextPath}/resources/images/chrome.png" alt="">
            </a>
            <a href="http://rj.baidu.com/soft/detail/11843.html?ald" class="link-firefox" title="下载火狐浏览器" target="_blank">
                <img src="${pageContext.request.contextPath}/resources/images/firefox.png" alt="">
            </a>
        </p>
    </div>
<div class="wrapper">
    <div class="content-info">
        <h3>${filecontent.title}</h3>
        <p>作者：${filecontent.author}</p>
        <p>
            上传时间：
            <fmt:formatDate value="${filecontent.uptime}" pattern="yyyy年MM月dd日"/>
        </p>
    </div>
    <div class="preview-content">
        <p class="periview-list-title">
            <span class="glyphicon glyphicon-tag"></span> 
            <b id="review-count"></b>个文件可预览,共<b id="all-file-count"></b>个文件（如果不能正常显示请更换浏览器或下载后观看）
        </p>
        <c:forEach items="${filecontent.fileItems}" var="ff">
            <c:if test="${ff.showing!=0}">
                
                <button class="btn btn-default boost-preview-file" data-src="${filecontent.url}/${ff.uid}${ff.prefix}" title="${ff.filename}">
                    <span class="glyphicon glyphicon-eye-open"></span> 
                    预览${ff.filename}
                </button>

            </c:if>
        </c:forEach>
        <iframe src="" frameborder="0" id="review-area" name="preview-frame"></iframe>
        <div class="download-link">
        <p>
            <span class="glyphicon glyphicon-tag"></span>
            文件下载链接，共<b id="downloadfile-count"></b>个文件可下载
        </p>
        <shiro:hasPermission name="file:down">
            <c:forEach items="${filecontent.fileItems}" var="ff">
                <a href="${pageContext.request.contextPath}/file/downLoadFile.action?uid=${ff.uid}">
                    <span class="glyphicon glyphicon-download-alt"></span>
                    ${ff.filename}
                </a>
            </c:forEach>
        </shiro:hasPermission>
    </div>
    </div>
    

</div>



<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/cssdist/filecontent-min.css">
<script type="text/javascript">
    
    (function checkBrownser(){
        var agent=navigator.appName //获取浏览器名字
        var version=navigator.appVersion.split(";"); //获取浏览器详细信息
        var trim_Version=version[1].replace(/[ ]/g,"");//获取浏览器版本号
        var model = document.documentMode;
        var floor = document.getElementById("warning");
        var loadingFloor = document.getElementById("loading-file-floor");

        if(agent=="Microsoft Internet Explorer" && (trim_Version=="MSIE7.0" || trim_Version=="MSIE8.0" || trim_Version=="MSIE9.0") || model < 10) { 
            floor.style.display = "block";
        }else{
            floor.style.display = "none";
        }
    }());
    
</script>
</body>
</html>