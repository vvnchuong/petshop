<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="author" content="" />
        <title>Thêm thương hiệu mới</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/admin/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <style>
          .card .form-label {
            font-weight: 600;
          }

          .helper {
            font-size: .875rem;
            color: #6c757d;
          }

          .required::after {
            content: " *";
            color: #d00;
            margin-left: 2px;
            font-weight: 600;
          }

          #logoPreview {
            max-height: 250px;
            margin-top: 15px;
            border-radius: 6px;
            border: 1px solid #dee2e6;
          }
        </style>

        <script>
          $(document).ready(() => {
            const logoFile = $("#logoFile");
            logoFile.change(function (e) {
              if (e.target.files && e.target.files[0]) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#logoPreview").attr("src", imgURL);
                $("#logoPreview").css({ "display": "block" });
              } else {
                $("#logoPreview").css({ "display": "none" });
                $("#logoPreview").attr("src", "");
              }
            });
          });
        </script>
      </head>

      <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav">
          <jsp:include page="../layout/sidebar.jsp" />

          <div id="layoutSidenav_content">
            <div class="container-fluid mt-4">
              <div class="row">
                <div class="col-12">
                  <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                      <h3 class="mb-3">Thêm thương hiệu sản phẩm mới</h3>
                      <hr />

                      <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                      </c:if>

                      <form:form method="post" action="/admin/brands/create" modelAttribute="newBrand"
                        enctype="multipart/form-data">

                        <div class="row g-3">

                          <div class="col-md-6">
                            <c:set var="errorName">
                              <form:errors path="name" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label required">Tên thương hiệu</label>
                            <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                              path="name" />${errorName}
                          </div>

                          <div class="col-12">
                            <c:set var="errorDescription">
                              <form:errors path="description" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label required">Mô tả</label>
                            <form:textarea class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                              path="description" rows="4" />${errorDescription}
                          </div>

                          <div class="col-md-6">
                            <c:set var="errorLogoUrl">
                              <form:errors path="logoUrl" cssClass="invalid-feedback" />
                            </c:set>
                            <label for="logoFile" class="form-label required">Logo</label>
                            <input type="file" class="form-control ${not empty errorLogoUrl ? 'is-invalid' : ''}"
                              id="logoFile" name="logoFile" accept=".png, .jpg, .jpeg">${errorLogoUrl}
                            <div class="helper">Hỗ trợ .png, .jpg, .jpeg</div>
                          </div>

                          <div class="col-12">
                            <img style="display: none;" alt="product preview" id="logoPreview">
                          </div>

                          <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-primary">Thêm mới</button>
                            <a href="/admin/brands" class="btn btn-outline-secondary ms-2">Hủy</a>
                          </div>

                        </div>
                      </form:form>
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