<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.idea.model.Admin" %>
        <%@ page import="com.idea.model.Product" %>
            <%@ page import="java.util.List" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <title>Product Management - iDea Admin</title>
                    <link href="../css/bootstrap.min.css" rel="stylesheet" />
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                        rel="stylesheet" />
                    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
                    <style>
                        /* Admin Page Specific Styles */
                        .admin-hero {
                            background: linear-gradient(135deg, #2f2f2f 0%, #3b5d50 100%);
                            padding: calc(4rem - 30px) 0 4rem 0;
                            padding-left: 30px;
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
                            padding-left: 30px;
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
                            background: #ffffff;
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
                            padding: 10px;
                        }

                        .add-product-btn {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #ffffff;
                            border: none;
                            border-radius: 25px;
                            padding: 0.75rem 1.5rem;
                            font-weight: 500;
                            transition: all 0.3s ease;
                            text-decoration: none;
                            display: inline-flex;
                            align-items: center;
                        }

                        .add-product-btn:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 5px 15px rgba(59, 93, 80, 0.3);
                            color: #ffffff;
                        }

                        .products-table {
                            background: #ffffff;
                            border-radius: 15px;
                            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                            overflow: hidden;
                        }

                        .table-header {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #ffffff;
                            padding: 1.5rem 2rem;
                            font-weight: 600;
                            font-size: 1.1rem;
                        }

                        .table-responsive {
                            margin: 0;
                        }

                        .table {
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

                        .product-image {
                            width: 60px;
                            height: 60px;
                            object-fit: cover;
                            border-radius: 8px;
                            border: 2px solid #e9ecef;
                        }

                        .product-name {
                            font-weight: 600;
                            color: #2f2f2f;
                            margin-bottom: 0.25rem;
                        }

                        .product-category {
                            color: #6a6a6a;
                            font-size: 0.85rem;
                        }

                        .product-price {
                            font-weight: 700;
                            color: #3b5d50;
                            font-size: 1.1rem;
                        }

                        .product-stock {
                            font-weight: 500;
                        }

                        .stock-in {
                            color: #28a745;
                        }

                        .stock-low {
                            color: #ffc107;
                        }

                        .stock-out {
                            color: #dc3545;
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
                            color: #ffffff;
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

                        <!-- Admin Sidebar -->
                        <div class="admin-sidebar">
                            <div class="sidebar-header">
                                <h3><i class="fas fa-cube me-2"></i>iDea Admin</h3>
                            </div>
                            <ul class="nav flex-column">
                                <li class="nav-item">
                                    <a class="nav-link" href="/iDea/admin-dashboard.jsp">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="AdminProductServlet">
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
                                    <a class="nav-link" href="../LogoutServlet?role=admin">
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
                                            <h1 class="navbar-brand mb-0">Product Management</h1>
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
                                            <h1>Product Management</h1>
                                            <p>Manage your product inventory, add new items, and keep your catalog up to
                                                date with our comprehensive product management tools.</p>
                                        </div>
                                        <div class="col-lg-4 text-center">
                                            <i class="fas fa-boxes"
                                                style="font-size: 4rem; color: rgba(255,255,255,0.3);"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Content Section -->
                            <div class="content-section">
                                <div class="container">
                                    <!-- Messages -->
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

                                                    <!-- Page Header -->
                                                    <div class="page-header">
                                                        <div class="row align-items-center">
                                                            <div class="col">
                                                                <h2><i class="fas fa-box-open me-2"></i>All Products
                                                                </h2>
                                                                <p>Manage your product catalog and inventory</p>
                                                            </div>
                                                            <div class="col-auto">
                                                                <a href="AdminProductServlet?action=showAddForm"
                                                                    class="add-product-btn">
                                                                    <i class="fas fa-plus me-2"></i>Add New Product
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Products Table -->
                                                    <div class="products-table">
                                                        <div class="table-header">
                                                            <i class="fas fa-list me-2"></i>Product Catalog
                                                        </div>
                                                        <div class="table-responsive">
                                                            <table class="table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Image</th>
                                                                        <th>Product Details</th>
                                                                        <th>Category</th>
                                                                        <th>Price</th>
                                                                        <th>Stock</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% List<Product> products = (List<Product>)
                                                                            request.getAttribute("products");
                                                                            if (products != null && !products.isEmpty())
                                                                            {
                                                                            for (Product product : products) {
                                                                            String stockClass =
                                                                            product.getStockQuantity() > 10 ? "stock-in"
                                                                            :
                                                                            product.getStockQuantity() > 0 ? "stock-low"
                                                                            : "stock-out";
                                                                            %>
                                                                            <tr>
                                                                                <td>
                                                                                    <% if (product.getImages() !=null &&
                                                                                        !product.getImages().isEmpty())
                                                                                        { %>
                                                                                        <img src="<%= product.getImages().get(0).getPath() %>"
                                                                                            class="product-image"
                                                                                            alt="<%= product.getName() %>" />
                                                                                        <% } else { %>
                                                                                            <img src="../images/default.png"
                                                                                                class="product-image"
                                                                                                alt="No Image" />
                                                                                            <% } %>
                                                                                </td>
                                                                                <td>
                                                                                    <div class="product-name">
                                                                                        <%= product.getName() %>
                                                                                    </div>
                                                                                    <div class="product-category">ID:
                                                                                        <%= product.getId() %>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <%= product.getCategoryName() %>
                                                                                </td>
                                                                                <td class="product-price">RM<%=
                                                                                        String.format("%.2f",
                                                                                        product.getPrice()) %>
                                                                                </td>
                                                                                <td>
                                                                                    <span
                                                                                        class="product-stock <%= stockClass %>">
                                                                                        <%= product.getStockQuantity()
                                                                                            %> units
                                                                                    </span>
                                                                                </td>
                                                                                <td>
                                                                                    <div class="action-buttons">
                                                                                        <a href="AdminProductServlet?action=showEditForm&id=<%= product.getId() %>"
                                                                                            class="btn-edit">
                                                                                            <i
                                                                                                class="fas fa-edit me-1"></i>Edit
                                                                                        </a>
                                                                                        <form
                                                                                            action="AdminProductServlet"
                                                                                            method="post"
                                                                                            style="display:inline-block;">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="delete">
                                                                                            <input type="hidden"
                                                                                                name="productId"
                                                                                                value="<%= product.getId() %>">
                                                                                            <button type="submit"
                                                                                                class="btn-delete"
                                                                                                onclick="return confirm('Are you sure you want to delete <%= product.getName() %>?');">
                                                                                                <i
                                                                                                    class="fas fa-trash me-1"></i>Delete
                                                                                            </button>
                                                                                        </form>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <% } } else { %>
                                                                                <tr>
                                                                                    <td colspan="6">
                                                                                        <div class="empty-state">
                                                                                            <i
                                                                                                class="fas fa-box-open"></i>
                                                                                            <h4>No Products Found</h4>
                                                                                            <p>Start building your
                                                                                                product catalog by
                                                                                                adding your first
                                                                                                product.</p>
                                                                                            <a href="AdminProductServlet?action=showAddForm"
                                                                                                class="add-product-btn">
                                                                                                <i
                                                                                                    class="fas fa-plus me-2"></i>Add
                                                                                                Your First Product
                                                                                            </a>
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