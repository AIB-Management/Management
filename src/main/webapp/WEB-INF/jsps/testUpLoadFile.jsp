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
    账号:<input type="text" name="accuid" value="835b8a58-f545-41ef-97b4-a561ef72c7d4"><<br>
    账号:<input type="text" name="navuid" value="1"><<br>
    标题:<input type="text" name="title"></br>
    <input type="file" name="file"><br>
    <input type="file" name="file"><br>
    <input type="submit"><<br>
</form>
</body>
</html>
