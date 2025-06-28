<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.idea.model.Admin, com.idea.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="author" content="iDea Admin">
  <link rel="shortcut icon" href="../images/favicon.png">
  <meta name="description" content="Admin Order Form">
  <meta name="keywords" content="admin, order, form, ecommerce">
  <title>Order Form - iDea Admin</title>

  <link href="../css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

  <style>
    body {
      background-color: #f8f9fa;
      margin-top: 3rem;
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
<% Admin admin = (Admin) session.getAttribute("admin");
   if (admin == null) {
       response.sendRedirect("../admin-login.jsp");
       return;
   }
%>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center mb-4">iDea Admin</h4>
        <ul class="nav flex-column">
            <li class="nav-item"><a class="nav-link" href="../admin-dashboard.jsp"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a></li>
            <li class="nav-item"><a class="nav-link" href="AdminProductServlet"><i class="fas fa-box-open me-2"></i> Products</a></li>
            <li class="nav-item"><a class="nav-link" href="AdminProductServlet"><i class="fas fa-shopping-bag me-2"></i> Orders</a></li>
            <li class="nav-item"><a class="nav-link" href="AdminCustomerServlet"><i class="fas fa-users me-2"></i> Customers</a></li>
            <li class="nav-item"><a class="nav-link active" href="AdminCategoryServlet"><i class="fas fa-th-list me-2"></i> Categories</a></li>
            <li class="nav-item"><a class="nav-link" href="../LogoutServlet?role=admin"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
        </ul>
    </div>

<div class="content">
  <div class="admin-header d-flex justify-content-between align-items-center">
    <h2 class="navbar-brand">Edit Order</h2>
    <span>Welcome, <%= admin.getName() %>!</span>
  </div>

  <div class="container-fluid pt-4">
    <% String error = (String) request.getAttribute("error");
       if (error != null && !error.isEmpty()) { %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>

    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">Edit Order Status</div>
          <div class="card-body">
            <% Order order = (Order) request.getAttribute("order");
               if (order != null) {
                 SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>

              <div class="mb-4">
                <h5>Order Information</h5>
                <div class="row">
                  <div class="col-md-6">
                    <p><strong>Order ID:</strong> <%= order.getOrderId() %></p>
                    <p><strong>User ID:</strong> <%= order.getUserId() %></p>
                    <p><strong>Date:</strong> <%= order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "N/A" %></p>
                  </div>
                  <div class="col-md-6">
                    <p><strong>Total Amount:</strong> RM<%= String.format("%.2f", order.getTotalAmount()) %></p>
                    <p><strong>Current Status:</strong> <%= order.getStatus() %></p>
                  </div>
                </div>
              </div>

              <form action="AdminOrderServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                <div class="mb-3">
                  <label for="status" class="form-label">Order Status *</label>
                  <select class="form-control" id="status" name="status" required>
                    <option value="">Select Status</option>
                    <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="Processing" <%= "Processing".equals(order.getStatus()) ? "selected" : "" %>>Processing</option>
                    <option value="Shipped" <%= "Shipped".equals(order.getStatus()) ? "selected" : "" %>>Shipped</option>
                    <option value="Delivered" <%= "Delivered".equals(order.getStatus()) ? "selected" : "" %>>Delivered</option>
                    <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                  </select>
                  <div class="form-text">Update the order status to reflect its current state.</div>
                </div>

                <div class="d-flex justify-content-between">
                  <a href="AdminOrderServlet" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to Orders
                  </a>
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-1"></i> Update Order Status
                  </button>
                </div>
              </form>

            <% } else { %>
              <div class="alert alert-warning">Order not found. Please go back to the orders list.</div>
              <a href="AdminOrderServlet" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i> Back to Orders
              </a>
            <% } %>
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