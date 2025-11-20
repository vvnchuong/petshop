<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.petshop.pet.utils.DateTimeUtil" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Lịch sử mua hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
</head>

<body>

    <jsp:include page="../layout/header.jsp" />

    <!-- Breadcrumb -->
    <div class="container-fluid bg-light py-3">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                </ol>
            </nav>
        </div>
    </div>

    <!-- Order History -->
    <div class="container py-5">
        <h2 class="mb-4 text-center">Lịch sử mua hàng</h2>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="alert alert-info text-center">
                    Bạn chưa có đơn hàng nào.
                </div>
            </c:when>

            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="order" items="${orders}">
                        <div class="col-12">
                            <div class="card shadow-sm">
                                <div class="card-body">

                                    <!-- Thông tin đơn hàng -->
                                    <div class="d-flex justify-content-between flex-wrap mb-3">
                                        <div>
                                            <h5 class="card-title mb-1">Mã đơn hàng: #${order.orderCode}</h5>
                                            <p class="mb-1">
                                                Ngày đặt: ${DateTimeUtil.formatInstant(order.createdAt)}
                                            </p>
                                            <p class="mb-1">
                                                Trạng thái:
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test='${order.status eq "PENDING"}'>bg-warning text-dark</c:when>
                                                        <c:when test='${order.status eq "SHIPPING"}'>bg-info</c:when>
                                                        <c:when test='${order.status eq "DELIVERED"}'>bg-success</c:when>
                                                        <c:when test='${order.status eq "CANCELLED"}'>bg-danger</c:when>
                                                        <c:otherwise>bg-secondary</c:otherwise>
                                                    </c:choose>">
                                                    ${order.status.name}
                                                </span>
                                            </p>
                                            <p class="mb-0">
                                                Tổng tiền:
                                                <strong class="text-danger">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> đ
                                                </strong>
                                            </p>
                                        </div>

                                        <div class="align-self-center">
                                            <a href="/orders/detail/${order.orderCode}"
                                               class="btn btn-outline-primary">
                                                Xem chi tiết
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Danh sách sản phẩm -->
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <div class="d-flex align-items-center border-top pt-3 mt-3">
                                            <img src="/admin/images/product/${orderDetail.product.imageUrl}"
                                                 alt="${orderDetail.product.name}"
                                                 class="rounded border"
                                                 width="80" height="80">

                                            <div class="ms-3 flex-grow-1">
                                                <a href="/products/${orderDetail.product.slug}"><h6 class="mb-1">${orderDetail.product.name}</h6></a>
                                                <p class="mb-1">Số lượng: ${orderDetail.quantity}</p>
                                                <p class="mb-0 text-primary fw-bold">
                                                    <fmt:formatNumber
                                                        value="${orderDetail.price * orderDetail.quantity}"
                                                        type="number" groupingUsed="true" /> đ
                                                </p>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/main.js"></script>
</body>
</html>
