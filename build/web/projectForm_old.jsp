<%-- 
    Document   : projectForm
    Created on : Jun 25, 2025, 8:01:44 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isFounder" value="${currentUser.role eq 'Founder'}"/>
<c:set var="isEdit" value="${not empty requestScope.isEdit}"/>  
<c:set var="project" value="${requestScope.project}"/>
<c:set var="checkError" value="${requestScope.checkError}"/>
<c:set var="message" value="${requestScope.message}"/>
<c:set var="keyword" value="${requestScope.keyword}"/>
<c:set var="pNameErr" value="${requestScope.pNameErr}"/>
<c:set var="desErr" value="${requestScope.desErr}"/>
<c:set var="statusErr" value="${requestScope.statusErr}"/>
<c:set var="lDateErr" value="${requestScope.lDateErr}"/>
<c:set var="selectedStatus" value="${isEdit ? project.status : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Form Register</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${isFounder}">
                <a href="projectDashboard.jsp">← Back to Products</a>
                <h1>
                    <c:choose>
                        <c:when test="${isEdit}">EDIT PROJECT</c:when>
                        <c:otherwise>ADD PROJECT</c:otherwise>
                    </c:choose>
                </h1>

                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="${isEdit ? 'updateProject' : 'addProject'}" />

                    <label>Project Name:</label><br/>
                    <c:if test="${not empty pNameErr}">
                        <p style="color: red;">${pNameErr}</p>
                    </c:if>
                    <input type="text" id="projectName" name="projectName" required="required"
                           value="${not empty project ? project.project_Name : ''}"
                           <c:if test="${isEdit}">readonly</c:if> />

                    <br/>
                    <label>Description:</label><br/>
                    <c:if test="${not empty desErr}">
                        <p style="color: red;">${desErr}</p>
                    </c:if>
                    <textarea id="description" name="description"
                            placeholder="Enter project description..."
                            <c:if test="${isEdit}">readonly</c:if>>${not empty project ? project.description : ''}
                    </textarea>
                              
                    <br/>
                    <c:if test="${not empty statusErr}">
                        <p style="color: red;">${statusErr}</p>
                    </c:if>
                    <label>Status:</label><br/>   
                    <select name="status" id="status" required>
                        <option value="" <c:if test="${empty selectedStatus}">selected</c:if>>-- Select status --</option>
                        <option value="Ideation" <c:if test="${selectedStatus == 'Ideation'}">selected</c:if>>Ideation</option>
                        <option value="Development" <c:if test="${selectedStatus == 'Development'}">selected</c:if>>Development</option>
                        <option value="Launch" <c:if test="${selectedStatus == 'Launch'}">selected</c:if>>Launch</option>
                        <option value="Scaling" <c:if test="${selectedStatus == 'Scaling'}">selected</c:if>>Scaling</option>
                    </select>
                    
                    <br/>
                    <label>Estimated Launch Date:</label><br/>
                    <c:if test="${not empty lDateErr}">
                        <p style="color: red;">${lDateErr}</p>
                    </c:if>
                    <input type="text" id="launchDate" name="launchDate" 
                           value="${isEdit ? project.estimated_launchString: ''}"
                           <c:if test="${isEdit}">readonly</c:if>/>
                    
                        
                    <br/>
                    <input type="hidden" name="keyword" value="${not empty keyword ? keyword : ''}" />
                    <input type="hidden" name="project_id" value="${project.project_Id}"/>
                    <input type="submit" value="${isEdit ? 'Update Project' : 'Add Project'}"/>
                    <input type="reset" value="Reset"/>    

                    
                    <c:if test="${not empty checkError}">
                        <p style="color: red;">${checkError}</p>
                    </c:if>
                        
                    <c:if test="${not empty message}">
                        <p style="color: green;">${message}</p>
                    </c:if>

                </form>
            </c:when>
            <c:otherwise>
                    <div class="header">
                        <h1>ACCESS DENIED</h1>
                    </div>
                    <div class="access-denied">
                        You do not have permission to access the Project Form. Only founder can manage project.
                    </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>
