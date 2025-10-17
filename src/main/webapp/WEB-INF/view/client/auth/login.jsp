<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <title>Đăng nhập / Đăng ký</title>

                <!-- Bootstrap -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

                <!-- Font Awesome -->
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

                <style>
                    body {
                        background: linear-gradient(135deg, #74b9ff, #a29bfe);
                        font-family: "Open Sans", sans-serif;
                    }

                    .auth-card {
                        background: #fff;
                        border-radius: 12px;
                        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                        overflow: hidden;
                    }

                    .tab-btn {
                        border: none;
                        background: transparent;
                        padding: 1rem 2rem;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s;
                        border-bottom: 3px solid transparent;
                    }

                    .tab-btn.active {
                        color: #0d6efd;
                        border-bottom-color: #0d6efd;
                    }

                    .form-control {
                        border-radius: 8px;
                        padding: 0.75rem 1rem;
                    }

                    .btn-primary {
                        border-radius: 8px;
                        padding: 0.75rem;
                        font-weight: 600;
                    }

                    .error-text {
                        color: #d63031;
                        font-size: 0.9rem;
                    }
                </style>
            </head>

            <body>
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-md-7 col-lg-5">
                            <div class="auth-card p-4">
                                <div class="text-center mb-4">
                                    <h3 class="fw-bold text-primary mb-3">Chào mừng bạn!</h3>
                                    <p class="text-muted">Đăng nhập hoặc tạo tài khoản mới</p>
                                </div>

                                <!-- Tabs -->
                                <div class="d-flex justify-content-center mb-3">
                                    <button class="tab-btn active" id="loginTab">Đăng nhập</button>
                                    <button class="tab-btn" id="registerTab">Đăng ký</button>
                                </div>

                                <!-- LOGIN FORM -->
                                <div id="loginForm">
                                    <form method="post" action="/doLogin">

                                        <c:if test="${not empty success}">
                                            <div class="alert alert-success text-center">${success}</div>
                                        </c:if>

                                        <c:if test="${param.error != null}">
                                            <div class="alert alert-danger text-center">
                                                Tên tài khoản hoặc mật khẩu không chính xác!
                                            </div>
                                        </c:if>

                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <div class="mb-3">
                                            <label for="username" class="form-label">Tên đăng nhập</label>
                                            <input type="text" class="form-control" id="username" name="username"
                                                placeholder="Nhập tên đăng nhập" required />
                                        </div>

                                        <div class="mb-3">
                                            <label for="password" class="form-label">Mật khẩu</label>
                                            <input type="password" class="form-control" id="password" name="password"
                                                placeholder="Nhập mật khẩu" required />
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <a href="/account/forgot-password" class="small text-muted">Quên mật khẩu?</a>
                                        </div>

                                        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                                    </form>
                                </div>

                                <!-- REGISTER FORM -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:if>

                                <div id="registerForm" style="display: none;">
                                    <form:form method="post" action="/account/register" modelAttribute="registerDTO">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <div class="mb-3">
                                            <label class="form-label">Họ và tên</label>
                                            <form:input path="fullName" class="form-control"
                                                placeholder="Nguyễn Văn A" />
                                            <form:errors path="fullName" cssClass="error-text" />
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <form:input path="email" class="form-control"
                                                placeholder="email@example.com" />
                                            <form:errors path="email" cssClass="error-text" />
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Tên đăng nhập</label>
                                            <form:input path="username" class="form-control"
                                                placeholder="Tên đăng nhập" />
                                            <form:errors path="username" cssClass="error-text" />
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu</label>
                                            <form:password path="password" class="form-control"
                                                placeholder="Tối thiểu 6 ký tự" />
                                            <form:errors path="password" cssClass="error-text" />
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Xác nhận mật khẩu</label>
                                            <form:password path="confirmPassword" class="form-control"
                                                placeholder="Nhập lại mật khẩu" />
                                            <form:errors path="confirmPassword" cssClass="error-text" />
                                        </div>

                                        <button type="submit" class="btn btn-success w-100">Tạo tài khoản</button>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- JS -->
                <script>
                    const loginTab = document.getElementById("loginTab");
                    const registerTab = document.getElementById("registerTab");
                    const loginForm = document.getElementById("loginForm");
                    const registerForm = document.getElementById("registerForm");

                    loginTab.addEventListener("click", () => {
                        loginTab.classList.add("active");
                        registerTab.classList.remove("active");
                        loginForm.style.display = "block";
                        registerForm.style.display = "none";
                    });

                    registerTab.addEventListener("click", () => {
                        registerTab.classList.add("active");
                        loginTab.classList.remove("active");
                        registerForm.style.display = "block";
                        loginForm.style.display = "none";
                    });
                </script>

                <c:if test="${register}">
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            registerTab.click();
                        });
                    </script>
                </c:if>


            </body>


            </html>