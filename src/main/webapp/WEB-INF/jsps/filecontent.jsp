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

作者:${filecontent.author}<br>
上传时间:${filecontent.uptime}<<br>
标题:${filecontent.title}<br>
点击下载:<br>
<ul>
    <p>需要预览的文档内容</p>
    <c:forEach items="${filecontent.fileItems}" var="ff">
        <c:if test="${ff.showing!=0}">
            <li>文件名:${ff.filename}</li>
            <%--<li>是否显示:1显示,0不显示:${ff.showing}</li>--%>
            <li>文件类型:${ff.prefix}</li>
            <li>文档位置:${ff.position}</li>
            <a href="${filecontent.filepath}/${ff.filename}">文件链接</a>
        </c:if>
    </c:forEach>
</ul>

<p> 下载链接</p>
<ul>
    <c:forEach items="${filecontent.fileItems}" var="ff">
        <a href="${filecontent.filepath}/${ff.filename}">${ff.filename}</a>
    </c:forEach>
</ul>
<!-- <a href="http://blog.csdn.net/tandesir/article/details/7598544">HTML嵌入多媒体对象</a> -->

</body>
</html>