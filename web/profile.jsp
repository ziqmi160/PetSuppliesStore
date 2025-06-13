<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Profile - iDea</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    </head>

    <body>
        <% if (session==null || session.getAttribute("userID")==null) { response.sendRedirect(request.getContextPath()
            + "/login.jsp?error=Please+login+first" ); return; } String userName=(String)
            session.getAttribute("userName"); %>

            <jsp:include page="navbar.jsp" />

            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h3 class="text-center mb-0">My Profile</h3>
                            </div>
                            <div class="card-body">
                                <% String error=request.getParameter("error"); String
                                    success=request.getParameter("success"); if (error !=null) { %>
                                    <div class="alert alert-danger">
                                        <i class="fas fa-exclamation-circle"></i>
                                        <%= error %>
                                    </div>
                                    <% } if (success !=null) { %>
                                        <div class="alert alert-success">
                                            <i class="fas fa-check-circle"></i>
                                            <%= success %>
                                        </div>
                                        <% } %>

                                            <div class="mb-4">
                                                <h4><i class="fas fa-user-circle"></i> Welcome, <%= userName %>
                                                </h4>
                                            </div>

                                            <div class="mb-4">
                                                <h5><i class="fas fa-info-circle"></i> Account Information</h5>
                                                <div class="card">
                                                    <div class="card-body">
                                                        <p><strong><i class="fas fa-user"></i> Username:</strong>
                                                            <%= userName %>
                                                        </p>
                                                        <p><strong><i class="fas fa-envelope"></i> Email:</strong>
                                                            <%= session.getAttribute("email") !=null ?
                                                                session.getAttribute("email") : "Not available" %>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="d-grid gap-2">
                                                <a href="${pageContext.request.contextPath}/edit-profile.jsp"
                                                    class="btn btn-primary">
                                                    <i class="fas fa-edit"></i> Edit Profile
                                                </a>
                                                <a href="${pageContext.request.contextPath}/LogoutServlet"
                                                    class="btn btn-danger">
                                                    <i class="fas fa-sign-out-alt"></i> Logout
                                                </a>
                                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="bg-dark text-white text-center py-3 mt-5">
                <p class="mb-0">&copy; 2024 iDea. All rights reserved.</p>
            </footer>

            <!-- Bootstrap JS -->
            <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/tiny-slider.js"></script>
            <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    </body>

    </html>