<%-- 
    Document   : projectDashboard.jsp
    Created on : Jun 22, 2025, 5:04:20 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isFounder" value="${currentUser.role eq 'Founder'}" />
<c:set var="keyword" value="${requestScope.keyword}" />
<c:set var="projectList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasProjects" value="${not empty projectList}" />
<c:set var="projectCount" value="${fn:length(projectList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page Project Dashboard</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not isLoggedIn}">
                <c:redirect url="login.jsp" />
            </c:when>
            <c:otherwise>
                <h1>Welcome ${currentUser.name}</h1>
                <a href="MainController?action=logout">Logout</a>

                <c:choose>
                    <c:when test="${isFounder}">

                        <label>Search Project Name</label>
                        <form action="ProjectController" method="post" >
                            <input type="hidden" name="action" value="searchProject"/>
                            <input type="text" name="keyword" value="${keywordParam}" 
                                   placeholder="Enter project name..."/>
                            <input type="submit" value="Search"/>
                        </form>

                        <a href="projectForm.jsp">Add new Project</a>

                        <c:choose>
                            <c:when test="${hasProjects and projectCount == 0}">
                                No projects have names that match the keyword !
                            </c:when>
                            <c:when test="${hasProjects and projectCount > 0}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Project Name</th>
                                            <th>Description</th>
                                            <th>Status</th>
                                            <th>Estimated_launch</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="project" items="${projectList}">
                                            <tr>
                                                <td>${project.project_Name}</td>
                                                <td>${project.description}</td>
                                                <td>${project.status}</td>
                                                <td><fmt:formatDate value="${project.estimated_launch}" pattern="yyyy-MM-dd"/></td>
                                                <td> 
                                                    <form action="MainController" method="post" >
                                                        <input type="hidden" name="action" value="editProject"/>
                                                        <input type="hidden" name="project_Id" value="${project.project_Id}"/>
                                                        <input type="hidden" name="keyword" value="${keywordParam}"/>
                                                        <input type="submit" value="Edit"/>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table> 
                            </c:when>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Project Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Estimated_launch</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="project" items="${sessionScope.projectsListMember}">
                                    <tr>
                                        <td>${project.project_Name}</td>
                                        <td>${project.description}</td>
                                        <td>${project.status}</td>
                                        <td>${project.estimated_launch}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </body>
</html>
