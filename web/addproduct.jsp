<%-- Document : addproduct Created on : Jun 12, 2025, 12:44:41 AM Author : User --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="author" content="iDea" />
            <link rel="shortcut icon" href="images/favicon.png" />
            <meta name="description" content="Insert New Product - iDea" />
            <meta name="keywords" content="bootstrap, product form, admin, insert product" />

            <title>Insert New Product - iDea</title>

            <!-- Bootstrap & Custom CSS -->
            <link href="css/bootstrap.min.css" rel="stylesheet" />
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                rel="stylesheet" />
            <link href="css/tiny-slider.css" rel="stylesheet" />
            <link href="css/style.css" rel="stylesheet" />
            <style>
                .form-section {
                    padding-top: 80px;
                    padding-bottom: 180px;
                    background-color: #f8f9fa;
                }
            </style>
        </head>

        <body>

            <!-- Navigation -->
            <nav class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">iDea<span>.</span></a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-md-0">
                            <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="ShopServlet">Shop</a></li>
                            <li class="nav-item"><a class="nav-link" href="blog.jsp">Blog</a></li>
                            <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact us</a></li>
                        </ul>
                        <ul class="navbar-nav mb-2 mb-md-0 ms-5">
                            <li class="nav-item"><a class="nav-link" href="login.jsp"><img src="images/user.svg" /></a>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="cart.jsp"><img src="images/cart.svg" /></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Hero Section -->
            <div class="hero"
                style="background-image: url('images/furniture2.jpg'); height: 300px; background-size: cover; position: relative;">
                <div class="container text-white">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="intro-excerpt mt-5">
                                <h1>Insert New Product</h1>
                                <p>Add a new product to your catalog.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="overlay"
                    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">
                </div>
            </div>

            <!-- Product Insert Form Section -->
            <section class="form-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <h2 class="mb-4">Product Entry Form</h2>
                            <form action="AddProductServlet" method="post">
                                <div class="mb-3">
                                    <label for="productName" class="form-label">Product Name</label>
                                    <input type="text" class="form-control" id="productName" name="name" required />
                                </div>
                                <div class="mb-3">
                                    <label for="productDescription" class="form-label">Description</label>
                                    <textarea class="form-control" id="productDescription" name="description" rows="4"
                                        required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="productPrice" class="form-label">Price (RM)</label>
                                    <input type="number" class="form-control" id="productPrice" name="price" step="0.01"
                                        required />
                                </div>
                                <div class="mb-3">
                                    <label for="productQuantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="productQuantity" name="quantity"
                                        required />
                                </div>
                                <button type="submit" class="btn btn-success">Insert Product</button>
                            </form>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <footer class="footer-section">
                <div class="container relative">
                    <div class="sofa-img">
                        <img src="images/sofa.png" alt="Image" class="img-fluid" />
                    </div>

                    <div class="row g-5 mb-5">
                        <div class="col-lg-4">
                            <div class="mb-4 footer-logo-wrap">
                                <a href="#" class="footer-logo">iDea<span>.</span></a>
                            </div>
                            <p class="mb-4">Your source for stylish, durable, and affordable furniture pieces that
                                enhance any living space.</p>
                            <ul class="list-unstyled custom-social">
                                <li><a href="#"><span class="fa fa-brands fa-facebook-f"></span></a></li>
                                <li><a href="#"><span class="fa fa-brands fa-twitter"></span></a></li>
                                <li><a href="#"><span class="fa fa-brands fa-instagram"></span></a></li>
                                <li><a href="#"><span class="fa fa-brands fa-linkedin"></span></a></li>
                            </ul>
                        </div>

                        <div class="col-lg-8">
                            <div class="row links-wrap">
                                <div class="col-6 col-md-4">
                                    <ul class="list-unstyled">
                                        <li><a href="#">About us</a></li>
                                        <li><a href="#">Contact us</a></li>
                                    </ul>
                                </div>
                                <div class="col-6 col-md-4">
                                    <ul class="list-unstyled">
                                        <li><a href="index.jsp">Home</a></li>
                                        <li><a href="ShopServlet">Shop Now</a></li>
                                        <li><a href="about.jsp">About Us</a></li>
                                        <li><a href="contact.jsp">Contact Us</a></li>
                                    </ul>
                                </div>
                                <div class="col-6 col-md-4">
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
                                    &copy;
                                    <script>document.write(new Date().getFullYear());</script> iDea. All rights
                                    reserved.
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

            <!-- JS Scripts -->
            <script src="js/bootstrap.bundle.min.js"></script>
            <script src="js/tiny-slider.js"></script>
            <script src="js/custom.js"></script>
        </body>

        </html>