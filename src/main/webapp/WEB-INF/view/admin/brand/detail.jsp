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
            <title>Chi tiết sản phẩm</title>
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="/admin/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

            <style>
              .logo-image {
                max-width: 100%;
                max-height: 400px;
                border-radius: 8px;
                border: 1px solid #dee2e6;
                object-fit: cover;
              }

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
                          <h3 class="mb-3">Thông tin chi tiết thương hiệu sản phẩm</h3>
                          <hr />

                          <div class="row g-4">
                            <div class="col-md-4 text-center text-md-start">
                              <img src="/admin/images/brands/${brand.logoUrl}" alt="${brand.name}"
                                class="logo-image mb-3">
                            </div>

                            <div class="col-md-8">
                              <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                  <span class="detail-key">ID:</span>
                                  <span class="detail-value">${brand.id}</span>
                                </li>
                                <li class="list-group-item">
                                  <span class="detail-key">Tên thương hiệu:</span>
                                  <span class="detail-value">${brand.name}</span>
                                </li>
                                <li class="list-group-item">
                                  <span class="detail-key">Mô tả:</span>
                                  <span class="detail-value">${brand.description}</span>
                                </li>
                                <li class="list-group-item">
                                  <span class="detail-key">Ngày tạo:</span>
                                  <span class="detail-value">${DateTimeUtil.formatInstant(brand.createdAt)}</span>
                                </li>
                                <li class="list-group-item">
                                  <span class="detail-key">Ngày cập nhật:</span>
                                  <span class="detail-value">${DateTimeUtil.formatInstant(brand.updatedAt)}</span>
                                </li>
                              </ul>
                            </div>
                          </div>
                        </div>
                        <div class="mt-3">
                          <a href="/admin/brands" class="btn btn-outline-secondary">
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