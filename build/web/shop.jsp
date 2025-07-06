<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.idea.model.Product, com.idea.model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="author" content="Untree.co" />
    <link rel="shortcut icon" href="images/favicon.png" />

    <meta name="description" content="Shop Page with Product Categories" />
    <meta name="keywords" content="bootstrap, bootstrap4, shop, products, categories" />

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
      rel="stylesheet"
    />
    <link href="css/tiny-slider.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title>Shop Now</title>
    <style>
      /* Custom styles for tabs */
      .nav-pills .nav-link {
        color: #3b5d50;
        border-radius: 0.5rem;
        padding: 0.75rem 1.25rem;
        font-weight: 600;
        transition: all 0.3s ease;
      }
      .nav-pills .nav-link.active,
      .nav-pills .nav-link:hover {
        background-color: #3b5d50;
        color: #fff;
      }
      .tab-content {
        padding-top: 20px;
      }
      .product-item {
        display: block; /* Ensure product items are block level for flex/grid layout */
        text-decoration: none;
        color: inherit;
      }
      .product-thumbnail {
        width: 100%; /* Make images responsive within their column */
        height: 250px; /* Fixed height for consistent display */
        object-fit: contain; /* Ensure image fits without cropping */
        margin-bottom: 15px;
      }
    </style>
  </head>

  <body>
    <!-- Start Header/Navigation -->
    <%@ include file="header.jsp" %>
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

    <div class="untree_co-section product-section before-footer-section">
      <div class="container">
        <div class="row">
          <div class="col-12 mb-5">
            <!-- Nav tabs (Pills) -->
            <ul class="nav nav-pills mb-3 justify-content-center" id="pills-tab" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="pills-all-tab" data-bs-toggle="pill"
                  data-bs-target="#pills-all-products-content" type="button" role="tab" aria-controls="pills-all-products-content"
                  aria-selected="true" data-category-id="all">All Products</button>
              </li>
              <c:forEach var="category" items="${applicationScope.categories}"> <%-- Use applicationScope.categories --%>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="pills-${category.categoryId}-tab" data-bs-toggle="pill"
                    data-bs-target="#pills-all-products-content" type="button" role="tab"
                    aria-controls="pills-all-products-content" aria-selected="false"
                    data-category-id="${category.categoryId}">
                    ${category.categoryName}
                  </button>
                </li>
              </c:forEach>
            </ul>
            <%-- Debugging: Check if categories are loaded --%>
            <c:if test="${empty applicationScope.categories}">
                <p style="color: red; text-align: center;">Warning: No categories loaded into application scope. Check CategoryLoaderListener and database connection.</p>
            </c:if>
          </div>

          <div class="col-12">
            <!-- Tab content - now only one pane containing all products -->
            <div class="tab-content" id="pills-tabContent">
              <div class="tab-pane fade show active" id="pills-all-products-content" role="tabpanel" aria-labelledby="pills-all-tab">
                <div class="row">
                  <c:if test="${empty products}">
                    <div class="col-12 text-center">
                      <p>No products found. Please check back later.</p>
                    </div>
                  </c:if>

                  <c:forEach var="product" items="${products}">
                    <%-- Add data-category-id for JavaScript filtering --%>
                    <div class="col-12 col-md-4 col-lg-3 mb-5 product-card" data-category-id="${product.categoryId}">
                      <a class="product-item" href="ProductDetailServlet?id=${product.id}">
                        <c:choose>
                          <c:when test="${not empty product.images}">
                            <img src="${product.images[0].path}" class="img-fluid product-thumbnail" alt="${product.name}" />
                          </c:when>
                          <c:otherwise>
                            <img src="images/default.png" class="img-fluid product-thumbnail" alt="No image" />
                          </c:otherwise>
                        </c:choose>
                        <h3 class="product-title">${product.name}</h3>
                        <strong class="product-price">RM<fmt:formatNumber value="${product.price}" type="currency" currencySymbol="" minFractionDigits="2" maxFractionDigits="2"/></strong>
                        <span class="icon-cross">
                          <img src="images/cross.svg" class="img-fluid" />
                        </span>
                      </a>
                    </div>
                  </c:forEach>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Start Footer Section -->
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
                  <li><a href="contact.jsp">Contact Us</a></li>
                </ul>
              </div>

              <div class="col-6 col-sm-6 col-md-4">
                <ul class="list-unstyled">
                  <c:forEach var="category" items="${applicationScope.categories}">
                    <li><a href="ShopServlet?categoryId=${category.categoryId}">${category.categoryName}</a></li>
                  </c:forEach>
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
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        console.log('shop.jsp: DOM Content Loaded. Initializing tab logic.');
        const productCards = document.querySelectorAll('.product-card');
        const tabButtons = document.querySelectorAll('#pills-tab .nav-link');

        // Function to filter products based on category ID
        function filterProducts(selectedCategoryId) {
            console.log('shop.jsp: filterProducts called with ID:', selectedCategoryId);
            productCards.forEach(card => {
                const cardCategoryId = card.dataset.categoryId;
                // Using loose equality (==) for comparison as data-attributes are strings
                if (selectedCategoryId === 'all' || cardCategoryId == selectedCategoryId) {
                    card.style.display = 'block'; // Show the card
                } else {
                    card.style.display = 'none'; // Hide the card
                }
            });
        }

        // Add event listeners for tab button clicks (Bootstrap's 'shown.bs.tab' event)
        tabButtons.forEach(button => {
          button.addEventListener('shown.bs.tab', function (event) {
            console.log('shop.jsp: Bootstrap "shown.bs.tab" event fired for:', this.id);
            const selectedCategoryId = this.dataset.categoryId;
            filterProducts(selectedCategoryId);
          });
        });

        // Get category ID from URL on page load
        const urlParams = new URLSearchParams(window.location.search);
        const categoryIdFromUrl = urlParams.get('categoryId');
        console.log('shop.jsp: Category ID from URL:', categoryIdFromUrl);

        // Determine which tab to activate initially
        let tabToActivate = null;
        let initialCategoryId = categoryIdFromUrl || 'all'; // Default to 'all' if no param

        console.log('shop.jsp: Determined initial category to activate:', initialCategoryId);

        if (initialCategoryId === 'all') {
            tabToActivate = document.getElementById('pills-all-tab');
        } else {
            // Find the button by iterating through all tab buttons
            tabButtons.forEach(button => {
                // Use loose equality (==) for comparison between string from URL and data-attribute
                if (button.dataset.categoryId == initialCategoryId) {
                    tabToActivate = button;
                    console.log('shop.jsp: Found matching tab button for ID:', initialCategoryId, 'Button ID:', button.id);
                }
            });

            if (!tabToActivate) {
                console.warn('shop.jsp: No tab button found for category ID from URL:', initialCategoryId, 'Defaulting to All Products.');
                tabToActivate = document.getElementById('pills-all-tab'); // Fallback to "All Products"
            }
        }

        // Activate the determined tab and filter products
        if (tabToActivate) {
            console.log('shop.jsp: Activating tab:', tabToActivate.id);
            const tab = new bootstrap.Tab(tabToActivate);
            tab.show(); // Programmatically show the tab
            // Manually call filterProducts because 'shown.bs.tab' might not fire if the tab was already active
            filterProducts(tabToActivate.dataset.categoryId);
        } else {
            console.error('shop.jsp: No tab found to activate. This should not happen if "All Products" fallback is present.');
        }
      });
    </script>
  </body>
</html>
