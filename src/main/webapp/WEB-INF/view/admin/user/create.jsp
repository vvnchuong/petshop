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
                <title>Thêm người dùng mới</title>
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

                    /* CSS cho ảnh preview */
                    #avatarPreview {
                        max-height: 250px;
                        max-width: 250px;
                        /* Thêm max-width */
                        margin-top: 15px;
                        border-radius: 6px;
                        border: 1px solid #dee2e6;
                        object-fit: cover;
                        /* Đảm bảo ảnh không bị méo */
                    }
                </style>

                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            // Kiểm tra file có tồn tại không
                            if (e.target.files && e.target.files[0]) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $("#avatarPreview").attr("src", imgURL);
                                $("#avatarPreview").css({ "display": "block" });
                            } else {
                                // Nếu hủy chọn file
                                $("#avatarPreview").css({ "display": "none" });
                                $("#avatarPreview").attr("src", ""); // Xóa src
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
                                            <h3>Thêm người dùng mới</h3>
                                            <hr />

                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger">${error}</div>
                                            </c:if>

                                            <form:form method="post" action="/admin/user/create"
                                                modelAttribute="newUser" enctype="multipart/form-data">

                                                <div class="row g-3">

                                                    <div class="col-md-6">
                                                        <c:set var="errorEmail">
                                                            <form:errors path="email" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Email</label>
                                                        <form:input type="email"
                                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                            path="email" />
                                                        ${errorEmail}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorUsername">
                                                            <form:errors path="username" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Tên đăng nhập</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorUsername ? 'is-invalid' : ''}"
                                                            path="username" />
                                                        ${errorUsername}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorPassword">
                                                            <form:errors path="password" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Mật khẩu</label>
                                                        <form:input type="password"
                                                            class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                            path="password" />
                                                        ${errorPassword}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label class="form-label required">Vai trò</label>
                                                        <form:select class="form-select" path="role.name">
                                                            <form:option value="CUSTOMER">CUSTOMER</form:option>
                                                            <form:option value="ADMIN">ADMIN</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorFullName">
                                                            <form:errors path="fullName" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Họ tên</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                                            path="fullName" />
                                                        ${errorFullName}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <c:set var="errorPhone">
                                                            <form:errors path="phone" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label required">Số điện thoại</label>
                                                        <form:input type="tel"
                                                            class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                                                            path="phone" />
                                                        ${errorPhone}
                                                    </div>

                                                    <div class="col-12">
                                                        <c:set var="errorAddress">
                                                            <form:errors path="address" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label">Địa chỉ</label>
                                                        <form:input type="text"
                                                            class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                                            path="address" />
                                                        ${errorAddress}
                                                    </div>

                                                    <div class="col-md-6">
                                                        <label for="avatarFile" class="form-label">Ảnh đại diện</label>
                                                        <input type="file" class="form-control" id="avatarFile"
                                                            name="inputFile" accept=".png, .jpg, .jpeg">
                                                        <div class="helper">Hỗ trợ .png, .jpg, .jpeg</div>
                                                    </div>

                                                    <div class="col-12">
                                                        <img style="display: none;" alt="avatar preview"
                                                            id="avatarPreview">
                                                    </div>

                                                    <div class="col-12 mt-4">
                                                        <button type="submit" class="btn btn-primary">Thêm mới</button>
                                                        <a href="/admin/user"
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