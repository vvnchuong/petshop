<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>


                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="utf-8" />
                        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                        <meta name="description" content=" - Dự án Petshop" />
                        <meta name="author" content="" />
                        <title>Dashboard - meomeo</title>
                        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                            rel="stylesheet" />
                        <link href="/admin/css/styles.css" rel="stylesheet" />
                        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                            crossorigin="anonymous"></script>
                    </head>

                    <body class="sb-nav-fixed">
                        <jsp:include page="../layout/header.jsp" />

                        <div id="layoutSidenav">
                            <jsp:include page="../layout/sidebar.jsp" />

                            <div id="layoutSidenav_content">
                                <div class="container">
                                    <div class="container py-4 mt-4">
                                        <h2 class="mb-4">Chi tiết đơn hàng #${order.orderCode}</h2>
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <p><strong>Id:</strong> ${order.id}</p>
                                                <p><strong>Mã đơn hàng:</strong> ${order.orderCode}</p>
                                                <p><strong>Ngày đặt:</strong> ${DateTimeUtil.formatInstant(order.createdAt)}</p>
                                                <p>
                                                    <strong>Trạng thái: </strong>
                                                    <c:choose>
                                                        <c:when test="${order.status.toString() eq 'PENDING'}">
                                                            <span
                                                                class="badge bg-warning text-dark">${order.status.name}</span>
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'SHIPPING'}">
                                                            <span class="badge bg-info">${order.status.name}</span>
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'DELIVERED'}">
                                                            <span class="badge bg-success">${order.status.name}</span>
                                                        </c:when>
                                                        <c:when test="${order.status.toString() eq 'CANCELLED'}">
                                                            <span class="badge bg-danger">${order.status.name}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${order.status.name}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>

                                                <p><strong>Người nhận:</strong> ${order.receiverName}</p>
                                                <p><strong>Điện thoại:</strong> ${order.receiverPhone}</p>
                                                <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                                                <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                                <p><strong>Tổng tiền:</strong>
                                                    <fmt:formatNumber value="${totalPrice}" type="number"
                                                        groupingUsed="true" /> đ
                                                </p>
                                                <p><strong>Giảm giá:</strong>
                                                    <fmt:formatNumber value="${totalPrice - order.totalAmount}" type="number"
                                                        groupingUsed="true" /> đ
                                                </p>
                                                <p><strong>Thành tiền:</strong>
                                                    <fmt:formatNumber value="${order.totalAmount}" type="number"
                                                        groupingUsed="true" /> đ
                                                </p>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-body">
                                                <h5 class="mb-3">Sản phẩm trong đơn hàng</h5>

                                                <c:forEach var="item" items="${order.orderDetails}">
                                                    <div class="d-flex align-items-center border-top pt-3 mt-3">
                                                        <img src="${pageContext.request.contextPath}/admin/images/product/${item.product.imageUrl}"
                                                            alt="${item.product.name}" class="rounded border" width="80"
                                                            height="80">

                                                        <div class="ms-3 flex-grow-1">
                                                            <h6 class="mb-1">${item.product.name}</h6>
                                                            <p class="mb-1">Số lượng: ${item.quantity}</p>
                                                            <p class="mb-0 text-primary fw-bold">
                                                                <fmt:formatNumber value="${item.price * item.quantity}"
                                                                    type="number" groupingUsed="true" /> đ
                                                            </p>
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                            </div>
                                        </div>
                                        <div class="mt-3">
                                            <a href="/admin/orders" class="btn btn-outline-secondary ms-2">
                                                <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách</a>
                                        </div>
                                    </div>

                                    <jsp:include page="../layout/footer.jsp" />
                                </div>
                            </div>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                                crossorigin="anonymous"></script>
                            <script src="js/scripts.js"></script>
                    </body>

                    </html>