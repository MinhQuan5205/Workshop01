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
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .login-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .login-title {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
                font-size: 28px;
                font-weight: 600;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                color: #555;
                font-weight: 500;
                font-size: 14px;
            }

            .form-input {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                font-size: 16px;
                transition: all 0.3s ease;
                background-color: #f8f9fa;
            }

            .form-input:focus {
                outline: none;
                border-color: #667eea;
                background-color: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .login-btn {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
            }

            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            }

            .login-btn:active {
                transform: translateY(0);
            }

            .error-message {
                color: #e74c3c;
                background-color: #fdf2f2;
                padding: 12px;
                border-radius: 8px;
                border-left: 4px solid #e74c3c;
                margin-top: 20px;
                font-size: 14px;
                animation: shake 0.5s ease-in-out;
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }

            .login-form {
                width: 100%;
            }

            @media (max-width: 480px) {
                .login-container {
                    margin: 20px;
                    padding: 30px 25px;
                }
                
                .login-title {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="projectDashboard.jsp"/>
            </c:when>
            <c:otherwise>
                <div class="login-container">
                    <h2 class="login-title">Login</h2>
                    <form class="login-form" action="MainController" method="post">
                        <input type="hidden" name="action" value="login"/>
                        
                        <div class="form-group">
                            <label class="form-label" for="username">User Name</label>
                            <input class="form-input" type="text" id="username" name="strUserName" required/>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label" for="password">Password</label>
                            <input class="form-input" type="password" id="password" name="strPassword" required/>
                        </div>
                        
                        <input class="login-btn" type="submit" value="Login"/>
                    </form>
                    
                    <c:if test="${not empty requestScope.errorMessage}">
                        <div class="error-message">${requestScope.errorMessage}</div>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>