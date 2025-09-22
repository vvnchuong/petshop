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
                <title>Dashboard - meomeo</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const productFile = $("#productFile");
                        productFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#productPreview").attr("src", imgURL);
                            $("#productPreview").css({ "display": "block" });
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
                                    <h3>Create a user</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/product/create" modelAttribute="newProduct"
                                     enctype="multipart/form-data">
                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Name</div>
                                                <form:input type="text" class="form-control" path="name" />
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Price</div>
                                                <form:input type="number" class="form-control" path="price" />
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <div class="mb-3 col-12">
                                                <div class="form-label">Detail description</div>
                                                <form:textarea type="text" class="form-control" path="detailDesc" />
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Short description</div>
                                                <form:input type="text" class="form-control" path="shortDesc" />
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Quantity</div>
                                                <form:input type="number" class="form-control" path="quantity" />
                                            </div>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Factory</label>
                                            <form:select class="form-select" path="factory">
                                                <form:option value="APPLE">Apple</form:option>
                                                <form:option value="LENOVO">Lenovo</form:option>
                                                <form:option value="ACER">Acer</form:option>
                                                <form:option value="ASUS">Asus</form:option>
                                                <form:option value="DELL">Dell</form:option>
                                                <form:option value="HP">Hp</form:option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Target</label>
                                            <form:select class="form-select" path="target">
                                                <form:option value="GAMING-DOHOA">Gaming - Đồ họa</form:option>
                                                <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</form:option>
                                                <form:option value="MONGNHE">Mỏng nhẹ</form:option>
                                                <form:option value="DOANHNHAN">Doanh nhân</form:option>
                                                <form:option value="AI">AI</form:option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="productFile" class="form-label">Image</label>
                                            <input type="file" class="form-control" id="productFile"
                                                name="productFile"
                                                accept=".png, .jpg, .jpeg">
                                        </div>
                                        <!-- name="productFile map với productFile trong ProductController nên cần đặt tên giống" -->
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="product preview"
                                                id="productPreview">
                                        </div>

                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Create</button>
                                        </div>
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