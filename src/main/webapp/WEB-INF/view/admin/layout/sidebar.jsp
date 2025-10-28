<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="layoutSidenav_nav">
  <nav class="sb-sidenav accordion sb-sidenav-dark bg-dark shadow-sm" id="sidenavAccordion">

    <!-- MENU -->
    <div class="sb-sidenav-menu">
      <div class="nav py-3">

        <div class="sb-sidenav-menu-heading text-uppercase text-secondary small">
          Main
        </div>
        <a class="nav-link" href="/admin">
          <div class="sb-nav-link-icon">
            <i class="fas fa-chart-line"></i>
          </div>
          Dashboard
        </a>

        <div class="sb-sidenav-menu-heading text-uppercase text-secondary small mt-3">
          Management
        </div>

        <a class="nav-link" href="/admin/user">
          <div class="sb-nav-link-icon">
            <i class="fas fa-users"></i>
          </div>
          Người dùng
        </a>

        <a class="nav-link" href="/admin/product">
          <div class="sb-nav-link-icon">
            <i class="fas fa-boxes"></i>
          </div>
          Sản phẩm
        </a>

        <a class="nav-link" href="/admin/news">
          <div class="sb-nav-link-icon">
            <i class="fa-solid fa-newspaper"></i>
          </div>
          Tin tức
        </a>

        <a class="nav-link" href="/admin/voucher">
          <div class="sb-nav-link-icon">
            <i class="fa-solid fa-ticket"></i>
          </div>
          Voucher
        </a>

        <a class="nav-link" href="/admin/order">
          <div class="sb-nav-link-icon">
            <i class="fas fa-shopping-cart"></i>
          </div>
          Đơn hàng
        </a>

      </div>
    </div>
  </nav>
</div>
