<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.idea.model.Product, com.idea.controller.ShopServlet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images/favicon.png" />

    <meta name="description" content="" />
    <meta name="keywords" content="bootstrap, bootstrap4" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
      rel="stylesheet"
    />
    <link href="css/tiny-slider.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>Shop Now</title>
  </head>

  <body>
    <!-- Start Header/Navigation -->
    <nav
      class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark"
      arial-label="Furni navigation bar"
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
            <li class="active">
              <a class="nav-link" href="ShopServlet">Shop</a>
            </li>
            <li><a class="nav-link" href="about.jsp">About us</a></li>
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
        background-image: url('images/shop-head.jpg');
        background-size: cover;
        background-position: center;
        position: relative;
        height: 400px;
      "
    >
      <div class="container">
        <div class="row justify-content-between">
          <div class="col-lg-5">
            <div class="intro-excerpt">
              <h1>Shop</h1>
              <p class="mb-4">
                Welcome to <strong>Idea</strong>, where innovative design meets
                quality craftsmanship. Discover our collection of stylish,
                durable furniture perfect for creating modern and inviting
                spaces.
              </p>
              <p>
                <a href="ShopServlet" class="btn btn-white-outline">Shop Now</a>
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

<!--    <div class="untree_co-section product-section before-footer-section">
      <div class="container">
        <div class="row">
           Start Column 1 
          <div class="col-12 col-md-4 col-lg-3 mb-5">
            <a class="product-item" href="product1.jsp">
              <img
                src="images/product-3.png"
                class="img-fluid product-thumbnail"
              />
              <h3 class="product-title">Nordic Chair</h3>
              <strong class="product-price">RM99.00</strong>

              <span class="icon-cross">
                <img src="images/cross.svg" class="img-fluid" />
              </span>
            </a>
          </div>
           End Column 1 

           Start Column 2 
          <div class="col-12 col-md-4 col-lg-3 mb-5">
            <a class="product-item" href="product2.jsp">
              <img
                src="images/product-1.png"
                class="img-fluid product-thumbnail"
              />
              <h3 class="product-title">Serene Chair</h3>
              <strong class="product-price">RM199.00</strong>

              <span class="icon-cross">
                <img src="images/cross.svg" class="img-fluid" />
              </span>
            </a>
          </div>
           End Column 2 

           Start Column 3 
          <div class="col-12 col-md-4 col-lg-3 mb-5">
            <a class="product-item" href="product3.jsp">
              <img
                src="images/product-2.png"
                class="img-fluid product-thumbnail"
              />
              <h3 class="product-title">Aurora Chair</h3>
              <strong class="product-price">RM249.00</strong>

              <span class="icon-cross">
                <img src="images/cross.svg" class="img-fluid" />
              </span>
            </a>
          </div>
           End Column 3 

           Start Column 4 
          <div class="col-12 col-md-4 col-lg-3 mb-5">
            <a class="product-item" href="product4.jsp">
              <img
                src="images/product-4.png"
                class="img-fluid product-thumbnail"
                style="width: 300px"
              />
              <h3 class="product-title">Eclipse Chair</h3>
              <strong class="product-price">RM299.00</strong>

              <span class="icon-cross">
                <img src="images/cross.svg" class="img-fluid" />
              </span>
            </a>
          </div>
           End Column 4 

           End Column 4 
        </div>
      </div>
    </div>-->

    <div class="untree_co-section product-section before-footer-section">
      <div class="container">
        <div class="row">

          <c:if test="${empty products}">
            <div class="col-12 text-center">
              <p>No products found. Please check back later.</p>
            </div>
          </c:if>

          <c:forEach var="product" items="${products}">
  <div class="col-12 col-md-4 col-lg-3 mb-5">
    <a class="product-item" href="product.jsp?id=${product.id}">
      <c:choose>
        <c:when test="${not empty product.images}">
            <img src="${product.images[0].path}" class="img-fluid product-thumbnail" alt="${product.name}" />
<!--            <div class="testimonial-slider-wrap text-center">
          <div id="testimonial-nav">
            <span class="prev" data-controls="prev"><span class="fa fa-chevron-left"></span></span>
            <span class="next" data-controls="next"><span class="fa fa-chevron-right"></span></span>
          </div>

          <div class="testimonial-slider">
              <c:forEach var="image" items="${product.images}">
                <div class="item">
                  <div class="row justify-content-center">
                    <div class="col-lg-8 mx-auto">
                      <div class="testimonial-block text-center">
                        <img src="${image.path}" class="img-fluid product-thumbnail" alt="${product.name}" />
                      </div>
                    </div>
                  </div>
                </div>
              </c:forEach>
          </div>
        </div>-->
        </c:when>
        <c:otherwise>
          <img src="images/default.png" class="img-fluid product-thumbnail" alt="No image" onerror="this.outerHTML = '<p>${product.image.path}</p>'" />
        </c:otherwise>
      </c:choose>
      <h3 class="product-title">${product.name}</h3>
      <strong class="product-price">RM${product.price}</strong>
      <span class="icon-cross">
        <img src="images/cross.svg" class="img-fluid" />
      </span>
    </a>
  </div>
</c:forEach>


        </div>
      </div>
    </div>
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
				</div -->

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
                  <li><a>Shop Now</a></li>
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
