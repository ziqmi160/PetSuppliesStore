<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.idea.model.Admin, com.idea.model.Product, com.idea.model.Category, com.idea.model.ProductImage" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Product Form - iDea Admin</title>
  <meta name="description" content="Admin Product Form">
  <meta name="keywords" content="admin, product, add, edit, form, ecommerce">
  <link rel="shortcut icon" href="../images/favicon.png">

  <!-- CSS Dependencies -->
  <link href="../css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

  <!--style>
    body {
      background-color: #f8f9fa;
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
  </style -->
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
    <h2 class="navbar-brand">Product Management</h2>
    <span>Welcome, <%= admin.getName() %>!</span>
  </div>

  <div class="container-fluid mt-4">
    <% Product product = (Product) request.getAttribute("product");
       String formAction = product != null ? "update" : "add";
       String submitButtonText = product != null ? "Update Product" : "Add Product";
       String pageTitle = product != null ? "Edit Product: " + product.getName() : "Add New Product";
       int productId = product != null ? product.getId() : -1;
       String name = product != null ? product.getName() : "";
       String description = product != null ? product.getDescription() : "";
       double price = product != null ? product.getPrice() : 0.0;
       int categoryId = product != null ? product.getCategoryId() : 0;
       int stockQuantity = product != null ? product.getStockQuantity() : 0;
       List<ProductImage> images = product != null && product.getImages() != null ? product.getImages() : new ArrayList<ProductImage>();
    %>

    <% String error = (String) request.getAttribute("error");
       if (error != null && !error.isEmpty()) { %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>

    <div class="card">
      <div class="card-header"><%= pageTitle %></div>
      <div class="card-body">
        <form action="AdminProductServlet" method="post">
          <input type="hidden" name="action" value="<%= formAction %>">
          <input type="hidden" name="productId" value="<%= productId %>">

          <div class="mb-3">
            <label for="name" class="form-label">Product Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
          </div>

          <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required><%= description %></textarea>
          </div>

          <div class="mb-3">
            <label for="price" class="form-label">Price (RM)</label>
            <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%= price %>" required>
          </div>

          <div class="mb-3">
            <label for="categoryId" class="form-label">Category</label>
            <select class="form-select" id="categoryId" name="categoryId" required>
              <option value="">Select a Category</option>
              <% List<Category> categories = (List<Category>) request.getAttribute("categories");
                 if (categories != null) {
                   for (Category category : categories) { %>
                    <option value="<%= category.getCategoryId() %>" <%= category.getCategoryId() == categoryId ? "selected" : "" %>>
                      <%= category.getCategoryName() %>
                    </option>
              <% } } %>
            </select>
          </div>

          <div class="mb-3">
            <label for="stockQuantity" class="form-label">Stock Quantity</label>
            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" value="<%= stockQuantity %>" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Product Images (Read Only)</label>
            <div class="d-flex flex-wrap">
              <% for (ProductImage img : images) { %>
                <div class="position-relative">
                  <img src="<%= img.getPath() %>" class="img-thumbnail me-2 mb-2" style="max-width: 150px; max-height: 150px;">
                  <input type="hidden" name="existingImageIds" value="<%= img.getId() %>">
                  <input type="hidden" name="existingImagePaths" value="<%= img.getPath() %>">
                </div>
              <% } %>
              <% if (images.isEmpty() && product != null) { %>
                <p class="text-muted">No images available for this product.</p>
              <% } %>
            </div>
          </div>

          <button type="submit" class="btn btn-primary"><%= submitButtonText %></button>
          <a href="AdminProductServlet" class="btn btn-secondary ms-2">Cancel</a>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="../js/bootstrap.bundle.min.js"></script>
<script src="../js/tiny-slider.js"></script>
<script src="../js/custom.js"></script>
</body>
</html>
