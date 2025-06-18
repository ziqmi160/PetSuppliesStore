<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.idea.model.Admin" %>
        <%@ page import="com.idea.model.User" %>
            <%@ page import="java.util.List" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Customer Management - iDea Admin</title>
                    <link href="../css/bootstrap.min.css" rel="stylesheet" />
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                        rel="stylesheet" />
                    <link href="../css/style.css" rel="stylesheet" />
                    <style>
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
                            background: url('../images/furniture2.jpg') center/cover;
                            opacity: 0.1;
                            z-index: 1;
                        }

                        .admin-hero .container {
                            position: relative;
                            z-index: 2;
                        }

                        .admin-hero h1 {
                            font-weight: 700;
                            color: #fff;
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
                            color: #fff;
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
                            color: #fff;
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
                            color: #fff;
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
                            background: #fff;
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

                        .content-section {
                            padding: 3rem 0;
                        }

                        .page-header {
                            background: #fff;
                            border-radius: 15px;
                            padding: 2rem;
                            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                            margin-bottom: 2rem;
                        }

                        .page-header h2 {
                            color: #2f2f2f;
                            font-weight: 600;
                            margin-bottom: 0.5rem;
                        }

                        .page-header p {
                            color: #6a6a6a;
                            margin: 0;
                        }

                        .customers-table {
                            background: #fff;
                            border-radius: 15px;
                            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                            overflow: hidden;
                        }

                        .table-header {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #fff;
                            padding: 1.5rem 2rem;
                            font-weight: 600;
                            font-size: 1.1rem;
                        }

                        .table-responsive {
                            margin: 0;
                        }

                        .table th {
                            background: #f8f9fa;
                            border: none;
                            padding: 1rem 1.5rem;
                            font-weight: 600;
                            color: #2f2f2f;
                            border-bottom: 2px solid #e9ecef;
                        }

                        .table td {
                            padding: 1rem 1.5rem;
                            border: none;
                            border-bottom: 1px solid #e9ecef;
                            vertical-align: middle;
                        }

                        .table tbody tr:hover {
                            background: #f8f9fa;
                        }

                        .action-buttons {
                            display: flex;
                            gap: 0.5rem;
                            flex-wrap: wrap;
                        }

                        .btn-edit {
                            background: #ffc107;
                            border: none;
                            color: #2f2f2f;
                            padding: 0.5rem 1rem;
                            border-radius: 20px;
                            font-size: 0.85rem;
                            font-weight: 500;
                            transition: all 0.3s ease;
                            text-decoration: none;
                        }

                        .btn-edit:hover {
                            background: #e0a800;
                            color: #2f2f2f;
                            transform: translateY(-1px);
                        }

                        .btn-delete {
                            background: #dc3545;
                            border: none;
                            color: #fff;
                            padding: 0.5rem 1rem;
                            border-radius: 20px;
                            font-size: 0.85rem;
                            font-weight: 500;
                            transition: all 0.3s ease;
                        }

                        .btn-delete:hover {
                            background: #c82333;
                            transform: translateY(-1px);
                        }

                        .alert {
                            border-radius: 10px;
                            border: none;
                            padding: 1rem 1.5rem;
                            margin-bottom: 2rem;
                        }

                        .alert-success {
                            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                            color: #155724;
                        }

                        .alert-danger {
                            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                            color: #721c24;
                        }

                        .empty-state {
                            text-align: center;
                            padding: 3rem 2rem;
                            color: #6a6a6a;
                        }

                        .empty-state i {
                            font-size: 4rem;
                            color: #dee2e6;
                            margin-bottom: 1rem;
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

                            .action-buttons {
                                flex-direction: column;
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
                                <li class="nav-item"><a class="nav-link" href="/iDea/admin-dashboard.jsp"><i
                                            class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                                <li class="nav-item"><a class="nav-link" href="AdminProductServlet"><i
                                            class="fas fa-box-open"></i> Products</a></li>
                                <li class="nav-item"><a class="nav-link" href="AdminOrderServlet"><i
                                            class="fas fa-shopping-bag"></i> Orders</a></li>
                                <li class="nav-item"><a class="nav-link active" href="AdminCustomerServlet"><i
                                            class="fas fa-users"></i> Customers</a></li>
                                <li class="nav-item"><a class="nav-link" href="AdminCategoryServlet"><i
                                            class="fas fa-th-list"></i> Categories</a></li>
                                <li class="nav-item mt-auto"><a class="nav-link" href="../LogoutServlet?role=admin"><i
                                            class="fas fa-sign-out-alt"></i> Logout</a></li>
                            </ul>
                        </div>
                        <div class="admin-content">
                            <div class="admin-header">
                                <div class="container-fluid">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <h1 class="navbar-brand mb-0">Customer Management</h1>
                                        </div>
                                        <div class="col-auto"><span class="welcome-text"><i
                                                    class="fas fa-user-circle me-2"></i>Welcome, <%= admin.getName() %>
                                                    !</span></div>
                                    </div>
                                </div>
                            </div>
                            <div class="admin-hero">
                                <div class="container">
                                    <div class="row align-items-center">
                                        <div class="col-lg-8">
                                            <h1>Customer Management</h1>
                                            <p>Manage your customer accounts, view details, and keep your customer base
                                                organized and up to date.</p>
                                        </div>
                                        <div class="col-lg-4 text-center"><i class="fas fa-users"
                                                style="font-size: 4rem; color: rgba(255,255,255,0.3);"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="content-section">
                                <div class="container">
                                    <% String message=request.getParameter("message"); if (message !=null &&
                                        !message.isEmpty()) { %>
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            <i class="fas fa-check-circle me-2"></i>
                                            <%= message %>
                                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                    aria-label="Close"></button>
                                        </div>
                                        <% } %>
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
                                                    <div class="page-header">
                                                        <div class="row align-items-center">
                                                            <div class="col">
                                                                <h2><i class="fas fa-users me-2"></i>All Customers</h2>
                                                                <p>Manage your customer base and details</p>
                                                            </div>
                                                            <div class="col-auto"><a
                                                                    href="AdminCustomerServlet?action=showAddForm"
                                                                    class="add-product-btn"><i
                                                                        class="fas fa-plus me-2"></i>Add New
                                                                    Customer</a></div>
                                                        </div>
                                                    </div>
                                                    <div class="customers-table">
                                                        <div class="table-header"><i
                                                                class="fas fa-list me-2"></i>Customer List</div>
                                                        <div class="table-responsive">
                                                            <table class="table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>ID</th>
                                                                        <th>Name</th>
                                                                        <th>Email</th>
                                                                        <th>Address</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% List<User> customers = (List<User>)
                                                                            request.getAttribute("customers");
                                                                            if (customers != null &&
                                                                            !customers.isEmpty()) {
                                                                            for (User customer : customers) {
                                                                            %>
                                                                            <tr>
                                                                                <td>
                                                                                    <%= customer.getId() %>
                                                                                </td>
                                                                                <td>
                                                                                    <%= customer.getUsername() %>
                                                                                </td>
                                                                                <td>
                                                                                    <%= customer.getEmail() %>
                                                                                </td>
                                                                                <td>
                                                                                    <%= customer.getAddress() !=null ?
                                                                                        customer.getAddress() : "N/A" %>
                                                                                </td>
                                                                                <td>
                                                                                    <div class="action-buttons">
                                                                                        <a href="AdminCustomerServlet?action=showEditForm&id=<%= customer.getId() %>"
                                                                                            class="btn-edit"><i
                                                                                                class="fas fa-edit me-1"></i>Edit</a>
                                                                                        <form
                                                                                            action="AdminCustomerServlet"
                                                                                            method="post"
                                                                                            style="display:inline-block;">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="delete">
                                                                                            <input type="hidden"
                                                                                                name="customerId"
                                                                                                value="<%= customer.getId() %>">
                                                                                            <button type="submit"
                                                                                                class="btn-delete"
                                                                                                onclick="return confirm('Are you sure you want to delete <%= customer.getUsername() %>?');"><i
                                                                                                    class="fas fa-trash me-1"></i>Delete</button>
                                                                                        </form>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <% } } else { %>
                                                                                <tr>
                                                                                    <td colspan="5">
                                                                                        <div class="empty-state">
                                                                                            <i class="fas fa-users"></i>
                                                                                            <h4>No Customers Found</h4>
                                                                                            <p>Start building your
                                                                                                customer base by adding
                                                                                                your first customer.</p>
                                                                                            <a href="AdminCustomerServlet?action=showAddForm"
                                                                                                class="add-product-btn"><i
                                                                                                    class="fas fa-plus me-2"></i>Add
                                                                                                Your First Customer</a>
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                                <% } %>
                                                                </tbody>
                                                            </table>
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