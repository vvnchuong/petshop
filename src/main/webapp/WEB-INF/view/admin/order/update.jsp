<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Cập nhật đơn hàng #${order.id}</title>
                <link href="/admin/css/styles.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main class="container py-4">
                            <h2 class="mb-4">Cập nhật đơn hàng #${order.id}</h2>

                            <c:if test="${param.success ne null}">
                                <div class="alert alert-success">Cập nhật trạng thái thành công!</div>
                            </c:if>

                            <div class="card mb-4">
                                <div class="card-body">
                                    <p><strong>Ngày đặt:</strong> ${order.createdAt}</p>
                                    <p><strong>Người nhận:</strong> ${order.receiverName}</p>
                                    <p><strong>Điện thoại:</strong> ${order.receiverPhone}</p>
                                    <p><strong>Địa chỉ giao hàng:</strong> ${order.shippingAddress}</p>
                                    <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                    <p><strong>Tổng tiền:</strong>
                                        <fmt:formatNumber value="${order.totalAmount}" type="number"
                                            groupingUsed="true" /> đ
                                    </p>
                                </div>
                            </div>

                            <form action="/admin/order/update/${orderId}" method="post" class="card p-4">
                                <input type="hidden" name="orderId" value="${order.id}" />

                                <div class="mb-3">
                                    <label for="status" class="form-label">Trạng thái đơn hàng</label>
                                    <select id="status" name="status" class="form-select">
                                        <option value="PENDING" ${order.status.toString() eq 'PENDING' ? 'selected' : ''
                                            }>Chờ xử lý</option>
                                        <option value="SHIPPING" ${order.status.toString() eq 'SHIPPING' ? 'selected'
                                            : '' }>Đang giao</option>
                                        <option value="DELIVERED" ${order.status.toString() eq 'DELIVERED' ? 'selected'
                                            : '' }>Đã giao</option>
                                        <option value="CANCELLED" ${order.status.toString() eq 'CANCELLED' ? 'selected'
                                            : '' }>Đã hủy</option>
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-warning">Cập nhật</button>
                            </form>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>