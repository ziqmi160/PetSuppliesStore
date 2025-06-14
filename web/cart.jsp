<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.idea.model.CartItem" %>
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
  <title>Cart</title>
</head>

<body>
  <!-- Start Header/Navigation -->
  <nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">
    <div class="container">
      <a class="navbar-brand" href="index.jsp">Furni<span>.</span></a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
        aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsFurni">
        <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
          <li class="nav-item">
            <a class="nav-link" href="index.jsp">Home</a>
          </li>
          <li><a class="nav-link" href="ShopServlet">Shop</a></li>
          <li><a class="nav-link" href="about.jsp">About us</a></li>
          <li><a class="nav-link" href="contact.jsp">Contact us</a></li>
        </ul>

        <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
          <li>
            <a class="nav-link" href="login.jsp"><img src="images/user.svg" /></a>
          </li>
          <li>
            <a class="nav-link" href="CartServlet"><img src="images/cart.svg" /></a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- End Header/Navigation -->

  <!-- Start Hero Section -->
  <div class="hero">
    <div class="container">
      <div class="row justify-content-between">
        <div class="col-lg-5">
          <div class="intro-excerpt">
            <h1>Cart</h1>
          </div>
        </div>
        <div class="col-lg-7"></div>
      </div>
    </div>
  </div>
  <!-- End Hero Section -->

  <div class="untree_co-section before-footer-section">
    <div class="container">
      <div class="row mb-5">
        <form class="col-md-12" method="post" id="cartForm"> <%-- Add an ID to the form --%>
          <div class="site-blocks-table">
            <table class="table">
              <thead>
                <tr>
                  <th class="product-thumbnail">Image</th>
                  <th class="product-name">Product</th>
                  <th class="product-price">Price</th>
                  <th class="product-quantity">Quantity</th>
                  <th class="product-total">Total</th>
                  <th class="product-remove">Remove</th>
                </tr>
              </thead>
              <tbody>
                <% List<CartItem> cart = (List<CartItem>) request.getAttribute("cartItems");
                            if (cart != null && !cart.isEmpty()) {
                            for (CartItem item : cart) {
                            %>
                <tr>
                  <td class="product-thumbnail">
                    <img src="<%= item.getImagePath() %>" alt="Image" class="img-fluid" />
                  </td>
                  <td class="product-name">
                    <h2 class="h5 text-black">
                      <%= item.getName() %>
                    </h2>
                  </td>
                  <td>RM<%= String.format("%.2f", item.getPrice()) %>
                  </td>
                  <td>
                    <div class="input-group mb-3 d-flex align-items-center quantity-container"
                      style="max-width: 120px">
                      <div class="input-group-prepend">
                        <button class="btn btn-outline-black decrease-btn" type="button"> <%-- Removed onclick --%>
                          &minus;
                        </button>
                      </div>
                      <input type="text" class="form-control text-center quantity-amount"
                        value="<%= item.getQuantity() %>" readonly
                        data-product-id="<%= item.getProductId() %>" />
                      <div class="input-group-append">
                        <button class="btn btn-outline-black increase-btn" type="button"> <%-- Removed onclick --%>
                          &plus;
                        </button>
                      </div>
                    </div>
                  </td>
                  <td>RM<%= String.format("%.2f", item.getTotal()) %>
                  </td>
                  <td>
                    <a href="CartServlet?action=remove&productId=<%= item.getProductId() %>"
                      class="btn btn-black btn-sm">
                      X
                    </a>
                  </td>
                </tr>
                <% } } else { %>
                <tr>
                  <td colspan="6" class="text-center">Your cart is empty</td>
                </tr>
                <% } %>
              </tbody>
            </table>
          </div>
        </form>
      </div>

      <div class="row">
        <div class="col-md-6">
          <div class="row mb-5">
            <div class="col-md-6 mb-3 mb-md-0">
              <button class="btn btn-black btn-sm btn-block" onclick="submitCartUpdate()">
                Update Cart
              </button>
            </div>
            <div class="col-md-6">
              <button class="btn btn-outline-black btn-sm btn-block" onclick="window.location='ShopServlet'">
                Continue Shopping
              </button>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <label class="text-black h4" for="coupon">Coupon</label>
              <p>Enter your coupon code if you have one.</p>
            </div>
            <div class="col-md-8 mb-3 mb-md-0">
              <input type="text" class="form-control py-3" id="coupon" placeholder="Coupon Code" />
            </div>
            <div class="col-md-4">
              <button class="btn btn-black">Apply Coupon</button>
            </div>
          </div>
        </div>
        <div class="col-md-6 pl-5">
          <div class="row justify-content-end">
            <div class="col-md-7">
              <div class="row">
                <div class="col-md-12 text-right border-bottom mb-5">
                  <h3 class="text-black h4 text-uppercase">Cart Totals</h3>
                </div>
              </div>
              <div class="row mb-3">
                <div class="col-md-6">
                  <span class="text-black">Subtotal</span>
                </div>
                <div class="col-md-6 text-right">
                  <strong class="text-black">RM<%= String.format("%.2f", request.getAttribute("subtotal") !=null ?
                                (Double)request.getAttribute("subtotal") : 0.0) %></strong>
                </div>
              </div>
              <div class="row mb-5">
                <div class="col-md-6">
                  <span class="text-black">Total</span>
                </div>
                <div class="col-md-6 text-right">
                  <strong class="text-black">RM<%= String.format("%.2f", request.getAttribute("total") !=null ?
                                (Double)request.getAttribute("total") : 0.0) %></strong>
                </div>
              </div>

              <div class="row">
                <div class="col-md-12">
                  <button class="btn btn-black btn-lg py-3 btn-block" onclick="window.location='checkout.jsp'">
                    Proceed To Checkout
                  </button>
                </div>
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

      <div class="col-md-12 col-lg-3 mb-5 mb-lg-0"></div>
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
  <script>
    // This function now only handles updating the display of the quantity input
    function updateQuantityDisplay(button, change) {
      const input = button.closest('.quantity-container').querySelector('.quantity-amount');
      const currentValue = parseInt(input.value);
      const newValue = Math.max(1, currentValue + change);
      input.value = newValue;
      // console.log(`Quantity updated to: ${newValue}`); // For debugging: check if this logs correctly
    }

    function submitCartUpdate() {
      const cartForm = document.getElementById('cartForm');
      const quantities = document.querySelectorAll('.quantity-amount');

      // Clear previous hidden inputs to avoid duplicates on subsequent updates
      const oldHiddenInputs = cartForm.querySelectorAll('input[type="hidden"][name="productId"], input[type="hidden"][name="quantity"]');
      oldHiddenInputs.forEach(input => input.remove());
      
      // Create new hidden input fields for each product's quantity
      quantities.forEach(input => {
        const productId = input.getAttribute('data-product-id');
        const quantity = input.value;

        // Create a hidden input for product ID
        const productIdInput = document.createElement('input');
        productIdInput.type = 'hidden';
        productIdInput.name = 'productId';
        productIdInput.value = productId;
        cartForm.appendChild(productIdInput);

        // Create a hidden input for quantity
        const quantityInput = document.createElement('input');
        quantityInput.type = 'hidden';
        quantityInput.name = 'quantity';
        quantityInput.value = quantity;
        cartForm.appendChild(quantityInput);
      });

      // Set the form's action and submit it
      cartForm.action = 'CartServlet?action=updateAll';
      cartForm.method = 'POST';
      cartForm.submit();
    }

    // Attach event listeners after the DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
      // Get all decrease buttons and add event listener
      document.querySelectorAll('.decrease-btn').forEach(button => {
        button.addEventListener('click', function() {
          updateQuantityDisplay(this, -1);
        });
      });

      // Get all increase buttons and add event listener
      document.querySelectorAll('.increase-btn').forEach(button => {
        button.addEventListener('click', function() {
          updateQuantityDisplay(this, 1);
        });
      });
    });
  </script>
</body>

</html>
