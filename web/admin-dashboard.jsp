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

                    .admin-header {
                        background: #fff;
                        border-radius: 20px;
                        padding: 2rem;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        margin-bottom: 2rem;
                        border: 1px solid rgba(255, 255, 255, 0.2);
                    }

                    .admin-header .navbar-brand {
                        color: #2f2f2f !important;
                        font-size: 2rem;
                        font-weight: 700;
                    }

                    .admin-header .welcome-text {
                        color: #6a6a6a;
                        font-weight: 500;
                    }

                    .dashboard-section {
                        padding: 0;
                    }

                    .stats-row {
                        margin-bottom: 2rem;
                    }

                    .stats-card {
                        background: #fff;
                        border-radius: 20px;
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                        overflow: hidden;
                        border: 1px solid rgba(255, 255, 255, 0.2);
                        padding: 2rem 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        position: relative;
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

                    .stats-card .card-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin: 0 auto 1.5rem auto;
                        font-size: 2rem;
                        color: #fff;
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
                        background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                        border: none;
                    }

                    .stats-card .btn-primary:hover {
                        background: #2f2f2f;
                        transform: translateY(-2px);
                    }

                    .welcome-banner {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: #fff;
                        border-radius: 20px;
                        padding: 2rem;
                        margin-bottom: 2rem;
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
                        background: url('images/furniture2.jpg') center/cover;
                        opacity: 0.1;
                    }

                    .welcome-banner h4 {
                        font-weight: 700;
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
                        background: #fff;
                        border-radius: 20px;
                        padding: 2rem;
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                        margin-top: 2rem;
                        border: 1px solid rgba(255, 255, 255, 0.2);
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
                        border-radius: 12px;
                        padding: 1.5rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        border: 2px solid transparent;
                        cursor: pointer;
                    }

                    .action-item:hover {
                        background: #fff;
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
                            padding: 1rem;
                        }

                        .admin-header {
                            padding: 1rem;
                        }

                        .stats-card {
                            padding: 1.5rem 1rem;
                        }

                        .welcome-banner {
                            padding: 1.5rem;
                        }

                        .quick-actions {
                            padding: 1.5rem;
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
                                <a class="nav-link active" href="<%= request.getContextPath() %>/admin-dashboard.jsp">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%= request.getContextPath() %>/AdminProductServlet">
                                    <i class="fas fa-box-open"></i> Products
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%= request.getContextPath() %>/AdminOrderServlet">
                                    <i class="fas fa-shopping-bag"></i> Orders
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%= request.getContextPath() %>/AdminCustomerServlet">
                                    <i class="fas fa-users"></i> Customers
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%= request.getContextPath() %>/AdminCategoryServlet">
                                    <i class="fas fa-th-list"></i> Categories
                                </a>
                            </li>
                            <li class="nav-item mt-auto">
                                <a class="nav-link" href="<%= request.getContextPath() %>/LogoutServlet?role=admin">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>

                    <!-- Admin Content -->
                    <div class="admin-content">
                        <!-- Admin Header -->
                        <div class="admin-header d-flex justify-content-between align-items-center mb-4">
                            <div class="navbar-brand mb-0">Admin Dashboard</div>
                            <span class="welcome-text">
                                <i class="fas fa-user-circle me-2"></i>
                                Welcome, <%= admin.getName() %>!
                            </span>
                        </div>

                        <!-- Welcome Banner -->
                        <div class="welcome-banner mb-4">
                            <h4><i class="fas fa-star me-2"></i>Hello, <%= admin.getName() %>!</h4>
                            <p>Welcome to your iDea Admin Dashboard. Use the tools below to manage your store
                                effectively.</p>
                        </div>

                        <!-- Statistics Cards -->
                        <div class="row stats-row">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="stats-card products">
                                    <div class="card-icon"><i class="fas fa-box-open"></i></div>
                                    <div class="stats-number"><i class="fas fa-info-circle"></i></div>
                                    <h5>Total Products</h5>
                                    <p>Product count will appear here soon</p>
                                    <a href="<%= request.getContextPath() %>/AdminProductServlet"
                                        class="btn btn-primary"><i class="fas fa-arrow-right me-1"></i>Manage
                                        Products</a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="stats-card categories">
                                    <div class="card-icon"><i class="fas fa-th-list"></i></div>
                                    <div class="stats-number"><i class="fas fa-info-circle"></i></div>
                                    <h5>Categories</h5>
                                    <p>Category count will appear here soon</p>
                                    <a href="<%= request.getContextPath() %>/AdminCategoryServlet"
                                        class="btn btn-primary"><i class="fas fa-arrow-right me-1"></i>Manage
                                        Categories</a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="stats-card orders">
                                    <div class="card-icon"><i class="fas fa-shopping-bag"></i></div>
                                    <div class="stats-number"><i class="fas fa-info-circle"></i></div>
                                    <h5>Total Orders</h5>
                                    <p>Order count will appear here soon</p>
                                    <a href="<%= request.getContextPath() %>/AdminOrderServlet"
                                        class="btn btn-primary"><i class="fas fa-arrow-right me-1"></i>View Orders</a>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="stats-card customers">
                                    <div class="card-icon"><i class="fas fa-users"></i></div>
                                    <div class="stats-number"><i class="fas fa-info-circle"></i></div>
                                    <h5>Customers</h5>
                                    <p>Customer count will appear here soon</p>
                                    <a href="<%= request.getContextPath() %>/AdminCustomerServlet"
                                        class="btn btn-primary"><i class="fas fa-arrow-right me-1"></i>View
                                        Customers</a>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <!-- Removed quick-actions section as requested -->
                    </div>

                    <script src="js/bootstrap.bundle.min.js"></script>
                    <script src="js/tiny-slider.js"></script>
                    <script src="js/custom.js"></script>
            </body>

            </html>