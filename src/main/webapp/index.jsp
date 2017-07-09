<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<shiro:user>
        <jsp:forward page="/content/relayById.action"/>
</shiro:user>
<shiro:notAuthenticated>
    <jsp:forward page="/WEB-INF/jsps/teacher/departmentpage.jsp"/>
</shiro:notAuthenticated>
