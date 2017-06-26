<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<shiro:user>
    <shiro:hasPermission name="admin:query">
        <jsp:forward page="/admin/rootPage.action"/>
    </shiro:hasPermission>
    <shiro:hasPermission name="page:query">
        <jsp:forward page="/content/departmentpage.action"/>
    </shiro:hasPermission>
</shiro:user>
<shiro:notAuthenticated>
    <jsp:forward page="/WEB-INF/jsps/teacher/departmentpage.jsp"/>
</shiro:notAuthenticated>
