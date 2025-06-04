<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Index - Yummy Bootstrap Template</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />

    <!-- Favicons -->
    <link
      href="${pageContext.request.contextPath}/resources/img/favicon.png"
      rel="icon"
    />
    <link
      href="${pageContext.request.contextPath}/resources/img/apple-touch-icon.png"
      rel="apple-touch-icon"
    />

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Amatic+SC:wght@400;700&display=swap"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link
      href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/vendor/bootstrap-icons/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/vendor/aos/aos.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/vendor/glightbox/css/glightbox.min.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/vendor/swiper/swiper-bundle.min.css"
      rel="stylesheet"
    />

    <!-- Main CSS File -->
    <link
      href="${pageContext.request.contextPath}/resources/css/main.css"
      rel="stylesheet"
    />

    <!-- Hiển thị thông báo nếu có -->
    <c:if test="${not empty message}">
      <div
        class="alert alert-${status == 'success' ? 'success' : 'danger'} alert-dismissible fade show"
        role="alert"
        style="position: fixed; top: 20px; right: 20px; z-index: 9999"
      >
        ${message}
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="alert"
          aria-label="Close"
        ></button>
      </div>
    </c:if>
  </head>
  <body class="index-page">
    <header id="header" class="header d-flex align-items-center sticky-top">
      <div
        class="container position-relative d-flex align-items-center justify-content-between"
      >
        <a
          href="index.jsp"
          class="logo d-flex align-items-center me-auto me-xl-0"
        >
          <!-- Uncomment the line below if you also wish to use an image logo -->
          <!-- <img src="assets/img/logo.png" alt=""> -->
          <h1 class="sitename">MyHanhSeaFood</h1>
          <span>.</span>
        </a>

        <nav id="navmenu" class="navmenu">
          <ul>
            <li>
              <a href="#hero" class="active">Trang chủ<br /></a>
            </li>
            <li><a href="#about">Về chúng tôi</a></li>
            <li><a href="#menu">Thực đơn</a></li>
            <li><a href="#events">Sự kiện</a></li>
            <li><a href="#chefs">Đầu bếp</a></li>
            <li><a href="#gallery">Trưng bày</a></li>
            <li><a href="#contact">Liên hệ</a></li>
          </ul>
          <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
        </nav>

        <a class="btn-getstarted" href="#book-a-table">Đặt bàn</a>
      </div>
    </header>

    <main class="main">
      <%
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
      %>
      <div class="alert alert-success" id="success-alert" style="position:relative;">
        <span><%= successMessage %></span>
        <button type="button" onclick="document.getElementById('success-alert').style.display='none';"
                style="position:absolute; right:10px; top:10px; background:transparent; border:none; font-size:20px; cursor:pointer;">&times;</button>
      </div>
      <%
          session.removeAttribute("successMessage");
        }
      %>
      <%
        String failMessage = (String) session.getAttribute("failMessage");
        if (failMessage != null) {
      %>
      <div class="alert alert-fail" id="fail-alert" style="position:relative;">
        <span><%= failMessage %></span>
        <button type="button" onclick="document.getElementById('fail-alert').style.display='none';"
                style="position:absolute; right:10px; top:10px; background:transparent; border:none; font-size:20px; cursor:pointer;">&times;</button>
      </div>
      <%
          session.removeAttribute("failMessage");
        }
      %>
      <!-- Hero Section -->
      <section id="hero" class="hero section light-background">
        <div class="container">
          <div
            class="row gy-4 justify-content-center justify-content-lg-between"
          >
            <div
              class="col-lg-5 order-2 order-lg-1 d-flex flex-column justify-content-center"
            >
              <h1 data-aos="fade-up">
                Thưởng Thức Đồ Ăn Ngon<br />Tốt Cho Sức Khỏe
              </h1>
              <p data-aos="fade-up" data-aos-delay="100">
                Đảm bảo chất lượng phục vụ và món ăn đảm bảo cho khách hàng
              </p>
              <div class="d-flex" data-aos="fade-up" data-aos-delay="200">
                <a href="#book-a-table" class="btn-get-started">Đặt bàn ngay</a>
                <a
                  href="https://www.youtube.com/watch?v=Y7f98aduVJ8"
                  class="glightbox btn-watch-video d-flex align-items-center"
                  ><i class="bi bi-play-circle"></i><span>Xem video</span></a
                >
              </div>
            </div>
            <div
              class="col-lg-5 order-1 order-lg-2 hero-img"
              data-aos="zoom-out"
            >
              <img
                src="${pageContext.request.contextPath}/resources/img/hero-img.png"
                class="img-fluid animated"
                alt=""
              />
            </div>
          </div>
        </div>
      </section>
      <!-- /Hero Section -->

      <!-- About Section -->
      <section id="about" class="about section">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Về chúng tôi<br /></h2>
          <p>
            <span>Biết thêm</span>
            <span class="description-title">về chúng tôi</span>
          </p>
        </div>
        <!-- End Section Title -->

        <div class="container">
          <div class="row gy-4">
            <div class="col-lg-7" data-aos="fade-up" data-aos-delay="100">
              <img
                src="${pageContext.request.contextPath}/resources/img/about.jpg"
                class="img-fluid mb-4"
                alt=""
              />
              <div class="book-a-table">
                <h3>Đặt bàn ngay</h3>
                <p>0971623584</p>
              </div>
            </div>
            <div class="col-lg-5" data-aos="fade-up" data-aos-delay="250">
              <div class="content ps-0 ps-lg-5">
                <p class="fst-italic">
                  Nhà Hàng MyHanhSeaFood tự hào là điểm đến lý tưởng cho những
                  bữa tiệc gia đình, buổi hẹn hò lãng mạn, hay các cuộc gặp gỡ
                  bạn bè.
                </p>
                <ul>
                  <li>
                    <i class="bi bi-check-circle-fill"></i>
                    <span
                      >Thực đơn đa dạng, phong phú – từ các món ăn truyền thống
                      đến các món hiện đại, phù hợp với mọi sở thích.</span
                    >
                  </li>
                  <li>
                    <i class="bi bi-check-circle-fill"></i>
                    <span
                      >Không gian sang trọng, ấm cúng – thiết kế hiện đại nhưng
                      vẫn mang lại cảm giác thoải mái, gần gũi.</span
                    >
                  </li>
                  <li>
                    <i class="bi bi-check-circle-fill"></i>
                    <span
                      >Dịch vụ chuyên nghiệp – đội ngũ nhân viên tận tâm và luôn
                      sẵn sàng phục vụ bạn mọi lúc.</span
                    >
                  </li>
                </ul>
                <p>
                  Hãy gọi ngay để đặt bàn cho bữa tiệc tiếp theo của bạn tại Nhà
                  Hàng MyHanhSeaFood. Chúng tôi sẽ chuẩn bị mọi thứ cho một bữa
                  ăn tuyệt vời!
                </p>

                <div class="position-relative mt-4">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/about-2.jpg"
                    class="img-fluid"
                    alt=""
                  />
                  <a
                    href="https://www.youtube.com/watch?v=Y7f98aduVJ8"
                    class="glightbox pulsating-play-btn"
                  ></a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- /About Section -->

      <!-- Why Us Section -->
      <section id="why-us" class="why-us section light-background">
        <div class="container">
          <div class="row gy-4">
            <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
              <div class="why-box">
                <h3>Tại sao chọn MyHanhSeaFood</h3>
                <p>
                  Nhà hàng MyHanhSeaFood cam kết mang đến những món ăn ngon
                  miệng với chất lượng hàng đầu. Chúng tôi luôn tìm cách mang
                  đến cho bạn những trải nghiệm ẩm thực tuyệt vời nhất với không
                  gian thoải mái và dịch vụ chuyên nghiệp.
                </p>
                <div class="text-center">
                  <a href="#" class="more-btn"
                    ><span>Đọc thêm</span> <i class="bi bi-chevron-right"></i
                  ></a>
                </div>
              </div>
            </div>
            <!-- End Why Box -->

            <div class="col-lg-8 d-flex align-items-stretch">
              <div class="row gy-4" data-aos="fade-up" data-aos-delay="200">
                <div class="col-xl-4">
                  <div
                    class="icon-box d-flex flex-column justify-content-center align-items-center"
                  >
                    <i class="bi bi-clipboard-data"></i>
                    <h4>Chất lượng thực phẩm đảm bảo</h4>
                    <p>
                      Chúng tôi sử dụng nguyên liệu tươi ngon và an toàn nhất.
                    </p>
                  </div>
                </div>
                <!-- End Icon Box -->

                <div class="col-xl-4" data-aos="fade-up" data-aos-delay="300">
                  <div
                    class="icon-box d-flex flex-column justify-content-center align-items-center"
                  >
                    <i class="bi bi-gem"></i>
                    <h4>Thực đơn phong phú</h4>
                    <p>
                      Mỗi món ăn đều được chế biến tinh tế, đa dạng để phù hợp
                      với tất cả khẩu vị.
                    </p>
                  </div>
                </div>
                <!-- End Icon Box -->

                <div class="col-xl-4" data-aos="fade-up" data-aos-delay="400">
                  <div
                    class="icon-box d-flex flex-column justify-content-center align-items-center"
                  >
                    <i class="bi bi-inboxes"></i>
                    <h4>Không gian sang trọng</h4>
                    <p>
                      Một không gian lý tưởng để thưởng thức bữa ăn cùng gia
                      đình và bạn bè.
                    </p>
                  </div>
                </div>
                <!-- End Icon Box -->
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- /Why Us Section -->

      <!-- Stats Section -->
      <section id="stats" class="stats section dark-background">
        <img
          src="${pageContext.request.contextPath}/resources/img/stats-bg.jpg"
          alt=""
          data-aos="fade-in"
        />

        <div
          class="container position-relative"
          data-aos="fade-up"
          data-aos-delay="100"
        >
          <div class="row gy-4">
            <div class="col-lg-3 col-md-6">
              <div class="stats-item text-center w-100 h-100">
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="232"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p>Khách hàng</p>
              </div>
            </div>
            <!-- End Stats Item -->

            <div class="col-lg-3 col-md-6">
              <div class="stats-item text-center w-100 h-100">
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="15"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p>Món ăn</p>
              </div>
            </div>
            <!-- End Stats Item -->

            <div class="col-lg-3 col-md-6">
              <div class="stats-item text-center w-100 h-100">
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="1453"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p>Số giờ hỗ trợ</p>
              </div>
            </div>
            <!-- End Stats Item -->

            <div class="col-lg-3 col-md-6">
              <div class="stats-item text-center w-100 h-100">
                <span
                  data-purecounter-start="0"
                  data-purecounter-end="32"
                  data-purecounter-duration="1"
                  class="purecounter"
                ></span>
                <p>Nhân viên</p>
              </div>
            </div>
            <!-- End Stats Item -->
          </div>
        </div>
      </section>
      <!-- /Stats Section -->

      <!-- Menu Section -->
      <section id="menu" class="menu section">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Thực đơn của chúng tôi</h2>
          <p>
            <span>Xem thực đơn</span>
            <span class="description-title">Nhà hàng MyHanhSeaFood</span>
          </p>
        </div>
        <!-- End Section Title -->

        <%@ include file="/WEB-INF/views/client/list-food.jsp" %>
      </section>
      <!-- /Menu Section -->

      <!-- Testimonials Section -->
      <section id="testimonials" class="testimonials section light-background">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Đánh giá từ khách hàng</h2>
          <p>
            Khách hàng
            <span class="description-title">Nói gì về chúng tôi</span>
          </p>
        </div>
        <!-- End Section Title -->

        <div class="container" data-aos="fade-up" data-aos-delay="100">
          <div class="swiper init-swiper">
            <script type="application/json" class="swiper-config">
              {
                "loop": true,
                "speed": 600,
                "autoplay": {
                  "delay": 5000
                },
                "slidesPerView": "auto",
                "pagination": {
                  "el": ".swiper-pagination",
                  "type": "bullets",
                  "clickable": true
                }
              }
            </script>
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <div class="testimonial-item">
                  <div class="row gy-4 justify-content-center">
                    <div class="col-lg-6">
                      <div class="testimonial-content">
                        <p>
                          <i class="bi bi-quote quote-icon-left"></i>
                          <span
                            >"Mỹ Hạnh Sea Food có không gian rộng rãi, thoáng
                            mát và rất sạch sẽ. Hải sản tươi ngon, chế biến vừa
                            miệng, đặc biệt là món tôm hùm và cua biển rất đậm
                            đà. Nhân viên phục vụ nhiệt tình, thân thiện khiến
                            tôi cảm thấy rất hài lòng. Chắc chắn sẽ quay lại lần
                            sau!"</span
                          >
                          <i class="bi bi-quote quote-icon-right"></i>
                        </p>
                        <h3>Nguyễn Thanh Tùng</h3>
                        <h4>Khách ăn</h4>
                        <div class="stars">
                          <i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-2 text-center">
                      <img
                        src="${pageContext.request.contextPath}/resources/img/testimonials/testimonials-1.jpg"
                        class="img-fluid testimonial-img"
                        alt=""
                      />
                    </div>
                  </div>
                </div>
              </div>
              <!-- End testimonial item -->

              <div class="swiper-slide">
                <div class="testimonial-item">
                  <div class="row gy-4 justify-content-center">
                    <div class="col-lg-6">
                      <div class="testimonial-content">
                        <p>
                          <i class="bi bi-quote quote-icon-left"></i>
                          <span
                            >"Nhà hàng Mỹ Hạnh có thực đơn đa dạng, giá cả hợp
                            lý so với chất lượng. Mình đặc biệt thích món sò
                            huyết nướng mỡ hành ở đây, rất thơm ngon. Tuy nhiên,
                            vào cuối tuần nhà hàng hơi đông, nên có lúc phải chờ
                            lâu một chút. Nhưng tổng thể vẫn rất đáng để
                            thử."</span
                          >
                          <i class="bi bi-quote quote-icon-right"></i>
                        </p>
                        <h3>Lê Thị Hạnh</h3>
                        <h4>Khách hàng</h4>
                        <div class="stars">
                          <i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-2 text-center">
                      <img
                        src="${pageContext.request.contextPath}/resources/img/testimonials/testimonials-2.jpg"
                        class="img-fluid testimonial-img"
                        alt=""
                      />
                    </div>
                  </div>
                </div>
              </div>
              <!-- End testimonial item -->

              <div class="swiper-slide">
                <div class="testimonial-item">
                  <div class="row gy-4 justify-content-center">
                    <div class="col-lg-6">
                      <div class="testimonial-content">
                        <p>
                          <i class="bi bi-quote quote-icon-left"></i>
                          <span
                            >"Tôi rất thích không khí ở Mỹ Hạnh Sea Food, có thể
                            ngồi ngoài trời nhìn ra biển rất thư giãn. Hải sản
                            được chế biến tươi mới và rất ngon. Đặc biệt, món
                            lẩu hải sản rất đậm đà và nhiều loại tươi ngon. Nhân
                            viên rất chu đáo, phục vụ nhanh chóng."
                          </span>
                          <i class="bi bi-quote quote-icon-right"></i>
                        </p>
                        <h3>Phạm Văn Dũng</h3>
                        <h4>Khách hàng</h4>
                        <div class="stars">
                          <i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-2 text-center">
                      <img
                        src="${pageContext.request.contextPath}/resources/img/testimonials/testimonials-3.jpg"
                        class="img-fluid testimonial-img"
                        alt=""
                      />
                    </div>
                  </div>
                </div>
              </div>
              <!-- End testimonial item -->

              <div class="swiper-slide">
                <div class="testimonial-item">
                  <div class="row gy-4 justify-content-center">
                    <div class="col-lg-6">
                      <div class="testimonial-content">
                        <p>
                          <i class="bi bi-quote quote-icon-left"></i>
                          <span
                            >"Mỹ Hạnh Sea Food có vị trí đẹp, hải sản khá tươi,
                            nhưng mình cảm thấy món ăn chưa đậm đà bằng mong
                            đợi. Giá cả thì hơi cao so với số lượng món ăn. Phục
                            vụ cũng ổn, nhưng cần cải thiện về tốc độ phục vụ
                            khi đông khách."
                          </span>
                          <i class="bi bi-quote quote-icon-right"></i>
                        </p>
                        <h3>Trần Thị Mai</h3>
                        <h4>Khách hàng</h4>
                        <div class="stars">
                          <i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i
                          ><i class="bi bi-star-fill"></i>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-2 text-center">
                      <img
                        src="${pageContext.request.contextPath}/resources/img/testimonials/testimonials-4.jpg"
                        class="img-fluid testimonial-img"
                        alt=""
                      />
                    </div>
                  </div>
                </div>
              </div>
              <!-- End testimonial item -->
            </div>
            <div class="swiper-pagination"></div>
          </div>
        </div>
      </section>
      <!-- /Testimonials Section -->

      <!-- Events Section -->
      <section id="events" class="events section">
        <div class="container-fluid" data-aos="fade-up" data-aos-delay="100">
          <div class="swiper init-swiper">
            <script type="application/json" class="swiper-config">
              {
                "loop": true,
                "speed": 600,
                "autoplay": {
                  "delay": 5000
                },
                "slidesPerView": "auto",
                "pagination": {
                  "el": ".swiper-pagination",
                  "type": "bullets",
                  "clickable": true
                },
                "breakpoints": {
                  "320": {
                    "slidesPerView": 1,
                    "spaceBetween": 40
                  },
                  "1200": {
                    "slidesPerView": 3,
                    "spaceBetween": 1
                  }
                }
              }
            </script>
            <div class="swiper-wrapper">
              <c:forEach var="combo" items="${combos}">
                <div
                  class="swiper-slide event-item d-flex flex-column justify-content-end"
                  style="background-image: url(${combo.imageUrl})"
                  onclick="addCombo('${combo.name}')"
                >
                  <h3>${combo.name}</h3>
                  <div class="price align-self-start">$${combo.price}</div>
                  <p class="description">${combo.description}</p>
                </div>
              </c:forEach>

              <%--
              <div
                class="swiper-slide event-item d-flex flex-column justify-content-end"
                style="
                  background-image: url(${pageContext.request.contextPath}/resources/img/events-2.jpg);
                "
              >
                --%> <%--
                <h3>Tiệc Riêng Tư</h3>
                --%> <%--
                <div class="price align-self-start">$289</div>
                --%> <%--
                <p class="description">
                  --%> <%-- Dịch vụ tổ chức tiệc riêng, không gian dành riêng
                  cho nhóm nhỏ, nơi bạn có thể thưởng thức bữa ăn ngon mà không
                  bị làm phiền.--%> <%--
                </p>
                --%> <%--
              </div>
              <!-- End Event item -->--%> <%--
              <div
                class="swiper-slide event-item d-flex flex-column justify-content-end"
                style="
                  background-image: url(${pageContext.request.contextPath}/resources/img/events-3.jpg);
                "
              >
                --%> <%--
                <h3>Tiệc Sinh Nhật</h3>
                --%> <%--
                <div class="price align-self-start">$499</div>
                --%> <%--
                <p class="description">
                  --%> <%-- Tổ chức tiệc sinh nhật hoàn hảo với thực đơn đặc
                  biệt, trang trí sinh động và không gian tuyệt vời. Chúng tôi
                  sẽ chăm sóc tất cả mọi thứ để bạn có thể tận hưởng ngày vui
                  trọn vẹn!--%> <%--
                </p>
                --%> <%--
              </div>
              <!-- End Event item -->--%> <%--
              <div
                class="swiper-slide event-item d-flex flex-column justify-content-end"
                style="
                  background-image: url(${pageContext.request.contextPath}/resources/img/events-4.jpg);
                "
              >
                --%> <%--
                <h3>Tiệc Cưới</h3>
                --%> <%--
                <div class="price align-self-start">$899</div>
                --%> <%--
                <p class="description">
                  --%> <%-- Tổ chức tiệc cưới trọn gói với không gian trang trí
                  lãng mạn, thực đơn món ăn tinh tế và dịch vụ chu đáo.--%> <%--
                </p>
                --%> <%--
              </div>
              <!-- End Event item -->--%>
            </div>
            <div class="swiper-pagination"></div>
          </div>
        </div>
      </section>
      <!-- /Events Section -->

      <!-- Chefs Section -->
      <section id="chefs" class="chefs section">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Đầu bếp</h2>
          <p>
            <span>Đội ngũ đầu bếp</span>
            <span class="description-title">Của nhà hàng<br /></span>
          </p>
        </div>
        <!-- End Section Title -->

        <div class="container">
          <div class="row gy-4">
            <div
              class="col-lg-4 d-flex align-items-stretch"
              data-aos="fade-up"
              data-aos-delay="100"
            >
              <div class="team-member">
                <div class="member-img">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/chefs/chefs-1.jpg"
                    class="img-fluid"
                    alt=""
                  />
                  <div class="social">
                    <a href=""><i class="bi bi-twitter-x"></i></a>
                    <a href=""><i class="bi bi-facebook"></i></a>
                    <a href=""><i class="bi bi-instagram"></i></a>
                    <a href=""><i class="bi bi-linkedin"></i></a>
                  </div>
                </div>
                <div class="member-info">
                  <h4>Walter White</h4>
                  <span>Master Chef</span>
                  <p>
                    Với kinh nghiệm lâu năm trong ngành ẩm thực, Walter White
                    luôn sáng tạo và mang đến những món ăn độc đáo, đậm đà hương
                    vị.
                  </p>
                </div>
              </div>
            </div>
            <!-- End Chef Team Member -->

            <div
              class="col-lg-4 d-flex align-items-stretch"
              data-aos="fade-up"
              data-aos-delay="200"
            >
              <div class="team-member">
                <div class="member-img">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/chefs/chefs-2.jpg"
                    class="img-fluid"
                    alt=""
                  />
                  <div class="social">
                    <a href=""><i class="bi bi-twitter-x"></i></a>
                    <a href=""><i class="bi bi-facebook"></i></a>
                    <a href=""><i class="bi bi-instagram"></i></a>
                    <a href=""><i class="bi bi-linkedin"></i></a>
                  </div>
                </div>
                <div class="member-info">
                  <h4>Sarah Jhonson</h4>
                  <span>Patissier</span>
                  <p>
                    Sarah là chuyên gia làm bánh tại nhà hàng. Cô ấy mang đến
                    những chiếc bánh ngọt tuyệt vời, từ các món truyền thống đến
                    hiện đại, luôn đảm bảo chất lượng và hương vị hoàn hảo.
                  </p>
                </div>
              </div>
            </div>
            <!-- End Chef Team Member -->

            <div
              class="col-lg-4 d-flex align-items-stretch"
              data-aos="fade-up"
              data-aos-delay="300"
            >
              <div class="team-member">
                <div class="member-img">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/chefs/chefs-3.jpg"
                    class="img-fluid"
                    alt=""
                  />
                  <div class="social">
                    <a href=""><i class="bi bi-twitter-x"></i></a>
                    <a href=""><i class="bi bi-facebook"></i></a>
                    <a href=""><i class="bi bi-instagram"></i></a>
                    <a href=""><i class="bi bi-linkedin"></i></a>
                  </div>
                </div>
                <div class="member-info">
                  <h4>William Anderson</h4>
                  <span>Cook</span>
                  <p>
                    William Anderson là đầu bếp với khả năng sáng tạo cao, luôn
                    nỗ lực mang đến những món ăn vừa ngon vừa đẹp mắt.
                  </p>
                </div>
              </div>
            </div>
            <!-- End Chef Team Member -->
          </div>
        </div>
      </section>
      <!-- /Chefs Section -->

      <!-- Book A Table Section -->
      <section id="book-a-table" class="book-a-table section">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Đặt bàn</h2>
          <p>
            <span>Hãy Đặt Bàn</span>
            <span class="description-title">Để Đến Với Chúng Tôi<br /></span>
          </p>
        </div>
        <!-- End Section Title -->

        <div class="container">
          <div class="row g-0" data-aos="fade-up" data-aos-delay="100">
            <div
              class="col-lg-4 reservation-img"
              style="
                background-image: url(${pageContext.request.contextPath}/resources/img/reservation.jpg);
              "
            ></div>

            <div
              class="col-lg-8 d-flex align-items-center reservation-form-bg"
              data-aos="fade-up"
              data-aos-delay="200"
            >
              <form
                id="reservationForm"
                action="${pageContext.request.contextPath}/book-table"
                method="post"
                role="form"
                class="php-email-form"
                enctype="application/x-www-form-urlencoded"
              >
                <div class="row gy-4">
                  <div class="col-lg-4 col-md-6">
                    <input
                      type="text"
                      name="name"
                      class="form-control"
                      id="name"
                      placeholder="Tên của bạn"
                      required
                    />
                  </div>
                  <div class="col-lg-4 col-md-6">
                    <input
                      type="email"
                      class="form-control"
                      name="email"
                      id="email"
                      placeholder="Email của bạn"
                      required
                    />
                  </div>
                  <div class="col-lg-4 col-md-6">
                    <input
                      type="text"
                      class="form-control"
                      name="phone"
                      id="phone"
                      placeholder="Số điện thoại"
                      required
                    />
                  </div>
                  <div class="col-lg-4 col-md-6">
                    <input
                      type="date"
                      name="date"
                      class="form-control"
                      id="date"
                      placeholder="Ngày đặt"
                      required
                    />
                  </div>
                  <div class="col-lg-4 col-md-6">
                    <input
                      type="time"
                      class="form-control"
                      name="time"
                      id="time"
                      placeholder="Thời gian"
                      required
                    />
                  </div>
                  <div class="col-lg-4 col-md-6">
                    <input
                      type="number"
                      class="form-control"
                      name="people"
                      id="people"
                      placeholder="# số người"
                      required
                    />
                  </div>
                </div>

                <div class="form-group mt-3">
                  <textarea
                    class="form-control"
                    name="message"
                    rows="5"
                    id="orderTextArea"
                    placeholder="Vui lòng chọn món hoặc combo!"
                    required
                  ></textarea>
                  <input type="hidden" name="orderDetails" id="orderDetails" />
                  <input type="hidden" name="orderType" id="orderType" />
                </div>

                <div class="text-center mt-3">
                  <div class="loading d-none">Loading</div>
                  <div class="error-message"></div>
                  <div class="sent-message d-none">
                    Bạn đã đặt bàn thành công. Chúng tôi sẽ gửi email để xác
                    minh. Xin cảm ơn!
                  </div>
                  <button type="submit">Đặt bàn</button>
                </div>
                <script>
                  // Biến lưu trạng thái combo và món ăn đã chọn
                  var comboOrder = {};
                  var foodOrder = {};
                  var currentMode = ""; // 'combo' hoặc 'food'

                  // Hàm thêm combo vào order
                  function addCombo(comboName) {
                    // Xóa các món ăn đã chọn nếu đang ở mode food
                    if (currentMode === "food") {
                      foodOrder = {};
                    }
                    currentMode = "combo";

                    // Lấy textarea hiển thị đơn hàng
                    var orderTextArea =
                      document.getElementById("orderTextArea");

                    // Nếu combo đã có thì tăng số lượng, chưa có thì tạo mới = 1
                    if (comboOrder[comboName]) {
                      comboOrder[comboName] += 1;
                    } else {
                      comboOrder[comboName] = 1;
                    }

                    // Tạo chuỗi hiển thị cập nhật
                    var orderText = "";
                    for (var combo in comboOrder) {
                      orderText += combo + " - " + comboOrder[combo] + " x\n";
                    }

                    // Cập nhật textarea
                    orderTextArea.value = orderText;
                  }

                  // Dish selection functionality
                  function addDish(dishName) {
                    // Xóa các combo đã chọn nếu đang ở mode combo
                    if (currentMode === "combo") {
                      comboOrder = {};
                    }
                    currentMode = "food";

                    // Get textarea element
                    var orderTextArea =
                      document.getElementById("orderTextArea");

                    // Check if dish already exists in order
                    if (foodOrder[dishName]) {
                      foodOrder[dishName] += 1;
                    } else {
                      foodOrder[dishName] = 1;
                    }

                    // Update textarea with current order
                    var orderText = "";
                    for (var dish in foodOrder) {
                      orderText += dish + " - " + foodOrder[dish] + " x\n";
                    }
                    orderTextArea.value = orderText;
                  }

                  // Đảm bảo chỉ có một event listener cho form đặt bàn
                  const reservationForm =
                    document.getElementById("reservationForm");
                  if (reservationForm) {
                    reservationForm.addEventListener("submit", function (e) {
                      // Không cần e.preventDefault() để form có thể submit bình thường

                      // Lưu thông tin đặt hàng
                      var orderDetails = {};
                      if (currentMode === "combo") {
                        orderDetails = comboOrder;
                        document.getElementById("orderType").value = "combo";
                      } else {
                        orderDetails = foodOrder;
                        document.getElementById("orderType").value = "food";
                      }

                      // Chuyển object thành JSON string
                      document.getElementById("orderDetails").value =
                        JSON.stringify(orderDetails);

                      // Show loading
                      this.querySelector(".loading").classList.remove("d-none");
                      this.querySelector(".error-message").textContent = "";
                      this.querySelector(".sent-message").classList.add(
                        "d-none"
                      );

                      // Cho phép form submit bình thường
                      return true;
                    });
                  }
                  // Form submission handling for review
                  const reviewForm = document.getElementById("reviewForm");
                  if (reviewForm) {
                    reviewForm.addEventListener("submit", function (e) {
                      // Không cần e.preventDefault() nữa để form có thể submit bình thường

                      // Show loading
                      this.querySelector(".loading").classList.remove("d-none");
                      this.querySelector(".error-message").textContent = "";
                      this.querySelector(".sent-message").classList.add(
                        "d-none"
                      );

                      // Cho phép form submit bình thường
                      return true;
                    });
                  }
                </script>
              </form>
            </div>
            <!-- End Reservation Form -->
          </div>
        </div>
      </section>
      <!-- /Book A Table Section -->

      <!-- Gallery Section -->
      <section id="gallery" class="gallery section light-background">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Trưng bày</h2>
          <p>
            <span>Xem</span>
            <span class="description-title">Phòng trưng bày</span>
          </p>
        </div>
        <!-- End Section Title -->

        <div class="container" data-aos="fade-up" data-aos-delay="100">
          <div class="swiper init-swiper">
            <script type="application/json" class="swiper-config">
              {
                "loop": true,
                "speed": 600,
                "autoplay": {
                  "delay": 5000
                },
                "slidesPerView": "auto",
                "centeredSlides": true,
                "pagination": {
                  "el": ".swiper-pagination",
                  "type": "bullets",
                  "clickable": true
                },
                "breakpoints": {
                  "320": {
                    "slidesPerView": 1,
                    "spaceBetween": 0
                  },
                  "768": {
                    "slidesPerView": 3,
                    "spaceBetween": 20
                  },
                  "1200": {
                    "slidesPerView": 5,
                    "spaceBetween": 20
                  }
                }
              }
            </script>
            <div class="swiper-wrapper align-items-center">
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-1.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-1.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-2.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-2.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-3.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-3.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-4.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-4.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-5.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-5.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-6.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-6.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-7.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-7.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
              <div class="swiper-slide">
                <a
                  class="glightbox"
                  data-gallery="images-gallery"
                  href="${pageContext.request.contextPath}/resources/img/gallery/gallery-8.jpg"
                  ><img
                    src="${pageContext.request.contextPath}/resources/img/gallery/gallery-8.jpg"
                    class="img-fluid"
                    alt=""
                /></a>
              </div>
            </div>
            <div class="swiper-pagination"></div>
          </div>
        </div>
      </section>
      <!-- /Gallery Section -->
      <section id="contact" class="contact section">
        <!-- Section Title -->
        <div class="container section-title" data-aos="fade-up">
          <h2>Liên hệ</h2>
          <p>
            <span>Cần giúp đỡ?</span>
            <span class="description-title">Liên hệ với chúng tôi</span>
          </p>
        </div>
        <!-- End Section Title -->

        <div class="container" data-aos="fade-up" data-aos-delay="100">
          <div class="mb-5">
            <iframe
              style="width: 100%; height: 400px"
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.0000943441482!2d108.2457453!3d16.065484899999998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314217ee3600dbb9%3A0xd51ecb708db1b26c!2sMy%20Hanh%20Seafood!5e0!3m2!1svi!2s!4v1706580190415!5m2!1svi!2s"
              frameborder="0"
              allowfullscreen=""
            ></iframe>
          </div>
          <!-- End Google Maps -->

          <div class="row gy-4">
            <div class="col-md-6">
              <div
                class="info-item d-flex align-items-center"
                data-aos="fade-up"
                data-aos-delay="200"
              >
                <i class="icon bi bi-geo-alt flex-shrink-0"></i>
                <div>
                  <h3>Địa chỉ</h3>
                  <p>Số 03 - 05 Võ Nguyên Giáp, Phước Mỹ, Sơn Trà, Đà Nẵng</p>
                </div>
              </div>
            </div>
            <!-- End Info Item -->

            <div class="col-md-6">
              <div
                class="info-item d-flex align-items-center"
                data-aos="fade-up"
                data-aos-delay="300"
              >
                <i class="icon bi bi-telephone flex-shrink-0"></i>
                <div>
                  <h3>Gọi chúng tôi</h3>
                  <p>096.774.8668</p>
                </div>
              </div>
            </div>
            <!-- End Info Item -->

            <div class="col-md-6">
              <div
                class="info-item d-flex align-items-center"
                data-aos="fade-up"
                data-aos-delay="400"
              >
                <i class="icon bi bi-envelope flex-shrink-0"></i>
                <div>
                  <h3>Gửi email cho chúng tôi</h3>
                  <p>info@myhanhseafood.vn</p>
                </div>
              </div>
            </div>
            <!-- End Info Item -->

            <div class="col-md-6">
              <div
                class="info-item d-flex align-items-center"
                data-aos="fade-up"
                data-aos-delay="500"
              >
                <i class="icon bi bi-clock flex-shrink-0"></i>
                <div>
                  <h3>Giờ làm việc<br /></h3>
                  <p><strong>Thứ 2 - Chủ nhật:</strong> 8AM - 23PM</p>
                </div>
              </div>
            </div>
            <!-- End Info Item -->
          </div>

          <form
            id="reviewForm"
            action="${pageContext.request.contextPath}/contact"
            method="post"
            class="php-email-form"
            data-aos="fade-up"
            data-aos-delay="600"
          >
            <div class="row gy-4">
              <div class="col-md-6">
                <input
                  type="text"
                  name="name"
                  class="form-control"
                  placeholder="Your Name"
                />
              </div>

              <div class="col-md-6">
                <input
                  type="email"
                  class="form-control"
                  name="email"
                  placeholder="Your Email"
                />
              </div>

              <div class="col-md-6">
                <input
                  type="text"
                  class="form-control"
                  name="phone"
                  placeholder="Your Phone"
                />
              </div>

              <div
                class="col-md-6 d-flex justify-content-center align-items-center"
              >
                <div
                  class="rating"
                  style="
                    justify-content: flex-end;
                    width: fit-content;
                    margin-bottom: 0px;
                    margin-left: 10px;
                  "
                >
                  <input type="radio" id="star5" name="rating" value="5" />
                  <label for="star5" title="5 sao"
                    ><i class="bi bi-star-fill"></i
                  ></label>
                  <input type="radio" id="star4" name="rating" value="4" />
                  <label for="star4" title="4 sao"
                    ><i class="bi bi-star-fill"></i
                  ></label>
                  <input type="radio" id="star3" name="rating" value="3" />
                  <label for="star3" title="3 sao"
                    ><i class="bi bi-star-fill"></i
                  ></label>
                  <input type="radio" id="star2" name="rating" value="2" />
                  <label for="star2" title="2 sao"
                    ><i class="bi bi-star-fill"></i
                  ></label>
                  <input type="radio" id="star1" name="rating" value="1" />
                  <label for="star1" title="1 sao"
                    ><i class="bi bi-star-fill"></i
                  ></label>
                </div>
                <style>
                  .rating {
                    display: flex;
                    flex-direction: row-reverse;
                    margin: 0 0 20px;
                  }
                  .rating input {
                    display: none;
                  }
                  .rating label {
                    cursor: pointer;
                    font-size: 24px;
                    color: #ccc;
                    margin: 0 2px;
                  }
                  .rating label:hover,
                  .rating label:hover ~ label,
                  .rating input:checked ~ label {
                    color: #ffd700;
                  }
                  .rating i.bi-star-fill {
                    font-size: 24px;
                  }
                </style>
              </div>

              <div class="col-md-12">
                <textarea
                  class="form-control"
                  name="content"
                  rows="6"
                  placeholder="Nội dung đánh giá"
                ></textarea>
              </div>

              <div class="col-md-12 text-center">
                <button type="submit" class="btn btn-danger">
                  Gửi đánh giá
                </button>
              </div>
            </div>
          </form>
          <!-- End Contact Form -->
        </div>
      </section>
      <!-- /Contact Section -->
    </main>

    <footer id="footer" class="footer dark-background">
      <div class="container">
        <div class="row gy-3">
          <div class="col-lg-3 col-md-6 d-flex">
            <i class="bi bi-geo-alt icon"></i>
            <div class="address">
              <h4>Địa chỉ</h4>
              <p>Số 03-05 Võ Nguyên Giáp</p>
              <p>Phước Mỹ, Sơn Trà, Đà Nẵng</p>
              <p></p>
            </div>
          </div>

          <div class="col-lg-3 col-md-6 d-flex">
            <i class="bi bi-telephone icon"></i>
            <div>
              <h4>Liên hệ</h4>
              <p>
                <strong>Phone:</strong> <span>0971623584</span><br />
                <strong>Email:</strong> <span>myhanhSeaFood@gmail.com</span
                ><br />
              </p>
            </div>
          </div>

          <div class="col-lg-3 col-md-6 d-flex">
            <i class="bi bi-clock icon"></i>
            <div>
              <h4>Giờ mở cửa</h4>
              <p>
                <strong>Thứ hai-Thứ bảy:</strong> <span>11AM - 23PM</span><br />
                <strong>Chủ nhật:</strong>: <span>Đóng cửa</span>
              </p>
            </div>
          </div>

          <div class="col-lg-3 col-md-6">
            <h4>Theo dõi chúng tôi</h4>
            <div class="social-links d-flex">
              <a href="#" class="twitter"><i class="bi bi-twitter-x"></i></a>
              <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
              <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
              <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
            </div>
          </div>
        </div>
      </div>

      <div class="container copyright text-center mt-4">
        <p>
          © <span>Copyright</span>
          <strong class="px-1 sitename">MyHanhSeaFood</strong>
          <span>All Rights Reserved</span>
        </p>
        <div class="credits">
          <!-- All the links in the footer should remain intact. -->
          <!-- You can delete the links only if you've purchased the pro version. -->
          <!-- Licensing information: https://bootstrapmade.com/license/ -->
          <!-- Purchase the pro version with working PHP/AJAX contact form: [buy-url] -->
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </div>
    </footer>

    <!-- Scroll Top -->
    <a
      href="#"
      id="scroll-top"
      class="scroll-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>

    <!-- Preloader -->
    <div id="preloader"></div>

    <!-- Vendor JS Files -->
    <script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/aos/aos.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/purecounter/purecounter_vanilla.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/swiper/swiper-bundle.min.js"></script>

    <!-- Template Main JS File -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  </body>
</html>
