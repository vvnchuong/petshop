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
                                    <div class="d-flex justify-content-between">
                                        <h3>User detail with id = ${product.id}</h3>
                                    </div>
                                    <!-- product map với product trong ProductController -->
                                    <hr />
                                    <div class="card" style="width: 60%">
                                        <div class="card-header">
                                            Product Information
                                        </div>
                                        <img src="/images/product/${product.image}" alt="laptop"
                                            class="mb-3">
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item">Id: ${product.id}</li>
                                            <li class="list-group-item">Name: ${product.name}</li>
                                            <li class="list-group-item">Price: ${product.price}</li>
                                            <li class="list-group-item">Detail description: ${product.detailDesc}</li>
                                            <li class="list-group-item">Short description: ${product.shortDesc}</li>
                                            <li class="list-group-item">Quantity: ${product.quantity}</li>
                                            <li class="list-group-item">Sold: ${product.sold}</li>
                                            <li class="list-group-item">Factory: ${product.factory}</li>
                                            <li class="list-group-item">Target: ${product.target}</li>
                                        </ul>
                                    </div>
                                    <div class="mt-3">
                                        <a href="/admin/product" class="btn btn-success">Back</a>
                                    </div>
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