<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content=" - Dự án Petshop" />
                <meta name="author" content="" />
                <title>Cập nhật sản phẩm</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/admin/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <style>
                    .card .form-label {
                        font-weight: 600;
                    }

                    .helper {
                        font-size: .875rem;
                        color: #6c757d;
                    }

                    .required::after {
                        content: " *";
                        color: #d00;
                        margin-left: 2px;
                        font-weight: 600;
                    }

                    #productPreview {
                        max-height: 250px;
                        margin-top: 15px;
                        border-radius: 6px;
                        border: 1px solid #dee2e6;
                        object-fit: cover;
                    }
                </style>

                <script>
                    $(document).ready(() => {
                        const productFile = $("#productFile");
                        const $preview = $("#productPreview");
                        const originalSrc = $preview.attr("src");
                        const originalDisplay = $preview.css("display");

                        productFile.change(function (e) {
                            if (e.target.files && e.target.files[0]) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $preview.attr("src", imgURL);
                                $preview.css({ "display": "block" });
                            } else {
                                $preview.attr("src", originalSrc);
                                $preview.css({ "display": originalDisplay });
                            }
                        });
                    });
                </script>
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
                                            <h3>Cập nhật thông tin sản phẩm</h3>
                                            <hr />

                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger">${error}</div>
                                            </c:if>

                                            <form:form method="post" action="/admin/products/update/${id}"
                                                modelAttribute="newProduct" enctype="multipart/form-data">

                                                <div class="row g-3">

                                                    <div class="col-md-6">
                                                        <c:set var="errorName">
                                                            <form:errors path="name" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Tên sản phẩm</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                            path="name" />${errorName}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label class="form-label required">Thương hiệu</label>
                                                        <form:select class="form-select" path="brand.id">
                                                            <form:option value="1">Royal Canin</form:option>
                                                            <form:option value="2">Pedigree</form:option>
                                                            <form:option value="3">Whiskas</form:option>
                                                            <form:option value="4">Sanicat</form:option>
                                                            <form:option value="5">SOS</form:option>
                                                            <form:option value="6">Me-O</form:option>
                                                            <form:option value="7">SmartHeart</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorPrice">
                                                            <form:errors path="price" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Giá (VND)</label>
                                                        <form:input type="number" min="0" step="1000"
                                                            class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                            path="price" />${errorPrice}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorStock">
                                                            <form:errors path="stock" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Số lượng</label>
                                                        <form:input type="number" min="0" step="1"
                                                            class="form-control ${not empty errorStock ? 'is-invalid' : ''}"
                                                            path="stock" />${errorStock}
                                                    </div>

                                                    <div class="col-md-4">
                                                        <label class="form-label required">Dành cho</label>
                                                        <form:select class="form-select" path="subcategory.petType.id"
                                                            id="petSelect">
                                                            <form:option value="1">Mèo</form:option>
                                                            <form:option value="2">Chó</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <label class="form-label required">Danh mục</label>
                                                        <form:select class="form-select" path="subcategory.category.id"
                                                            id="categorySelect">
                                                            <form:option value="1">Thức ăn</form:option>
                                                            <form:option value="2">Vệ sinh</form:option>
                                                            <form:option value="3">Phụ kiện</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <label class="form-label required">Danh mục phụ</label>
                                                        <form:select class="form-select" path="subcategory.id"
                                                            id="subcategorySelect">
                                                            <form:option value="1" data-pet="1" data-category="1">Hạt
                                                                cho mèo
                                                            </form:option>
                                                            <form:option value="2" data-pet="1" data-category="1">Pate
                                                                cho mèo
                                                            </form:option>
                                                            <form:option value="3" data-pet="1" data-category="1">Súp
                                                                thưởng
                                                            </form:option>
                                                            <form:option value="4" data-pet="1" data-category="2">Cát vệ
                                                                sinh
                                                            </form:option>
                                                            <form:option value="5" data-pet="1" data-category="2">Sữa
                                                                tắm mèo
                                                            </form:option>
                                                            <form:option value="6" data-pet="1" data-category="3">Phụ
                                                                kiện mèo
                                                            </form:option>
                                                            <form:option value="7" data-pet="2" data-category="1">Hạt
                                                                cho chó
                                                            </form:option>
                                                            <form:option value="8" data-pet="2" data-category="1">Pate
                                                                cho chó
                                                            </form:option>
                                                            <form:option value="9" data-pet="2" data-category="1">Bánh
                                                                thưởng
                                                            </form:option>
                                                            <form:option value="10" data-pet="2" data-category="2">Sữa
                                                                tắm chó
                                                            </form:option>
                                                            <form:option value="11" data-pet="2" data-category="2">Chăm
                                                                sóc
                                                                tai/mắt/miệng</form:option>
                                                            <form:option value="12" data-pet="2" data-category="3">Phụ
                                                                kiện chó
                                                            </form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-12">
                                                        <c:set var="errorShortDesc">
                                                            <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Mô tả ngắn</label>
                                                        <form:textarea
                                                            class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}"
                                                            path="shortDesc" rows="2" />${errorShortDesc}
                                                    </div>

                                                    <div class="col-12">
                                                        <c:set var="errorDescription">
                                                            <form:errors path="description"
                                                                cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Mô tả chi tiết</label>
                                                        <form:textarea
                                                            class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                                            path="description" rows="4" />${errorDescription}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label for="productFile" class="form-label">Ảnh sản phẩm</label>
                                                        <input type="file" class="form-control" id="productFile"
                                                            name="productFile" accept=".png, .jpg, .jpeg">
                                                        <div class="helper">Hỗ trợ .png, .jpg, .jpeg</div>
                                                    </div>

                                                    <div class="col-12 mb-3">
                                                        <c:set var="currentImgUrl"
                                                            value="/admin/images/product/${newProduct.imageUrl}" />
                                                        <img style="max-height: 250px; ${not empty newProduct.imageUrl ? 'display: block;' : 'display: none;'}"
                                                            alt="Xem trước ảnh sản phẩm" id="productPreview"
                                                            src="${not empty newProduct.imageUrl ? currentImgUrl : ''}">
                                                    </div>

                                                    <div class="col-12 mt-4">
                                                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                                                        <a href="/admin/products"
                                                            class="btn btn-outline-secondary ms-2">Hủy</a>
                                                    </div>

                                                </div>
                                            </form:form>
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
                <script src="/client/js/main.js"></script>
            </body>

            </html>