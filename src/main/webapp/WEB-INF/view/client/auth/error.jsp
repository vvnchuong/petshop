<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống gặp sự cố</title>
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
            color: #b02a37;
        }
        .error-text {
            font-size: 24px;
            color: #dc3545;
        }
    </style>
</head>
<body>
<div class="container text-center error-container">
    <div class="error-code">500</div>
    <div class="error-text mb-3">Đã xảy ra sự cố</div>
    <p class="lead">Hệ thống hiện đang gặp sự cố kỹ thuật. Vui lòng thử lại sau hoặc liên hệ bộ phận hỗ trợ:</p>
    <p><strong>Email:</strong> support@petshop.com | <strong>Hotline:</strong> 1900 1234</p>
</div>
</body>
</html>
