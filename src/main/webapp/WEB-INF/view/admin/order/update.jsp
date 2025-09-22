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
                                <div class="col-12 mx-auto">
                                    <h3>Update user with id = ${id}</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/order/update/${id}"
                                        modelAttribute="newOrder">
                                        <!-- newProduct ứng với currentProduct trong trong ProductController spring sẽ tự map -->

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                Order id: ${newOrder.id}
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <fmt:formatNumber value="${newOrder.totalPrice}" type="number"
                                                                groupingUsed="true" /> đ
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">User</label>
                                                <form:input type="text" class="form-control bg-light" path="user.role.name" readonly="true" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Status</label>
                                                <form:select class="form-select" path="status">
                                                    <form:option value="PENDING">PENDING</form:option>
                                                    <form:option value="SHIPING">SHIPING</form:option>
                                                    <form:option value="COMPLETE">COMPLETE</form:option>
                                                    <form:option value="CANCEL">CANCEL</form:option>
                                                </form:select>
                                            </div>
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