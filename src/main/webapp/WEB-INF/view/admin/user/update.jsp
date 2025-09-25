<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content=" - Dự án Petshop" />
                <meta name="author" content="" />
                <title>Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/admin/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    }); 
                </script>
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">

                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">

                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Cập nhật thông tin người dùng</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/user/update/${id}" modelAttribute="newUser"
                                        enctype="multipart/form-data">
                                        <div class="mb-3">
                                            <div class="form-label">Id</div>
                                            <form:input type="number" class="form-control" path="id" disabled="true" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Email</div>
                                            <form:input type="email" class="form-control" path="email"
                                                disabled="true" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Số điện thoại</div>
                                            <form:input type="text" class="form-control" path="phone" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Họ tên</div>
                                            <form:input type="text" class="form-control" path="fullName" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Địa chỉ</div>
                                            <form:input type="text" class="form-control" path="address" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="avatarFile" class="form-label">Ảnh đại diện</label>
                                            <input type="file" class="form-control" id="avatarFile" name="inputFile"
                                                accept=".png, .jpg, .jpeg">
                                        </div>
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                id="avatarPreview">
                                        </div>
                                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                                    </form:form>
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