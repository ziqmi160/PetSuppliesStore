<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <% boolean isLoggedIn=session !=null && session.getAttribute("userID") !=null; String userName=isLoggedIn ? (String)
        session.getAttribute("userName") : null; %>
        <!-- Start Header/Navigation -->
        <nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">iDea<span>.</span></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
                    aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarsFurni">
                    <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                        </li>
                        <li><a class="nav-link" href="${pageContext.request.contextPath}/ShopServlet">Shop</a></li>
                        <li><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About us</a></li>
                        <li><a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact us</a>
                        </li>
                    </ul>
                    <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                        <% if (isLoggedIn) { %>
                            <li class="nav-item">
                           
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-user"></i>
                                    <%= userName %>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile.jsp">
                                            <i class="fas fa-user-circle"></i> My Profile
                                        </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders.jsp">
                                            <i class="fas fa-shopping-bag"></i> My Orders
                                        </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/wishlist.jsp">
                                            <i class="fas fa-heart"></i> Wishlist
                                        </a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li><a class="dropdown-item"
                                            href="${pageContext.request.contextPath}/LogoutServlet">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a></li>
                                </ul>
                            </li>
                            <% } else { %>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">
                                        <img src="${pageContext.request.contextPath}/images/user.svg" alt="Login"
                                            style="width: 24px; height: 24px;">
                                    </a>
                                </li>
                                <% } %>
                                    <li class="nav-item">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/cart.jsp">
                                            <i class="fas fa-shopping-cart"></i> Cart
                                        </a>
                                    </li>
                                    <% if (isLoggedIn) { %>
                                        <li class="nav-item">
                                            <a class="nav-link" href="${pageContext.request.contextPath}/profile.jsp">
                                                <img src="${pageContext.request.contextPath}/images/user.svg"
                                                    alt="Profile" class="profile-icon"> Profile
                                            </a>
                                        </li>
                                        <% } else { %>
                                            <li class="nav-item">
                                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">
                                                    <img src="${pageContext.request.contextPath}/images/user.svg"
                                                        alt="Login" class="profile-icon"> Login
                                                </a>
                                            </li>
                                            <% } %>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- End Header/Navigation -->

        <!-- Add Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!-- Add Bootstrap JS for dropdown functionality -->
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

        <style>
            .navbar-nav .nav-link {
                padding: 0.5rem 1rem;
                color: #fff !important;
                text-decoration: none;
            }

            .navbar-nav .nav-link:hover {
                color: #ccc !important;
            }

            .dropdown-menu {
                background-color: #343a40;
                border: none;
                box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            }

            .dropdown-item {
                color: #fff !important;
                padding: 0.5rem 1rem;
                text-decoration: none;
            }

            .dropdown-item:hover {
                background-color: #495057;
                color: #fff !important;
            }

            .dropdown-divider {
                border-top-color: #495057;
            }

            .navbar-nav .nav-link i {
                margin-right: 0.5rem;
            }

            .dropdown-item i {
                width: 20px;
                text-align: center;
                margin-right: 0.5rem;
            }

            /* Ensure links are clickable */
            .nav-link,
            .dropdown-item {
                cursor: pointer;
                position: relative;
                z-index: 1000;
            }

            /* Profile icon specific styles */
            .fa-user-circle {
                color: #fff !important;
                transition: transform 0.3s ease;
                font-size: 1.8rem;
                margin-right: 10px;
            }

            .fa-user-circle:hover {
                transform: scale(1.1);
                color: #007bff !important;
            }

            /* Make sure the profile icon is visible */
            .custom-navbar-cta .nav-link {
                display: flex;
                align-items: center;
                padding: 0.5rem 1rem;
            }

            .custom-navbar-cta .nav-link i {
                margin-right: 0.5rem;
            }

            /* Add tooltip styles */
            .nav-link[title] {
                position: relative;
            }

            .nav-link[title]:hover::after {
                content: attr(title);
                position: absolute;
                bottom: -30px;
                left: 50%;
                transform: translateX(-50%);
                background-color: rgba(0, 0, 0, 0.8);
                color: white;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 12px;
                white-space: nowrap;
                z-index: 1000;
            }
        </style>