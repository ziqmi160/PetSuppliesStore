<%-- Document : customer-form Created on : Jun 16, 2025, 1:06:45 AM Author : haziq --%>

    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ page import="com.idea.model.Admin" %>
            <%@ page import="com.idea.model.User" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="author" content="Untree.co" />
                    <link rel="shortcut icon" href="../images/favicon.png" />

                    <meta name="description" content="Admin Customer Form" />
                    <meta name="keywords" content="admin, customer, form, ecommerce" />

                    <!-- Bootstrap CSS -->
                    <link href="../css/bootstrap.min.css" rel="stylesheet" />
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                        rel="stylesheet" />
                    <link href="../css/style.css" rel="stylesheet" />
                    <title>Customer Form - iDea Admin</title>

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

                        .form-container {
                            background: #fff;
                            border-radius: 20px;
                            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                            overflow: hidden;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                        }

                        .form-header {
                            background: linear-gradient(135deg, #3b5d50 0%, #2f2f2f 100%);
                            color: #fff;
                            padding: 2rem;
                            text-align: center;
                            position: relative;
                            overflow: hidden;
                        }

                        .form-header::before {
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

                        .form-header h2 {
                            position: relative;
                            z-index: 2;
                            font-weight: 700;
                            margin: 0;
                            font-size: 1.8rem;
                        }

                        .form-header p {
                            position: relative;
                            z-index: 2;
                            margin: 0.5rem 0 0 0;
                            opacity: 0.9;
                            font-size: 1rem;
                        }

                        .form-body {
                            padding: 3rem;
                        }

                        .form-group {
                            margin-bottom: 2rem;
                        }

                        .form-label {
                            color: #2f2f2f;
                            font-weight: 600;
                            margin-bottom: 0.75rem;
                            font-size: 1rem;
                            display: flex;
                            align-items: center;
                        }

                        .form-label i {
                            margin-right: 0.5rem;
                            color: #3b5d50;
                            font-size: 1.1rem;
                        }

                        .form-control {
                            border: 2px solid #e9ecef;
                            border-radius: 12px;
                            padding: 1rem 1.25rem;
                            font-size: 1rem;
                            transition: all 0.3s ease;
                            background: #f8f9fa;
                            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
                        }

                        .form-control:focus {
                            border-color: #3b5d50;
                            box-shadow: 0 0 0 0.2rem rgba(59, 93, 80, 0.15), inset 0 2px 4px rgba(0, 0, 0, 0.05);
                            background: #fff;
                            transform: translateY(-1px);
                        }

                        .form-text {
                            color: #6a6a6a;
                            font-size: 0.875rem;
                            margin-top: 0.5rem;
                            display: flex;
                            align-items: center;
                        }

                        .form-text i {
                            margin-right: 0.5rem;
                            color: #3b5d50;
                        }

                        .form-actions {
                            display: flex;
                            gap: 1rem;
                            justify-content: flex-end;
                            margin-top: 3rem;
                            padding-top: 2rem;
                            border-top: 1px solid #e9ecef;
                        }

                        .btn {
                            padding: 1rem 2rem;
                            border-radius: 12px;
                            font-weight: 600;
                            text-decoration: none;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            transition: all 0.3s ease;
                            border: none;
                            font-size: 1rem;
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

                        /* Enhanced error styling */
                        .error-message {
                            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                            color: #721c24;
                            border: 1px solid #f5c6cb;
                            border-radius: 12px;
                            padding: 1.5rem;
                            margin-bottom: 2rem;
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.15);
                        }

                        .form-control.is-invalid {
                            border-color: #dc3545;
                            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
                        }

                        .invalid-feedback {
                            display: block;
                            color: #dc3545;
                            font-size: 0.875rem;
                            margin-top: 0.5rem;
                        }

                        .form-control.is-valid {
                            border-color: #28a745;
                            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
                        }

                        .valid-feedback {
                            display: block;
                            color: #28a745;
                            font-size: 0.875rem;
                            margin-top: 0.5rem;
                        }

                        .form-row {
                            display: grid;
                            grid-template-columns: 1fr 1fr;
                            gap: 2rem;
                        }

                        @media (max-width: 768px) {
                            .admin-sidebar {
                                transform: translateX(-100%);
                            }

                            .admin-content {
                                margin-left: 0;
                            }

                            .form-row {
                                grid-template-columns: 1fr;
                                gap: 1rem;
                            }

                            .form-actions {
                                flex-direction: column;
                            }

                            .btn {
                                width: 100%;
                                justify-content: center;
                            }
                        }
                    </style>
                </head>

                <body>
                    <%-- Security Check: Ensure admin is logged in --%>
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
                                        <a class="nav-link"
                                            href="<%= request.getContextPath() %>/LogoutServlet?role=admin">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="admin-content">
                                <div class="page-header">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h1>
                                                <% User customer=(User) request.getAttribute("customer"); if (customer
                                                    !=null) { %>
                                                    <i class="fas fa-edit me-2"></i>Edit Customer
                                                    <% } else { %>
                                                        <i class="fas fa-plus me-2"></i>Add New Customer
                                                        <% } %>
                                            </h1>
                                            <p>
                                                <% if (customer !=null) { %>
                                                    Update customer information to keep your customer database organized
                                                    and up-to-date.
                                                    <% } else { %>
                                                        Create a new customer account to expand your customer base and
                                                        improve service.
                                                        <% } %>
                                            </p>
                                        </div>
                                        <a href="AdminCustomerServlet" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i>Back to Customers
                                        </a>
                                    </div>
                                </div>

                                <% String error=(String) request.getAttribute("error"); if (error !=null &&
                                    !error.isEmpty()) { %>
                                    <div class="error-message">
                                        <i class="fas fa-exclamation-triangle"></i>
                                        <strong>Error:</strong>
                                        <%= error %>
                                    </div>
                                    <% } %>

                                        <div class="form-container">
                                            <div class="form-header">
                                                <h2>
                                                    <% if (customer !=null) { %>
                                                        <i class="fas fa-edit me-2"></i>Edit Customer Information
                                                        <% } else { %>
                                                            <i class="fas fa-plus me-2"></i>Create New Customer
                                                            <% } %>
                                                </h2>
                                                <p>
                                                    <% if (customer !=null) { %>
                                                        Update the customer details below
                                                        <% } else { %>
                                                            Fill in the customer details below
                                                            <% } %>
                                                </p>
                                            </div>

                                            <div class="form-body">
                                                <form action="AdminCustomerServlet" method="post" id="customerForm">
                                                    <% if (customer !=null) { %>
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="customerId"
                                                            value="<%= customer.getId() %>">
                                                        <input type="hidden" id="isEditForm" value="true">
                                                        <% } else { %>
                                                            <input type="hidden" name="action" value="add">
                                                            <input type="hidden" id="isEditForm" value="false">
                                                            <% } %>

                                                                <div class="form-row">
                                                                    <div class="form-group">
                                                                        <label for="username" class="form-label">
                                                                            <i class="fas fa-user"></i>Username
                                                                            *
                                                                        </label>
                                                                        <input type="text" class="form-control"
                                                                            id="username" name="username"
                                                                            value="<%= customer != null ? customer.getUsername() : "" %>"
                                                                            required placeholder="Enter username">
                                                                        <div class="form-text">
                                                                            <i class="fas fa-info-circle"></i>
                                                                            This will be used for customer
                                                                            login.
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="form-label">
                                                                            <i class="fas fa-envelope"></i>Email
                                                                            Address *
                                                                        </label>
                                                                        <input type="email" class="form-control"
                                                                            id="email" name="email"
                                                                            value="<%= customer != null ? customer.getEmail() : "" %>"
                                                                            required placeholder="Enter email address">
                                                                        <div class="form-text">
                                                                            <i class="fas fa-info-circle"></i>
                                                                            This will be used for login and
                                                                            order notifications.
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="form-group">
                                                                    <label for="address" class="form-label">
                                                                        <i class="fas fa-map-marker-alt"></i>Address
                                                                    </label>
                                                                    <textarea class="form-control" id="address"
                                                                        name="address" rows="3"
                                                                        placeholder="Enter full address"><%= customer != null ? customer.getAddress() : "" %></textarea>
                                                                    <div class="form-text">
                                                                        <i class="fas fa-info-circle"></i>
                                                                        Optional: For delivery purposes.
                                                                    </div>
                                                                </div>

                                                                <% if (customer==null) { %>
                                                                    <div class="form-row">
                                                                        <div class="form-group">
                                                                            <label for="password" class="form-label">
                                                                                <i class="fas fa-lock"></i>Password
                                                                                *
                                                                            </label>
                                                                            <input type="password" class="form-control"
                                                                                id="password" name="password" required
                                                                                placeholder="Enter password (minimum 8 characters)"
                                                                                onblur="validatePassword()">
                                                                            <div class="form-text">
                                                                                <i class="fas fa-info-circle"></i>
                                                                                Minimum 8 characters
                                                                                required.
                                                                            </div>
                                                                            <div class="invalid-feedback"
                                                                                id="passwordError"></div>
                                                                            <div class="valid-feedback"
                                                                                id="passwordSuccess"></div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="confirmPassword"
                                                                                class="form-label">
                                                                                <i class="fas fa-lock"></i>Confirm
                                                                                Password *
                                                                            </label>
                                                                            <input type="password" class="form-control"
                                                                                id="confirmPassword"
                                                                                name="confirmPassword" required
                                                                                placeholder="Confirm your password"
                                                                                onblur="validateConfirmPassword()">
                                                                            <div class="form-text">
                                                                                <i class="fas fa-info-circle"></i>
                                                                                Please re-enter your
                                                                                password to confirm.
                                                                            </div>
                                                                            <div class="invalid-feedback"
                                                                                id="confirmPasswordError">
                                                                            </div>
                                                                            <div class="valid-feedback"
                                                                                id="confirmPasswordSuccess">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <% } else { %>
                                                                        <div class="form-row">
                                                                            <div class="form-group">
                                                                                <label for="password"
                                                                                    class="form-label">
                                                                                    <i class="fas fa-lock"></i>New
                                                                                    Password
                                                                                    (Optional)
                                                                                </label>
                                                                                <input type="password"
                                                                                    class="form-control" id="password"
                                                                                    name="password"
                                                                                    placeholder="Leave blank to keep current password"
                                                                                    onblur="validatePassword()">
                                                                                <div class="form-text">
                                                                                    <i class="fas fa-info-circle"></i>
                                                                                    Leave blank to keep
                                                                                    current password.
                                                                                    Minimum 8 characters if
                                                                                    changed.
                                                                                </div>
                                                                                <div class="invalid-feedback"
                                                                                    id="passwordError">
                                                                                </div>
                                                                                <div class="valid-feedback"
                                                                                    id="passwordSuccess">
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label for="confirmPassword"
                                                                                    class="form-label">
                                                                                    <i class="fas fa-lock"></i>Confirm
                                                                                    New Password
                                                                                </label>
                                                                                <input type="password"
                                                                                    class="form-control"
                                                                                    id="confirmPassword"
                                                                                    name="confirmPassword"
                                                                                    placeholder="Confirm new password"
                                                                                    onblur="validateConfirmPassword()">
                                                                                <div class="form-text">
                                                                                    <i class="fas fa-info-circle"></i>
                                                                                    Only required if
                                                                                    changing password.
                                                                                </div>
                                                                                <div class="invalid-feedback"
                                                                                    id="confirmPasswordError">
                                                                                </div>
                                                                                <div class="valid-feedback"
                                                                                    id="confirmPasswordSuccess">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <% } %>

                                                                            <div class="form-actions">
                                                                                <a href="AdminCustomerServlet"
                                                                                    class="btn btn-secondary">
                                                                                    <i class="fas fa-times"></i>Cancel
                                                                                </a>
                                                                                <button type="submit"
                                                                                    class="btn btn-primary"
                                                                                    id="submitBtn">
                                                                                    <% if (customer !=null) { %>
                                                                                        <i
                                                                                            class="fas fa-save"></i>Update
                                                                                        Customer
                                                                                        <% } else { %>
                                                                                            <i
                                                                                                class="fas fa-plus"></i>Add
                                                                                            Customer
                                                                                            <% } %>
                                                                            </div>
                                                </form>
                                            </div>
                                        </div>
                            </div>
                            </div>
                            </div>

                            <script src="../js/bootstrap.bundle.min.js"></script>
                            <script src="../js/tiny-slider.js"></script>
                            <script src="../js/custom.js"></script>
                            <script>
                                // Password validation functions
                                function validatePassword() {
                                    const passwordInput = document.getElementById('password');
                                    const password = passwordInput.value;
                                    const errorDiv = document.getElementById('passwordError');
                                    const successDiv = document.getElementById('passwordSuccess');

                                    // Remove existing validation classes
                                    passwordInput.classList.remove('is-valid', 'is-invalid');
                                    errorDiv.style.display = 'none';
                                    successDiv.style.display = 'none';

                                    // Check if this is an edit form (password is optional)
                                    const isEditForm = document.getElementById('isEditForm').value === 'true';

                                    // If it's an edit form and password is empty, that's fine
                                    if (isEditForm && password === '') {
                                        return true;
                                    }

                                    // Basic validation
                                    if (password === '') {
                                        passwordInput.classList.add('is-invalid');
                                        errorDiv.textContent = 'Password is required.';
                                        errorDiv.style.display = 'block';
                                        return false;
                                    }

                                    if (password.length < 8) {
                                        passwordInput.classList.add('is-invalid');
                                        errorDiv.textContent = 'Password must be at least 8 characters long.';
                                        errorDiv.style.display = 'block';
                                        return false;
                                    }

                                    // If validation passes
                                    passwordInput.classList.add('is-valid');
                                    successDiv.textContent = 'Password meets requirements!';
                                    successDiv.style.display = 'block';

                                    // Also validate confirm password if it has a value
                                    const confirmPassword = document.getElementById('confirmPassword').value;
                                    if (confirmPassword) {
                                        validateConfirmPassword();
                                    }

                                    return true;
                                }

                                function validateConfirmPassword() {
                                    const passwordInput = document.getElementById('password');
                                    const confirmPasswordInput = document.getElementById('confirmPassword');
                                    const password = passwordInput.value;
                                    const confirmPassword = confirmPasswordInput.value;
                                    const errorDiv = document.getElementById('confirmPasswordError');
                                    const successDiv = document.getElementById('confirmPasswordSuccess');

                                    // Remove existing validation classes
                                    confirmPasswordInput.classList.remove('is-valid', 'is-invalid');
                                    errorDiv.style.display = 'none';
                                    successDiv.style.display = 'none';

                                    // Check if this is an edit form
                                    const isEditForm = document.getElementById('isEditForm').value === 'true';

                                    // If it's an edit form and both fields are empty, that's fine
                                    if (isEditForm && password === '' && confirmPassword === '') {
                                        return true;
                                    }

                                    // If password is provided but confirm password is empty
                                    if (password && confirmPassword === '') {
                                        confirmPasswordInput.classList.add('is-invalid');
                                        errorDiv.textContent = 'Please confirm your password.';
                                        errorDiv.style.display = 'block';
                                        return false;
                                    }

                                    // If confirm password is provided but password is empty
                                    if (confirmPassword && password === '') {
                                        confirmPasswordInput.classList.add('is-invalid');
                                        errorDiv.textContent = 'Please enter a password first.';
                                        errorDiv.style.display = 'block';
                                        return false;
                                    }

                                    // Check if passwords match
                                    if (password !== confirmPassword) {
                                        confirmPasswordInput.classList.add('is-invalid');
                                        errorDiv.textContent = 'Passwords do not match.';
                                        errorDiv.style.display = 'block';
                                        return false;
                                    }

                                    // If validation passes
                                    confirmPasswordInput.classList.add('is-valid');
                                    successDiv.textContent = 'Passwords match!';
                                    successDiv.style.display = 'block';
                                    return true;
                                }

                                // Form submission validation
                                document.getElementById('customerForm').addEventListener('submit', function (e) {
                                    const password = document.getElementById('password');
                                    const confirmPassword = document.getElementById('confirmPassword');

                                    // Only validate passwords if they exist (new customer form)
                                    if (password && confirmPassword) {
                                        if (!validatePassword() || !validateConfirmPassword()) {
                                            e.preventDefault();
                                            return false;
                                        }
                                    }

                                    // Show loading state
                                    const submitBtn = document.getElementById('submitBtn');
                                    const originalText = submitBtn.innerHTML;
                                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                                    submitBtn.disabled = true;

                                    // Re-enable after a short delay (in case of validation errors)
                                    setTimeout(() => {
                                        submitBtn.innerHTML = originalText;
                                        submitBtn.disabled = false;
                                    }, 3000);
                                });

                                // Real-time validation on input
                                document.getElementById('password')?.addEventListener('input', function () {
                                    this.classList.remove('is-valid', 'is-invalid');
                                    document.getElementById('passwordError').style.display = 'none';
                                    document.getElementById('passwordSuccess').style.display = 'none';
                                });

                                document.getElementById('confirmPassword')?.addEventListener('input', function () {
                                    this.classList.remove('is-valid', 'is-invalid');
                                    document.getElementById('confirmPasswordError').style.display = 'none';
                                    document.getElementById('confirmPasswordSuccess').style.display = 'none';
                                });
                            </script>
                </body>

                </html>