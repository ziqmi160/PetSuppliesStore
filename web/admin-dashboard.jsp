<%-- Document : admin-dashboard Created on : Jun 16, 2025, 12:05:00 AM Author : haziq --%>

    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                    rel="stylesheet" />
                <link href="css/style.css" rel="stylesheet" />
                <title>Admin Dashboard - iDea</title>

                <style>
                    /* Admin Dashboard Specific Styles */
                    .admin-hero {
                        background: linear-gradient(135deg, #2f2f2f 0%, #3b5d50 100%);
                        padding: calc(4rem - 30px) 0 4rem 0;
                        position: relative;
                        overflow: hidden;
                    }

                    .admin-hero::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: url('images/furniture2.jpg') center/cover;
                        opacity: 0.1;
                        z-index: 1;
                    }

                    .admin-hero .container {
                        position: relative;
                        z-index: 2;
                    }

                    .admin-hero h1 {
                        font-weight: 700;
                        color: #ffffff;
                        margin-bottom: 20px;
                        font-size: 3rem;
                    }

                    .admin-hero p {
                        color: rgba(255, 255, 255, 0.9);
                        font-size: 1.1rem;
                        margin-bottom: 30px;
                    }

                    .admin-sidebar {
                        background: #2f2f2f;
                        color: #ffffff;
                        height: 100vh;
                        position: fixed;
                        left: 0;
                        top: 0;
                        width: 280px;
                        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
                        z-index: 1000;
                        transition: all 0.3s ease;
                    }

                    .admin-sidebar .sidebar-header {
                        padding: 2rem 1.5rem;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                        text-align: center;
                    }

                    .admin-sidebar .sidebar-header h3 {
                        color: #ffffff;
                        font-weight: 600;
                        margin: 0;
                        font-size: 1.5rem;
                    }

                    .admin-sidebar .nav-link {
                        color: rgba(255, 255, 255, 0.8);
                        padding: 1rem 1.5rem;
                        display: flex;
                        align-items: center;
                        border-left: 3px solid transparent;
                        transition: all 0.3s ease;
                        font-weight: 500;
                    }

                    .admin-sidebar .nav-link:hover,
                    .admin-sidebar .nav-link.active {
                        background: rgba(59, 93, 80, 0.2);
                        border-left-color: #3b5d50;
                        color: #ffffff;
                        transform: translateX(5px);
                    }

                    .admin-sidebar .nav-link i {
                        width: 20px;
                        margin-right: 12px;
                        font-size: 1.1rem;
                    }

                    .admin-content {
                        margin-left: 280px;
                        min-height: 100vh;
                        background: #eff2f1;
                    }

                    .admin-header {
                        background: #ffffff;
                        padding: 1rem 0;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        position: sticky;
                        top: 0;
                        z-index: 999;
                    }

                    .admin-header .navbar-brand {
                        color: #2f2f2f !important;
                        font-size: 1.5rem;
                        font-weight: 600;
                    }

                    .admin-header .welcome-text {
                        color: #6a6a6a;
                        font-weight: 500;
                    }

                    .dashboard-section {
                        padding: 3rem 0;
                    }

                    .stats-card {
                        background: #ffffff;
                        border-radius: 15px;
                        padding: 2rem;
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                        transition: all 0.3s ease;
                        border: none;
                        position: relative;
                        overflow: hidden;
                    }

                    .stats-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 4px;
                        background: linear-gradient(90deg, #3b5d50, #2f2f2f);
                    }

                    .stats-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                    }

                    .stats-card .card-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin-bottom: 1.5rem;
                        font-size: 1.5rem;
                        color: #ffffff;
                    }

                    .stats-card.products .card-icon {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    }

                    .stats-card.categories .card-icon {
                        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                    }

                    .stats-card.orders .card-icon {
                        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    }

                    .stats-card.customers .card-icon {
                        background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                    }

                    .stats-card h5 {
                        color: #2f2f2f;
                        font-weight: 600;
                        margin-bottom: 0.5rem;
                        font-size: 1.25rem;
                    }

                    .stats-card .stats-number {
                        font-size: 2.5rem;
                        font-weight: 700;
                        color: #3b5d50;
                        margin-bottom: 0.5rem;
                    }

                    .stats-card p {
                        color: #6a6a6a;
                        margin-bottom: 1.5rem;
                        font-size: 0.9rem;
                    }

                    .stats-card .btn {
                        border-radius: 25px;
                        padding: 0.5rem 1.5rem;
                        font-weight: 500;
                        transition: all 0.3s ease;
                    }

                    .stats-card .btn-primary {
                        background: #3b5d50;
                        border-color: #3b5d50;
                    }

                    .stats-card .btn-primary:hover {
                        background: #2f2f2f;
                        border-color: #2f2f2f;
                        transform: translateY(-2px);
                    }

                    .welcome-banner {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: #ffffff;
                        border-radius: 15px;
                        padding: 2rem;
                        margin-bottom: 3rem;
                        position: relative;
                        overflow: hidden;
                    }

                    .welcome-banner::before {
                        content: '';
                        position: absolute;
                        top: -50%;
                        right: -50%;
                        width: 200%;
                        height: 200%;
                        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/><circle cx="10" cy="60" r="0.5" fill="white" opacity="0.1"/><circle cx="90" cy="40" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                        opacity: 0.3;
                    }

                    .welcome-banner h4 {
                        font-weight: 600;
                        margin-bottom: 0.5rem;
                        position: relative;
                        z-index: 1;
                    }

                    .welcome-banner p {
                        margin: 0;
                        opacity: 0.9;
                        position: relative;
                        z-index: 1;
                    }

                    .quick-actions {
                        background: #ffffff;
                        border-radius: 15px;
                        padding: 2rem;
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                        margin-top: 2rem;
                    }

                    .quick-actions h5 {
                        color: #2f2f2f;
                        font-weight: 600;
                        margin-bottom: 1.5rem;
                        display: flex;
                        align-items: center;
                    }

                    .quick-actions h5 i {
                        margin-right: 0.5rem;
                        color: #3b5d50;
                    }

                    .action-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                        gap: 1rem;
                    }

                    .action-item {
                        background: #f8f9fa;
                        border-radius: 10px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        border: 2px solid transparent;
                    }

                    .action-item:hover {
                        background: #ffffff;
                        border-color: #3b5d50;
                        transform: translateY(-3px);
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                    }

                    .action-item i {
                        font-size: 2rem;
                        color: #3b5d50;
                        margin-bottom: 1rem;
                    }

                    .action-item h6 {
                        color: #2f2f2f;
                        font-weight: 600;
                        margin-bottom: 0.5rem;
                    }

                    .action-item p {
                        color: #6a6a6a;
                        font-size: 0.85rem;
                        margin: 0;
                    }

                    @media (max-width: 768px) {
                        .admin-sidebar {
                            transform: translateX(-100%);
                        }

                        .admin-content {
                            margin-left: 0;
                        }

                        .admin-hero h1 {
                            font-size: 2rem;
                        }

                        .stats-card .stats-number {
                            font-size: 2rem;
                        }
                    }
                </style>
            </head>

            <body>
                <% Admin admin=(Admin) session.getAttribute("admin"); if (admin==null) {
                    response.sendRedirect("admin-login.jsp"); return; } %>

                    <!-- Admin Sidebar -->
                    <div class="admin-sidebar">
                        <div class="sidebar-header">
                            <h3><i class="fas fa-cube me-2"></i>iDea Admin</h3>
                        </div>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="admin-dashboard.jsp">
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
                                <a class="nav-link" href="AdminCategoryServlet">
                                    <i class="fas fa-th-list"></i> Categories
                                </a>
                            </li>
                            <li class="nav-item mt-auto">
                                <a class="nav-link" href="LogoutServlet?role=admin">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Admin Content -->
                    <div class="admin-content">
                        <!-- Admin Header -->
                        <div class="admin-header">
                            <div class="container-fluid">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <h1 class="navbar-brand mb-0">Admin Dashboard</h1>
                                    </div>
                                    <div class="col-auto">
                                        <span class="welcome-text">
                                            <i class="fas fa-user-circle me-2"></i>
                                            Welcome, <%= admin.getName() %>!
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Hero Section -->
                        <div class="admin-hero">
                            <div class="container">
                                <div class="row align-items-center">
                                    <div class="col-lg-8">
                                        <h1>Welcome to iDea Admin</h1>
                                        <p>Manage your store, products, orders, and customers with ease. Everything you
                                            need to run your business is right here.</p>
                                    </div>
                                    <div class="col-lg-4 text-center">
                                        <i class="fas fa-chart-line"
                                            style="font-size: 4rem; color: rgba(255,255,255,0.3);"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Dashboard Content -->
                        <div class="dashboard-section">
                            <div class="container">
                                <!-- Welcome Banner -->
                                <div class="welcome-banner">
                                    <h4><i class="fas fa-star me-2"></i>Hello, <%= admin.getName() %>!</h4>
                                    <p>Welcome to your iDea Admin Dashboard. Use the tools below to manage your store
                                        effectively.</p>
                                </div>

                                <!-- Statistics Cards -->
                                <div class="row">
                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card products">
                                            <div class="card-icon">
                                                <i class="fas fa-box-open"></i>
                                            </div>
                                            <div class="stats-number">X</div>
                                            <h5>Total Products</h5>
                                            <p>Manage your product inventory</p>
                                            <a href="AdminProductServlet" class="btn btn-primary">
                                                <i class="fas fa-arrow-right me-1"></i>Manage Products
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card categories">
                                            <div class="card-icon">
                                                <i class="fas fa-th-list"></i>
                                            </div>
                                            <div class="stats-number">W</div>
                                            <h5>Categories</h5>
                                            <p>Organize your products</p>
                                            <a href="AdminCategoryServlet" class="btn btn-primary">
                                                <i class="fas fa-arrow-right me-1"></i>Manage Categories
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card orders">
                                            <div class="card-icon">
                                                <i class="fas fa-shopping-bag"></i>
                                            </div>
                                            <div class="stats-number">Y</div>
                                            <h5>Total Orders</h5>
                                            <p>Track customer orders</p>
                                            <a href="AdminOrderServlet" class="btn btn-primary">
                                                <i class="fas fa-arrow-right me-1"></i>View Orders
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-lg-3 col-md-6 mb-4">
                                        <div class="stats-card customers">
                                            <div class="card-icon">
                                                <i class="fas fa-users"></i>
                                            </div>
                                            <div class="stats-number">Z</div>
                                            <h5>Customers</h5>
                                            <p>Manage customer accounts</p>
                                            <a href="AdminCustomerServlet" class="btn btn-primary">
                                                <i class="fas fa-arrow-right me-1"></i>View Customers
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <!-- Quick Actions -->
                                <div class="quick-actions">
                                    <h5><i class="fas fa-bolt"></i>Quick Actions</h5>
                                    <div class="action-grid">
                                        <div class="action-item">
                                            <i class="fas fa-plus-circle"></i>
                                            <h6>Add Product</h6>
                                            <p>Create a new product listing</p>
                                        </div>
                                        <div class="action-item">
                                            <i class="fas fa-tags"></i>
                                            <h6>Add Category</h6>
                                            <p>Create a new product category</p>
                                        </div>
                                        <div class="action-item">
                                            <i class="fas fa-chart-bar"></i>
                                            <h6>View Reports</h6>
                                            <p>Check sales and analytics</p>
                                        </div>
                                        <div class="action-item">
                                            <i class="fas fa-cog"></i>
                                            <h6>Settings</h6>
                                            <p>Configure store settings</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="js/bootstrap.bundle.min.js"></script>
                    <script src="js/tiny-slider.js"></script>
                    <script src="js/custom.js"></script>
            </body>

            </html>