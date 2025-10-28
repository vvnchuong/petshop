<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>

                <!doctype html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8" />
                    <title>Chi tiết bài viết</title>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content=" - Dự án Petshop" />
                    <meta name="author" content="" />

                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/admin/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>

                    <style>
                        .news-thumbnail {
                            max-height: 450px;
                            width: 100%;
                            object-fit: cover;
                            border-radius: 8px;
                            border: 1px solid #dee2e6;
                        }

                        .news-content-wrapper {
                            margin-top: 1.5rem;
                            line-height: 1.7;
                            font-size: 1.05rem;
                        }

                        .news-content-wrapper img {
                            max-width: 100%;
                            height: auto;
                            border-radius: 6px;
                        }

                        .content-panel {
                            max-width: 900px;
                            margin-left: auto;
                            margin-right: auto;
                        }

                        .news-content-wrapper figure.image {
                            text-align: center;
                        }

                        .news-content-wrapper figure.image img[style*="float:left"] {
                            float: left;
                            margin-right: 15px;
                        }

                        .news-content-wrapper figure.image img[style*="float:right"] {
                            float: right;
                            margin-left: 15px;
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
                                    <div class="col-12 col-lg-10 mx-auto">
                                        <div class="card shadow-sm border-0">
                                            <div class="card-body p-4 p-md-5">

                                                <h2 class="card-title mb-3">${news.title}</h2>

                                                <p class="text-muted">
                                                    Đăng ngày:
                                                    ${DateTimeUtil.formatInstant(news.createdAt)}
                                                </p>
                                                <hr />

                                                <c:if test="${not empty news.thumbnail}">
                                                    <img src="/admin/images/thumbnail/${news.thumbnail}"
                                                        alt="${news.title}" class="news-thumbnail mb-4">
                                                </c:if>

                                                <div class="news-content-wrapper">
                                                    <c:out value="${news.content}" escapeXml="false" />
                                                </div>

                                                <hr class="mt-4">
                                                <a href="/admin/news" class="btn btn-outline-secondary">
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
                    <script src="/admin/js/scripts.js"></script>

                </body>

                </html>