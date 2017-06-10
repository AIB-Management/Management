<%@ page import="com.gdaib.pojo.VFileInfo" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gdaib.pojo.FileCustom" %>
<%@ page import="com.gdaib.pojo.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>内容页</title>
</head>
<body>
<% FileCustom fileCustom = (FileCustom) request.getAttribute("fileCustom");

%>
作者:${fileCustom.author}<br>
上传时间:${fileCustom.file.uptime}<<br>
标题:${fileCustom.file.title}<br>
点击下载:<br>
<ul>

	<% List<HashMap<String,Object>> fileItems = (List<HashMap<String,Object>>)request.getAttribute("fileItems");
		for (HashMap<String,Object> map:fileItems){
		    out.println(
		            "<li><a href='"+map.get("url")+"'>"+map.get("filename")+"</a></li>"

			);
		}
	%>
	<%
		for (HashMap<String,Object> map:fileItems){
			out.println(
					"<li><a href='javascript:' onclick=\"window.open('"+map.get("url")+"')>"+map.get("filename")+"</a></li>"

			);
		}
	%>
</ul>
<a href="http://blog.csdn.net/tandesir/article/details/7598544">HTML嵌入多媒体对象</a>

</body>
</html>