<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
          <meta charset="utf-8">
          <title>Chi tiết giỏ hàng</title>
          <meta content="width=device-width, initial-scale=1.0" name="viewport">

          <!-- Fonts & Icons -->
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">
          <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
          <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

          <!-- Libraries -->
          <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
          <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

          <!-- CSS -->
          <link href="/client/css/bootstrap.min.css" rel="stylesheet">
          <link href="/client/css/style.css" rel="stylesheet">
        </head>

        <body>

          <jsp:include page="../layout/header.jsp" />

          <div class="container-fluid py-5">
            <div class="container py-5">
              <div>
                <nav aria-label="breadcrumb">
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="/cart">Giỏ hàng</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Thông tin thanh toán</li>
                  </ol>
                </nav>
              </div>

              <form action="/checkout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="row g-4">
                  <div class="col-sm-12 col-md-6">
                    <div class="bg-light rounded p-4">
                      <h3 class="mb-4">Thông tin người nhận</h3>
                      <div class="mb-3">
                        <label for="fullName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="fullName" name="receiverName"
                          value="${currentUser.fullName}" placeholder="Nhập họ tên" required>
                      </div>
                      <div class="mb-3">
                        <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="phone" value="${currentUser.phone}"
                          name="receiverPhone" placeholder="Nhập số điện thoại" required>
                      </div>

                      <div class="mb-3">
                        <label class="form-label">Địa chỉ giao hàng <span class="text-danger">*</span></label>

                        <div class="row g-2 mb-2">
                          <div class="col-md-6 mb-2">
                            <select class="form-select" id="province" required>
                              <option value="" disabled selected>Chọn Tỉnh/Thành</option>
                            </select>
                          </div>

                          <div class="col-md-6">
                            <select class="form-select" id="district" required>
                              <option value="" disabled selected>Chọn Quận/Huyện</option>
                            </select>
                          </div>

                          <div class="col-md-6">
                            <select class="form-select" id="ward" required>
                              <option value="" disabled selected>Chọn Phường/Xã</option>
                            </select>
                          </div>

                          <div class="col-md-6">
                            <input type="text" class="form-control" id="houseNumber"
                              placeholder="Số nhà, tên đường, tòa nhà..." required>
                          </div>
                        </div>

                        <input type="hidden" id="fullAddress" name="receiverAddress" value="${currentUser.address}">
                      </div>
                    </div>
                  </div>

                  <div class="col-sm-12 col-md-6">
                    <div class="bg-light rounded p-4">
                      <h3>Đơn hàng</h3>

                      <c:forEach var="cartDetail" items="${cartDetails}">
                        <div class="d-flex align-items-center border-bottom py-2">
                          <img src="/admin/images/product/${cartDetail.product.imageUrl}" alt="Sản phẩm" class="rounded"
                            width="80" height="80">

                          <div class="ms-3 flex-grow-1">
                            <h5 class="mb-1">${cartDetail.product.name}</h5>
                            <p class="mb-1">Số lượng: ${cartDetail.quantity}</p>
                            <p class="mb-0 text-primary fw-bold">
                              <fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}" type="number"
                                groupingUsed="true" /> đ
                            </p>
                          </div>
                        </div>
                      </c:forEach>

                      <p class="my-3">

                      <div class="input-group mb-3">
                        <input id="voucherInput" type="text" class="form-control" placeholder="Nhập mã giảm giá">
                        <button id="applyVoucherBtn" class="btn btn-outline-primary" type="button">Áp dụng</button>
                      </div>

                      <div id="voucherError" class="text-danger small mt-1"></div>

                      <input type="hidden" name="voucherCode" id="voucherCodeField">


                      <hr class="my-3">

                      <div class="d-flex justify-content-between mb-2">
                        <span>Tạm tính</span>
                        <p class="mb-0 text-primary fw-bold">
                          <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" /> đ
                        </p>
                      </div>
                      <div class="d-flex justify-content-between mb-2">
                        <span>Phí vận chuyển</span>
                        <span>
                          <fmt:formatNumber value="0" type="number" groupingUsed="true" />
                          đ
                        </span>
                      </div>

                      <div class="d-flex justify-content-between mb-2">
                        <span>Giảm giá</span>
                        <span id="discountAmount">0 đ</span>
                      </div>

                      <hr class="my-3">

                      <div class="d-flex justify-content-between mb-3 fw-bold">
                        <span>Tổng cộng</span>
                        <span class="text-danger" id="finalPrice">
                          <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" /> đ
                        </span>
                      </div>
                      <input type="hidden" id="totalPriceRaw" value="${totalPrice}">

                      <hr class="my-3">

                      <div class="mb-3">
                        <label class="form-label fw-bold">Phương thức thanh toán</label>
                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD"
                            checked>
                          <label class="form-check-label" for="cod">
                            Thanh toán khi nhận hàng (COD)
                          </label>
                        </div>

                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="VNPAY">
                          <label class="form-check-label" for="vnpay">
                            Thanh toán qua VNPAY
                          </label>
                        </div>
                      </div>

                      <button type="submit" class="btn btn-primary w-100 fw-bold">Đặt
                        hàng</button>
                    </div>
                  </div>

                </div>
              </form>
            </div>

          </div>

          <!-- JS -->
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
          <script src="/client/lib/easing/easing.min.js"></script>
          <script src="/client/lib/waypoints/waypoints.min.js"></script>
          <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
          <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
          <script src="/client/js/main.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
          <script>
            $(document).ready(function () {
              $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
                if (data_tinh.error == 0) {
                  $.each(data_tinh.data, function (key_tinh, val_tinh) {
                    $("#province").append('<option value="' + val_tinh.id + '">' + val_tinh.full_name + '</option>');
                  });
                }
              });

              $("#province").change(function (e) {
                var idtinh = $(this).val();
                $("#district").html('<option value="">Chọn Quận/Huyện</option>').prop('disabled', true);
                $("#ward").html('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);

                if (idtinh !== "") {
                  $.getJSON('https://esgoo.net/api-tinhthanh/2/' + idtinh + '.htm', function (data_quan) {
                    if (data_quan.error == 0) {
                      $("#district").prop('disabled', false);
                      $.each(data_quan.data, function (key_quan, val_quan) {
                        $("#district").append('<option value="' + val_quan.id + '">' + val_quan.full_name + '</option>');
                      });
                    }
                  });
                }
                updateFullAddress();
              });

              $("#district").change(function (e) {
                var idquan = $(this).val();
                $("#ward").html('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);

                if (idquan !== "") {
                  $.getJSON('https://esgoo.net/api-tinhthanh/3/' + idquan + '.htm', function (data_phuong) {
                    if (data_phuong.error == 0) {
                      $("#ward").prop('disabled', false);
                      $.each(data_phuong.data, function (key_phuong, val_phuong) {
                        $("#ward").append('<option value="' + val_phuong.id + '">' + val_phuong.full_name + '</option>');
                      });
                    }
                  });
                }
                updateFullAddress();
              });

              $("#ward, #houseNumber").change(function () {
                updateFullAddress();
              });

              $("#houseNumber").on('input', function () {
                updateFullAddress();
              });

              function updateFullAddress() {
                var provinceText = $("#province option:selected").text();
                var districtText = $("#district option:selected").text();
                var wardText = $("#ward option:selected").text();
                var houseVal = $("#houseNumber").val();

                var addressParts = [];

                if (houseVal && houseVal.trim() !== "") addressParts.push(houseVal);
                if ($("#ward").val() !== "") addressParts.push(wardText);
                if ($("#district").val() !== "") addressParts.push(districtText);
                if ($("#province").val() !== "") addressParts.push(provinceText);

                $("#fullAddress").val(addressParts.join(", "));
              }
            });
          </script>
          
          <script>
            const form = document.querySelector('form');
            const province = document.getElementById('province');
            const district = document.getElementById('district');
            const ward = document.getElementById('ward');
            const houseNumber = document.getElementById('houseNumber');

            form.addEventListener('submit', function (e) {
              const houseVal = houseNumber.value.trim();
              const wardText = $("#ward option:selected").text();
              const districtText = $("#district option:selected").text();
              const provinceText = $("#province option:selected").text();

              const addressParts = [];
              if (houseVal) addressParts.push(houseVal);
              if ($("#ward").val() !== "") addressParts.push(wardText);
              if ($("#district").val() !== "") addressParts.push(districtText);
              if ($("#province").val() !== "") addressParts.push(provinceText);

              const hiddenInput = document.getElementById('fullAddress');
              if (hiddenInput) {
                hiddenInput.value = addressParts.join(", ");
              }
            });
          </script>

        </body>

        </html>