<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>文件内容</title>
    <style type="text/css">

    </style>
</head>
<body>

<%--作者:${filecontent.author}<br>--%>
<%--上传时间:${filecontent.uptime}<<br>--%>
<%--标题:${filecontent.title}<br>--%>
<%--点击下载:<br>--%>
<%--<ul>--%>
<%--<p>需要预览的文档内容</p>--%>
<%--<c:forEach items="${filecontent.fileItems}" var="ff">--%>
    <%--<c:if test="${ff.showing!=0}">--%>
        <%--<li>文件名:${ff.filename}</li>--%>
        <%--&lt;%&ndash;<li>是否显示:1显示,0不显示:${ff.showing}</li>&ndash;%&gt;--%>
        <%--<li>文件类型:${ff.prefix}</li>--%>
        <%--<li>文档位置:${ff.position}</li>--%>
        <%--<a href="${filecontent.filepath}/${ff.filename}">文件链接</a>--%>
    <%--</c:if>--%>
<%--</c:forEach>--%>
<%--</ul>--%>

<%--<p> 下载链接</p>--%>
<%--<ul>--%>
    <%--<c:forEach items="${filecontent.fileItems}" var="ff">--%>
        <%--<a href="${filecontent.filepath}/${ff.filename}">${ff.filename}</a>--%>
    <%--</c:forEach>--%>
<%--</ul>--%>

<div class="wrapper">
    <div class="content-info">
        <p>作者：${filecontent.author}</p>
        <p>标题：${filecontent.title}</p>
        <p>上传时间：${filecontent.uptime}</p> 
    </div>
    <div class="preview-content">
        <p><b id="review-count"></b>个文件可预览,共<b id="all-file-count"></b>个文件</p>
        <c:forEach items="${filecontent.fileItems}" var="ff">
            <c:if test="${ff.showing!=0}">
                <li>文件名:${ff.filename}</li>
                <!-- <li>是否显示:1显示,0不显示:${ff.showing}</li> -->
                <li>文件类型:${ff.prefix}</li>
                <!-- <li>文档位置:${ff.position}</li> -->
                <a href="${filecontent.filepath}/${ff.filename}">
                    <span class="glyphicon glyphicon-paperclip"></span> 
                    链接
                </a>
            </c:if>
            
        </c:forEach>
    </div>
    <div class="download-link">
        <p>可下载链接，共<b id="downloadfile-count"></b>个文件可下载</p>
        <c:forEach items="${filecontent.fileItems}" var="ff">
            <a href="${filecontent.filepath}/${ff.filename}">
                <span class="glyphicon glyphicon-download-alt"></span> 
                ${ff.filename}
            </a>
        </c:forEach>
    </div>
</div>


<!-- <a href="http://blog.csdn.net/tandesir/article/details/7598544">HTML嵌入多媒体对象</a> -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/filecontent.css">

<script type="text/javascript">
    var links = document.querySelectorAll(".download-link a"),
        previewLinks = document.querySelectorAll(".preview-content a"),
        previewCountNum = document.querySelector("#review-count"),
        fileTotal = document.querySelector("#all-file-count"),
        downloadcountNum = document.querySelector("#downloadfile-count");



    downloadcountNum.innerText = links.length;
    previewCountNum.innerText = previewLinks.length;
    fileTotal.innerText = links.length;
</script>
</body>
</html>