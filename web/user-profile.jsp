<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.idea.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images/favicon.png" />

    <meta name="description" content="User Profile Page for iDea Store" />
    <meta name="keywords" content="user, profile, account, dashboard" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>My Profile - iDea</title>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-container {
            padding-top: 80px; /* Adjust based on header height */
            padding-bottom: 50px;
        }
        .profile-card {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            margin: 0 auto;
            text-align: left;
        }
        .profile-card h2 {
            margin-bottom: 20px;
            color: #2f2f2f;
        }
        .profile-info p {
            margin-bottom: 10px;
            font-size: 1.1em;
            color: #555;
        }
        .profile-info strong {
            color: #333;
        }
        .btn-primary {
            background-color: #3b5d50;
            border-color: #3b5d50;
        }
        .btn-primary:hover {
            background-color: #2f2f2f;
            border-color: #2f2f2f;
        }
    </style>
</head>
<body>
    <%-- Include the common header --%>
    <%@ include file="header.jsp" %>

    <div class="untree_co-section profile-container">
        <div class="container">
            <%-- Security Check: Ensure user is logged in --%>
            <% // currentUser is already defined by header.jsp
               if (currentUser == null) {
                   response.sendRedirect("login.jsp");
                   return; // Stop execution
               }
            %>
            <div class="profile-card">
                <h2>My Profile</h2>
                <div class="profile-info">
                    <p><strong>User ID:</strong> <%= currentUser.getId() %></p>
                    <p><strong>Username:</strong> <%= currentUser.getUsername() %></p>
                    <p><strong>Email:</strong> <%= currentUser.getEmail() %></p>
                    <p><strong>Address:</strong> <%= currentUser.getAddress() %></p>
                    <p><strong>Cart ID:</strong> <%= currentUser.getCartId() %></p>
                </div>
                <hr>
                <p>
                    <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                    <%-- Add more profile management links here (e.g., Edit Profile, Order History) --%>
                </p>
            </div>
        </div>
    </div>

    <!-- Start Footer Section (assuming you have a common footer or it's added here) -->
    <!-- footer class="footer-section">
        <div class="container relative">
            <div class="sofa-img">
                <img src="images/sofa.png" alt="Image" class="img-fluid" />
            </div>

            <div class="row g-5 mb-5">
                <div class="col-lg-4">
                    <div class="mb-4 footer-logo-wrap">
                        <a href="#" class="footer-logo">iDea<span>.</span></a>
                    </div>
                    <p class="mb-4">
                        At iDea, we are dedicated to providing high-quality, stylish
                        furniture crafted to enhance every space in your home. With a
                        focus on comfort, durability, and timeless design, we strive to
                        make your shopping experience easy and enjoyable. Thank you for
                        choosing us to help create your perfect living environment.
                    </p>

                    <ul class="list-unstyled custom-social">
                        <li>
                            <a href="#"><span class="fa fa-brands fa-facebook-f"></span></a>
                        </li>
                        <li>
                            <a href="#"><span class="fa fa-brands fa-twitter"></span></a>
                        </li>
                        <li>
                            <a href="#"><span class="fa fa-brands fa-instagram"></span></a>
                        </li>
                        <li>
                            <a href="#"><span class="fa fa-brands fa-linkedin"></span></a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-8">
                    <div class="row links-wrap">
                        <div class="col-6 col-sm-6 col-md-4">
                            <ul class="list-unstyled">
                                <li><a href="#">About us</a></li>
                                <li><a href="#">Contact us</a></li>
                            </ul>
                        </div>

                        <div class="col-6 col-sm-6 col-md-4">
                            <ul class="list-unstyled">
                                <li><a href="index.jsp">Home</a></li>
                                <li><a href="ShopServlet">Shop Now</a></li>
                                <li><a href="about.jsp">About Us</a></li>
                                <li><a href="contact.jspss">Contact Us</a></li>
                            </ul>
                        </div>

                        <div class="col-6 col-sm-6 col-md-4">
                            <ul class="list-unstyled">
                                <li><a href="product1.jsp">Nordic Chair</a></li>
                                <li><a href="product2.jsp">Serene Chair</a></li>
                                <li><a href="product3.jsp">Aurora Chair</a></li>
                                <li><a href="product4.jsp">Eclipse Chair</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="border-top copyright">
                <div class="row pt-4">
                    <div class="col-lg-6">
                        <p class="mb-2 text-center text-lg-start">
                            Copyright iDea&copy;
                            <script>
                                document.write(new Date().getFullYear());
                            </script>
                            . All Rights Reserved.
                        </p>
                    </div>

                    <div class="col-lg-6 text-center text-lg-end">
                        <ul class="list-unstyled d-inline-flex ms-auto">
                            <li class="me-4"><a href="#">Terms &amp; Conditions</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer -->
<%@ include file="footer.jsp" %>
    <!-- End Footer Section -->

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/custom.js"></script>
</body>
</html>
