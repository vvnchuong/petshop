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
                    <c:forEach var="item" items="${categories}">
                      <div class="col-md-4">
                        <h6 class="fw-bold border-bottom pb-2">${item.name}</h6>
                        <c:forEach var="subCategory" items="${item.subcategories}">
                          <c:if test="${subCategory.petType.id == 2}">
                            <a class="dropdown-item" href="/shop-cho/${subCategory.slug}">
                              ${subCategory.name}
                            </a>
                          </c:if>
                        </c:forEach>
                      </div>
                    </c:forEach>
                  </div>
                </div>
              </li>

              <!-- SHOP CHO MÈO -->
              <li class="nav-item dropdown mega-dropdown">
                <a href="/shop-meo" class="nav-link dropdown-toggle">SHOP CHO MÈO</a>
                <div class="dropdown-menu mega-menu p-4">
                  <div class="row">
                    <c:forEach var="item" items="${categories}">
                      <div class="col-md-4">
                        <h6 class="fw-bold border-bottom pb-2">${item.name}</h6>
                        <c:forEach var="subCategory" items="${item.subcategories}">
                          <c:if test="${subCategory.petType.id == 1}">
                            <a class="dropdown-item" href="/shop-meo/${subCategory.slug}">
                              ${subCategory.name}
                            </a>
                          </c:if>
                        </c:forEach>
                      </div>
                    </c:forEach>
                  </div>
                </div>
              </li>

              <li class="nav-item">
                <a href="/brands" class="nav-link">THƯƠNG HIỆU</a>
              </li>

              <li class="nav-item">
                <a href="/news" class="nav-link">TIN THÚ CƯNG</a>
              </li>
            </ul>
            <div class="d-flex m-3 me-0">
              <a href="/cart" class="position-relative me-4 my-auto">
                <i class="fa fa-shopping-bag fa-2x"></i>
                <c:if test="${cartQuantity > 0}">
                  <span id="cartBadge"
                    class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                    style="top:-5px;left:15px;height:20px;min-width:20px;">
                    ${cartQuantity}
                  </span>
                </c:if>
              </a>
              <c:if test="${not empty pageContext.request.userPrincipal}">
                <div class="dropdown my-auto">
                  <a href="#" class="dropdown" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    <i class="fas fa-user fa-2x"></i>
                  </a>

                  <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                    <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                      <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                        src="/admin/images/avatar/${user.avatarUrl}" />
                      <div class="text-center my-3">
                        ${user.fullName}
                      </div>
                    </li>
                    <li><a class="dropdown-item" href="/account">Quản lý tài khoản</a></li>
                    <li><a class="dropdown-item" href="/orders/history">Lịch sử mua hàng</a></li>
                    <li>
                      <hr class="dropdown-divider">
                    </li>
                    <li>
                      <form method="post" action="/logout">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <button class="dropdown-item">Đăng xuất</button>
                      </form>
                    </li>
                  </ul>
                </div>
              </c:if>

              <c:if test="${empty pageContext.request.userPrincipal}">
                <a href="/account/login" class="my-auto">
                  <i class="fas fa-user fa-2x"></i>
                </a>
              </c:if>


            </div>
          </div>
        </nav>
      </div>
    </div>
    <!-- Navbar End -->