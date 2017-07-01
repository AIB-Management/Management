<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>文件内容</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/filecontentMain.js"></script>
</head>
<body>
<div id="floor">
    <div class="close-btn clearfix">
        <button type="button" id="filecontent-close-btn" class="close" aria-label="Close">×</button>
    </div>
    <iframe src="" id="file-content"></iframe>
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
            <b id="review-count"></b>个文件可预览,共<b id="all-file-count"></b>个文件
        </p>
        <c:forEach items="${filecontent.fileItems}" var="ff">
            <c:if test="${ff.showing!=0}">
                <!-- <p>文件名:${ff.filename}</p> -->
                <!-- <li>是否显示:1显示,0不显示:${ff.showing}</li> -->
                <!-- <p>文件类型:${ff.prefix}</p> -->
                <!-- <li>文档位置:${ff.position}</li> -->
               <!--  <iframe src="${filecontent.filepath}/${ff.filename}" class="review-file-content"></iframe> -->
                <!-- 文件预览标签-->
                <!--
                <c:if test="${ff.prefix=='.swf' || ff.prefix=='.pdf'}">
                    <embed width="737" height="602" src="${filecontent.filepath}/${ff.filename}" type="${ff.datatype}" play="true" loop="true" menu="true"></embed>
                </c:if>

                <c:if test="${ff.prefix=='.png' || ff.prefix=='.jpg' || ff.prefix=='.gif' || ff.prefix=='.jpeg'}">
                    <img src="${filecontent.filepath}/${ff.filename}" width="737" alt="${ff.filename}"/>
                </c:if>
                -->
                <button class="btn btn-default boost-preview-file" data-src="${filecontent.filepath}/${ff.filename}">
                    <span class="glyphicon glyphicon-eye-open"></span> 
                    预览${ff.filename}
                </button>
            </c:if>
        </c:forEach>
        <iframe src="" frameborder="0" id="review-area"></iframe>
    </div>
    <div class="download-link">
        <p>
            <span class="glyphicon glyphicon-tag"></span> 
            文件下载链接，共<b id="downloadfile-count"></b>个文件可下载
        </p>
        <c:forEach items="${filecontent.fileItems}" var="ff">
            <!--
            <a href="${filecontent.filepath}/${ff.filename}">
            -->
            <a href="${pageContext.request.contextPath}/file/downLoadFile.action?uid=${ff.uid}">
                <span class="glyphicon glyphicon-download-alt"></span>
                ${ff.filename}
            </a>
        </c:forEach>
    </div>
</div>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/filecontent.css">

</body>
</html>