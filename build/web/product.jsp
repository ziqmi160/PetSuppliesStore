<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="author" content="Untree.co" />
        <link rel="shortcut icon" href="images\favicon.png" />

        <meta name="description" content="Nordic Chair - Detailed Information" />
        <meta
            name="keywords"
            content="bootstrap, bootstrap4, furniture, interior design, nordic chair"
            />

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
            rel="stylesheet"
            />
        <link href="css/tiny-slider.css" rel="stylesheet" />
        <link href="css/style.css" rel="stylesheet" />
        <title>Nordic Chair</title>
    </head>

    <body>
        <!-- Start Header/Navigation -->
        <nav
            class="custom-navbar navbar navbar-expand-md navbar-dark bg-dark"
            aria-label="Furni navigation bar"
            >
            <div class="container">
                <a class="navbar-brand" href="index.jsp">iDea<span>.</span></a>
                <button
                    class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarsFurni"
                    aria-controls="navbarsFurni"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    >
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarsFurni">
                    <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>
                        <li><a class="nav-link" href="ShopServlet">Shop</a></li>
                        <li><a class="nav-link" href="blog.jsp">Blog</a></li>
                        <li><a class="nav-link" href="contact.jsp">Contact us</a></li>
                    </ul>
                    <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
                        <li>
                            <a class="nav-link" href="login.jsp"
                               ><img src="images/user.svg"
                                  /></a>
                        </li>
                        <li>
                            <a class="nav-link" href="cart.jsp"
                               ><img src="images/cart.svg"
                                  /></a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- End Header/Navigation -->

        <!-- Start Hero Section -->
        <div
            class="hero"
            style="
            background-image: url('images/furniture2.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
            height: 355px;
            "
            >
            <div class="container">
                <div class="row justify-content-between">
                    <div class="col-lg-5">
                        <div class="intro-excerpt">
                            <h1>Nordic Chair</h1>
                            <p class="mb-4">
                                Discover the elegance and comfort of the Nordic Chair.
                            </p>
                            <p>
                                <a href="#product-details" class="btn btn-secondary me-2"
                                   >View Details</a
                                >
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div
                class="overlay"
                style="
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                "
                ></div>
        </div>
        <!-- End Hero Section -->

        <!-- Start Product Details Section -->
        <section
            id="product-details"
            class="untree_co-section product-details-section"
            >
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
<!--                        <img
                            src="images/product-3.png"
                            class="img-fluid"
                            alt="Nordic Chair"
                            />-->
                        <img src="${product.images[0].path}" class="img-fluid" alt="${product.name}" />
                    </div>
                    <div class="col-md-6">
                        <!--            <h2 class="mb-0">Nordic Chair</h2>
                                    <p class="mb-4">Wing chair</p>
                                    <h2 class="mb-4"><strong>RM99.00</strong></h2>
                                    <p class="mb-4">
                                      The Nordic Chair is designed with simplicity and comfort in mind.
                                      Its minimalist design and ergonomic features make it a perfect
                                      addition to any living space.
                                    </p>
                                    <p class="mb-2"><strong>Dimension:</strong> 50cm x 80cm</p>
                                    <p class="mb-2"><strong>Materials:</strong> Tibbleby</p>
                                    <p class="mb-4"><strong>Colour:</strong> Green</p>
                                    <p class="mb-4"></p>-->
                                      
                                    

                        <h2 class="mb-0">${product.name}</h2>
                        <p class="mb-4">${product.category}</p>
                        <h2 class="mb-4"><strong>RM${product.price}</strong></h2>
                        <p class="mb-4">${product.description}</p>

<a href="cart.jsp" class="btn btn-primary">Add to Cart</a>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Product Details Section -->
        <div class="col-md-12 col-lg-3 mb-5 mb-lg-0"></div>
        <!-- Start Footer Section -->
        <footer class="footer-section">
            <div class="container relative">
                <div class="sofa-img">
                    <img src="images/sofa.png" alt="Image" class="img-fluid" />
                </div>

                <!--div class="row">
                                                <div class="col-lg-8">
                                                        <div class="subscription-form">
                                                                <h3 class="d-flex align-items-center"><span class="me-1"><img src="images/envelope-outline.svg" alt="Image" class="img-fluid"></span><span>Subscribe to Newsletter</span></h3>
        
                                                                <form action="#" class="row g-3">
                                                                        <div class="col-auto">
                                                                                <input type="text" class="form-control" placeholder="Enter your name">
                                                                        </div>
                                                                        <div class="col-auto">
                                                                                <input type="email" class="form-control" placeholder="Enter your email">
                                                                        </div>
                                                                        <div class="col-auto">
                                                                                <button class="btn btn-primary">
                                                                                        <span class="fa fa-paper-plane"></span>
                                                                                </button>
                                                                        </div>
                                                                </form>
        
                                                        </div>
                                                </div>
                                        </div-->

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
        </footer>
        <!-- End Footer Section -->

        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/tiny-slider.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
