<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background: linear-gradient(135deg, #74b9ff, #a29bfe); font-family: "Open Sans", sans-serif; }
        .auth-card { background: #fff; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.15); overflow: hidden; }
        .form-control { border-radius:8px; padding:0.75rem 1rem; }
        .btn-primary { border-radius:8px; padding:0.75rem; font-weight:600; }
    </style>
</head>
<body>
<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-7 col-lg-5">
      <div class="auth-card p-4">
        <div class="text-center mb-4">
          <h3 class="fw-bold text-primary mb-2">Đặt lại mật khẩu</h3>
          <p class="text-muted">Đặt lại mật khẩu mới cho tài khoản của bạn</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/account/reset-password">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="token" value="${token}" />

            <div class="mb-3">
                <label class="form-label">Mật khẩu mới</label>
                <input type="password" name="password" class="form-control" placeholder="Mật khẩu mới" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Xác nhận mật khẩu</label>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu" required />
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-2">
                <i class="fas fa-key"></i> Đặt lại mật khẩu
            </button>
        </form>

        <div class="mt-3 text-center">
            <a href="${pageContext.request.contextPath}/account/login" class="text-muted">Quay lại đăng nhập</a>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
