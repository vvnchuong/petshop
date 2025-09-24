<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Navbar start -->
        <div class="container-fluid fixed-top">

            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="/" class="navbar-brand">
                        <h1 class="text-primary display-6">Petshop</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                        <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a href="/" class="nav-link active">TRANG CHỦ</a>
                    </li>

                    <!-- SHOP CHO CHÓ -->
                    <li class="nav-item dropdown mega-dropdown">
                        <a href="/shop-cho" class="nav-link dropdown-toggle">SHOP CHO CHÓ</a>
                        <div class="dropdown-menu mega-menu p-4">
                            <div class="row">
                                <div class="col-md-4">
                                    <h6 class="fw-bold border-bottom pb-2">Thức ăn cho chó</h6>
                                    <a class="dropdown-item" href="/shop-cho/thuc-an-hat-cho-cho">Thức ăn hạt</a>
                                    <a class="dropdown-item" href="/shop-cho/pate-cho-cho">Pate</a>
                                    <a class="dropdown-item" href="/shop-cho/banh-thuong-cho-cho">Bánh thưởng</a>
                                </div>
                                <div class="col-md-4">
                                    <h6 class="fw-bold border-bottom pb-2">Vệ sinh & chăm sóc</h6>
                                    <a class="dropdown-item" href="/shop-cho/khay-ve-sinh-cho-cho">Khay vệ sinh</a>
                                    <a class="dropdown-item" href="/shop-cho/sua-tam-cho-cho">Sửa tắm</a>
                                    <a class="dropdown-item" href="/shop-cho/cham-soc-tai-mat-mieng">Chăm sóc tai/mắt/miệng</a>
                                </div>
                                <div class="col-md-4">
                                    <h6 class="fw-bold border-bottom pb-2">Phụ kiện</h6>
                                    <a class="dropdown-item" href="/shop-cho/phu-kien-cho-cho">Đồ chơi</a>
                                    <a class="dropdown-item" href="/shop-cho/quan-ao-cho-cho">Quần áo</a>
                                    <a class="dropdown-item" href="/shop-cho/day-dat-cho-cho">Dây dắt</a>
                                </div>
                            </div>
                        </div>
                    </li>

                    <!-- SHOP CHO MÈO -->
                    <li class="nav-item dropdown mega-dropdown">
                        <a href="/shop-meo" class="nav-link dropdown-toggle">SHOP CHO MÈO</a>
                        <div class="dropdown-menu mega-menu p-4">
                            <div class="row">
                                <div class="col-md-4">
                                    <h6 class="fw-bold border-bottom pb-2">Thức ăn cho mèo</h6>
                                    <a class="dropdown-item" href="/shop-meo/thuc-an-hat-cho-meo">Thức Ăn Hạt</a>
                                    <a class="dropdown-item" href="/shop-meo/pate-cho-meo">Pate</a>
                                    <a class="dropdown-item" href="/shop-meo/sup-thuong-cho-meo">Súp Thưởng</a>
                                </div>
                                <div class="col-md-4">
                                    <h6 class="fw-bold border-bottom pb-2">Vệ sinh, chăm sóc</h6>
                                    <a class="dropdown-item" href="/shop-meo/cat-ve-sinh-cho-meo">Cát Vệ Sinh</a>
                                    <a class="dropdown-item" href="/shop-meo/nha-ve-sinh-cho-meo">Nhà Vệ Sinh</a>
                                    <a class="dropdown-item" href="/shop-meo/sua-tam-cho-meo">Sữa Tắm</a>
                                </div>
                                <div class="col-md-4">
                                    <h6 class="fw-bold border-bottom pb-2">Phụ kiện, đồ chơi</h6>
                                    <a class="dropdown-item" href="/shop-meo/nha-cho-meo">Cào Móng & Đệm Ngủ</a>
                                    <a class="dropdown-item" href="/shop-meo/phu-kien-cho-meo">Đồ Chơi</a>
                                    <a class="dropdown-item" href="/shop-meo/quan-ao-cho-meo">Quần Áo</a>
                                    <a class="dropdown-item" href="/shop-meo/vong-co-cho-meo">Vòng Cổ, Dây Dắt</a>
                                    <a class="dropdown-item" href="/shop-meo/long-van-chuyen-cho-meo">Lồng Vận Chuyển</a>
                                    <a class="dropdown-item" href="/shop-meo/bat-an-cho-meo">Bát Ăn</a>
                                </div>
                            </div>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a href="#" class="nav-link text-danger">KHUYẾN MÃI</a>
                    </li>
                </ul>
                        <div class="d-flex m-3 me-0">
                            <c:if test="${not empty pageContext.request.userPrincipal}">

                                <button
                                    class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                                    data-bs-toggle="modal" data-bs-target="#searchModal"><i
                                        class="fas fa-search text-primary"></i></button>
                                <a href="/cart" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                                        ${sessionScope.sum}
                                    </span>
                                </a>
                                <div class="dropdown my-auto">
                                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                                        aria-expanded="false">
                                        <i class="fas fa-user fa-2x"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                            <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                                src="/images/avatar/${sessionScope.avatar}" />
                                            <div class="text-center my-3">
                                                <c:out value="${sessionScope.name}" />
                                            </div>
                                        </li>

                                        <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>

                                        <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li>
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button class="dropdown-item" href="#">Đăng xuất</button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->