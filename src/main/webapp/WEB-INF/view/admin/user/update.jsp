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
                <title>Cập nhật người dùng</title>
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

                    #avatarPreview {
                        max-height: 250px;
                        max-width: 250px;
                        margin-top: 15px;
                        border-radius: 6px;
                        border: 1px solid #dee2e6;
                        object-fit: cover;
                    }
                </style>

                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");

                        const $preview = $("#avatarPreview");
                        const originalSrc = $preview.attr("src");
                        const originalDisplay = $preview.css("display");

                        avatarFile.change(function (e) {
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
                                            <h3>Cập nhật thông tin người dùng</h3>
                                            <hr />

                                            <form:form method="post" action="/admin/users/update/${id}"
                                                modelAttribute="newUser" enctype="multipart/form-data">

                                                <div class="row g-3">

                                                    <div class="col-md-6">
                                                        <c:set var="errorFullName">
                                                            <form:errors path="fullName" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Họ tên</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                                            path="fullName" />${errorFullName}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorPhone">
                                                            <form:errors path="phone" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Số điện thoại</label>
                                                        <form:input type="tel"
                                                            class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                                                            path="phone" />${errorPhone}
                                                    </div>

                                                    <div class="col-12">
                                                        <c:set var="errorAddress">
                                                            <form:errors path="address" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label">Địa chỉ</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                                            path="address" />${errorAddress}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label class="form-label required">Vai trò</label>
                                                        <form:select class="form-select" path="role.id">
                                                            <form:option value="2">CUSTOMER</form:option>
                                                            <form:option value="1">ADMIN</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label for="avatarFile" class="form-label">Ảnh đại diện</label>
                                                        <input type="file" class="form-control" id="avatarFile"
                                                            name="inputFile" accept=".png, .jpg, .jpeg">
                                                    </div>

                                                    <div class="col-12">
                                                        <c:set var="currentImgUrl"
                                                            value="/admin/images/avatar/${newUser.avatarUrl}" />
                                                        <img style="max-height: 250px; ${not empty newUser.avatarUrl ? 'display: block;' : 'display: none;'}"
                                                            alt="Xem trước ảnh đại diện" id="avatarPreview"
                                                            src="${not empty newUser.avatarUrl ? currentImgUrl : ''}">
                                                    </div>

                                                    <div class="col-12 mt-4">
                                                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                                                        <a href="/admin/users"
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

            </body>

            </html>