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
                                        <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                                    </ol>
                                </nav>
                            </div>

                            <!-- Giỏ hàng -->
                            <div class="table-responsive">
                                <table class="table">
                                    <c:forEach var="order" items="${orders}">
                                        <div class="mb-4 border rounded p-3">
                                            <h5>Đơn hàng #${order.id}</h5>
                                            <p><strong>Trạng thái:</strong> ${order.status}</p>
                                            <p><strong>Tổng tiền:</strong>
                                                <fmt:formatNumber value="${order.totalPrice}" type="number"
                                                    groupingUsed="true" /> đ
                                            </p>

                                            <table class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Ảnh</th>
                                                        <th>Tên sản phẩm</th>
                                                        <th>Giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="detail" items="${order.orderDetails}">
                                                        <tr>
                                                            <td>
                                                                <img src="/images/product/${detail.product.image}"
                                                                    class="img-fluid rounded-circle"
                                                                    style="width: 80px; height: 80px;" alt="">
                                                            </td>
                                                            <td>${detail.product.name}</td>
                                                            <td>
                                                                <fmt:formatNumber value="${detail.price}" type="number"
                                                                    groupingUsed="true" /> đ
                                                            </td>
                                                            <td>${detail.quantity}</td>
                                                            <td>
                                                                <fmt:formatNumber
                                                                    value="${detail.price * detail.quantity}"
                                                                    type="number" groupingUsed="true" /> đ
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:forEach>


                                </table>
                            </div>


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