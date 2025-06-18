<%-- 
    Document   : products
    Created on : Jun 16, 2025, 1:06:45 AM
    Author     : haziq
--%>

<%@page import="com.idea.model.ProductImage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.idea.model.Admin" %>
<%@ page import="com.idea.model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="../images/favicon.png" /> <%-- Adjusted path for favicon --%>

    <meta name="description" content="Admin Product Management" />
    <meta name="keywords" content="admin, products, management, ecommerce" />

    <!-- Bootstrap CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet" /> <%-- Adjusted path for bootstrap --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" /> <%-- Adjusted path for style --%>
    <title>Product Management - iDea Admin</title>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Inter', sans-serif;
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
            background-color: #343a40;
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
            border-left-color: #3b5d50;
            color: #ffffff;
        }
        .content {
            margin-left: 250px;
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
        .table-responsive {
            margin-top: 20px;
        }
        .product-thumbnail-admin {
            width: 80px; /* Smaller image in admin table */
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        .action-buttons button, .action-buttons a {
            margin-right: 5px;
            margin-bottom: 5px;
            padding: 5px 10px;
            font-size: 0.85em;
            border-radius: 5px;
        }
        .add-product-btn {
            background-color: #2f2f2f;
            color: #ffffff;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .add-product-btn:hover {
            background-color: #3b5d50;
        }
    </style>
</head>
<body>
    <%-- Security Check: Ensure admin is logged in --%>
    <% Admin admin = (Admin) session.getAttribute("admin");
       if (admin == null) {
           response.sendRedirect("../admin-login.jsp");
           return;
       }
    %>

    <div class="sidebar">
        <h3 class="text-center mb-4">iDea Admin</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="../admin-dashboard.jsp"> <%-- Adjusted path --%>
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="AdminProductServlet"> <%-- Current page --%>
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
                <a class="nav-link" href="../LogoutServlet?role=admin"> <%-- Adjusted path --%>
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>

    <div class="content">
        <div class="admin-header fixed-top" style="margin-left: 250px;">
            <div class="container-fluid d-flex justify-content-between align-items-center">
                <h1 class="navbar-brand mb-0">Product Management</h1>
                <span>Welcome, <%= admin.getName() %>!</span>
            </div>
        </div>
        
        <div class="container-fluid mt-5 pt-4">
            <%-- Display messages (success/error) --%>
            <% String message = request.getParameter("message");
               if (message != null && !message.isEmpty()) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            <% String error = (String) request.getAttribute("error");
               if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="d-flex justify-content-end mb-3">
                <a href="AdminProductServlet?action=showAddForm" class="btn add-product-btn">
                    <i class="fas fa-plus me-1"></i> Add New Product
                </a>
            </div>

            <div class="card">
                <div class="card-header">All Products</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Product> products = (List<Product>) request.getAttribute("products");
                                   if (products != null && !products.isEmpty()) {
                                       for (int i = 0; i < products.size(); i++) { // For Java 5 compatibility
                                           Product product = (Product) products.get(i); // Explicit cast
                                %>
                                <tr>
                                    <td><%= product.getId() %></td>
                                    <td>
                                        <% if (product.getImages() != null && !product.getImages().isEmpty()) { %>
                                            <img src="<%= ((ProductImage)product.getImages().get(0)).getPath() %>" 
                                                 alt="<%= product.getName() %>" class="product-thumbnail-admin" onerror="this.onerror=null;this.src='https://placehold.co/80x80/eeeeee/333333?text=No+Img';"/>
                                        <% } else { %>
                                            <img src="https://placehold.co/80x80/eeeeee/333333?text=No+Img" 
                                                 alt="No Image" class="product-thumbnail-admin"/>
                                        <% } %>
                                    </td>
                                    <td><%= product.getName() %></td>
                                    <td><%= product.getCategoryName() != null ? product.getCategoryName() : "N/A" %></td>
                                    <td>RM<%= String.format("%.2f", product.getPrice()) %></td>
                                    <td><%= product.getStockQuantity() %></td>
                                    <td class="action-buttons">
                                        <a href="AdminProductServlet?action=showEditForm&id=<%= product.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                        <form action="AdminProductServlet" method="post" style="display:inline-block;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete <%= product.getName() %>?');">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td colspan="7" class="text-center">No products found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/bootstrap.bundle.min.js"></script> <%-- Adjusted path --%>
    <script src="../js/tiny-slider.js"></script> <%-- Adjusted path --%>
    <script src="../js/custom.js"></script> <%-- Adjusted path --%>
</body>
</html>
