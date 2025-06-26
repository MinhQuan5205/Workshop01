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
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                color: #333;
            }

            /* Header Section */
            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px 0;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .welcome-text {
                font-size: 24px;
                font-weight: 600;
            }

            .logout-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 25px;
                transition: all 0.3s ease;
                font-weight: 500;
                border: 1px solid rgba(255, 255, 255, 0.3);
            }

            .logout-btn:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: translateY(-2px);
            }

            /* Main Container */
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            /* Search Section */
            .search-section {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }

            .search-label {
                display: block;
                margin-bottom: 15px;
                font-size: 18px;
                font-weight: 600;
                color: #333;
            }

            .search-form {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }

            .search-input {
                flex: 1;
                min-width: 250px;
                padding: 12px 16px;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .search-btn, .add-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .search-btn:hover, .add-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            .add-btn {
                background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                margin-bottom: 20px;
            }

            .add-btn:hover {
                box-shadow: 0 8px 25px rgba(17, 153, 142, 0.3);
            }

            /* Table Styles */
            .table-container {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .project-table {
                width: 100%;
                border-collapse: collapse;
            }

            .project-table thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .project-table th {
                padding: 20px 15px;
                text-align: left;
                font-weight: 600;
                font-size: 16px;
            }

            .project-table td {
                padding: 15px;
                border-bottom: 1px solid #f0f0f0;
                vertical-align: middle;
            }

            .project-table tbody tr {
                transition: all 0.3s ease;
            }

            .project-table tbody tr:hover {
                background: #f8f9ff;
                transform: scale(1.01);
            }

            .project-table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Status Badges */
            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-transform: uppercase;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background: #f8d7da;
                color: #721c24;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }

            /* Edit Button */
            .edit-form {
                display: inline-block;
            }

            .edit-btn {
                background: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
                color: #2d3436;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .edit-btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(255, 171, 160, 0.4);
            }

            /* No Results Message */
            .no-results {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                color: #666;
                font-size: 18px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .header-content {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                }

                .search-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .search-input {
                    min-width: unset;
                }

                .table-container {
                    overflow-x: auto;
                }

                .project-table {
                    min-width: 600px;
                }

                .container {
                    padding: 20px 15px;
                }
            }

            /* Animation for table loading */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .table-container {
                animation: fadeInUp 0.6s ease-out;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not isLoggedIn}">
                <c:redirect url="login.jsp" />
            </c:when>
            <c:otherwise>
                <!-- Header -->
                <div class="header">
                    <div class="header-content">
                        <h1 class="welcome-text">Welcome ${currentUser.name} !!! </h1>
                        <a href="MainController?action=logout" class="logout-btn">Logout</a>
                    </div>
                </div>

                <!-- Main Container -->
                <div class="container">
                    <c:choose>
                        <c:when test="${isFounder}">
                            <!-- Search Section -->
                            <div class="search-section">
                                <label class="search-label">Search Project Name</label>
                                <form action="ProjectController" method="post" class="search-form">
                                    <input type="hidden" name="action" value="searchProject"/>
                                    <input type="text" name="keyword" value="${keywordParam}" 
                                           placeholder="Enter project name..." class="search-input"/>
                                    <input type="submit" value="Search" class="search-btn"/>
                                </form>
                            </div>

                            <!-- Add Project Button -->
                            <a href="projectForm.jsp" class="add-btn">Add new Project</a>

                            <!-- Projects Table -->
                            <c:choose>
                                <c:when test="${hasProjects and projectCount == 0}">
                                    <div class="no-results">
                                        No projects have names that match the keyword !
                                    </div>
                                </c:when>
                                <c:when test="${hasProjects and projectCount > 0}">
                                    <div class="table-container">
                                        <table class="project-table">
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
                                                        <td><strong>${project.project_Name}</strong></td>
                                                        <td>${project.description}</td>
                                                        <td>
                                                            <span class="status-badge status-active">${project.status}</span>
                                                        </td>
                                                        <td><fmt:formatDate value="${project.estimated_launch}" pattern="yyyy-MM-dd"/></td>
                                                        <td> 
                                                            <form action="MainController" method="post" class="edit-form">
                                                                <input type="hidden" name="action" value="editProject"/>
                                                                <input type="hidden" name="project_Id" value="${project.project_Id}"/>
                                                                <input type="hidden" name="keyword" value="${keywordParam}"/>
                                                                <input type="submit" value="Edit" class="edit-btn"/>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <!-- Member View -->
                            <div class="table-container">
                                <table class="project-table">
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
                                                <td><strong>${project.project_Name}</strong></td>
                                                <td>${project.description}</td>
                                                <td>
                                                    <span class="status-badge status-active">${project.status}</span>
                                                </td>
                                                <td>${project.estimated_launch}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>