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
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">

                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">

                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Update user with id = ${id}</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/product/update/${id}" modelAttribute="newProduct">
                                        <!-- newProduct ứng với currentProduct trong trong ProductController spring sẽ tự map -->
                                        <div class="mb-3">
                                            <div class="form-label">id</div>
                                            <form:input type="number" class="form-control" path="id" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Name</div>
                                            <form:input type="text" class="form-control" path="name" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Price</div>
                                            <form:input type="text" class="form-control" path="price" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Detail description</div>
                                            <form:input type="text" class="form-control" path="detailDesc" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Short description</div>
                                            <form:input type="text" class="form-control" path="shortDesc" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Quantity</div>
                                            <form:input type="text" class="form-control" path="quantity" />
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-label">Sold</div>
                                            <form:input type="text" class="form-control" path="sold" />
                                        </div>
                                        <div class="mb-3">
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
                                        <div class="mb-3">
                                            <label class="form-label">Target</label>
                                            <form:select class="form-select" path="target">
                                                <form:option value="GAMING">Gaming</form:option>
                                                <form:option value="AI">AI</form:option>
                                                <form:option value="THIN">Mỏng nhẹ</form:option>
                                                <form:option value="BUSINESSMEN">Doanh nhân</form:option>
                                            </form:select>
                                        </div>

                                        <button type="submit" class="btn btn-warning">Update</button>
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