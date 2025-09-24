<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

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
                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Chi tiết đơn đặt hàng</h3>

                                        </div>

                                        <hr />
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Sản phẩm</th>
                                                    <th>Tên</th>
                                                    <th>Giá cả</th>
                                                    <th>Số lượng</th>
                                                    <th>Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="orderDetail" items="${orderDetails}">
                                                    <tr>
                                                        <td>
                                                            <img src="/images/product/${orderDetail.product.image}"
                                                                alt="laptop" class="rounded-circle"
                                                                style="width: 50px; height: 50px; object-fit: cover;" />
                                                        </td>
                                                        <td>${orderDetail.product.name}</td>
                                                        <td>
                                                            <fmt:formatNumber value="${orderDetail.price}" type="number"
                                                                groupingUsed="true" /> đ
                                                        </td>
                                                        <td>${orderDetail.quantity}</td>
                                                        <td>
                                                            <fmt:formatNumber value="${orderDetail.order.totalPrice}"
                                                                type="number" groupingUsed="true" /> đ
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="mt-3">
                                            <a href="/admin/order" class="btn btn-success">Back</a>
                                        </div>
                                    </div>
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