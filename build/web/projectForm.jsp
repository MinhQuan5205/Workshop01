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

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Form Register</title>
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
                text-align: center;
            }

            .header h1 {
                font-size: 28px;
                font-weight: 600;
                margin: 0;
            }

            /* Container */
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            /* Back Link */
            .back-link {
                display: inline-flex;
                align-items: center;
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
                margin-bottom: 20px;
                padding: 10px 15px;
                border-radius: 8px;
                transition: all 0.3s ease;
                background: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .back-link:hover {
                background: #667eea;
                color: white;
                transform: translateX(-5px);
            }

            /* Form Container */
            .form-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }

            .form-title {
                text-align: center;
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: #333;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .form-title.edit {
                color: #e17055;
            }

            .form-title.add {
                color: #00b894;
            }

            /* Form Elements */
            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 600;
                font-size: 16px;
            }

            .form-input, .form-textarea, .form-select {
                width: 100%;
                padding: 15px;
                border: 2px solid #e1e5e9;
                border-radius: 10px;
                font-size: 16px;
                transition: all 0.3s ease;
                background-color: #f8f9fa;
                font-family: inherit;
            }

            .form-input:focus, .form-textarea:focus, .form-select:focus {
                outline: none;
                border-color: #667eea;
                background-color: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .form-textarea {
                min-height: 120px;
                resize: vertical;
            }

            .form-input[readonly], .form-textarea[readonly] {
                background-color: #e9ecef;
                color: #6c757d;
                cursor: not-allowed;
            }

            /* Select Styling */
            .form-select {
                cursor: pointer;
                appearance: none;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 12px center;
                background-repeat: no-repeat;
                background-size: 16px;
                padding-right: 40px;
            }

            /* Error Messages */
            .error-message {
                color: #e74c3c;
                background-color: #fdf2f2;
                padding: 10px 15px;
                border-radius: 8px;
                border-left: 4px solid #e74c3c;
                margin-bottom: 10px;
                font-size: 14px;
                animation: shake 0.5s ease-in-out;
            }

            /* Success Messages */
            .success-message {
                color: #27ae60;
                background-color: #f0fff4;
                padding: 10px 15px;
                border-radius: 8px;
                border-left: 4px solid #27ae60;
                margin-top: 20px;
                font-size: 14px;
                animation: fadeIn 0.5s ease-in-out;
            }

            /* Buttons */
            .button-group {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
            }

            .btn {
                padding: 15px 30px;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            }

            .btn-secondary {
                background: linear-gradient(135deg, #fd79a8 0%, #fdcb6e 100%);
                color: white;
            }

            .btn-secondary:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(253, 121, 168, 0.3);
            }

            /* Access Denied */
            .access-denied-container {
                text-align: center;
                padding: 60px 20px;
            }

            .access-denied {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: 0 auto;
                color: #e74c3c;
                font-size: 18px;
                line-height: 1.6;
            }

            .access-denied h1 {
                font-size: 48px;
                margin-bottom: 20px;
                color: #e74c3c;
            }

            /* Animations */
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .form-container {
                animation: fadeIn 0.6s ease-out;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    padding: 20px 15px;
                }

                .form-container {
                    padding: 30px 20px;
                }

                .form-title {
                    font-size: 24px;
                }

                .button-group {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                }

                .access-denied {
                    padding: 30px 20px;
                }

                .access-denied h1 {
                    font-size: 36px;
                }
            }

            /* Status-specific colors */
            .form-select option[value="Ideation"] {
                color: #3498db;
            }

            .form-select option[value="Development"] {
                color: #f39c12;
            }

            .form-select option[value="Launch"] {
                color: #e74c3c;
            }

            .form-select option[value="Scaling"] {
                color: #27ae60;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${isFounder}">
                <div class="container">
                    <a href="projectDashboard.jsp" class="back-link">← Back to Products</a>
                    
                    <div class="form-container">
                        <h1 class="form-title ${isEdit ? 'edit' : 'add'}">
                            <c:choose>
                                <c:when test="${isEdit}">EDIT PROJECT</c:when>
                                <c:otherwise>ADD PROJECT</c:otherwise>
                            </c:choose>
                        </h1>

                        <form action="MainController" method="post">
                            <input type="hidden" name="action" value="${isEdit ? 'updateProject' : 'addProject'}" />

                            <div class="form-group">
                                <label class="form-label">Project Name:</label>
                                <c:if test="${not empty pNameErr}">
                                    <div class="error-message">${pNameErr}</div>
                                </c:if>
                                <input type="text" id="projectName" name="projectName" required="required"
                                       value="${not empty project ? project.project_Name : ''}"
                                       class="form-input"
                                       <c:if test="${isEdit}">readonly</c:if> />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Description:</label>
                                <c:if test="${not empty desErr}">
                                    <div class="error-message">${desErr}</div>
                                </c:if>
                                <textarea id="description" name="description"
                                        placeholder="Enter project description..."
                                        class="form-textarea"
                                        <c:if test="${isEdit}">readonly</c:if>>${not empty project ? project.description : ''}
                                </textarea>
                            </div>
                                      
                            <div class="form-group">
                                <label class="form-label">Status:</label> 
                                <c:if test="${not empty statusErr}">
                                    <div class="error-message">${statusErr}</div>
                                </c:if>
                                <select name="status" id="status" required class="form-select">
                                    <option value="" <c:if test="${empty project.status}">selected</c:if>>-- Select status --</option>
                                    <option value="Ideation" <c:if test="${project.status == 'Ideation'}">selected</c:if>>Ideation</option>
                                    <option value="Development" <c:if test="${project.status == 'Development'}">selected</c:if>>Development</option>
                                    <option value="Launch" <c:if test="${project.status == 'Launch'}">selected</c:if>>Launch</option>
                                    <option value="Scaling" <c:if test="${project.status == 'Scaling'}">selected</c:if>>Scaling</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">Estimated Launch Date:</label>
                                <c:if test="${not empty lDateErr}">
                                    <div class="error-message">${lDateErr}</div>
                                </c:if>
                                <input type="text" id="launchDate" name="launchDate" 
                                       value="${project.estimated_launchString}"
                                       class="form-input"
                                       placeholder="yyyy-MM-dd"
                                       <c:if test="${isEdit}">readonly</c:if>/>
                            </div>
                            
                            <input type="hidden" name="keyword" value="${not empty keyword ? keyword : ''}" />
                            <input type="hidden" name="project_id" value="${project.project_Id}"/>
                            
                            <div class="button-group">
                                <input type="submit" value="${isEdit ? 'Update Project' : 'Add Project'}" class="btn btn-primary"/>
                                <button type="button" class="btn btn-secondary" onclick="window.location.reload();">Reset</button>    
                            </div>

                            <c:if test="${not empty checkError}">
                                <div class="error-message">${checkError}</div>
                            </c:if>
                                
                            <c:if test="${not empty message}">
                                <div class="success-message">${message}</div>
                            </c:if>

                        </form>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="header">
                    <h1>ACCESS DENIED</h1>
                </div>
                <div class="access-denied-container">
                    <div class="access-denied">
                        You do not have permission to access the Project Form. Only founder can manage project.
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>