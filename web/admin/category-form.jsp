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
                            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                            font-family: 'Inter', sans-serif;
                            min-height: 100vh;
                        }

                        .admin-sidebar {
                            background: linear-gradient(180deg, #2f2f2f 0%, #3b5d50 100%);
                            color: #fff;
                            height: 100vh;
                            position: fixed;
                            left: 0;
                            top: 0;
                            width: 280px;
                            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                            z-index: 1000;
                            transition: all 0.3s ease;
                        }

                        .admin-sidebar .sidebar-header {
                            padding: 2rem 1.5rem;
                            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                            text-align: center;
                            background: rgba(255, 255, 255, 0.05);
                        }

                        .admin-sidebar .sidebar-header h3 {
                            color: #fff;
                            font-weight: 700;
                            margin: 0;
                            font-size: 1.5rem;
                            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
                        }

                        .admin-sidebar .nav-link {
                            color: rgba(255, 255, 255, 0.9);
                            padding: 1rem 1.5rem;
                            display: flex;
                            align-items: center;
                            border-left: 4px solid transparent;
                            transition: all 0.3s ease;
                            font-weight: 500;
                            margin: 0.25rem 1rem;
                            border-radius: 8px;
                        }

                        .admin-sidebar .nav-link:hover,
                        .admin-sidebar .nav-link.active {
                            background: rgba(255, 255, 255, 0.1);
                            border-left-color: #fff;
                            color: #fff;
                            transform: translateX(5px);
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                        }

                        .admin-sidebar .nav-link i {
                            width: 20px;
                            margin-right: 12px;
                            font-size: 1.1rem;
                        }

                        .admin-content {
                            margin-left: 280px;
                            min-height: 100vh;
                            padding: 2rem;
                        }

                        .page-header {
                            background: #fff;
                            border-radius: 20px;
                            padding: 2rem;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                            margin-bottom: 2rem;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                        }

                        .page-header h1 {
                            color: #2f2f2f;
                            font-weight: 700;
                            margin-bottom: 0.5rem;
                            font-size: 2rem;
                        }

                        .page-header p {
                            color: #6a6a6a;
                            margin: 0;
                            font-size: 1.1rem;
                        }

                        .form-container {
                            background: #fff;
                            border-radius: 20px;
                            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                            overflow: hidden;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                        }

                        .form-header {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #fff;
                            padding: 2rem;
                            text-align: center;
                            position: relative;
                            overflow: hidden;
                        }

                        .form-header::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            bottom: 0;
                            background: url('../images/furniture2.jpg') center/cover;
                            opacity: 0.1;
                            z-index: 1;
                        }

                        .form-header h2 {
                            position: relative;
                            z-index: 2;
                            font-weight: 700;
                            margin: 0;
                            font-size: 1.8rem;
                        }

                        .form-header p {
                            position: relative;
                            z-index: 2;
                            margin: 0.5rem 0 0 0;
                            opacity: 0.9;
                            font-size: 1rem;
                        }

                        .form-body {
                            padding: 3rem;
                        }

                        .form-group {
                            margin-bottom: 2rem;
                        }

                        .form-label {
                            color: #2f2f2f;
                            font-weight: 600;
                            margin-bottom: 0.75rem;
                            font-size: 1rem;
                            display: flex;
                            align-items: center;
                        }

                        .form-label i {
                            margin-right: 0.5rem;
                            color: #3b5d50;
                            font-size: 1.1rem;
                        }

                        .form-control {
                            border: 2px solid #e9ecef;
                            border-radius: 12px;
                            padding: 1rem 1.25rem;
                            font-size: 1rem;
                            transition: all 0.3s ease;
                            background: #f8f9fa;
                            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
                        }

                        .form-control:focus {
                            border-color: #3b5d50;
                            box-shadow: 0 0 0 0.2rem rgba(59, 93, 80, 0.15), inset 0 2px 4px rgba(0, 0, 0, 0.05);
                            background: #fff;
                            transform: translateY(-1px);
                        }

                        .form-text {
                            color: #6a6a6a;
                            font-size: 0.875rem;
                            margin-top: 0.5rem;
                        }

                        .btn {
                            padding: 0.75rem 1.5rem;
                            border-radius: 12px;
                            font-weight: 600;
                            text-decoration: none;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            transition: all 0.3s ease;
                            border: none;
                            font-size: 0.9rem;
                            cursor: pointer;
                        }

                        .btn-primary {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #fff;
                        }

                        .btn-primary:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 8px 25px rgba(59, 93, 80, 0.3);
                        }

                        .btn-secondary {
                            background: #6c757d;
                            color: #fff;
                        }

                        .btn-secondary:hover {
                            background: #5a6268;
                            transform: translateY(-2px);
                        }

                        .alert {
                            border-radius: 12px;
                            border: none;
                            padding: 1rem 1.5rem;
                            margin-bottom: 2rem;
                        }

                        .alert-danger {
                            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                            color: #721c24;
                        }

                        @media (max-width: 768px) {
                            .admin-sidebar {
                                transform: translateX(-100%);
                            }

                            .admin-content {
                                margin-left: 0;
                            }

                            .form-body {
                                padding: 2rem;
                            }

                            .btn {
                                width: 100%;
                                justify-content: center;
                                margin-bottom: 0.5rem;
                            }
                        }
                    </style>
                </head>

                <body>
                    <%-- Security Check: Ensure admin is logged in --%>
                        <% Admin admin=(Admin) session.getAttribute("admin"); if (admin==null) {
                            response.sendRedirect("../admin-login.jsp"); return; } %>

                            <div class="admin-sidebar">
                                <div class="sidebar-header">
                                    <h3><i class="fas fa-cube me-2"></i>iDea Admin</h3>
                                </div>
                                <ul class="nav flex-column">
                                    <li class="nav-item">
                                        <a class="nav-link" href="<%= request.getContextPath() %>/admin-dashboard.jsp">
                                            <i class="fas fa-tachometer-alt"></i> Dashboard
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="AdminProductServlet">
                                            <i class="fas fa-box-open"></i> Products
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="AdminOrderServlet">
                                            <i class="fas fa-shopping-bag"></i> Orders
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="AdminCustomerServlet">
                                            <i class="fas fa-users"></i> Customers
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" href="AdminCategoryServlet">
                                            <i class="fas fa-th-list"></i> Categories
                                        </a>
                                    </li>
                                    <li class="nav-item mt-auto">
                                        <a class="nav-link"
                                            href="<%= request.getContextPath() %>/LogoutServlet?role=admin">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="admin-content">
                                <%-- Retrieve category object if editing, otherwise it's null for adding --%>
                                    <% Category category=(Category) request.getAttribute("category"); String
                                        formAction="add" ; String submitButtonText="Add Category" ; String
                                        pageTitle="Add New Category" ; String
                                        pageDescription="Create a new category for your product catalog" ; if (category
                                        !=null) { formAction="update" ; submitButtonText="Update Category" ;
                                        pageTitle="Edit Category: " + category.getCategoryName();
                                        pageDescription="Modify category information and details" ; } %>

                                        <!-- Page Header -->
                                        <div class="page-header">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h1><i class="fas fa-th-list me-2"></i>
                                                        <%= pageTitle %>
                                                    </h1>
                                                    <p>
                                                        <%= pageDescription %>
                                                    </p>
                                                </div>
                                                <a href="AdminCategoryServlet" class="btn btn-secondary">
                                                    <i class="fas fa-arrow-left"></i>Back to Categories
                                                </a>
                                            </div>
                                        </div>

                                        <%-- Display error messages --%>
                                            <% String error=(String) request.getAttribute("error"); if (error !=null &&
                                                !error.isEmpty()) { %>
                                                <div class="alert alert-danger alert-dismissible fade show"
                                                    role="alert">
                                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                                    <%= error %>
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                            aria-label="Close"></button>
                                                </div>
                                                <% } %>

                                                    <div class="form-container">
                                                        <div class="form-header">
                                                            <h2><i class="fas fa-th-list me-2"></i>
                                                                <%= pageTitle %>
                                                            </h2>
                                                            <p>Fill in the category details below</p>
                                                        </div>

                                                        <div class="form-body">
                                                            <form action="AdminCategoryServlet" method="post">
                                                                <% if (category !=null) { %>
                                                                    <input type="hidden" name="action" value="update">
                                                                    <input type="hidden" name="categoryId"
                                                                        value="<%= category.getCategoryId() %>">
                                                                    <% } else { %>
                                                                        <input type="hidden" name="action" value="add">
                                                                        <% } %>

                                                                            <div class="form-group">
                                                                                <label for="categoryName"
                                                                                    class="form-label">
                                                                                    <i class="fas fa-tag"></i>Category
                                                                                    Name *
                                                                                </label>
                                                                                <input type="text" class="form-control"
                                                                                    id="categoryName"
                                                                                    name="categoryName"
                                                                                    value="<%= category != null ? category.getCategoryName() : "" %>"
                                                                                    required>
                                                                                <div class="form-text">
                                                                                    <i
                                                                                        class="fas fa-info-circle me-1"></i>Enter
                                                                                    a
                                                                                    descriptive name for the
                                                                                    category.
                                                                                </div>
                                                                            </div>

                                                                            <div class="d-flex gap-3">
                                                                                <button type="submit"
                                                                                    class="btn btn-primary">
                                                                                    <i class="fas fa-save"></i>
                                                                                    <%= submitButtonText %>
                                                                                </button>
                                                                                <a href="AdminCategoryServlet"
                                                                                    class="btn btn-secondary">
                                                                                    <i class="fas fa-times"></i>Cancel
                                                                                </a>
                                                                            </div>
                                                            </form>
                                                        </div>
                                                    </div>
                            </div>

                            <script src="../js/bootstrap.bundle.min.js"></script>
                            <script src="../js/tiny-slider.js"></script>
                            <script src="../js/custom.js"></script>
                </body>

                </html>