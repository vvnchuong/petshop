<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>403 - Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .error-container {
            margin-top: 10%;
        }
        .error-code {
            font-size: 120px;
            font-weight: 700;
            color: #6c757d;
        }
        .error-text {
            font-size: 24px;
            color: #fd7e14;
        }
    </style>
</head>
<body>
<div class="container text-center error-container">
    <div class="error-code">404</div>
    <div class="error-text mb-3">Page Not Found</div>
    <p class="lead">Trang này không tồn tại.</p>
    <a href="/" class="btn btn-primary mt-3">Quay lại trang chủ</a>
</div>
</body>
</html>
