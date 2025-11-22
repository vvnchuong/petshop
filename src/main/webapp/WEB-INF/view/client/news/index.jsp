<%@ page contentType="text/html;charset=UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <html>

    <head>
      <title>Danh sách tin tức</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
      <style>
        .card-img-top {
          width: 100%;
          height: 200px;
          object-fit: cover;
        }

        .card-text {
          -webkit-line-clamp: 2;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          overflow: hidden;
          max-height: 3.2em;
        }

        .card-text img {
          display: none !important;
        }
      </style>
      <!-- Google Web Fonts -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">

      <!-- Icon Font Stylesheet -->
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

      <!-- Libraries Stylesheet -->
      <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
      <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


      <!-- Customized Bootstrap Stylesheet -->
      <link href="/client/css/bootstrap.min.css" rel="stylesheet">

      <!-- Template Stylesheet -->
      <link href="/client/css/style.css" rel="stylesheet">
    </head>

    <body>

      <jsp:include page="../layout/header.jsp" />

      <div class="container-fluid fruite py-5 mt-5">
        <div class="container py-5">
          <div class="row g-4">
            <c:forEach var="item" items="${news}">
              <div class="col-12 col-sm-6 col-lg-4">
                <div class="card h-100 d-flex flex-column">
                  <img class="card-img-top" src="/admin/images/thumbnail/${item.thumbnail}" />
                  <div class="card-body d-flex flex-column flex-grow-1">
                    <a href="/news/${item.slug}" style="text-decoration: none;">
                      <h5 class="card-title text-truncate">${item.title}</h5>
                    </a>
                    <div class="card-text">
                      ${item.content}
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
            <div class="mt-4 d-flex justify-content-center">
              <nav aria-label="News pagination">
                <ul class="pagination">
                  <c:forEach begin="1" end="${totalPages}" var="p">
                    <li class="page-item ${p == currentPage ? 'active' : ''}">
                      <a class="page-link" href="/admin/news?page=${p}">${p}</a>
                    </li>
                  </c:forEach>
                </ul>
              </nav>
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

      <!-- Template Javascript -->
      <script src="/client/js/main.js"></script>

    </body>

    </html>