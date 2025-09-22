<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .success-wrapper {
            max-width: 600px;
            margin: 100px auto;
            background: #fff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .success-icon {
            font-size: 60px;
            color: #28a745;
        }

        .btn-home, .btn-support {
            padding: 10px 24px;
            border-radius: 30px;
        }

        .btn-home {
            border: 1px solid #28a745;
            color: #28a745;
        }

        .btn-home:hover {
            background-color: #28a745;
            color: white;
        }

        .btn-support {
            background-color: #007bff;
            color: white;
        }

        .btn-support:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="success-wrapper text-center">
        <div class="success-icon mb-4">
            ✅
        </div>
        <h2 class="mb-3">Cảm ơn bạn đã mua hàng!</h2>
        <p>Đơn hàng của bạn đã được đặt thành công.<br>Chúng tôi sẽ sớm liên hệ để xác nhận và giao hàng.</p>

        <!-- Mã đơn hàng (bạn truyền từ controller) -->
        <p class="mt-3">Mã đơn hàng của bạn: <strong>#ORD123456</strong></p>

        <div class="mt-4 d-flex justify-content-center gap-3">
            <a href="/" class="btn btn-home">Về trang chủ</a>
            <a href="/contact" class="btn btn-support">Liên hệ hỗ trợ</a>
        </div>
    </div>
</body>
</html>
