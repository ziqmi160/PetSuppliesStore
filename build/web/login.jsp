<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Untree.co">
    <link rel="shortcut icon" href="images\favicon.png">

    <meta name="description" content="" />
    <meta name="keywords" content="bootstrap, bootstrap4" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="css/tiny-slider.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <title>Login</title>
</head>

<body>

    <!-- Start Header/Navigation -->
    <nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">iDea<span>.</span></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
                aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarsFurni">
                <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                    <li class="nav-item ">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li><a class="nav-link" href="ShopServlet">Shop</a></li>
                    <li><a class="nav-link" href="about.jsp">About us</a></li>
                    <li><a class="nav-link" href="contact.jsp">Contact us</a></li>
                </ul>
                <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                    <li><a class="nav-link" href="login.jsp"><img src="images/user.svg"></a></li>
                    <li><a class="nav-link" href="CartServlet"><img src="images/cart.svg"></a></li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Header/Navigation -->

    <!-- Start Login Section -->
    <div class="login-section" style="padding-bottom: 5rem;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="login-form">
                        <div class="row mb-5">
                            <div class="col-lg-5 mx-auto text-center" style="padding-top: 5rem;">
                                <h2 class="section-title">Login</h2>
                            </div>
                        </div>
                        <% String error=request.getParameter("error"); String success=request.getParameter("success");
                            if (error !=null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= error %>
                            </div>
                            <% } else if (success !=null) { %>
                                <div class="alert alert-success" role="alert">
                                    <%= success %>
                                </div>
                                <% } %>
                                    <form action="LoginServlet" method="post">
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="password">Password</label>
                                            <input type="password" class="form-control" id="password" name="password"
                                                required>
                                        </div>
                                        <div class="form-group form-check">
                                            <input type="checkbox" class="form-check-input" id="rememberMe">
                                            <label class="form-check-label" for="rememberMe">Remember me</label>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                                        <p class="text-center mt-3">Don't have an account? <a
                                                href="register.jsp">Register
                                                here</a>
                                        </p>
                                    </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Login Section -->

    <!-- Start Footer Section -->
    <footer class="footer-section">
        <div class="container relative">

            <div class="row g-5 mb-5">
                <div class="col-lg-4">
                    <div class="mb-4 footer-logo-wrap"><a href="#" class="footer-logo">iDea<span>.</span></a></div>
                    <p class="mb-4">At iDea, we are dedicated to providing high-quality, stylish furniture crafted to
                        enhance every space in your home. With a focus on comfort, durability, and timeless design, we
                        strive to make your shopping experience easy and enjoyable. Thank you for choosing us to help
                        create your perfect living environment.</p>
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
                                <li><a href="contact.jsp">Contact Us</a></li>
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
                        <p class="mb-2 text-center text-lg-start">Copyright iDea&copy;
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
    </footer>
    <!-- End Footer Section -->

    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/custom.js"></script>
</body>

</html>