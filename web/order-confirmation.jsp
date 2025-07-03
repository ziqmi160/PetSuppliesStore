<%-- 
    Document   : order-confirmation
    Created on : Jun 15, 2025, 1:54:39 AM
    Author     : haziq
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images\favicon.png" />

    <meta name="description" content="" />
    <meta name="keywords" content="bootstrap, bootstrap4" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <link href="css/tiny-slider.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>Order Confirmation</title>
</head>
<body>
    <!-- Start Header/Navigation -->
  <%@ include file="header.jsp" %>
    <!-- End Header/Navigation -->

    <!-- Start Hero Section -->
    <div class="hero" style="background-image: url('images/orderconfirm.jpg'); background-size: cover; background-position: center; position: relative; height: 400px;">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1>Order Confirmation</h1>
                    </div>
                </div>
                <div class="col-lg-7"></div>
            </div>
        </div>
    <div class="overlay" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);"></div>
    </div>
    <!-- End Hero Section -->

    <div class="untree_co-section" style="padding:5rem 0;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 text-center p-5 border rounded bg-light">
                    <% String message = (String) session.getAttribute("message");
                       Integer orderId = (Integer) session.getAttribute("lastOrderId");
                       if (message != null && !message.isEmpty()) { %>
                        <div class="alert alert-success" role="alert">
                            <%= message %>
                        </div>
                    <% } else if (orderId != null) { %>
                        <h2 class="display-4 text-black mb-4">Thank You!</h2>
                        <p class="lead mb-5">Your order has been placed successfully. Your Order ID is: <strong><%= orderId.intValue() %></strong></p>
                    <% } else { %>
                        <h2 class="display-4 text-black mb-4">Order Confirmation</h2>
                        <p class="lead mb-5">There was no specific order information found. Please check your order history or contact support.</p>
                    <% } 
                       // Clear session attributes after display
                       session.removeAttribute("message");
                       session.removeAttribute("lastOrderId");
                    %>
                    <p>
                        <a href="ShopServlet" class="btn btn-sm btn-outline-black">Continue Shopping</a>
                        <a href="index.jsp" class="btn btn-sm btn-black">Back to Home</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Start Footer Section -->
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
                        <li><a href="#"><span class="fa fa-brands fa-facebook-f"></span></a></li>
                        <li><a href="#"><span class="fa fa-brands fa-twitter"></span></a></li>
                        <li><a href="#"><span class="fa fa-brands fa-instagram"></span></a></li>
                        <li><a href="#"><span class="fa fa-brands fa-linkedin"></span></a></li>
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
                            <script>document.write(new Date().getFullYear());</script>
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
    </footer-->
    <%@ include file="footer.jsp" %>
    <!-- End Footer Section -->

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/custom.js"></script>
</body>
</html>
