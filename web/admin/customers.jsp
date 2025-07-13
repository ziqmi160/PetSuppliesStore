<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.idea.model.Admin" %>
        <%@ page import="com.idea.model.User" %>
            <%@ page import="java.util.List" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="author" content="Untree.co" />
                    <link rel="shortcut icon" href="../images/favicon.png" />

                    <meta name="description" content="Admin Customer Management" />
                    <meta name="keywords" content="admin, customer, management, ecommerce" />

                    <!-- Bootstrap CSS -->
                    <link href="css/bootstrap.min.css" rel="stylesheet" />
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                        rel="stylesheet" />
                    <link href="css/style.css" rel="stylesheet" />
                    <title>Customer Management - iDea Admin</title>

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

                        .customers-table {
                            background: #fff;
                            border-radius: 20px;
                            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                            overflow: hidden;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                        }

                        .table-header {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #fff;
                            padding: 2rem;
                            text-align: center;
                            position: relative;
                            overflow: hidden;
                        }

                        .table-header::before {
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

                        .table-header h2 {
                            position: relative;
                            z-index: 2;
                            font-weight: 700;
                            margin: 0;
                            font-size: 1.8rem;
                        }

                        .table-header p {
                            position: relative;
                            z-index: 2;
                            margin: 0.5rem 0 0 0;
                            opacity: 0.9;
                            font-size: 1rem;
                        }

                        .table-responsive {
                            margin: 0;
                        }

                        .table th {
                            background: #f8f9fa;
                            border: none;
                            padding: 1.5rem 2rem;
                            font-weight: 600;
                            color: #2f2f2f;
                            border-bottom: 2px solid #e9ecef;
                            font-size: 1rem;
                        }

                        .table td {
                            padding: 1.5rem 2rem;
                            border: none;
                            border-bottom: 1px solid #e9ecef;
                            vertical-align: middle;
                            font-size: 1rem;
                        }

                        .table tbody tr:hover {
                            background: #f8f9fa;
                            transform: translateY(-1px);
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                            transition: all 0.3s ease;
                        }

                        .action-buttons {
                            display: flex;
                            gap: 0.75rem;
                            flex-wrap: wrap;
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

                        .btn-edit {
                            background: #ffc107;
                            color: #2f2f2f;
                            border: none;
                        }

                        .btn-edit:hover {
                            background: #e0a800;
                            transform: translateY(-2px);
                            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
                        }

                        .btn-delete {
                            background: #dc3545;
                            color: #fff;
                            border: none;
                        }

                        .btn-delete:hover {
                            background: #c82333;
                            transform: translateY(-2px);
                            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
                        }

                        .empty-state {
                            text-align: center;
                            padding: 4rem 2rem;
                            color: #6a6a6a;
                        }

                        .empty-state i {
                            font-size: 4rem;
                            color: #dee2e6;
                            margin-bottom: 1rem;
                        }

                        .empty-state h3 {
                            color: #2f2f2f;
                            margin-bottom: 0.5rem;
                        }

                        .empty-state p {
                            margin-bottom: 2rem;
                        }

                        .status-badge {
                            padding: 0.5rem 1rem;
                            border-radius: 20px;
                            font-size: 0.875rem;
                            font-weight: 600;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                        }

                        .status-active {
                            background: #d4edda;
                            color: #155724;
                        }

                        .status-inactive {
                            background: #f8d7da;
                            color: #721c24;
                        }

                        .user-avatar {
                            width: 40px;
                            height: 40px;
                            border-radius: 50%;
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: #fff;
                            font-weight: 600;
                            font-size: 1rem;
                        }

                        .user-info {
                            display: flex;
                            align-items: center;
                            gap: 1rem;
                        }

                        .user-details h6 {
                            margin: 0;
                            font-weight: 600;
                            color: #2f2f2f;
                        }

                        .user-details small {
                            color: #6a6a6a;
                            font-size: 0.875rem;
                        }

                        @media (max-width: 768px) {
                            .admin-sidebar {
                                transform: translateX(-100%);
                            }

                            .admin-content {
                                margin-left: 0;
                            }

                            .action-buttons {
                                flex-direction: column;
                            }

                            .btn {
                                width: 100%;
                                justify-content: center;
                            }

                            .table-responsive {
                                font-size: 0.875rem;
                            }

                            .table th,
                            .table td {
                                padding: 1rem;
                            }

                            .user-info {
                                flex-direction: column;
                                align-items: flex-start;
                                gap: 0.5rem;
                            }
                        }
                    </style>
                </head>

                <body>
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
                                    <a class="nav-link active" href="AdminCustomerServlet">
                                        <i class="fas fa-users"></i> Customers
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="AdminCategoryServlet">
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

                        <div class="admin-content">
                            <div class="page-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h1><i class="fas fa-users me-2"></i>Customer Management</h1>
                                        <p>Manage your customer accounts, view their information, and maintain customer
                                            relationships.</p>
                                    </div>
                                    <a href="AdminCustomerServlet?action=showAddForm" class="btn btn-primary">
                                        <i class="fas fa-plus"></i>Add New Customer
                                    </a>
                                </div>
                            </div>

                            <% String message=(String) request.getParameter("message"); if (message !=null &&
                                !message.isEmpty()) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert"
                                    style="border-radius: 12px; margin-bottom: 2rem;">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <%= message %>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                </div>
                                <% } %>

                                    <div class="customers-table">
                                        <div class="table-header">
                                            <h2><i class="fas fa-users me-2"></i>Customers List</h2>
                                            <p>Manage and organize your customer accounts</p>
                                        </div>

                                        <div class="table-responsive">
                                            <% List<User> customers = (List<User>) request.getAttribute("customers");
                                                    if (customers != null && !customers.isEmpty()) { %>
                                                    <table class="table table-hover mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                                                <th><i class="fas fa-user me-2"></i>Customer</th>
                                                                <th><i class="fas fa-envelope me-2"></i>Email</th>
                                                                <th><i class="fas fa-phone me-2"></i>Phone</th>
                                                                <th><i class="fas fa-map-marker-alt me-2"></i>Address</th>
                                                                <th><i class="fas fa-cogs me-2"></i>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (User customer : customers) { %>
                                                                <tr>
                                                                    <td><strong>#<%= customer.getId() %></strong>
                                                                    </td>
                                                                    <td>
                                                                        <div class="user-info">
                                                                            <div class="user-avatar">
                                                                                <%= customer.getUsername().substring(0,
                                                                                    1).toUpperCase() %>
                                                                            </div>
                                                                            <div class="user-details">
                                                                                <h6>
                                                                                    <%= customer.getUsername() %>
                                                                                </h6>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <i class="fas fa-envelope me-2"
                                                                                style="color: #3b5d50;"></i>
                                                                            <span>
                                                                                <%= customer.getEmail() %>
                                                                            </span>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <i class="fas fa-phone me-2"
                                                                                style="color: #3b5d50;"></i>
                                                                            <span>
                                                                                <%= customer.getPhone() != null && !customer.getPhone().isEmpty() ? customer.getPhone() : "No phone" %>
                                                                            </span>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <i class="fas fa-map-marker-alt me-2"
                                                                                style="color: #3b5d50;"></i>
                                                                            <span>
                                                                                <%= customer.getAddress() != null ? customer.getAddress() : "No address" %>
                                                                            </span>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="action-buttons">
                                                                            <a href="AdminCustomerServlet?action=showEditForm&id=<%= customer.getId() %>"
                                                                                class="btn btn-edit"
                                                                                title="Edit Customer">
                                                                                <i class="fas fa-edit"></i>Edit
                                                                            </a>
                                                                            <form action="AdminCustomerServlet"
                                                                                method="post" style="display: inline;"
                                                                                onsubmit="return confirm('Are you sure you want to delete <%= customer.getUsername() %>? This action cannot be undone.');">
                                                                                <input type="hidden" name="action"
                                                                                    value="delete">
                                                                                <input type="hidden" name="userId"
                                                                                    value="<%= customer.getId() %>">
                                                                                <button type="submit"
                                                                                    class="btn btn-delete"
                                                                                    title="Delete Customer">
                                                                                    <i class="fas fa-trash"></i>Delete
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                        </tbody>
                                                    </table>
                                                    <% } else { %>
                                                        <div class="empty-state">
                                                            <i class="fas fa-users"></i>
                                                            <h3>No Customers Found</h3>
                                                            <p>You haven't registered any customers yet. Start by adding
                                                                your first customer account.</p>
                                                            <a href="AdminCustomerServlet?action=showAddForm"
                                                                class="btn btn-primary">
                                                                <i class="fas fa-plus"></i>Add Your First Customer
                                                            </a>
                                                        </div>
                                                        <% } %>
                                        </div>
                                    </div>
                        </div>

                        <script src="../js/bootstrap.bundle.min.js"></script>
                        <script src="../js/tiny-slider.js"></script>
                        <script src="../js/custom.js"></script>
                </body>

                </html>