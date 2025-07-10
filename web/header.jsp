<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ page import="com.idea.model.User" %>
<%@ page import="com.idea.model.Admin" %>
<%
    // Retrieve User and Admin objects from session
    User currentUser = (User) session.getAttribute("user");
    Admin currentAdmin = (Admin) session.getAttribute("admin");
%>
<nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark" aria-label="Furni navigation bar">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">iDea<span>.</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li><a class="nav-link" href="ShopServlet">Shop</a></li>
                <li><a class="nav-link" href="about.jsp">About Us</a></li>
                <li><a class="nav-link" href="contact.jsp">Contact Us</a></li>
            </ul>
            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                <% if (currentUser != null) { %>
                    <%-- Display for logged-in regular user --%>
                    <li>
                        <a class="nav-link" href="UserServlet">
                            <img src="images/user.svg" class="me-1" alt="User Icon"/>
                            Hello, <%= currentUser.getUsername() %>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="CartServlet"><img src="images/cart.svg" alt="Cart Icon"/></a>
                    </li>
                    <li>
                        <a class="nav-link" href="LogoutServlet?role=user">Logout</a>
                    </li>
                <% } else if (currentAdmin != null) { %>
                    <%-- Display for logged-in administrator --%>
                    <li>
                        <a class="nav-link" href="admin-dashboard.jsp">
                            <img src="images/user.svg" class="me-1" alt="Admin Icon"/>
                            Admin: <%= currentAdmin.getName() %>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="LogoutServlet?role=admin">Logout</a>
                    </li>
                <% } else { %>
                    <%-- Display for not logged-in user/guest --%>
                    <li>
                        <a class="nav-link" href="login.jsp"><img src="images/user.svg" alt="Login Icon"/></a>
                    </li>
                    <%-- Cart link is intentionally omitted here as our CartServlet requires login --%>
                    <%-- If you want cart visible without login, CartServlet's logic needs adjustment --%>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
