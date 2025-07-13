<%@page import="com.idea.model.OrderItem"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="com.idea.model.Order"%>
<%@page import="com.idea.model.User"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Profile - iDea</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background: #cce5ff;
            color: #004085;
        }

        .status-shipped {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-delivered {
            background: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .order-row {
            cursor: pointer;
            transition: background-color 0.2s;
            border-left: 4px solid transparent;
        }

        .order-row:hover {
            background-color: #f8f9fa;
            border-left-color: #007bff;
        }

        .order-items-row {
            display: none;
            background-color: #f8f9fa;
        }

        .order-items-row.show {
            display: table-row;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }

        .toggle-icon {
            transition: transform 0.3s;
            color: #6c757d;
        }

        .toggle-icon.rotated {
            transform: rotate(180deg);
            color: #007bff;
        }

        .section-header {
            background: #000000;
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .profile-info {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
        }

        .orders-section {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
        }

        .table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .table thead th {
            background-color: #343a40;
            color: white;
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.875rem;
        }

        .table tbody tr {
            border-bottom: 1px solid #dee2e6;
        }

        .table tbody tr:last-child {
            border-bottom: none;
        }

        .order-item-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid #e9ecef;
        }

        .order-item-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .empty-orders {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-orders i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem;
            background: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #0a0b0c;
        }

        .info-item i {
            margin-right: 0.75rem;
            color: #007bff;
            width: 20px;
        }

        .info-value {
            color: #495057;
        }

        .info-value.empty {
            color: #6c757d;
            font-style: italic;
        }
    </style>
</head>

<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=Please+login+first");
        return;
    }

    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    List<Order> orders = (List<Order>) request.getAttribute("orders");

    boolean editMode = request.getParameter("edit") != null;
%>

<!-- Navbar -->
    <%@ include file="header.jsp" %>

<!-- Page Content -->
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <!-- Profile Header -->
            <div class="section-header text-center">
                <h3 class="mb-0">My Profile</h3>
            </div>

            <!-- Profile Information Section -->
            <div class="profile-info">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="mb-0">Profile Information</h4>
                    <a href="edit-profile.jsp" class="btn btn-outline-primary">
                        <i class="fas fa-edit me-2"></i>Edit Profile
                    </a>
                </div>

                <% if (error != null) { %>
                    <div class="alert alert-danger"><%= error %></div>
                <% } %>
                <% if (success != null) { %>
                    <div class="alert alert-success"><%= success %></div>
                <% } %>

                <div class="row">
                    <div class="col-md-6">
                        <div class="info-item">
                            <i class="fas fa-user"></i>
                            <div>
                                <strong>Username:</strong><br>
                                <span class="info-value"><%= user.getUsername() %></span>
                            </div>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-envelope"></i>
                            <div>
                                <strong>Email:</strong><br>
                                <span class="info-value"><%= user.getEmail() %></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <div>
                                <strong>Address:</strong><br>
                                <span class="info-value <%= (user.getAddress() == null || user.getAddress().trim().isEmpty()) ? "empty" : "" %>">
                                    <%= (user.getAddress() != null && !user.getAddress().trim().isEmpty()) ? user.getAddress() : "No address provided" %>
                                </span>
                            </div>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-phone"></i>
                            <div>
                                <strong>Phone:</strong><br>
                                <span class="info-value <%= (user.getPhone() == null || user.getPhone().trim().isEmpty()) ? "empty" : "" %>">
                                    <%= (user.getPhone() != null && !user.getPhone().trim().isEmpty()) ? user.getPhone() : "No phone number provided" %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Orders Section -->
            <div class="orders-section">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="mb-0">Order History</h3>
                    <span class="badge bg-primary fs-6"><%= orders != null ? orders.size() : 0 %> Orders</span>
                </div>

                <% if (orders == null || orders.isEmpty()) { %>
                    <div class="empty-orders">
                        <i class="fas fa-shopping-bag"></i>
                        <h4>No Orders Yet</h4>
                        <p class="text-muted">You haven't placed any orders yet. Start shopping to see your order history here!</p>
                        <a href="shop.jsp" class="btn btn-primary">
                            <i class="fas fa-shopping-cart me-2"></i>Start Shopping
                        </a>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <thead>
                                <tr class="text-center">
                                    <th style="width: 50px;"></th>
                                    <th>Order ID</th>
                                    <th>Order Date</th>
                                    <th>Status</th>
                                    <th>Total Amount (RM)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Order order : orders) { 
                                    String status = order.getStatus(); 
                                    String statusClass = (status != null) ? "status-" + status.toLowerCase() : "status-pending"; 
                                %>
                                    <tr class="order-row" onclick="toggleOrderItems(<%= order.getOrderId() %>)">
                                        <td class="text-center">
                                            <i class="fas fa-chevron-down toggle-icon" id="icon-<%= order.getOrderId() %>"></i>
                                        </td>
                                        <td class="text-center fw-bold">#<%= order.getOrderId() %></td>
                                        <td class="text-center"><%= order.getOrderDate() %></td>
                                        <td class="text-center"><span class="status-badge <%= statusClass %>"><%= (status != null) ? status : "Pending" %></span></td>
                                        <td class="text-end fw-bold">RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                                    </tr>
                                    <!-- Order Items (collapsible) -->
                                    <tr class="order-items-row" id="items-<%= order.getOrderId() %>">
                                        <td colspan="5" class="p-0">
                                            <div class="p-4">
                                                <h6 class="mb-3 text-muted fw-bold">
                                                    <i class="fas fa-boxes me-2"></i>Order Items (<%= order.getOrderItems().size() %> items)
                                                </h6>
                                                <div class="row">
                                                    <% for (OrderItem item : order.getOrderItems()) { %>
                                                        <div class="col-md-6 col-lg-4 mb-3">
                                                            <div class="card order-item-card h-100">
                                                                <div class="row g-0">
                                                                    <div class="col-4">
                                                                        <img src="<%= item.getProductImage() != null ? item.getProductImage() : "images/default.png" %>"
                                                                             class="product-image w-100 h-100"
                                                                             alt="<%= item.getProductName() %>"
                                                                             onerror="this.src='images/default.png'">
                                                                    </div>
                                                                    <div class="col-8">
                                                                        <div class="card-body p-3">
                                                                            <h6 class="card-title mb-1 fw-bold"><%= item.getProductName() %></h6>
                                                                            <p class="card-text mb-1">
                                                                                <small class="text-muted">
                                                                                    <i class="fas fa-hashtag me-1"></i>Qty: <%= item.getQuantity() %>
                                                                                </small>
                                                                            </p>
                                                                            <p class="card-text mb-0">
                                                                                <strong class="text-primary">RM <%= String.format("%.2f", item.getPrice()) %></strong>
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

        </div>
    </div>
</div>

<!-- Footer -->

<script src="js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
<script>
function toggleOrderItems(orderId) {
    const itemsRow = document.getElementById('items-' + orderId);
    const icon = document.getElementById('icon-' + orderId);
    
    if (itemsRow.classList.contains('show')) {
        itemsRow.classList.remove('show');
        icon.classList.remove('rotated');
    } else {
        itemsRow.classList.add('show');
        icon.classList.add('rotated');
    }
}
</script>
</body>
</html>
