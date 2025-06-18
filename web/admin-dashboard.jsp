<%-- 
    Document   : admin-dashboard
    Created on : Jun 16, 2025, 12:05:00 AM
    Author     : haziq
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.idea.model.Admin" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images/favicon.png" />

    <meta name="description" content="Admin Dashboard for iDea Store" />
    <meta name="keywords" content="admin, dashboard, ecommerce" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>Admin Dashboard - iDea</title>

    <style>
        body {
            background-color: #f8f9fa; /* Light background */
            font-family: 'Inter', sans-serif; /* Consistent font */
        }
        .admin-header {
            background-color: #2f2f2f;
            color: #ffffff;
            padding: 15px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .admin-header .navbar-brand {
            color: #ffffff !important;
            font-size: 24px;
            font-weight: bold;
        }
        .admin-header .nav-link {
            color: #ffffff !important;
            opacity: 0.8;
            transition: opacity 0.3s ease;
        }
        .admin-header .nav-link:hover {
            opacity: 1;
        }
        .sidebar {
            background-color: #343a40; /* Darker sidebar */
            color: #ffffff;
            height: 100vh;
            padding-top: 20px;
            position: fixed;
            left: 0;
            top: 0;
            width: 250px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar .nav-link {
            color: #ffffff;
            padding: 10px 20px;
            display: block;
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: #495057;
            border-left-color: #3b5d50; /* Accent color */
            color: #ffffff;
        }
        .content {
            margin-left: 250px; /* Offset content by sidebar width */
            padding: 30px;
        }
        .card {
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .card-header {
            background-color: #3b5d50;
            color: #ffffff;
            font-weight: bold;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        .welcome-section {
            background-color: #d1e7dd; /* Light green background */
            border-left: 5px solid #28a745;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .footer {
            margin-top: 50px;
            padding: 20px;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <%-- Security Check: Ensure admin is logged in --%>
    <% Admin admin = (Admin) session.getAttribute("admin");
       if (admin == null) {
           response.sendRedirect("admin-login.jsp");
           return; // Stop execution
       }
    %>

    <div class="sidebar">
        <h3 class="text-center mb-4">iDea Admin</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="admin-dashboard.jsp">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="AdminProductServlet">
                    <i class="fas fa-box-open me-2"></i> Products
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-shopping-bag me-2"></i> Orders
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-users me-2"></i> Customers
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-th-list me-2"></i> Categories
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet?role=admin">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>

    <div class="content">
        <div class="admin-header fixed-top" style="margin-left: 250px;">
            <div class="container-fluid d-flex justify-content-between align-items-center">
                <h1 class="navbar-brand mb-0">Dashboard</h1>
                <span>Welcome, <%= admin.getName() %>!</span>
            </div>
        </div>
        
        <div class="container-fluid mt-5 pt-4"> <%-- Added margin-top and padding-top to avoid overlap with fixed header --%>
            <div class="welcome-section">
                <h4>Hello, <%= admin.getName() %>!</h4>
                <p>Welcome to your iDea Admin Dashboard. Use the sidebar to navigate and manage your store.</p>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">Products</div>
                        <div class="card-body">
                            <h5 class="card-title">X Total Products</h5> <%-- Placeholder --%>
                            <p class="card-text">Manage your product catalog.</p>
                            <a href="#" class="btn btn-primary btn-sm">Go to Products</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">Orders</div>
                        <div class="card-body">
                            <h5 class="card-title">Y Pending Orders</h5> <%-- Placeholder --%>
                            <p class="card-text">View and process customer orders.</p>
                            <a href="#" class="btn btn-primary btn-sm">Go to Orders</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">Customers</div>
                        <div class="card-body">
                            <h5 class="card-title">Z Registered Customers</h5> <%-- Placeholder --%>
                            <p class="card-text">Manage your customer accounts.</p>
                            <a href="#" class="btn btn-primary btn-sm">Go to Customers</a>
                        </div>
                    </div>
                </div>
            </div>
            <%-- More content areas can be added here --%>
        </div>
    </div>

    <div class="footer">
        <p>iDea Admin &copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %></p>
    </div>

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script> <%-- Keep if custom.js uses it --%>
    <script src="js/custom.js"></script>
</body>
</html>

