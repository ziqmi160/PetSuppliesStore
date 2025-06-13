<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Profile - iDea</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <% String userName=null; if (session !=null && session.getAttribute("userID") !=null) { userName=(String)
            session.getAttribute("userName"); } else { response.sendRedirect("login.jsp?error=Please+login+first");
            return; } %>

            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">iDea</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="ShopServlet">Shop</a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="LogoutServlet">Logout</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="text-center">My Profile</h3>
                            </div>
                            <div class="card-body">
                                <% String error=request.getParameter("error"); String
                                    success=request.getParameter("success"); if (error !=null) { %>
                                    <div class="alert alert-danger">
                                        <%= error %>
                                    </div>
                                    <% } if (success !=null) { %>
                                        <div class="alert alert-success">
                                            <%= success %>
                                        </div>
                                        <% } %>

                                            <div class="mb-4">
                                                <h4>Welcome, <%= userName %>
                                                </h4>
                                            </div>

                                            <div class="mb-4">
                                                <h5>Account Information</h5>
                                                <p><strong>Username:</strong>
                                                    <%= userName %>
                                                </p>
                                            </div>

                                            <div class="d-grid gap-2">
                                                <a href="edit-profile.jsp" class="btn btn-primary">Edit Profile</a>
                                                <a href="LogoutServlet" class="btn btn-danger">Logout</a>
                                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="bg-dark text-white text-center py-3 mt-5">
                <p class="mb-0">&copy; 2024 iDea. All rights reserved.</p>
            </footer>

            <script src="js/bootstrap.bundle.min.js"></script>
    </body>

    </html>