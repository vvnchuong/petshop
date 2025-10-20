<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <link href="/client/css/bootstrap.min.css" rel="stylesheet">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
          href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
          rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <link href="/client/css/bootstrap.min.css" rel="stylesheet">
        <link href="/client/css/style.css" rel="stylesheet">
      </head>

      <body>

        <jsp:include page="../layout/header.jsp" />

        <div class="container py-4 mt-4">
          <h2 class="mb-4">Chi tiết đơn hàng #${order.id}</h2>
          <div class="card mb-4">
            <div class="card-body">
              <p><strong>Ngày đặt:</strong> ${order.createdAt}</p>
              <p>
                <strong>Trạng thái: </strong>
                <c:choose>
                  <c:when test="${order.status.toString() eq 'PENDING'}">
                    <span class="badge bg-warning text-dark">${order.status.name}</span>
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
              <p class="text-warning" style="font-weight: bold;"><strong>Tổng tiền:</strong>
                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> đ
              </p>
            </div>
          </div>
          <div class="card">
            <div class="card-body">
              <h5 class="mb-3">Sản phẩm trong đơn hàng</h5>

              <c:forEach var="orderDetail" items="${order.orderDetails}">
                <div class="d-flex align-items-center border-top pt-3 mt-3">
                  <img src="${pageContext.request.contextPath}/admin/images/product/${orderDetail.product.imageUrl}"
                    alt="${orderDetail.product.name}" class="rounded border" width="80" height="80">

                  <div class="ms-3 flex-grow-1">
                    <a href="/product/${orderDetail.product.slug}">
                      <h6 class="mb-1">${orderDetail.product.name}</h6>
                    </a>
                    <p class="mb-1">Số lượng: ${orderDetail.quantity}</p>
                    <p class="mb-0 text-primary fw-bold">
                      <fmt:formatNumber value="${orderDetail.price * orderDetail.quantity}" type="number"
                        groupingUsed="true" /> đ
                    </p>
                  </div>
                </div>
              </c:forEach>

            </div>
          </div>

          <div class="mt-4">
            <a href="/order/history" class="btn btn-secondary">Quay lại lịch sử mua hàng</a>
          </div>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/client/js/main.js"></script>
      </body>

      </html>