<%-- Document : category-form Created on : Jun 16, 2025, 1:06:45 AM Author : haziq --%>

    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ page import="com.idea.model.Admin" %>
            <%@ page import="com.idea.model.Category" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="author" content="Untree.co" />
                    <link rel="shortcut icon" href="../images/favicon.png" />

                    <meta name="description" content="Admin Category Form" />
                    <meta name="keywords" content="admin, category, form, ecommerce" />

                    <!-- Bootstrap CSS -->
                    <link href="../css/bootstrap.min.css" rel="stylesheet" />
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                        rel="stylesheet" />
                    <link href="../css/style.css" rel="stylesheet" />
                    <title>Category Form - iDea Admin</title>

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
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
                            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                        }

                        .sidebar .nav-link {
                            color: #ffffff;
                            padding: 10px 20px;
                            display: block;
                            border-left: 3px solid transparent;
                            transition: all 0.3s ease;
                        }

                        .sidebar .nav-link:hover,
                        .sidebar .nav-link.active {
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
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                            margin-bottom: 25px;
                        }

                        .card-header {
                            background-color: #3b5d50;
                            color: #ffffff;
                            font-weight: bold;
                            border-top-left-radius: 8px;
                            border-top-right-radius: 8px;
                        }

                        .form-control:focus {
                            border-color: #3b5d50;
                            box-shadow: 0 0 0 0.2rem rgba(59, 93, 80, 0.25);
                        }

                        .btn-primary {
                            background-color: #3b5d50;
                            border-color: #3b5d50;
                        }

                        .btn-primary:hover {
                            background-color: #2f2f2f;
                            border-color: #2f2f2f;
                        }

                        .btn-secondary {
                            background-color: #6c757d;
                            border-color: #6c757d;
                        }

                        .btn-secondary:hover {
                            background-color: #5a6268;
                            border-color: #545b62;
                        }
                    </style>
                </head>

                <body>
                    <%-- Security Check: Ensure admin is logged in --%>
                        <% Admin admin=(Admin) session.getAttribute("admin"); if (admin==null) {
                            response.sendRedirect("../admin-login.jsp"); return; } %>

                            <div class="sidebar">
                                <h3 class="text-center mb-4">iDea Admin</h3>
                                <ul class="nav flex-column">
                                    <li class="nav-item">
                                        <a class="nav-link" href="../admin-dashboard.jsp">
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
                                        <a class="nav-link active" href="AdminCategoryServlet">
                                            <i class="fas fa-th-list me-2"></i> Categories
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="../LogoutServlet?role=admin">
                                            <i class="fas fa-sign-out-alt me-2"></i> Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="content">
                                <div class="admin-header fixed-top" style="margin-left: 250px;">
                                    <div class="container-fluid d-flex justify-content-between align-items-center">
                                        <h1 class="navbar-brand mb-0">
                                            <% Category category=(Category) request.getAttribute("category"); if
                                                (category !=null) { %>
                                                Edit Category
                                                <% } else { %>
                                                    Add New Category
                                                    <% } %>
                                        </h1>
                                        <span>Welcome, <%= admin.getName() %>!</span>
                                    </div>
                                </div>

                                <div class="container-fluid mt-5 pt-4">
                                    <%-- Display error messages --%>
                                        <% String error=(String) request.getAttribute("error"); if (error !=null &&
                                            !error.isEmpty()) { %>
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                <%= error %>
                                                    <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                        aria-label="Close"></button>
                                            </div>
                                            <% } %>

                                                <div class="row justify-content-center">
                                                    <div class="col-md-8">
                                                        <div class="card">
                                                            <div class="card-header">
                                                                <% if (category !=null) { %>
                                                                    Edit Category
                                                                    <% } else { %>
                                                                        Add New Category
                                                                        <% } %>
                                                            </div>
                                                            <div class="card-body">
                                                                <form action="AdminCategoryServlet" method="post">
                                                                    <% if (category !=null) { %>
                                                                        <input type="hidden" name="action"
                                                                            value="update">
                                                                        <input type="hidden" name="categoryId"
                                                                            value="<%= category.getCategoryId() %>">
                                                                        <% } else { %>
                                                                            <input type="hidden" name="action"
                                                                                value="add">
                                                                            <% } %>

                                                                                <div class="mb-3">
                                                                                    <label for="categoryName"
                                                                                        class="form-label">Category Name
                                                                                        *</label>
                                                                                    <input type="text"
                                                                                        class="form-control"
                                                                                        id="categoryName"
                                                                                        name="categoryName"
                                                                                        value="<%= category != null ? category.getCategoryName() : "" %>"
                                                                                        required>
                                                                                    <div class="form-text">Enter a
                                                                                        descriptive name for the
                                                                                        category.</div>
                                                                                </div>

                                                                                <div
                                                                                    class="d-flex justify-content-between">
                                                                                    <a href="AdminCategoryServlet"
                                                                                        class="btn btn-secondary">
                                                                                        <i
                                                                                            class="fas fa-arrow-left me-1"></i>
                                                                                        Back to Categories
                                                                                    </a>
                                                                                    <button type="submit"
                                                                                        class="btn btn-primary">
                                                                                        <% if (category !=null) { %>
                                                                                            <i
                                                                                                class="fas fa-save me-1"></i>
                                                                                            Update Category
                                                                                            <% } else { %>
                                                                                                <i
                                                                                                    class="fas fa-plus me-1"></i>
                                                                                                Add Category
                                                                                                <% } %>
                                                                                    </button>
                                                                                </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                </div>
                            </div>

                            <script src="../js/bootstrap.bundle.min.js"></script>
                            <script src="../js/tiny-slider.js"></script>
                            <script src="../js/custom.js"></script>
                </body>

                </html>