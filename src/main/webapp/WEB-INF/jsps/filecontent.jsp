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
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/require.min.js" defer async="true" data-main="${pageContext.request.contextPath}/resources/js/filecontentMain.js"></script>
</head>
<body>
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
                
                <button class="btn btn-default boost-preview-file" data-src="${filecontent.filepath}/${ff.uid}${ff.prefix}">
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