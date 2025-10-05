<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Sản phẩm</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->


                    <jsp:include page="../layout/header.jsp" />


                    <div class="container-fluid fruite py-5 mt-5">
                        <div class="container py-5">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <div class="col-xl-3">
                                            <div class="input-group w-100 mx-auto d-flex">
                                                <input type="search" class="form-control p-3" placeholder="Tìm kiếm"
                                                    aria-describedby="search-icon-1">
                                                <span id="search-icon-1" class="input-group-text p-3"><i
                                                        class="fa fa-search"></i></span>
                                            </div>
                                        </div>
                                        <div class="col-6"></div>
                                        <div class="col-xl-3">
                                            <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                                <label for="fruits">Sắp xếp:</label>
                                                <select id="fruits" name="fruitlist"
                                                    class="border-0 form-select-sm bg-light me-3">
                                                    <option value="default" ${currentSort=='default' ? 'selected' : ''
                                                        }>Mặc định</option>
                                                    <option value="priceDesc" ${currentSort=='priceDesc' ? 'selected'
                                                        : '' }>Giá từ cao đến thấp</option>
                                                    <option value="priceAsc" ${currentSort=='priceAsc' ? 'selected' : ''
                                                        }>Giá từ thấp tới cao</option>
                                                </select>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row g-4">
                                        <div class="col-lg-3">
                                            <div class="row g-4">
                                                <div class="col-lg-12">
                                                    <div class="mb-3">
                                                        <h4>Danh mục sản phẩm</h4>
                                                        <ul class="list-unstyled fruite-categorie">
                                                            <c:forEach var="category" items="${categories}"
                                                                varStatus="loop">
                                                                <li class="mb-2">
                                                                    <button
                                                                        class="btn btn-toggle d-flex justify-content-between w-100"
                                                                        data-bs-toggle="collapse"
                                                                        data-bs-target="#collapse${loop.index}"
                                                                        aria-expanded="false">
                                                                        ${category.name}
                                                                        <i class="bi bi-chevron-down"></i>
                                                                    </button>

                                                                    <div class="collapse mt-1"
                                                                        id="collapse${loop.index}">
                                                                        <ul class="list-unstyled ms-3">
                                                                            <c:forEach var="sub"
                                                                                items="${category.subcategories}">
                                                                                <c:if
                                                                                    test="${sub.petType.id == petType.id}">
                                                                                    <li>
                                                                                        <a href="/${petType.slug}/${sub.slug}"
                                                                                            class="d-block py-1">
                                                                                            ${sub.name}
                                                                                        </a>
                                                                                    </li>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </ul>
                                                                    </div>
                                                                </li>
                                                            </c:forEach>

                                                            <li class="mt-3">
                                                                <div class="d-flex justify-content-between fruite-name">
                                                                    <a href="#">Khuyến mãi</a>
                                                                    <span>(8)</span>
                                                                </div>
                                                            </li>
                                                        </ul>

                                                    </div>
                                                </div>
                                                <div class="col-lg-12">
                                                    <div class="mb-3">
                                                        <h4 class="mb-2">Khoảng giá</h4>
                                                        <input type="range" class="form-range w-100" id="rangeInput"
                                                            name="rangeInput" min="0" max="500" value="0"
                                                            oninput="amount.value=rangeInput.value">
                                                        <output id="amount" name="amount" min-velue="0" max-value="500"
                                                            for="rangeInput">0</output>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="col-lg-9">
                                            <div class="row g-4 justify-content-center" id="product-container">
                                                <c:forEach var="product" items="${products}">
                                                    <div class="col-md-6 col-lg-4 col-xl-3">
                                                        <div class="rounded position-relative fruite-item">
                                                            <div class="fruitep-img">
                                                                <img src="/admin/images/product/${product.imageUrl}"
                                                                    class="img-fluid w-100 rounded-top" alt="">
                                                            </div>
                                                            <div
                                                                class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                <h4 class="multiline-ellipsis">
                                                                    <a href="/product/${product.slug}">
                                                                        ${product.name}
                                                                    </a>
                                                                </h4>
                                                                <p class="multiline-ellipsis">
                                                                    ${product.shortDesc}
                                                                </p>
                                                                <div class="d-flex flex-lg-wrap justify-content-center">
                                                                    <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                        class="text-dark fw-bold mb-3">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${product.price}" />đ
                                                                    </p>
                                                                    <form action="/product/${product.slug}">
                                                                        <input type="hidden"
                                                                            name="${_csrf.parameterName}"
                                                                            value="${_csrf.token}" />
                                                                        <button
                                                                            class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                            xem sản phẩm
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>

                                            </div>
                                            <c:if test="${totalPages > 1}">
                                                <div class="text-center my-4">
                                                    <button id="loadMoreBtn" class="btn btn-primary">Hiện thêm sản
                                                        phẩm</button>
                                                </div>
                                            </c:if>

                                            <div id="loading" class="text-center my-3" style="display:none;">
                                                <div class="spinner-border text-primary" role="status"></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer Start -->
                    <jsp:include page="../layout/footer.jsp"></jsp:include>
                    <!-- Footer End -->

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <script src="/client/js/main.js"></script>
                    <script>
                        $(function () {
                            let currentPage = Number("${currentPage}");
                            const totalPages = Number("${totalPages}");
                            const petSlug = "${petSlug}";
                            const subSlug = "${subcategorySlug}";
                            const size = 4;
                            const sort = "${currentSort}";

                            $('#loadMoreBtn').on('click', function () {
                                currentPage++;

                                $('#loadMoreBtn').hide();
                                $('#loading').show();

                                let url = "/" + petSlug;
                                if (subSlug) {
                                    url += "/" + subSlug;
                                }
                                url += "?page=" + currentPage + "&size=" + size + "&sort=" + sort;

                                $.ajax({
                                    url: url,
                                    type: 'GET',
                                    success: function (response) {
                                        const newProducts = $(response).find('#product-container > div');
                                        $('#product-container').append(newProducts);
                                        $('#loading').hide();

                                        if (currentPage < totalPages - 1) {
                                            $('#loadMoreBtn').show();
                                        } else {
                                            $('#loadMoreBtn').hide();
                                        }
                                    },
                                    error: function () {
                                        $('#loading').hide();
                                        $('#loadMoreBtn').show();
                                        currentPage--;
                                    }
                                });
                            });

                            $('#fruits').on('change', function () {
                                const sort = $(this).val();
                                let url = "/" + petSlug;
                                if (subSlug) {
                                    url += "/" + subSlug;
                                }
                                url += "?sort=" + sort;
                                window.location.href = url;
                            });
                        });
                    </script>
                </body>

                </html>