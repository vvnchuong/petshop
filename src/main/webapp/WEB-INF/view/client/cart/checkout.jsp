<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Chi tiết giỏ hàng</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">

                    <!-- Fonts & Icons -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- CSS -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <jsp:include page="../layout/header.jsp" />

                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                                        <li class="breadcrumb-item"><a href="/cart">Giỏ hàng</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Thông tin thanh toán</li>
                                    </ol>
                                </nav>
                            </div>

                            <!-- Giỏ hàng -->
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Tên</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cart" items="${carts}">
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${cart.product.image}"
                                                        class="img-fluid rounded-circle"
                                                        style="width: 80px; height: 80px;" alt="">
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4">${cart.product.name}</p>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4 product-price" data-price="${cart.price}">
                                                        <fmt:formatNumber value="${cart.price}" type="number"
                                                            groupingUsed="true" /> đ
                                                    </p>
                                                </td>
                                                <td>
                                                    <div class="mb-0 mt-4 mx-4" style="width: 100px;">
                                                        ${cart.quantity}
                                                    </div>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4 line-total">
                                                        <fmt:formatNumber value="${cart.price * cart.quantity}"
                                                            type="number" groupingUsed="true" /> đ
                                                    </p>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Thông tin đơn hàng -->
                            <form action="/place-order" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <div class="row g-4">
                                    <!-- Cột trái: Thông tin người nhận -->
                                    <div class="col-sm-12 col-md-6">
                                        <div class="bg-light rounded p-4">
                                            <h3 class="mb-4">Thông tin người nhận</h3>
                                            <div class="mb-3">
                                                <label for="fullName" class="form-label">Họ và tên</label>
                                                <input type="text" class="form-control" id="fullName" name="receiverName"
                                                    placeholder="Nhập họ tên" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" id="phone" name="receiverPhone"
                                                    placeholder="Nhập số điện thoại" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="address" class="form-label">Địa chỉ giao hàng</label>
                                                <textarea class="form-control" id="address" name="receiverAddress" rows="3"
                                                    placeholder="Nhập địa chỉ" required></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Cột phải: Thông tin thanh toán -->
                                    <div class="col-sm-12 col-md-6">
                                        <div class="bg-light rounded p-4">
                                            <h3 class="mb-4">Thông tin thanh toán</h3>
                                            <div class="d-flex justify-content-between mb-3">
                                                <span>Tạm tính:</span>
                                                <span>
                                                    <fmt:formatNumber value="${totalPrice}" type="number"
                                                        groupingUsed="true" /> đ
                                                </span>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3">
                                                <span>Phí vận chuyển:</span>
                                                <span>0 đ</span>
                                            </div>
                                            <hr>
                                            <div class="d-flex justify-content-between mb-4">
                                                <strong>Tổng cộng:</strong>
                                                <strong>
                                                    <fmt:formatNumber value="${totalPrice}" type="number"
                                                        groupingUsed="true" /> đ
                                                </strong>
                                            </div>

                                            <button type="submit" class="btn btn-primary w-100 text-uppercase">Xác nhận
                                                đặt hàng</button>
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- JS -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                    <script src="/client/js/main.js"></script>

                </body>

                </html>