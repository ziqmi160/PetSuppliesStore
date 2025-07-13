<%-- 
    Document   : edit-profile
    Created on : Jul 10, 2025, 4:26:25 PM
    Author     : haziq
--%>

<%@page import="com.idea.model.User"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=Please+login+first");
        return;
    }

    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - iDea</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="css/tiny-slider.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .edit-header {
            background: #000000;
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .edit-form {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border: 1px solid #e9ecef;
        }

        .form-section {
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid #e9ecef;
        }

        .form-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .section-title {
            color: #343a40;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
        }

        .section-title i {
            margin-right: 0.5rem;
            color: #007bff;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 0.75rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .form-control.empty {
            border-color: #dc3545;
        }

        .btn {
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.2s;
        }

        .btn-outline-secondary {
            border-color: #6c757d;
            color: #6c757d;
        }

        .btn-outline-secondary:hover {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .alert {
            border-radius: 8px;
            border: none;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .optional-text {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }

        .password-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-top: 1rem;
        }
    </style>
</head>
<body class="bg-light">
    
<%@ include file="header.jsp" %>
  
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white" style="background-color: #2f2f2f !important; ">
            <h4>Edit Profile</h4>
        </div>
        <div class="card-body">

            <!-- Edit Form -->
            <div class="edit-form">
                <% if (error != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i><%= error %>
                    </div>
                <% } %>
                <% if (success != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i><%= success %>
                    </div>
                <% } %>

                <form action="UserServlet?action=edit" method="post" id="editForm">
                    <!-- Basic Information Section -->
                    <div class="form-section">
                        <h5 class="section-title">
                            <i class="fas fa-user"></i>Basic Information
                        </h5>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" name="username" id="username" class="form-control" 
                                       value="<%= user.getUsername() %>" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" name="email" id="email" class="form-control" 
                                       value="<%= user.getEmail() %>" required>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information Section -->
                    <div class="form-section">
                        <h5 class="section-title">
                            <i class="fas fa-address-book"></i>Contact Information
                        </h5>
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea name="address" id="address" class="form-control" rows="3" 
                                      placeholder="Enter your full address"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                            <div class="optional-text">Leave empty if you don't want to provide an address</div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" name="phone" id="phone" class="form-control" 
                                   value="<%= user.getPhone() != null ? user.getPhone() : "" %>"
                                   placeholder="Enter your phone number">
                            <div class="optional-text">Leave empty if you don't want to provide a phone number</div>
                        </div>
                    </div>

                    <!-- Password Change Section -->
                    <div class="form-section">
                        <h5 class="section-title">
                            <i class="fas fa-lock"></i>Change Password
                        </h5>
                        <div class="optional-text mb-3">Leave password fields empty if you don't want to change your password</div>
                        
                        <div class="password-section">
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label for="currentPassword" class="form-label">Current Password</label>
                                    <input type="password" name="currentPassword" id="currentPassword" 
                                           class="form-control" autocomplete="off"
                                           placeholder="Enter your current password">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="newPassword" class="form-label">New Password</label>
                                    <input type="password" name="newPassword" id="newPassword" 
                                           class="form-control" autocomplete="off"
                                           placeholder="Enter new password">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input type="password" name="confirmPassword" id="confirmPassword" 
                                           class="form-control" autocomplete="off"
                                           placeholder="Confirm new password">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-between align-items-center pt-3">
                        <a href="profile.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back to Profile
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
<script>
// Form validation
document.getElementById('editForm').addEventListener('submit', function(e) {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const currentPassword = document.getElementById('currentPassword').value;
    
    // If any password field is filled, all must be filled
    if (newPassword || confirmPassword || currentPassword) {
        if (!newPassword || !confirmPassword || !currentPassword) {
            e.preventDefault();
            alert('Please fill in all password fields if you want to change your password.');
            return;
        }
        
        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('New password and confirm password do not match.');
            return;
        }
        
        if (newPassword.length < 6) {
            e.preventDefault();
            alert('New password must be at least 6 characters long.');
            return;
        }
    }
});

// Real-time validation
document.getElementById('newPassword').addEventListener('input', function() {
    const confirmPassword = document.getElementById('confirmPassword');
    if (this.value !== confirmPassword.value && confirmPassword.value) {
        confirmPassword.classList.add('empty');
    } else {
        confirmPassword.classList.remove('empty');
    }
});

document.getElementById('confirmPassword').addEventListener('input', function() {
    const newPassword = document.getElementById('newPassword');
    if (this.value !== newPassword.value) {
        this.classList.add('empty');
    } else {
        this.classList.remove('empty');
    }
});
</script>
</body>
</html>

