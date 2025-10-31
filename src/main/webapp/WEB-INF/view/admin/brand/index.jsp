<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="/admin/css/styles.css" rel="stylesheet" />
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
                      <div class="d-flex justify-content-between">
                        <h3>Danh sách thương hiệu sản phẩm</h3>
                        <a href="/admin/brands/create" class="btn btn-primary">Thêm thương hiệu sản phẩm</a>
                      </div>

                      <hr />
                      <table class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th>Id</th>
                            <th>Tên thương hiệu</th>
                            <th>Ngày tạo</th>
                            <th>Ngày cập nhật</th>
                            <th>Thực hiện</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="brand" items="${brands}">
                            <tr>
                              <td>${brand.id}</td>
                              <td>${brand.name}</td>
                              <td>${DateTimeUtil.formatInstant(brand.createdAt)}</td>
                              <td>${DateTimeUtil.formatInstant(brand.updatedAt)}</td>
                              <td>
                                <a href="/admin/brands/${brand.id}" class="btn btn-success">Chi tiết</a>
                                <a href="/admin/brands/update/${brand.id}" class="btn btn-warning">Cập nhật</a>
                                <a href="/admin/brands/delete/${brand.id}" class="btn btn-danger">Xóa</a>
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>

                      <nav aria-label="Page navigation example">
                        <ul class="pagination">
                          <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                              <span aria-hidden="true">&laquo;</span>
                            </a>
                          </li>

                          <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                              <a class="page-link" href="?page=${i}">${i}</a>
                            </li>
                          </c:forEach>

                          <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                              <span aria-hidden="true">&raquo;</span>
                            </a>
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