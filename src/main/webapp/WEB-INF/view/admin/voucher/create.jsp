<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Dự án Petshop - Quản trị" />
        <meta name="author" content="" />
        <title>Thêm voucher mới</title>

        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link href="/admin/css/styles.css" rel="stylesheet" />
      </head>

      <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav">
          <jsp:include page="../layout/sidebar.jsp" />

          <div id="layoutSidenav_content">
            <div class="container-fluid mt-4">
              <div class="row">
                <div class="col-12">
                  <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                      <h3 class="mb-3">Tạo voucher mới</h3>
                      <hr />

                      <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                      </c:if>

                      <form:form method="post" action="/admin/vouchers/create" modelAttribute="newVoucher"
                        enctype="multipart/form-data" id="voucherForm">
                        <div class="row g-3">

                          <div class="col-md-6">
                            <c:set var="errorCode">
                              <form:errors path="code" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label required">Mã voucher</label>
                            <form:input path="code" class="form-control ${not empty errorCode ? 'is-invalid' : ''}"
                              placeholder="VD: CATSALE20" />${errorCode}
                          </div>

                          <div class="col-md-6">
                            <label class="form-label">Trạng thái</label>
                            <form:select path="active" class="form-select" id="activeSelect">
                              <form:option value="true">Kích hoạt</form:option>
                              <form:option value="false">Dừng kích hoạt</form:option>
                            </form:select>
                          </div>

                          <div class="col-12">
                            <c:set var="errorDescription">
                              <form:errors path="description" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label">Mô tả</label>
                            <form:textarea path="description"
                              class="form-control ${not empty errorDescription ? 'is-invalid' : ''}" rows="2"
                              placeholder="Mô tả ngắn (ví dụ: Áp dụng cho đơn ≥ 200.000 VND)"></form:textarea>
                          </div>

                          <div class="col-md-6">
                            <c:set var="errorStartDate">
                              <form:errors path="startDate" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label">Ngày bắt đầu</label>
                            <form:input path="startDate" id="startDate" type="datetime-local"
                              class="form-control ${not empty errorStartDate ? 'is-invalid' : ''}" />${errorStartDate}
                          </div>

                          <div class="col-md-6">
                            <c:set var="errorEndDate">
                              <form:errors path="endDate" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label">Ngày kết thúc</label>
                            <form:input path="endDate" id="endDate" type="datetime-local"
                              class="form-control ${not empty errorEndDate ? 'is-invalid' : ''}" />${errorEndDate}
                          </div>

                          <div class="col-md-6">
                            <c:set var="errorMaxUsage">
                              <form:errors path="maxUsage" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label">Số lượng tối đa</label>
                            <form:input path="maxUsage" type="number" min="1"
                              class="form-control ${not empty errorMaxUsage ? 'is-invalid' : ''}"
                              placeholder="Số lượng voucher (ví dụ: 100)" />${errorMaxUsage}
                          </div>

                          <div class="col-md-6">
                            <c:set var="errorMinOrder">
                              <form:errors path="minOrder" cssClass="invalid-feedback" />
                            </c:set>
                            <label class="form-label">Giá trị đơn tối thiểu (VND)</label>
                            <form:input path="minOrder" type="number" min="0" class="form-control ${not empty errorMinOrder ? 'is-invalid' : ''}"
                              placeholder="VD: 200000 (0 = không yêu cầu)" />${errorMinOrder}
                          </div>

                          <div class="col-md-6">
                            <label class="form-label">Mức giảm phần trăm (%)</label>
                            <form:input path="discountPercent" id="discountPercent" type="number" min="0" max="100"
                              step="0.01" class="form-control" placeholder="Nhập 10 cho 10%" />
                          </div>

                          <div class="col-md-6">
                            <label class="form-label">Mức giảm cố định (VND)</label>
                            <form:input path="discountAmount" id="discountAmount" type="number" min="0" step="1"
                              class="form-control" placeholder="Nhập số tiền VND" />
                          </div>

                          <div class="col-12">
                            <div class="form-text text-muted">
                              Lưu ý: chỉ được nhập một trong hai: <strong>Mức giảm phần trăm</strong> hoặc
                              <strong>Mức giảm cố định</strong>. Hệ thống sẽ tự khóa trường kia khi bạn
                              nhập.
                            </div>
                          </div>

                          <div class="col-12 mt-3">
                            <button type="submit" class="btn btn-primary px-4">Thêm mới</button>
                            <a href="/admin/vouchers" class="btn btn-outline-secondary ms-2">Hủy</a>
                          </div>

                        </div>
                      </form:form>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <jsp:include page="../layout/footer.jsp" />
          </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
          crossorigin="anonymous"></script>
        <script>

        </script>
        <script src="/client/js/main.js"></script>

      </body>

      </html>