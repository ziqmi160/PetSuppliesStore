<%-- 
    Document   : product-form
    Created on : Jun 16, 2025, 1:17:53 AM
    Author     : haziq
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.idea.model.Admin" %>
<%@ page import="com.idea.model.Product" %>
<%@ page import="com.idea.model.Category" %>
<%@ page import="com.idea.model.ProductImage" %> <%-- For images handling --%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> <%-- For Java 5 compatibility --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="../images/favicon.png" />

    <meta name="description" content="Admin Product Form" />
    <meta name="keywords" content="admin, product, add, edit, form, ecommerce" />

    <!-- Bootstrap CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
    <title>Product Form - iDea Admin</title>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Inter', sans-serif;
        }
        .admin-header {
            background-color: #2f2f2f;
            color: #ffffff;
            padding: 15px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar .nav-link {
            color: #ffffff;
            padding: 10px 20px;
            display: block;
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
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
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .card-header {
            background-color: #3b5d50;
            color: #ffffff;
            font-weight: bold;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        .form-control, .form-select {
            border-radius: 5px;
        }
        .btn-primary-form {
            background-color: #2f2f2f;
            color: #ffffff;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .btn-primary-form:hover {
            background-color: #3b5d50;
        }
        .image-preview {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <%-- Security Check: Ensure admin is logged in --%>
    <% Admin admin = (Admin) session.getAttribute("admin");
       if (admin == null) {
           response.sendRedirect("../admin-login.jsp");
           return;
       }
    %>

    <div class="sidebar">
        <h3 class="text-center mb-4">iDea Admin</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="../admin-dashboard.jsp">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="AdminProductServlet">
                    <i class="fas fa-box-open me-2"></i> Products
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-shopping-bag me-2"></i> Orders
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-users me-2"></i> Customers
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-th-list me-2"></i> Categories
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../LogoutServlet?role=admin">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>

    <div class="content">
        <div class="admin-header fixed-top" style="margin-left: 250px;">
            <div class="container-fluid d-flex justify-content-between align-items-center">
                <h1 class="navbar-brand mb-0">Product Management</h1>
                <span>Welcome, <%= admin.getName() %>!</span>
            </div>
        </div>
        
        <div class="container-fluid mt-5 pt-4">
            <%-- Retrieve product object if editing, otherwise it's null for adding --%>
            <% Product product = (Product) request.getAttribute("product");
               String formAction = "add";
               String submitButtonText = "Add Product";
               String pageTitle = "Add New Product";
               int productId = -1;
               String name = "";
               String description = "";
               double price = 0.0;
               int categoryId = 0; // Default or first category
               int stockQuantity = 0;
               List<ProductImage> images = new ArrayList<ProductImage>(); // For Java 5

               if (product != null) {
                   formAction = "update";
                   submitButtonText = "Update Product";
                   pageTitle = "Edit Product: " + product.getName();
                   productId = product.getId();
                   name = product.getName();
                   description = product.getDescription();
                   price = product.getPrice();
                   categoryId = product.getCategoryId();
                   stockQuantity = product.getStockQuantity();
                   if (product.getImages() != null) { // For Java 5
                       images = product.getImages();
                   }
               }
            %>

            <%-- Display messages (success/error) --%>
            <% String error = (String) request.getAttribute("error");
               if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
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
                            <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%= price %>" min="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Category</label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">Select a Category</option>
                                <% List<Category> categories = (List<Category>) request.getAttribute("categories");
                                   if (categories != null) {
                                       for (int i = 0; i < categories.size(); i++) { // For Java 5 compatibility
                                           Category category = (Category) categories.get(i); // Explicit cast
                                %>
                                <option value="<%= category.getCategoryId() %>" <%= category.getCategoryId() == categoryId ? "selected" : "" %>>
                                    <%= category.getCategoryName() %>
                                </option>
                                <% } } %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="stockQuantity" class="form-label">Stock Quantity</label>
                            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" value="<%= stockQuantity %>" min="0" required>
                        </div>

                        <%-- Image Upload Section (Placeholder - requires multipart form handling) --%>
                        <div class="mb-3">
                            <label for="imageUpload" class="form-label">Product Images (Not yet functional)</label>
                            <input type="file" class="form-control" id="imageUpload" name="imageFiles" multiple disabled>
                            <small class="form-text text-muted">Image upload functionality is not yet implemented.</small>
                            <div class="d-flex flex-wrap mt-2">
                                <% if (images != null && !images.isEmpty()) {
                                    for (int i = 0; i < images.size(); i++) { // For Java 5
                                        ProductImage img = (ProductImage) images.get(i); // Explicit cast
                                %>
                                    <div class="position-relative me-2 mb-2">
                                        <img src="<%= img.getPath() %>" class="image-preview" alt="Product Image"/>
                                        <button type="button" class="btn btn-danger btn-sm position-absolute top-0 end-0" style="width: 25px; height: 25px; border-radius: 50%; padding: 0;" disabled title="Delete image (not yet functional)">X</button>
                                        <input type="hidden" name="existingImageIds" value="<%= img.getId() %>"/>
                                        <input type="hidden" name="existingImagePaths" value="<%= img.getPath() %>"/>
                                    </div>
                                <% } } else if (product != null) { %>
                                    <p class="text-muted">No images available for this product.</p>
                                <% } %>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary-form me-2"><%= submitButtonText %></button>
                        <a href="AdminProductServlet" class="btn btn-secondary">Cancel</a>
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
