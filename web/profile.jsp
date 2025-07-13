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
        }

        .order-row:hover {
            background-color: #f8f9fa;
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
        }

        .toggle-icon.rotated {
            transform: rotate(180deg);
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

            <!-- Profile Section -->
            <div class="card shadow mb-5">
                <div class="card-header bg-primary text-white text-center" style="background-color: #2f2f2f !important;">
                    <h3 class="mb-0">My Profile</h3>
                </div>
                <div class="card-body p-4">
                    <% if (error != null) { %>
                        <div class="alert alert-danger"><%= error %></div>
                    <% } %>
                    <% if (success != null) { %>
                        <div class="alert alert-success"><%= success %></div>
                    <% } %>
    <!-- View Mode -->
    <h5 class="fw-bold">Welcome, <%= user.getUsername() %>!</h5>
    <p><strong>Email:</strong> <%= user.getEmail() %></p>
    <p><strong>Address:</strong> <%= !(user.getAddress()).isEmpty()? user.getAddress():"No Address Registered" %></p>
    
    <div class="d-grid gap-2 d-md-flex justify-content-md-start">
        <a href="edit-profile.jsp" class="btn btn-outline-primary me-md-2">Edit Profile</a>
    </div>

            <!-- Orders Section -->
                <div class="card-body p-4">
                    <% if (orders == null || orders.isEmpty()) { %>
                        <p class="text-center text-muted">You have no orders yet.</p>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover align-middle">
                                <thead class="table-dark">
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
                                            <td class="text-center"><%= order.getOrderId() %></td>
                                            <td class="text-center"><%= order.getOrderDate() %></td>
                                            <td class="text-center"><span class="status-badge <%= statusClass %>"><%= (status !=null) ? status: "Pending" %></span></td>
                                            <td class="text-end">RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
                                        </tr>
                                        <!-- Order Items (collapsible) -->
                                        <tr class="order-items-row" id="items-<%= order.getOrderId() %>">
                                            <td colspan="5" class="p-0">
                                                <div class="p-3">
                                                    <h6 class="mb-3 text-muted">Order Items:</h6>
                                                    <div class="row">
                                                        <% for (OrderItem item : order.getOrderItems()) { %>
                                                            <div class="col-md-6 col-lg-4 mb-3">
                                                                <div class="card h-100">
                                                                    <div class="row g-0">
                                                                        <% String imgPath = (item.getProductImage() != null && !item.getProductImage().isEmpty()) ? item.getProductImage() : "images/default.png"; %>
                                                                        <div class="col-4">
                                                                            <img src='<%= imgPath %>'
                                                                                 class='product-image w-100 h-100'
                                                                                 alt='<%= item.getProductName() %>'
                                                                                 onerror="this.src='images/default.png'">
                                                                        </div>
                                                                        <div class="col-8">
                                                                            <div class="card-body p-2">
                                                                                <h6 class="card-title mb-1"><%= item.getProductName() %></h6>
                                                                                <p class="card-text mb-1">
                                                                                    <small class="text-muted">Qty: <%= item.getQuantity() %></small>
                                                                                </p>
                                                                                <p class="card-text mb-0">
                                                                                    <strong>RM <%= String.format("%.2f", item.getPrice()) %></strong>
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
