<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8">
        <title>Tài khoản của tôi</title>
        <link href="/client/css/bootstrap.min.css" rel="stylesheet">

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
          href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
          rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <link href="/client/css/bootstrap.min.css" rel="stylesheet">
        <link href="/client/css/style.css" rel="stylesheet">
        <style>
          .error-text {
            color: #d63031;
            font-size: 0.9rem;
          }
        </style>
      </head>

      <body>

        <jsp:include page="../layout/header.jsp" />

        <div class="container py-5">
          <h2 class="mb-4 text-center">Tài khoản của tôi</h2>

          <c:if test="${param.success ne null}">
            <div class="alert alert-success">Cập nhật thông tin thành công!</div>
          </c:if>
          <c:if test="${param.passwordChanged ne null}">
            <div class="alert alert-success">Đổi mật khẩu thành công!</div>
          </c:if>
          <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
          </c:if>

          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card">
                <div class="card-header bg-primary text-white">Thông tin cá nhân</div>
                <div class="card-body">
                  <form:form action="/account/update" method="post" modelAttribute="userDTO"
                    enctype="multipart/form-data">
                    <div class="mb-3">
                      <label class="form-label">Họ và tên</label>
                      <form:input path="fullName" class="form-control" />
                      <form:errors path="fullName" cssClass="error-text" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Email</label>
                      <input type="email" class="form-control" value="${userDTO.email}" readonly="true" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Số điện thoại</label>
                      <form:input path="phone" class="form-control" />
                      <form:errors path="phone" cssClass="error-text" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Địa chỉ</label>
                      <form:textarea path="address" cssClass="form-control" />
                      <form:errors path="address" cssClass="error-text" />
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Ảnh đại diện</label>
                      <input type="file" name="inputFile" class="form-control" accept="image/*"
                        onchange="previewAvatar(event)">
                    </div>

                    <!-- preview -->
                    <div class="mb-3 text-center">
                      <img id="avatarPreview"
                        style="display:none; width:150px;; height:150px; object-fit:cover; border:1px solid #ddd; border-radius:50%;">
                    </div>
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                  </form:form>
                </div>
              </div>
            </div>

            <div class="col-md-6 mb-4">
              <div class="card">
                <div class="card-header bg-warning">Đổi mật khẩu</div>
                <div class="card-body">

                  <form:form action="/account/change-password" method="post" modelAttribute="passwordDTO">
                    <div class="mb-3">
                      <label class="form-label">Mật khẩu hiện tại</label>
                      <form:password path="oldPassword" class="form-control" />
                      <form:errors path="oldPassword" cssClass="error-text" />
                    </div>

                    <div class="mb-3">
                      <label class="form-label">Mật khẩu mới</label>
                      <form:password path="newPassword" class="form-control" />
                      <form:errors path="newPassword" cssClass="error-text" />
                    </div>

                    <div class="mb-3">
                      <label class="form-label">Xác nhận mật khẩu mới</label>
                      <form:password path="confirmPassword" class="form-control" />
                      <form:errors path="confirmPassword" cssClass="error-text" />
                    </div>

                    <button type="submit" class="btn btn-warning">Đổi mật khẩu</button>
                  </form:form>
                </div>
              </div>

            </div>
          </div>

          <div class="mt-4 text-center">
            <a href="/orders/history" class="btn btn-outline-primary">Xem lịch sử mua hàng</a>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/client/js/main.js"></script>

        <script>
          function previewAvatar(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('avatarPreview');

            if (file) {
              const reader = new FileReader();
              reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'inline-block';
              };
              reader.readAsDataURL(file);
            } else {
              preview.src = '';
              preview.style.display = 'none';
            }
          }
        </script>

      </body>

      </html>