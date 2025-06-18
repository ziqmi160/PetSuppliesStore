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
    <title>About Us</title>
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
              <h1>About Us</h1>
              <p class="mb-4">
                At <strong>Idea</strong>, we believe that great furniture
                transforms a house into a home. Founded on a passion for
                innovative design and quality craftsmanship.
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

    <!-- Start Team Section -->
    <div class="untree_co-section">
      <div class="container">
        <!-- Start First Row with 3 Columns -->
        <div class="untree_co-section">
          <div class="container">
            <div class="row mb-5">
              <div class="col-lg-5 mx-auto text-center">
                <h2 class="section-title">Our Team</h2>
              </div>
            </div>

            <!-- Start First Row with 3 Columns -->
            <div class="row justify-content-center">
              <!-- Start Column 1 -->
              <div class="col-12 col-md-6 col-lg-4 mb-5">
                <img src="images/daniel-pic.jpg" class="img-fluid mb-5" />
                <h3 class="text-center">
                  <a href="#" style="text-decoration: none"
                    ><span class="">Daniel</span> Iskandar</a
                  >
                </h3>
                <span class="d-block position mb-4 text-center">Founder</span>
                <p class="text-center">
                  We blend timeless design with modern innovation to craft
                  furniture that enriches your space and story.
                </p>
              </div>
              <!-- End Column 1 -->

              <!-- Start Column 2 -->
              <div class="col-12 col-md-6 col-lg-4 mb-5">
                <img src="images/asyraf-pic.jpg" class="img-fluid mb-5" />
                <h3 class="text-center">
                  <a href="#" style="text-decoration: none"
                    ><span class="">Asyraf</span> Haikal</a
                  >
                </h3>
                <span class="d-block position mb-4 text-center"
                  >Chief Operating Officer (COO)</span
                >
                <p class="text-center">
                  As Warren Buffett said, if the skies darkened and there's an
                  opportunity it's going to rain gold, you want to run outside
                  with washtubs and not teaspoons.
                </p>
              </div>
              <!-- End Column 2 -->

              <!-- Start Column 3 -->
              <div class="col-12 col-md-6 col-lg-4 mb-5">
                <img src="images/haziq-pic.jpg" class="img-fluid mb-5" />
                <h3 class="text-center">
                  <a href="#" style="text-decoration: none"
                    ><span class="">Haziq</span> Hilmi</a
                  >
                </h3>
                <span class="d-block position mb-4 text-center"
                  >Chief Financial Officer (CFO)</span
                >
                <p class="text-center">
                  You can have brilliant ideas, but if you can’t get them
                  across, your ideas won’t get you anywhere.
                </p>
              </div>
              <!-- End Column 3 -->
            </div>
            <!-- End First Row -->

            <!-- Start Second Row with 2 Columns -->
            <div class="row justify-content-center">
              <!-- Start Column 4 -->
              <div class="col-12 col-md-6 col-lg-4 mb-5">
                <img src="images/aidil-pic.jpg" class="img-fluid mb-5" />
                <h3 class="text-center">
                  <a href="#" style="text-decoration: none"
                    ><span class="">Aidil</span> Azani</a
                  >
                </h3>
                <span class="d-block position mb-4 text-center"
                  >Chief Technology Officer (CTO)</span
                >
                <p class="text-center">
                  The most dangerous poison is the feeling of achievement. The
                  antidote is to every evening think what can be done better
                  tomorrow.
                </p>
              </div>
              <!-- End Column 4 -->

              <!-- Start Column 5 -->
              <div class="col-12 col-md-6 col-lg-4 mb-5">
                <img src="images/kimi-pic.jpg" class="img-fluid mb-5" />
                <h3 class="text-center">
                  <a href="#" style="text-decoration: none"
                    ><span class="">Muhammad</span> Hakimi</a
                  >
                </h3>
                <span class="d-block position mb-4 text-center"
                  >Chief Human Resources Officer (CHRO)</span
                >
                <p class="text-center">
                  Comfort zone is a nice place, but nothing grows there.
                </p>
              </div>
              <!-- End Column 5 -->
            </div>
            <!-- End Second Row -->
          </div>
        </div>
      </div>
    </div>
    <!-- End Team Section -->

    <!-- Start Why Choose Us Section -->
    <div class="why-choose-section">
      <div class="container">
        <div class="row justify-content-between align-items-center">
          <div class="col-lg-6">
            <h2 class="section-title">Why Choose Us</h2>
            <p>
              We prioritize customer satisfaction with personalized service,
              affordable prices, and reliable delivery. Choose Idea for quality,
              style, and a seamless shopping experience you can trust.
            </p>

            <div class="row my-5">
              <div class="col-6 col-md-6">
                <div class="feature">
                  <div class="icon">
                    <img src="images/truck.svg" alt="Image" class="imf-fluid" />
                  </div>
                  <h3>Fast &amp; Free Shipping</h3>
                  <p>Shipping in 5-7 working day.</p>
                </div>
              </div>

              <div class="col-6 col-md-6">
                <div class="feature">
                  <div class="icon">
                    <img src="images/bag.svg" alt="Image" class="imf-fluid" />
                  </div>
                  <h3>Easy to Shop</h3>
                  <p>Browse our catalog and choose the one you like.</p>
                </div>
              </div>

              <div class="col-6 col-md-6">
                <div class="feature">
                  <div class="icon">
                    <img
                      src="images/support.svg"
                      alt="Image"
                      class="imf-fluid"
                    />
                  </div>
                  <h3>24/7 Support</h3>
                  <p>Our customer's service wil help you with your inquiry.</p>
                </div>
              </div>

              <div class="col-6 col-md-6">
                <div class="feature">
                  <div class="icon">
                    <img
                      src="images/return.svg"
                      alt="Image"
                      class="imf-fluid"
                    />
                  </div>
                  <h3>Hassle Free Returns</h3>
                  <p>
                    Something missing? tell us and we will give you a brand new
                    one.
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-5">
            <div class="img-wrap">
              <img
                src="images/why-choose-us-img.jpg"
                alt="Image"
                class="img-fluid"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- End Why Choose Us Section -->

    <!-- Start Testimonial Slider -->
    <div class="testimonial-section">
      <div class="container">
        <div class="row">
          <div class="col-lg-7 mx-auto text-center">
            <h2 class="section-title">Testimonials</h2>
          </div>
        </div>

        <div class="row justify-content-center">
          <div class="col-lg-12">
            <div class="testimonial-slider-wrap text-center">
              <div id="testimonial-nav">
                <span class="prev" data-controls="prev"
                  ><span class="fa fa-chevron-left"></span
                ></span>
                <span class="next" data-controls="next"
                  ><span class="fa fa-chevron-right"></span
                ></span>
              </div>

              <div class="testimonial-slider">
                <div class="item">
                  <div class="row justify-content-center">
                    <div class="col-lg-8 mx-auto">
                      <div class="testimonial-block text-center">
                        <blockquote class="mb-5">
                          <p>
                            &ldquo;I’m really impressed with the quality and
                            design of the furniture. Our living room feels
                            completely transformed and looks amazing. The pieces
                            are both stylish and comfortable. I highly recommend
                            this store to anyone looking to upgrade their
                            home.&rdquo;
                          </p>
                        </blockquote>

                        <div class="author-info">
                          <div class="author-pic">
                            <img
                              src="images/person-1.jpg"
                              alt="Aswan Jomri"
                              class="img-fluid"
                            />
                          </div>
                          <h3 class="font-weight-bold">Aswan Jomri</h3>
                          <span class="position d-block mb-3">Customer</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END item -->

                <div class="item">
                  <div class="row justify-content-center">
                    <div class="col-lg-8 mx-auto">
                      <div class="testimonial-block text-center">
                        <blockquote class="mb-5">
                          <p>
                            &ldquo;The delivery was prompt, and the furniture
                            matched the description perfectly as advertised.
                            It’s comfortable and adds a modern touch to my
                            space. The whole experience was smooth and
                            hassle-free. Customer service was excellent from
                            start to finish.&rdquo;
                          </p>
                        </blockquote>

                        <div class="author-info">
                          <div class="author-pic">
                            <img
                              src="images/person-2.jpg"
                              alt="Danial Atlas"
                              class="img-fluid"
                            />
                          </div>
                          <h3 class="font-weight-bold">Danial Atlas</h3>
                          <span class="position d-block mb-3">Customer</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END item -->

                <div class="item">
                  <div class="row justify-content-center">
                    <div class="col-lg-8 mx-auto">
                      <div class="testimonial-block text-center">
                        <blockquote class="mb-5">
                          <p>
                            &ldquo;I was pleasantly surprised by how affordable
                            the prices were, especially considering the quality.
                            My new dining set is not only stylish but also very
                            sturdy. Great value for money! I’m very happy with
                            my purchase and will definitely shop here
                            again.&rdquo;
                          </p>
                        </blockquote>

                        <div class="author-info">
                          <div class="author-pic">
                            <img
                              src="images/person-3.jpg"
                              alt="Jofsyar Shri"
                              class="img-fluid"
                            />
                          </div>
                          <h3 class="font-weight-bold">Jofsyar Shri</h3>
                          <span class="position d-block mb-3">Customer</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- END item -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- End Testimonial Slider -->

    <!-- Start Footer Section -->
    <footer class="footer-section">
      <div class="container relative">
        <div class="sofa-img">
          <img src="images/sofa.png" alt="Image" class="img-fluid" />
        </div>

        <!-- div class="row">
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
  </body>
</html>
