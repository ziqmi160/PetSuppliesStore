<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.idea.model.CartItem" %>
<%@ page import="java.util.ArrayList" %> <%-- Added import for ArrayList --%>
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
  <title>Checkout</title>
</head>

<body>
  <!-- Start Header/Navigation -->
  <%@ include file="header.jsp" %>
  <!-- End Header/Navigation -->

  <!-- Start Hero Section -->
  <div class="hero">
    <div class="container">
      <div class="row justify-content-between">
        <div class="col-lg-5">
          <div class="intro-excerpt">
            <h1>Checkout</h1>
          </div>
        </div>
        <div class="col-lg-7"></div>
      </div>
    </div>
  </div>
  <!-- End Hero Section -->

  <div class="untree_co-section">
    <div class="container">
      <div class="row">
        <div class="col-md-6 mb-5 mb-md-0">
          <h2 class="h3 mb-3 text-black">Billing Details</h2>
          <div class="p-3 p-lg-5 border bg-white">
            <form action="CheckoutServlet" method="post">
              <div class="form-group row">
                <div class="col-md-6">
                  <label for="firstName" class="text-black">First Name <span class="text-danger">*</span></label>
                  <input type="text" class="form-control" id="firstName" name="firstName" required>
                </div>
                <div class="col-md-6">
                  <label for="lastName" class="text-black">Last Name <span class="text-danger">*</span></label>
                  <input type="text" class="form-control" id="lastName" name="lastName" required>
                </div>
              </div>

              <div class="form-group row">
                <div class="col-md-12">
                  <label for="email" class="text-black">Email <span class="text-danger">*</span></label>
                  <input type="email" class="form-control" id="email" name="email" required>
                </div>
              </div>

              <div class="form-group row">
                <div class="col-md-12">
                  <label for="address" class="text-black">Address <span class="text-danger">*</span></label>
                  <input type="text" class="form-control" id="address" name="address" placeholder="Street address"
                    required>
                </div>
              </div>

              <div class="form-group row">
                <div class="col-md-6">
                  <label for="city" class="text-black">City <span class="text-danger">*</span></label>
                  <input type="text" class="form-control" id="city" name="city" required>
                </div>
                <div class="col-md-6">
                  <label for="postalCode" class="text-black">Postal Code <span
                      class="text-danger">*</span></label>
                  <input type="text" class="form-control" id="postalCode" name="postalCode" required>
                </div>
              </div>

              <div class="form-group row mb-5">
                <div class="col-md-12">
                  <label for="phone" class="text-black">Phone <span class="text-danger">*</span></label>
                  <input type="tel" class="form-control" id="phone" name="phone" required>
                </div>
              </div>

              <div class="form-group">
                <label for="notes" class="text-black">Order Notes</label>
                <textarea name="notes" id="notes" cols="30" rows="5" class="form-control"
                  placeholder="Write your notes here..."></textarea>
              </div>

              <div class="form-group">
                <button type="submit" class="btn btn-black btn-lg py-3 btn-block">Place Order</button>
              </div>
            </form>
          </div>
        </div>
        <div class="col-md-6">
          <div class="row mb-5">
            <div class="col-md-12">
              <h2 class="h3 mb-3 text-black">Your Order</h2>
              <div class="p-3 p-lg-5 border bg-white">
                <table class="table site-block-order-table mb-5">
                  <thead>
                    <th>Product</th>
                    <th>Total</th>
                  </thead>
                  <tbody>
                    <%
                      // Retrieve selected cart items from session
                      List<CartItem> selectedCartItems = (List<CartItem>) session.getAttribute("selectedCartItemsForCheckout");
                      Double totalSelected = (Double) session.getAttribute("totalSelectedForCheckout");

                      // Initialize if not found (e.g., direct access or session expired)
                      if (selectedCartItems == null) {
                          selectedCartItems = new ArrayList<CartItem>(); // Changed: Removed diamond operator
                      }
                      if (totalSelected == null) {
                          totalSelected = 0.0;
                      }

                      // Iterate and display selected items
                      if (!selectedCartItems.isEmpty()) {
                          for (CartItem item : selectedCartItems) {
                    %>
                    <tr>
                      <td>
                        <%= item.getName() %> <strong class="mx-2">x</strong>
                        <%= item.getQuantity() %>
                      </td>
                      <td>RM<%= String.format("%.2f", item.getTotal()) %>
                      </td>
                    </tr>
                    <%
                          }
                      } else {
                    %>
                    <tr>
                      <td colspan="2" class="text-center">No items selected for checkout. Please go back to cart.</td>
                    </tr>
                    <%
                      }
                    %>
                    <tr>
                      <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
                      <td class="text-black font-weight-bold"><strong>RM<%= String.format("%.2f", totalSelected) %></strong></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="col-md-12 col-lg-3 mb-5 mb-lg-0"></div>
  <div class="col-md-12 col-lg-3 mb-5 mb-lg-0"></div>
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
