<%@ page import="com.gdaib.pojo.VFileInfo" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>内容页</title>
</head>
<body>
<% VFileInfo vFileInfo = (VFileInfo) request.getAttribute("fileInfo");

%>
老师:${fileInfo.name}<br>
时间:${fileInfo.upTime}<br>
标题:${fileInfo.title}<br>
点击下载:<br>
<ul>
	<% List<HashMap<String,Object>> fileNames = (List<HashMap<String,Object>>)request.getAttribute("fileNames");
		for (HashMap<String,Object> map:fileNames){
		    out.println(
		            "<li><a href='"+map.get("url")+"'>"+map.get("filename")+"</a></li>"

			);
		}
	%>

</ul>


</body>
</html>