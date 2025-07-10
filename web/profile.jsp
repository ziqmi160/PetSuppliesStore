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
                <div class="card-header bg-primary text-white text-center">
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
        <a href="LogoutServlet" class="btn btn-outline-danger">Logout</a>
    </div>

            <!-- Orders Section -->
            <div class="card shadow">
                <div class="card-header bg-secondary text-white text-center">
                    <h4 class="mb-0">My Orders</h4>
                </div>
                <div class="card-body p-4">
                    <% if (orders == null || orders.isEmpty()) { %>
                        <p class="text-center text-muted">You have no orders yet.</p>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover align-middle">
                                <thead class="table-dark">
                                    <tr class="text-center">
                                        <th>Order ID</th>
                                        <th>Order Date</th>
                                        <th>Status</th>
                                        <th>Total Amount (RM)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Order order : orders) { %>
                                        <tr>
                                            <td class="text-center"><%= order.getOrderId() %></td>
                                            <td class="text-center"><%= order.getOrderDate() %></td>
                                            <td class="text-center"><span class="badge bg-info text-dark"><%= order.getStatus() %></span></td>
                                            <td class="text-end">RM <%= String.format("%.2f", order.getTotalAmount()) %></td>
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
</div>

<!-- Footer -->

<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>
