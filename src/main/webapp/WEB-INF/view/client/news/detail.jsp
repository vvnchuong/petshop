<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>

                <html lang="vi">

                <head>
                    <meta charset="utf-8" />
                    <title>${newsDetail.title}</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1">

                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet" />

                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <link href="/client/css/style.css" rel="stylesheet">

                    <style>
                        .post-thumbnail {
                            width: 100%;
                            max-height: 500px;
                            height: auto;
                            margin-bottom: 2rem;
                            object-fit: cover;
                            border-radius: 8px;
                            border: 1px solid #eee;
                        }

                        .post-meta {
                            color: #6c757d;
                            font-size: 0.9rem;
                            margin-bottom: 2rem;
                            border-bottom: 1px dashed #eee;
                            padding-bottom: 1rem;
                        }

                        .post-content {
                            line-height: 1.8;
                            font-size: 1.05rem;
                            color: var(--bs-body-color, #212529);
                        }

                        .post-content img {
                            max-width: 100%;
                            height: auto;
                            margin: 2rem 0;
                            border-radius: 8px;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        }

                        .post-content h1,
                        .post-content h2,
                        .post-content h3,
                        .post-content h4 {
                            margin-top: 2.5rem;
                            margin-bottom: 1rem;
                            font-weight: 600;
                        }

                        .post-content p {
                            margin-bottom: 1.25rem;
                        }

                        .post-content figure.image {
                            margin: 2rem 0;
                            text-align: center;
                        }

                        .post-content figure.image img[style*="float:left"] {
                            float: left;
                            margin-right: 15px;
                            margin-bottom: 10px;
                        }

                        .post-content figure.image img[style*="float:right"] {
                            float: right;
                            margin-left: 15px;
                            margin-bottom: 10px;
                        }

                        .latest-news-item a {
                            text-decoration: none;
                            color: var(--bs-dark);
                            font-weight: 600;
                            transition: color 0.2s ease-in-out;
                        }

                        .latest-news-item a:hover {
                            color: var(--bs-primary);
                        }

                        .latest-news-item .text-muted {
                            font-size: 0.8rem;
                        }

                        .sidebar-heading {
                            font-weight: 700;
                            color: var(--bs-secondary);
                            border-bottom: 2px solid var(--bs-primary);
                            padding-bottom: 0.5rem;
                        }
                    </style>
                </head>

                <body>

                    <jsp:include page="../layout/header.jsp" />

                    <div class="container-fluid py-5 mt-5">
                        <div class="container py-5">
                            <div class="row g-4 g-lg-5">

                                <div class="col-lg-8">
                                    <h1 class="mb-3 display-5 fw-bold">${newsDetail.title}</h1>

                                    <div class="post-meta">
                                        <i class="fas fa-calendar-alt me-1"></i> Đăng ngày:
                                        ${DateTimeUtil.formatInstant(newsDetail.createdAt)}
                                        <span class="mx-2">|</span>
                                        <i class="fas fa-user me-1"></i> Tác giả:
                                        <c:out value="${newsDetail.user.username}" />
                                    </div>

                                    <c:if test="${not empty newsDetail.thumbnail}">
                                        <img class="post-thumbnail img-fluid"
                                            src="/admin/images/thumbnail/${newsDetail.thumbnail}"
                                            alt="${newsDetail.title}" />
                                    </c:if>

                                    <div class="post-content">
                                        <c:out value="${newsDetail.content}" escapeXml="false" />
                                    </div>

                                    <hr class="my-5" />

                                    <div id="comment-section">
                                        <h3 class="mb-4">Để lại bình luận</h3>
                                        <form action="/news/comment" method="POST">
                                            <input type="hidden" name="newsId" value="${newsDetail.id}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                            <div class="row g-3">
                                                <div class="col-md-6 mb-3">
                                                    <label for="commentName" class="form-label">Tên của bạn <span
                                                            class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" id="commentName" name="name"
                                                        required>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label for="commentEmail" class="form-label">Email (tùy
                                                        chọn)</label>
                                                    <input type="email" class="form-control" id="commentEmail"
                                                        name="email">
                                                </div>
                                                <div class="col-12 mb-3">
                                                    <label for="commentContent" class="form-label">Nội dung bình luận
                                                        <span class="text-danger">*</span></label>
                                                    <textarea class="form-control" id="commentContent" name="content"
                                                        rows="4" required></textarea>
                                                </div>
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary">Gửi bình luận</button>
                                                </div>
                                            </div>
                                        </form>

                                        <div class="mt-5">
                                            <h4 class="mb-4">Bình luận</h4>
                                            <div id="comment-list">
                                                <p class="text-muted">Chưa có bình luận nào.</p>
                                                <div class="d-flex mb-3 border-bottom pb-3">

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="col-lg-4">
                                    <h4 class="mb-4 sidebar-heading">Tin mới nhất</h4>

                                    <c:forEach var="item" items="${latestNews}">
                                        <div class="latest-news-item mb-4 border-bottom pb-3">
                                            <a href="/news/${item.slug}" class="d-block mb-1"> ${item.title}
                                            </a>
                                            <div class="text-muted">
                                                <i class="fas fa-clock me-1"></i>
                                                ${DateTimeUtil.formatInstant(newsDetail.createdAt)}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                            </div>
                        </div>
                    </div>

                    <jsp:include page="../layout/footer.jsp"></jsp:include>

                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <script src="/client/js/main.js"></script>
                </body>

                </html>