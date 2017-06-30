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
        <button type="button" class="close" aria-label="Close"><span id="filecontent-close-btn" aria-hidden="true">&times;</span></button>
    </div>
    <iframe src="" id="file-content"></iframe>
</div>
<div class="wrapper">
    <div class="content-info">
        <h3>标题：${filecontent.title}</h3>
        <h4>作者：${filecontent.author}</h4>
        <h4>上传时间：
            <%--${filecontent.uptime}--%>
            <fmt:formatDate value="${filecontent.uptime}" pattern="yyyy年MM月dd日"/>
        </h4>
    </div>
    <div class="preview-content">
        <p><b id="review-count"></b>个文件可预览,共<b id="all-file-count"></b>个文件</p>
        <c:forEach items="${filecontent.fileItems}" var="ff">
            <c:if test="${ff.showing!=0}">
                <li>文件名:${ff.filename}</li>
                <!-- <li>是否显示:1显示,0不显示:${ff.showing}</li> -->
                <!--<li>文件类型:${ff.prefix}</li>-->

                <c:if test="${ff.prefix=='.swf' || ff.prefix=='.pdf'}">
                    <embed width="737" height="602" src="${filecontent.filepath}/${ff.filename}" type="${ff.datatype}" play="true" loop="true" menu="true"></embed>
                </c:if>

                <c:if test="${ff.prefix=='.png' || ff.prefix=='.jpg' || ff.prefix=='.gif' || ff.prefix=='.jpeg'}">
                    <img src="${filecontent.filepath}/${ff.filename}" width="737" alt="${ff.filename}"/>
                </c:if>

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