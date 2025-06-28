<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.idea.model.Admin" %>
<%@ page import="com.idea.model.Category" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin-login.jsp");
        return;
    }

    Category category = (Category) request.getAttribute("category");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><%= category != null ? "Edit Category" : "Add Category" %> - iDea Admin</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.png" />
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />
</head>

<body>

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

    <!-- Header -->
    <div class="admin-header d-flex justify-content-between align-items-center">
        <h1 class="h4 mb-0"><%= category != null ? "Edit Category" : "Add New Category" %></h1>
        <span>Welcome, <%= admin.getName() %>!</span>
    </div>

    <!-- Main Content -->
    <div class="content container-fluid">
        <% if (error != null && !error.isEmpty()) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header">
                        <%= category != null ? "Edit Category" : "Add New Category" %>
                    </div>
                    <div class="card-body">
                        <form action="AdminCategoryServlet" method="post">
                            <% if (category != null) { %>
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>" />
                            <% } else { %>
                            <input type="hidden" name="action" value="add" />
                            <% } %>

                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Category Name *</label>
                                <input type="text" class="form-control" id="categoryName" name="categoryName"
                                    value="<%= category != null ? category.getCategoryName() : "" %>" required />
                                <div class="form-text">Enter a descriptive name for the category.</div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="AdminCategoryServlet" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-1"></i> Back
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas <%= category != null ? "fa-save" : "fa-plus" %> me-1"></i>
                                    <%= category != null ? "Update Category" : "Add Category" %>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/tiny-slider.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
</body>

</html>
