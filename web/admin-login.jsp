<%-- 
    Document   : admin-login
    Created on : Jun 16, 2025, 12:04:08 AM
    Author     : haziq
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images/favicon.png" />

    <meta name="description" content="Admin Login Page for iDea Store" />
    <meta name="keywords" content="admin, login, ecommerce, dashboard" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" /> <%-- Your main style.css --%>
    <title>Admin Login - iDea</title>

    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f8f9fa; /* Light background */
        }
        .login-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 30px;
            color: #2f2f2f;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-control {
            border-radius: 5px;
            padding: 12px;
            font-size: 16px;
        }
        .btn-login {
            background-color: #2f2f2f; /* Dark button like your site's theme */
            color: #ffffff;
            border-radius: 5px;
            padding: 12px 20px;
            font-size: 18px;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        .btn-login:hover {
            background-color: #3b5d50; /* A slightly lighter shade on hover */
            color: #ffffff;
        }
        .alert {
            margin-top: 20px;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <%-- Display error message if present --%>
        <% String error = (String) request.getAttribute("error");
           if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger" role="alert">
                <%= error %>
            </div>
        <% } %>

        <form action="AdminLoginServlet" method="post">
            <div class="form-group">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" required placeholder="Enter admin email">
            </div>
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required placeholder="Enter password">
            </div>
            <button type="submit" class="btn btn-login">Login</button>
        </form>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>

