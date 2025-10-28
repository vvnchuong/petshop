<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content=" - Dự án Petshop" />
                    <meta name="author" content="" />
                    <title>Dashboard</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/admin/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />

                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Danh sách tin tức</h3>
                                            <a href="/admin/news/create" class="btn btn-primary">Thêm tin tức</a>
                                        </div>

                                        <hr />

                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Tác giả</th>
                                                    <th>Ngày đăng</th>
                                                    <th>Thực hiện</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="news" items="${news}">
                                                    <tr>
                                                        <td>${news.id}</td>
                                                        <td>${news.title}</td>
                                                        <td>${news.user.fullName}</td>
                                                        <td>${DateTimeUtil.formatInstant(news.createdAt)}</td>
                                                        <td>
                                                            <a href="/admin/news/${news.id}" class="btn btn-success">Chi
                                                                tiết</a>
                                                            <a href="/admin/news/update/${news.id}"
                                                                class="btn btn-warning">Cập nhật</a>
                                                            <a href="/admin/news/delete/${news.id}"
                                                                class="btn btn-danger">Xóa</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination">
                                                <!-- previous -->
                                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                    <a class="page-link" href="?page=${currentPage - 1}">&laquo;</a>
                                                </li>

                                                <!-- page -->
                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="?page=${i}">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <!-- next -->
                                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                    <a class="page-link" href="?page=${currentPage + 1}">&raquo;</a>
                                                </li>
                                            </ul>
                                        </nav>

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