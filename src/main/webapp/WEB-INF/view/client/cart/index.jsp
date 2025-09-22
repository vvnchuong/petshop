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
                                        <li class="breadcrumb-item active" aria-current="page">Chi tiết giỏ hàng</li>
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
                                            <th>Xử lý</th>
                                        </tr>
                                    </thead>
                                    <form:form method="post" action="/confirm-checkout">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Sản phẩm</th>
                                                        <th>Tên</th>
                                                        <th>Giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Thành tiền</th>
                                                        <th>Xử lý</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cart" items="${carts}" varStatus="status">
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
                                                                <p class="mb-0 mt-4 product-price"
                                                                    data-price="${cart.price}">
                                                                    <fmt:formatNumber value="${cart.price}"
                                                                        type="number" groupingUsed="true" /> đ
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <!-- Hidden productId -->
                                                                <input type="hidden"
                                                                    name="cartDetails[${status.index}].id"
                                                                    value="${cart.id}" />

                                                                <!-- Quantity input -->
                                                                <div class="input-group quantity mt-4"
                                                                    style="width: 100px;">
                                                                    <div class="input-group-btn">
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                            <i class="fa fa-minus"></i>
                                                                        </button>
                                                                    </div>
                                                                    <input type="text"
                                                                        class="form-control form-control-sm text-center border-0 quantity-input"
                                                                        name="cartDetails[${status.index}].quantity"
                                                                        value="${cart.quantity}" />
                                                                    <div class="input-group-btn">
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                            <i class="fa fa-plus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <p class="mb-0 mt-4 line-total">
                                                                    <fmt:formatNumber
                                                                        value="${cart.price * cart.quantity}"
                                                                        type="number" groupingUsed="true" /> đ
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <!-- chưa fix chỗ này spring không nhận form lồng form -->
                                                                <!-- <form action="/delete-cart-product/${cart.id}"
                                                                    method="post">
                                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                                        value="${_csrf.token}" />
                                                                    <button
                                                                        class="btn btn-md rounded-circle bg-light border mt-4">
                                                                        <i class="fa fa-times text-danger"></i>
                                                                    </button>
                                                                </form> -->
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Thông tin đơn hàng -->
                                        <div class="mt-5 row g-4 justify-content-start">
                                            <div class="col-12 col-md-8"></div>
                                            <div class="bg-light rounded">
                                                <div class="p-4">
                                                    <h1 class="display-6 mb-4">Thông tin đơn hàng</h1>
                                                    <div class="d-flex justify-content-between mb-4">
                                                        <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                        <p class="mb-0" id="total-price">
                                                            <fmt:formatNumber value="${totalPrice}" type="number"
                                                                groupingUsed="true" /> đ
                                                        </p>
                                                    </div>
                                                    <div class="d-flex justify-content-between">
                                                        <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                        <p class="mb-0">0 đ</p>
                                                    </div>
                                                </div>
                                                <div
                                                    class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                    <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                                    <p class="mb-0 pe-4" id="grand-total">
                                                        <fmt:formatNumber value="${totalPrice}" type="number"
                                                            groupingUsed="true" /> đ
                                                    </p>
                                                </div>

                                                <!-- Nút xác nhận -->
                                                <div class="text-end mb-4">
                                                    <button
                                                        class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase ms-4"
                                                        type="submit">
                                                        Xác nhận đặt hàng
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form:form>

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

                    <!-- Script cập nhật tự động giá tiền -->
                    <script>
                        function formatNumber(num) {
                            return num.toLocaleString('vi-VN');
                        }

                        function updateTotals() {
                            let totalPrice = 0;
                            $('.quantity-input').each(function () {
                                let quantity = parseInt($(this).val());
                                if (isNaN(quantity) || quantity < 1) {
                                    quantity = 1;
                                    $(this).val(1);
                                }

                                let price = parseFloat($(this).closest('tr').find('.product-price').data('price'));
                                let lineTotal = price * quantity;

                                $(this).closest('tr').find('.line-total').text(formatNumber(lineTotal) + ' đ');
                                totalPrice += lineTotal;
                            });

                            $('#total-price').text(formatNumber(totalPrice) + ' đ');
                            $('#grand-total').text(formatNumber(totalPrice) + ' đ');
                        }

                        $(document).ready(function () {
                            // Gỡ bỏ handler cũ trước khi gán (đề phòng gán trùng)
                            $('.btn-plus, .btn-minus').off('click').on('click', function () {
                                let input = $(this).closest('.quantity').find('.quantity-input');
                                let currentVal = parseInt(input.val()) || 1;

                                if ($(this).hasClass('btn-plus')) {
                                    input.val(currentVal + 1);
                                } else {
                                    if (currentVal > 1) {
                                        input.val(currentVal - 1);
                                    }
                                }
                                updateTotals();
                            });

                            $('.quantity-input').off('change').on('change', function () {
                                updateTotals();
                            });

                            // Cập nhật tổng ban đầu
                            updateTotals();
                        });
                    </script>

                </body>

                </html>