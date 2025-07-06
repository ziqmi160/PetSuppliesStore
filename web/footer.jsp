<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.idea.model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>Footer</title>
    </head>
    <body>
        <footer class="footer-section">
            <div class="container relative">

                <div class="sofa-img">
                    <img src="images/sofa.png" alt="Image" class="img-fluid">
                </div>

                <div class="col-md-12 col-lg-3 mb-5 mb-lg-0"></div>

                <div class="row g-5 mb-5">
                    <div class="col-lg-4">
                        <div class="mb-4 footer-logo-wrap"><a href="#" class="footer-logo">iDea<span>.</span></a></div>
                        <p class="mb-4">At iDea, we are dedicated to providing high-quality, stylish furniture crafted to enhance every space in your home. With a focus on comfort, durability, and timeless design, we strive to make your shopping experience easy and enjoyable. Thank you for choosing us to help create your perfect living environment.</p>

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
                                    <%-- Dynamically generated category links --%>
                                   <c:forEach var="category" items="${applicationScope.categories}">
                                        <li><a href="ShopServlet?categoryId=${category.categoryId}" class="footer-link">${category.categoryName}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="border-top copyright">
                    <div class="row pt-4">
                        <div class="col-lg-6">
                            <p class="mb-2 text-center text-lg-start">Copyright iDea&copy;<script>document.write(new Date().getFullYear());</script>
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
    </body>
</html>
