<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <title>400 - Bad Request</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
      body {
        background-color: #fff5f5;
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
        color: #b02a37;
      }

      .lead {
        color: #6c757d;
      }
    </style>
  </head>

  <body>
    <div class="container text-center error-container">
      <div class="error-code">400</div>
      <div class="error-text mb-3">Bad Request</div>
      <p class="lead">Yêu cầu của bạn không hợp lệ hoặc bị thiếu thông tin cần thiết.</p>
      <a href="/" class="btn btn-danger mt-3">Quay lại trang chủ</a>
    </div>
  </body>

  </html>