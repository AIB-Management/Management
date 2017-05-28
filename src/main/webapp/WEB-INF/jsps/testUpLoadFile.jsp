<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: mahanzhen
  Date: 17-5-28
  Time: 下午1:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/file/doUploadFile.action" method="post" enctype="multipart/form-data">

    标题:<input type="text" name="title"></br>
    <input type="file" name="file">
    <input type="file" name="file">
    <input type="submit">
</form>
</body>
</html>
