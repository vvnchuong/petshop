<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt hàng thành công</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>

        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="bg-light rounded p-5 text-center shadow-sm">
                        <div class="mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="90" height="90" fill="green"
                                class="bi bi-check-circle-fill" viewBox="0 0 16 16">
                                <path
                                    d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM6.97 11.03a.75.75 0 0 0 1.08-.02l3.992-4.99a.75.75 0 1 0-1.14-.976L7.477 9.417 5.324 7.262a.75.75 0 1 0-1.06 1.06l2.707 2.708z" />
                            </svg>
                        </div>
                        <h2 class="text-success mb-3">Đặt hàng thành công!</h2>
                        <p class="lead">Cảm ơn bạn đã mua sản phẩm của chúng tôi.</p>
                        <div class="d-flex justify-content-center gap-3 mt-4">
                            <a href="/" class="btn btn-outline-primary px-4">
                                Tiếp tục mua sắm
                            </a>
                            <a href="/orders/detail/${orderCode}" class="btn btn-primary px-4">
                                Xem chi tiết đơn hàng
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>