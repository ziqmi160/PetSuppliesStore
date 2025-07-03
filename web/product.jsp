<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.idea.model.Product" %>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images\favicon.png" />

    <meta name="description" content="Nordic Chair - Detailed Information" />
    <meta name="keywords" content="bootstrap, bootstrap4, furniture, interior design, nordic chair" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
        rel="stylesheet" />
    <link href="css/tiny-slider.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Nordic Chair</title>
    
    <style>
</style>
</head>

<body>
    <!-- Start Header/Navigation -->
    <%@ include file="header.jsp" %>
    <!-- End Header/Navigation -->

    <!-- Start Hero Section -->
    <div class="hero" style="
    background-image: url('images/furniture2.jpg');
    background-size: cover;
    background-position: center;
    position: relative;
    max-height: 400px;
    ">
        <% Product product = (Product) request.getAttribute("product"); %>
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-5">
                    <div class="intro-excerpt">
                        <h1><%= product.getName() %></h1>
                        <p class="mb-4">
                            Your perfect furniture for your home.
                        </p>
                        <p>
                            <a href="#product-details" class="btn btn-secondary me-2">View Details</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay" style="
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        "></div>
    </div>
    <!-- End Hero Section -->

    <!-- Start Product Details Section -->
    <section id="product-details" class="untree_co-section product-details-section" style="padding:4.5rem;">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <% 
                       if (product != null && product.getImages() != null && !product.getImages().isEmpty()) { %>
                           <img src="<%= product.getImages().get(0).getPath() %>" class="img-fluid" alt="<%= product.getName() %>" />
                    <% } else { %>
                        <img src="https://placehold.co/600x400/eeeeee/333333?text=No+Image" class="img-fluid" alt="No Image" />
                    <% } %>
                </div>
                <div class="col-md-6">
                    <% if (product != null) { %>
                        <h2 class="mb-0"><%= product.getName() %></h2>
                        <p class="mb-4"><%= product.getCategoryName() %></p> <%-- Changed to getCategoryName --%>
                        <h2 class="mb-4"><strong>RM<%= String.format("%.2f", product.getPrice()) %></strong></h2>
                        <p class="mb-4"><%= product.getDescription() %></p>
                        <p class="mb-4">Stock: <span id="productStockQuantity"><%= product.getStockQuantity() %></span></p>

                        <form action="CartServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <div class="container-del">
                                    <div class="section">
                                        <h3><i class="fa fa-truck" aria-hidden="true" style="margin-right:5px;"></i>Delivery</h3>
                                        <div class="delivery">
                                            <div class="icon"></div>
                                            <div>
                                                <p style="margin-bottom:0px">Available</p>
                                                <p>Find all options at checkout</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="section">
                                        <h3><i class="fa fa-store" aria-hidden="true" style="margin-right:5px;"></i>In store</h3>
                                        <p class="store">Also available physical store</p>
                                    </div>
                                </div>
<!--                            <div class="input-group mb-3" style="max-width: 120px">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-black decrease" type="button">&minus;</button>
                                </div>
                                <input type="number" class="form-control text-center" name="quantity" value="1"
                                    min="1" readonly>
                                <div class="input-group-append">
                                    <button class="btn btn-outline-black increase" type="button">&plus;</button>
                                </div>
                            </div>-->
                            <div class="quantity-container">
                                <button class="btn decrease" type="button">&minus;</button>
                                <input class="number" type="number" class="quantity-input" name="quantity" value="1" min="1" readonly>
                                <button class="btn increase" type="button">&plus;</button>
                            </div>

                            <% if (product.getStockQuantity() > 0) { %>
                                <button type="submit" class="btn btn-black">Add to Cart</button>
                            <% } else { %>
                                <button type="submit" class="btn btn-black" disabled>Out of Stock</button>
                                <p class="text-danger mt-2">This item is currently out of stock.</p>
                            <% } %>
                        </form>
                    <% } else { %>
                        <p>Product details not available.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </section>
    <!-- End Product Details Section -->
    <div class="col-md-12 col-lg-3 mb-5 mb-lg-0"></div>
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
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const quantityInput = document.querySelector('input[name="quantity"]');
            const decreaseBtn = document.querySelector('.decrease');
            const increaseBtn = document.querySelector('.increase');

            // Get the maximum allowed quantity (stockQuantity) from the JSP
            // Ensure product.getStockQuantity() is available and correctly rendered
            const maxStockElement = document.getElementById('productStockQuantity');
            const maxStock = maxStockElement ? parseInt(maxStockElement.textContent) : 1; // Default to 1 if not found or invalid
            
            // Initial check: if quantity is more than stock, cap it
            if (parseInt(quantityInput.value) > maxStock) {
                quantityInput.value = maxStock;
            }
            if (maxStock === 0) { // If stock is zero, disable buttons and set quantity to 0
                quantityInput.value = 0;
                quantityInput.setAttribute('disabled', 'disabled');
                decreaseBtn.setAttribute('disabled', 'disabled');
                increaseBtn.setAttribute('disabled', 'disabled');
            }


            decreaseBtn.addEventListener('click', function () {
                let currentValue = parseInt(quantityInput.value);
                if (currentValue > 1) { // Ensure quantity doesn't go below 1
                    quantityInput.value = currentValue - 1;
                }
            });

            increaseBtn.addEventListener('click', function () {
                let currentValue = parseInt(quantityInput.value);
                if (currentValue < maxStock) { // Ensure quantity doesn't exceed available stock
                    quantityInput.value = currentValue + 1;
                }
            });
        });
    </script>
</body>

</html>
