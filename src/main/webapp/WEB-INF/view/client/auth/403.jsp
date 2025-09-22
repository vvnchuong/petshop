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
            color: #dc3545;
        }
        .error-text {
            font-size: 24px;
        }
    </style>
</head>
<body>
<div class="container text-center error-container">
    <div class="error-code">403</div>
    <div class="error-text mb-3">Access Denied</div>
    <p class="lead">Bạn không có quyền truy cập vào trang này.</p>
    <a href="/" class="btn btn-primary mt-3">Quay lại trang chủ</a>
</div>
</body>
</html>
