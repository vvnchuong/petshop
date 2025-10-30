<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>

                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="utf-8" />
                        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                        <meta name="description" content=" - Dự án Petshop" />
                        <meta name="author" content="" />
                        <title>Chi tiết voucher</title>
                        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                            rel="stylesheet" />
                        <link href="/admin/css/styles.css" rel="stylesheet" />
                        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                            crossorigin="anonymous"></script>

                        <style>
                            .list-group-item {
                                padding-top: 1rem;
                                padding-bottom: 1rem;
                            }

                            .list-group-item .detail-key {
                                font-weight: 600;
                                color: #495057;
                                display: inline-block;
                                min-width: 150px;
                            }

                            .list-group-item .detail-value {
                                color: #212529;
                                word-break: break-word;
                            }

                            .voucher-code {
                                font-family: 'Courier New', Courier, monospace;
                                font-weight: bold;
                                font-size: 1.1rem;
                                color: #d00;
                                background-color: #f8f9fa;
                                padding: 2px 6px;
                                border-radius: 4px;
                            }
                        </style>
                    </head>

                    <body class="sb-nav-fixed">

                        <jsp:include page="../layout/header.jsp" />

                        <div id="layoutSidenav">

                            <jsp:include page="../layout/sidebar.jsp" />

                            <div id="layoutSidenav_content">

                                <div class="container-fluid mt-4">
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="card shadow-sm border-0">
                                                <div class="card-body p-4">
                                                    <h3 class="mb-3">Thông tin chi tiết voucher</h3>
                                                    <hr />

                                                    <h5 class="card-header bg-light"
                                                        style="margin-left:-1.5rem; margin-right:-1.5rem; border-top: 1px solid #dee2e6; border-bottom: 1px solid #dee2e6;">
                                                        Thông tin
                                                    </h5>

                                                    <ul class="list-group list-group-flush mt-3">
                                                        <li class="list-group-item">
                                                            <span class="detail-key">ID:</span>
                                                            <span class="detail-value">${voucher.id}</span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Mã voucher:</span>
                                                            <span
                                                                class="detail-value voucher-code">${voucher.code}</span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Mô tả:</span>
                                                            <span class="detail-value">${voucher.description}</span>
                                                        </li>

                                                        <li class="list-group-item">
                                                            <span class="detail-key">Mức giảm:</span>
                                                            <span class="detail-value">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty voucher.discountPercent and voucher.discountPercent > 0}">
                                                                        <fmt:formatNumber
                                                                            value="${voucher.discountPercent}" />%
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${not empty voucher.discountAmount and voucher.discountAmount > 0}">
                                                                        <fmt:formatNumber
                                                                            value="${voucher.discountAmount}"
                                                                            type="number" /> VND
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        (Không có)
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </li>

                                                        <li class="list-group-item">
                                                            <span class="detail-key">Đơn hàng tối thiểu:</span>
                                                            <span class="detail-value">
                                                                <fmt:formatNumber value="${voucher.minOrder}"
                                                                    type="number" /> VND
                                                            </span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Số lượng tối đa:</span>
                                                            <span class="detail-value">
                                                                <fmt:formatNumber value="${voucher.maxUsage}"
                                                                    type="number" />
                                                            </span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Đã sử dụng:</span>
                                                            <span class="detail-value">
                                                                <fmt:formatNumber value="${voucher.usedCount}"
                                                                    type="number" />
                                                            </span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Ngày bắt đầu:</span>
                                                            <span class="detail-value">
                                                                ${DateTimeUtil.formatInstant(voucher.startDate)}
                                                            </span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Ngày kết thúc:</span>
                                                            <span class="detail-value">
                                                                ${DateTimeUtil.formatInstant(voucher.endDate)}
                                                            </span>
                                                        </li>
                                                        <li class="list-group-item">
                                                            <span class="detail-key">Trạng thái:</span>
                                                            <span class="detail-value">
                                                                <c:choose>
                                                                    <c:when test="${voucher.active}">
                                                                        <span class="badge bg-success">Kích hoạt</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger">Dừng kích
                                                                            hoạt</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </span>
                                                        </li>
                                                    </ul>

                                                    <div class="mt-4">
                                                        <a href="/admin/vouchers" class="btn btn-outline-secondary">
                                                            <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                                                        </a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <jsp:include page="../layout/footer.jsp" />

                            </div>
                        </div>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                            crossorigin="anonymous"></script>
                    </body>

                    </html>