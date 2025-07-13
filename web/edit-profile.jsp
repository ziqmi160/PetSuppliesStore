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
<html>
<head>
    <title>Edit Profile - iDea</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="css/tiny-slider.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    
<%@ include file="header.jsp" %>
  
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white" style="background-color: #2f2f2f !important; ">
            <h4>Edit Profile</h4>
        </div>
        <div class="card-body">

            <% if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>
            <% if (success != null) { %>
                <div class="alert alert-success"><%= success %></div>
            <% } %>

            <form action="UserServlet?action=edit" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" name="username" id="username" class="form-control" value="<%= user.getUsername() %>" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" id="email" class="form-control" value="<%= user.getEmail() %>" required>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <textarea name="address" id="address" class="form-control" required><%= user.getAddress() %></textarea>
                </div>

                <hr>
                <h5>Change Password</h5>

                <div class="mb-3">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" name="currentPassword" class="form-control" autocomplete="off">
                </div>

                <div class="mb-3">
                    <label for="newPassword">New Password</label>
                    <input type="password" name="newPassword" class="form-control" autocomplete="off">
                </div>

                <div class="mb-3">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" name="confirmPassword" class="form-control" autocomplete="off">
                </div>

                <div class="d-flex justify-content-between">
                    <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-success">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="js/bootstrap.bundle.min.js"></script>

</body>
</html>

