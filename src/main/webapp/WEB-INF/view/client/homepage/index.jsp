<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content=" - Dự án Petshop" />
                    <meta name="author" content="" />
                    <title>Pet shop</title>
                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->


                    <jsp:include page="../layout/header.jsp" />



                    <jsp:include page="../layout/banner.jsp" />

                    <div class="text-center display-3">Dịch vụ thú cưng</div>

                    <jsp:include page="../layout/feature.jsp" />


                    <!-- Fruits Shop Start-->
                    <div class="container-fluid fruite py-5">
                        <div class="container py-5">
                            <div class="tab-class text-center">
                                <div class="row g-4">
                                    <div class="col-lg-4 text-start">
                                        <h1>Sản phẩm nổi bật</h1>
                                    </div>
                                    <div class="col-lg-8 text-end">
                                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                            <li class="nav-item">
                                                <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                                                    data-bs-toggle="pill" href="#tab-1">
                                                    <span class="text-dark" style="width: 130px;">Tất cả sản phẩm</span>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill"
                                                    href="#tab-2">
                                                    <span class="text-dark" style="width: 130px;">Thức ăn</span>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill"
                                                    href="#tab-3">
                                                    <span class="text-dark" style="width: 130px;">Vệ sinh</span>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill"
                                                    href="#tab-4">
                                                    <span class="text-dark" style="width: 130px;">Phụ kiện</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane fade show p-0 active">
                                        <div class="row g-4">
                                            <div class="col-lg-12">
                                                <div class="row g-4">

                                                    <c:forEach var="entry" items="${products}">
                                                        <c:forEach var="product" items="${entry.value}">
                                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                                <div class="rounded position-relative fruite-item">
                                                                    <div class="fruite-img">
                                                                        <img src="/admin/images/product/${product.imageUrl}"
                                                                            class="img-fluid w-100 rounded-top" alt="">
                                                                    </div>

                                                                    <div
                                                                        class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                        <h4 class="multiline-ellipsis">
                                                                            <a href="/products/${product.slug}">
                                                                                ${product.name}
                                                                            </a>
                                                                        </h4>
                                                                        <p class="multiline-ellipsis">
                                                                            ${product.shortDesc}</p>
                                                                        <div
                                                                            class="d-flex flex-lg-wrap justify-content-center">
                                                                            <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                                class="text-dark fw-bold mb-3">
                                                                                <fmt:formatNumber type="number"
                                                                                    value="${product.price}" />đ
                                                                            </p>
                                                                            <form action="/products/${product.slug}">
                                                                                <input type="hidden"
                                                                                    name="${_csrf.parameterName}"
                                                                                    value="${_csrf.token}" />
                                                                                <button
                                                                                    class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                    xem sản phẩm
                                                                                </button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </c:forEach>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-2" class="tab-pane fade show p-0">
                                        <div class="row g-4">
                                            <div class="col-lg-12">
                                                <div class="row g-4">

                                                    <c:forEach var="product" items="${products[1]}">
                                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                                            <div class="rounded position-relative fruite-item">
                                                                <div class="fruite-img">
                                                                    <img src="/admin/images/product/${product.imageUrl}"
                                                                        class="img-fluid w-100 rounded-top" alt="">
                                                                </div>

                                                                <div
                                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                    <h4 class="multiline-ellipsis">
                                                                        <a href="/product/${product.slug}">
                                                                            ${product.name}
                                                                        </a>
                                                                    </h4>
                                                                    <p class="multiline-ellipsis">${product.shortDesc}
                                                                    </p>
                                                                    <div
                                                                        class="d-flex flex-lg-wrap justify-content-center">
                                                                        <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                            class="text-dark fw-bold mb-3">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${product.price}" />đ
                                                                        </p>
                                                                        <form action="/product/${product.slug}">
                                                                            <input type="hidden"
                                                                                name="${_csrf.parameterName}"
                                                                                value="${_csrf.token}" />
                                                                            <button
                                                                                class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                xem sản phẩm
                                                                            </button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-3" class="tab-pane fade show p-0">
                                        <div class="row g-4">
                                            <div class="col-lg-12">
                                                <div class="row g-4">

                                                    <c:forEach var="product" items="${products[2]}">
                                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                                            <div class="rounded position-relative fruite-item">
                                                                <div class="fruite-img">
                                                                    <img src="/admin/images/product/${product.imageUrl}"
                                                                        class="img-fluid w-100 rounded-top" alt="">
                                                                </div>

                                                                <div
                                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                    <h4 class="multiline-ellipsis">
                                                                        <a href="/product/${product.slug}">
                                                                            ${product.name}
                                                                        </a>
                                                                    </h4>
                                                                    <p class="multiline-ellipsis">${product.shortDesc}
                                                                    </p>
                                                                    <div
                                                                        class="d-flex flex-lg-wrap justify-content-center">
                                                                        <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                            class="text-dark fw-bold mb-3">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${product.price}" />đ
                                                                        </p>
                                                                        <form action="/product/${product.slug}">
                                                                            <input type="hidden"
                                                                                name="${_csrf.parameterName}"
                                                                                value="${_csrf.token}" />
                                                                            <button
                                                                                class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                xem sản phẩm
                                                                            </button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-4" class="tab-pane fade show p-0">
                                        <div class="row g-4">
                                            <div class="col-lg-12">
                                                <div class="row g-4">

                                                    <c:forEach var="product" items="${products[3]}">
                                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                                            <div class="rounded position-relative fruite-item">
                                                                <div class="fruite-img">
                                                                    <img src="/admin/images/product/${product.imageUrl}"
                                                                        class="img-fluid w-100 rounded-top" alt="">
                                                                </div>

                                                                <div
                                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                    <h4 class="multiline-ellipsis">
                                                                        <a href="/product/${product.slug}">
                                                                            ${product.name}
                                                                        </a>
                                                                    </h4>
                                                                    <p class="multiline-ellipsis">
                                                                        ${product.shortDesc}
                                                                    </p>
                                                                    <div
                                                                        class="d-flex flex-lg-wrap justify-content-center">
                                                                        <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                            class="text-dark fw-bold mb-3">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${product.price}" />đ
                                                                        </p>
                                                                        <form action="/product/${product.slug}">
                                                                            <input type="hidden"
                                                                                name="${_csrf.parameterName}"
                                                                                value="${_csrf.token}" />
                                                                            <button
                                                                                class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                xem sản phẩm
                                                                            </button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Fruits Shop End-->

                    <!-- Commitment -->
                    <div class="container my-5">
                        <h4 class="text-center mb-4 text-primary fw-bold">CAM KẾT 100% HÀI LÒNG</h4>
                        <div class="accordion" id="faqAccordion">

                            <!-- Item 1 -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseOne">
                                        01. Petshop đang bán những gì?
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse"
                                    data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Petshop chuyên về sản phẩm cho thú cưng chó và mèo như thức ăn, sản phẩm chăm
                                        sóc, phụ kiện,... Đội ngũ của Petshop sẵn sàng lắng nghe nhu cầu của bạn sau đó
                                        giới thiệu cho bạn sản phẩm phù hợp với mong muốn của bạn và tình trạng của thú
                                        cưng.
                                    </div>
                                </div>
                            </div>

                            <!-- Item 2 -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseTwo">
                                        02. Đồng hành cùng bạn trong quá trình sử dụng
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse"
                                    data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Với kinh nghiệm hơn 10 năm về nuôi dưỡng, chăm sóc thú cưng, Petshop luôn sẵn
                                        sàng hỗ trợ tư vấn và hướng dẫn bạn lựa chọn sản phẩm và phương pháp chăm sóc
                                        các bé làm sao để đảm bảo tinh thần của các bé luôn thoải mái cũng như có một
                                        sức khỏe thật tốt.
                                    </div>
                                </div>
                            </div>

                            <!-- Item 3 -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingThree">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseThree">
                                        03. Petshop có cung cấp các sản phẩm liên quan đến chữa bệnh cho thú cưng
                                        không?
                                    </button>
                                </h2>
                                <div id="collapseThree" class="accordion-collapse collapse"
                                    data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Petshop chỉ có những sản phẩm chăm sóc sức khỏe thú cưng cùng các loại thực phẩm
                                        chức năng giúp phòng bệnh cho Boss. Những sản phẩm liên quan đến chữa trị, bạn
                                        có thể nhận tư vấn và tìm mua tại các cơ sở thú y để đảm bảo tình trạng sức khỏe
                                        của Boss được đảm bảo nhất nhé!
                                    </div>
                                </div>
                            </div>

                            <!-- Item 4 -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingFour">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseFour">
                                        04. Petshop hiện đang có các chương trình ưu đãi nào không?
                                    </button>
                                </h2>
                                <div id="collapseFour" class="accordion-collapse collapse"
                                    data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Petshop luôn có các chương trình ưu đãi đem đến cho Quý khách hàng những trải
                                        nghiệm sản phẩm với lợi ích tốt nhất như các chương trình ưu đãi sản phẩm theo
                                        tháng, ưu đãi thứ 7 hằng tuần hay ưu đãi khi mua combo, tặng voucher mua hàng
                                        cho khách hàng thân thiết,... Ngoài ra, Petshop còn có tổ chức các minigame mỗi
                                        tháng, bạn có thể theo dõi, cùng Kin chơi trò chơi và nhận quà “xịn” về cho pet.
                                    </div>
                                </div>
                            </div>

                            <!-- Item 5 -->
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingFive">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#collapseFive">
                                        05. Phí giao hàng được tính như thế nào?
                                    </button>
                                </h2>
                                <div id="collapseFive" class="accordion-collapse collapse"
                                    data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Phí giao hàng sẽ tùy thuộc vào địa điểm giao hàng và khối lượng sản phẩm bạn
                                        đặt. Hiện Petshop đang có chính sách:
                                        <ul>
                                            <li>Freeship nội thành TP.HCM và Hà Nội nếu đơn hàng đạt giá trị tối thiểu
                                                399.000 đồng.</li>
                                            <li>Freeship ngoại thành với đơn hàng từ 1 triệu. Tùy thuộc vào giá trị,
                                                Petshop sẽ yêu cầu quý khách cọc từ 20-50% trước khi ship hàng.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- End Commitment -->


                    <jsp:include page="../layout/footer.jsp" />



                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                </body>


                </html>