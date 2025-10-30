<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content=" - Dự án Petshop" />
                    <meta name="author" content="" />
                    <title>Chi tiết sản phẩm</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/admin/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>

                    <style>
                        .product-image {
                            max-width: 100%;
                            /* Đảm bảo ảnh responsive */
                            max-height: 400px;
                            /* Giới hạn chiều cao */
                            border-radius: 8px;
                            /* Bo góc */
                            border: 1px solid #dee2e6;
                            object-fit: cover;
                            /* Chống méo ảnh */
                        }

                        /* Căn chỉnh danh sách chi tiết */
                        .list-group-item {
                            padding-top: 1rem;
                            padding-bottom: 1rem;
                        }

                        .list-group-item .detail-key {
                            font-weight: 600;
                            color: #495057;
                            display: inline-block;
                            min-width: 150px;
                            /* Tăng chiều rộng cho các nhãn dài */
                        }

                        .list-group-item .detail-value {
                            color: #212529;
                            word-break: break-word;
                            /* Ngăn vỡ layout nếu mô tả quá dài */
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
                                                <h3 class="mb-3">Thông tin chi tiết sản phẩm</h3>
                                                <hr />

                                                <div class="row g-4">
                                                    <div class="col-md-4 text-center text-md-start">
                                                        <img src="/admin/images/product/${product.imageUrl}"
                                                            alt="${product.name}" class="product-image mb-3">
                                                    </div>

                                                    <div class="col-md-8">
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item">
                                                                <span class="detail-key">ID:</span>
                                                                <span class="detail-value">${product.id}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Tên sản phẩm:</span>
                                                                <span class="detail-value">${product.name}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Giá:</span>
                                                                <span class="detail-value">
                                                                    <fmt:formatNumber value="${product.price}"
                                                                        type="number" /> VND
                                                                </span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Số lượng tồn kho:</span>
                                                                <span class="detail-value">
                                                                    <fmt:formatNumber value="${product.stock}"
                                                                        type="number" />
                                                                </span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Dành cho:</span>
                                                                <span
                                                                    class="detail-value">${product.subcategory.petType.name}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Danh mục:</span>
                                                                <span
                                                                    class="detail-value">${product.subcategory.category.name}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Danh mục phụ:</span>
                                                                <span
                                                                    class="detail-value">${product.subcategory.name}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Thương hiệu:</span>
                                                                <span class="detail-value">${product.brand.name}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Mô tả ngắn:</span>
                                                                <span class="detail-value">${product.shortDesc}</span>
                                                            </li>
                                                            <li class="list-group-item">
                                                                <span class="detail-key">Mô tả chi tiết:</span>
                                                                <span class="detail-value">${product.description}</span>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="mt-3">
                                                <a href="/admin/products" class="btn btn-outline-secondary">
                                                    <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                                                </a>
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