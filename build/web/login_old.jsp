<%-- 
    Document   : login.jsp
    Created on : Jun 22, 2025, 2:39:13 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page Login</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="projectDashboard.jsp"/>
            </c:when>
            <c:otherwise>
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="login"/>
                    UserName : <input type="text" name="strUserName"/><br>
                    Password: <input type="password" name="strPassword"/><br>
                    <input type="submit" value="Login"/>
                </form>
                <c:if test="${not empty requestScope.errorMessage}">
                    <span style="color:red">${requestScope.errorMessage}</span> 
                </c:if>
            </c:otherwise>
        </c:choose>
    </body>
</html>
