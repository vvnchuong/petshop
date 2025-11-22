<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
          <meta charset="utf-8" />
          <meta http-equiv="X-UA-Compatible" content="IE=edge" />
          <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
          <title>Dashboard - Petshop Admin</title>
          <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
          <link href="/admin/css/styles.css" rel="stylesheet" />
          <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
          <style>
            .card {
              border: none;
              border-radius: 0.5rem;
              box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            }

            .card-footer a {
              text-decoration: none;
            }
          </style>
        </head>

        <body class="sb-nav-fixed">

          <jsp:include page="../layout/header.jsp" />

          <div id="layoutSidenav">

            <jsp:include page="../layout/sidebar.jsp" />

            <div id="layoutSidenav_content">
              <main>
                <div class="container-fluid px-4">

                  <div class="d-flex justify-content-between align-items-center my-4">
                    <h1 class="m-0">Dashboard</h1>
                    <form action="/admin" method="get" class="d-flex align-items-center">
                      <label class="me-2 fw-bold mb-0">Thống kê:</label>
                      <select name="range" class="form-select form-select-sm" onchange="this.form.submit()"
                        style="width: 180px;">

                        <option value="TODAY" ${data.currentRange=='TODAY' ? 'selected' : '' }>Hôm nay</option>
                        <option value="YESTERDAY" ${data.currentRange=='YESTERDAY' ? 'selected' : '' }>Hôm qua</option>

                        <option value="DAYS_7" ${data.currentRange=='DAYS_7' ? 'selected' : '' }>7 ngày qua</option>
                        <option value="DAYS_30" ${data.currentRange=='DAYS_30' ? 'selected' : '' }>30 ngày qua</option>

                        <option value="THIS_MONTH" ${data.currentRange=='THIS_MONTH' ? 'selected' : '' }>Tháng này
                        </option>

                      </select>
                    </form>
                  </div>

                  <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-primary text-white h-100">
                        <div class="card-body">
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <div class="text-uppercase fw-bold small">Doanh thu (${data.labelTime})</div>
                              <div class="h3 fw-light">
                                <fmt:formatNumber value="${data.revenuePeriod}" type="number" pattern="#,##0" /> VNĐ
                              </div>
                            </div>
                            <i class="fas fa-dollar-sign fa-2x text-white-50"></i>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-success text-white h-100">
                        <div class="card-body">
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <div class="text-uppercase fw-bold small">Đơn hàng (${data.labelTime})</div>
                              <div class="h3 fw-light">${data.ordersPeriod}</div>
                            </div>
                            <i class="fas fa-shopping-cart fa-2x text-white-50"></i>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-info text-white h-100">
                        <div class="card-body">
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <div class="text-uppercase fw-bold small">Khách hàng mới (${data.labelTime})</div>
                              <div class="h3 fw-light">${data.newUsersPeriod}</div>
                            </div>
                            <i class="fas fa-user-plus fa-2x text-white-50"></i>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-danger text-white h-100">
                        <div class="card-body">
                          <div class="d-flex justify-content-between align-items-center">
                            <div>
                              <div class="text-uppercase fw-bold small">Chờ xử lý (Hiện tại)</div>
                              <div class="h3 fw-light">${data.pendingOrders}</div>
                            </div>
                            <i class="fas fa-hourglass-start fa-2x text-white-50"></i>
                          </div>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                          <a class="small text-white stretched-link" href="/admin/orders?status=PENDING">
                            Xem chi tiết
                          </a>
                          <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-xl-6">
                      <div class="card mb-4">
                        <div class="card-header">
                          <i class="fas fa-chart-area me-1"></i>
                          Biểu đồ doanh thu (${data.labelTime})
                        </div>
                        <div class="card-body"><canvas id="myAreaChart" width="100%"></canvas></div>
                      </div>
                    </div>
                    <div class="col-xl-6">
                      <div class="card mb-4">
                        <div class="card-header">
                          <i class="fas fa-chart-bar me-1"></i>
                          Trạng thái đơn hàng (Tổng)
                        </div>
                        <div class="card-body"><canvas id="myPieChart" width="100%"></canvas></div>
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-xl-6">
                      <div class="card mb-4">
                        <div class="card-header">
                          <i class="fas fa-table me-1"></i>
                          Các đơn hàng mới nhất (${data.labelTime})
                        </div>
                        <div class="card-body">
                          <table id="datatablesSimple">
                            <thead>
                              <tr>
                                <th>Mã Đơn</th>
                                <th>Khách Hàng</th>
                                <th>Ngày Đặt</th>
                                <th>Tổng Tiền</th>
                                <th>Trạng Thái</th>
                              </tr>
                            </thead>
                            <tbody>
                              <c:forEach items="${data.recentOrders}" var="order">
                                <tr>
                                  <td><a href="/admin/orders/update/${order.id}">#${order.orderCode}</a></td>
                                  <td>${order.receiverName}</td>
                                  <td>${DateTimeUtil.formatInstant(order.createdAt)}</td>
                                  <td>
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,##0 VNĐ" />
                                  </td>
                                  <td>
                                    <c:choose>
                                      <c:when test="${order.status.toString() eq 'PENDING'}">
                                        <span class="badge bg-warning text-dark">Chờ xử lý</span>
                                      </c:when>
                                      <c:when test="${order.status.toString() eq 'SHIPPING'}">
                                        <span class="badge bg-info text-dark">Đang giao</span>
                                      </c:when>
                                      <c:when test="${order.status.toString() eq 'DELIVERED'}">
                                        <span class="badge bg-success">Đã giao</span>
                                      </c:when>
                                      <c:when test="${order.status.toString() eq 'CANCELLED'}">
                                        <span class="badge bg-danger">Đã hủy</span>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="badge bg-secondary">${order.status.name}</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </td>
                                </tr>
                              </c:forEach>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>

                    <div class="col-xl-6">
                      <div class="card mb-4">
                        <div class="card-header">
                          <i class="fas fa-star me-1"></i>
                          Sản phẩm bán chạy nhất
                        </div>
                        <div class="card-body">
                          <table class="table table-hover">
                            <thead>
                              <tr>
                                <th>Sản phẩm</th>
                                <th>Đã bán</th>
                                <th>Tồn kho</th>
                              </tr>
                            </thead>
                            <tbody>
                              <c:forEach items="${data.topSellingProducts}" var="product">
                                <tr>
                                  <td>
                                    <a href="/admin/products/${product.productId}" class="text-decoration-none">
                                      ${product.name}
                                    </a>
                                  </td>
                                  <td>${product.totalSold}</td>
                                  <td>${product.stock}</td>
                                </tr>
                              </c:forEach>
                              <c:if test="${empty data.topSellingProducts}">
                                <tr>
                                  <td colspan="3" class="text-center">Chưa có dữ liệu</td>
                                </tr>
                              </c:if>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-dark text-white h-100">
                        <div class="card-body">
                          <div class="text-uppercase fw-bold small">Tổng doanh thu (Toàn bộ)</div>
                          <div class="h4 fw-light">
                            <fmt:formatNumber value="${data.totalRevenue}" type="number" pattern="#,##0" /> VNĐ
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-secondary text-white h-100">
                        <div class="card-body">
                          <div class="text-uppercase fw-bold small">Tổng số khách hàng</div>
                          <div class="h4 fw-light">${data.totalUser}</div>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                          <a class="small text-white stretched-link" href="/admin/users">Xem chi tiết</a>
                          <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-warning text-dark h-100">
                        <div class="card-body">
                          <div class="text-uppercase fw-bold small">Tổng số sản phẩm</div>
                          <div class="h4 fw-light">${data.totalProduct}</div>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                          <a class="small text-dark stretched-link" href="/admin/products">Xem chi tiết</a>
                          <div class="small text-dark"><i class="fas fa-angle-right"></i></div>
                        </div>
                      </div>
                    </div>
                    <div class="col-xl-3 col-md-6 mb-4">
                      <div class="card bg-success text-white h-100">
                        <div class="card-body">
                          <div class="text-uppercase fw-bold small">Tổng số đơn hàng</div>
                          <div class="h4 fw-light">${data.totalOrder}</div>
                        </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                          <a class="small text-white stretched-link" href="/admin/orders">Xem chi tiết</a>
                          <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                        </div>
                      </div>
                    </div>
                  </div>

                </div>
              </main>

              <jsp:include page="../layout/footer.jsp" />

            </div>
          </div>

          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
          <script src="/admin/js/scripts.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
            crossorigin="anonymous"></script>
          <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
            crossorigin="anonymous"></script>
          <script src="/admin/js/datatables-simple-demo.js"></script>
          <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>

          <script>
            Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
            Chart.defaults.global.defaultFontColor = '#292b2c';
            
            const dateLabels = JSON.parse('${data.dateLabelsJson}');
            const revenueValues = JSON.parse('${data.revenueValuesJson}');

            var ctxArea = document.getElementById("myAreaChart");
            var myLineChart = new Chart(ctxArea, {
              type: 'line',
              data: {
                labels: dateLabels,
                datasets: [{
                  label: "Doanh thu",
                  lineTension: 0.3,
                  backgroundColor: "rgba(2,117,216,0.2)",
                  borderColor: "rgba(2,117,216,1)",
                  pointRadius: 5,
                  pointBackgroundColor: "rgba(2,117,216,1)",
                  pointBorderColor: "rgba(255,255,255,0.8)",
                  pointHoverRadius: 7,
                  pointHoverBackgroundColor: "rgba(2,117,216,1)",
                  pointHitRadius: 50,
                  pointBorderWidth: 2,
                  data: revenueValues,
                }],
              },
              options: {
                scales: {
                  xAxes: [{
                    time: { unit: 'date' },
                    gridLines: { display: false },
                    ticks: { maxTicksLimit: 7 }
                  }],
                  yAxes: [{
                    ticks: {
                      min: 0,
                      maxTicksLimit: 5,
                      callback: function (value, index, values) {
                        return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                      }
                    },
                    gridLines: { color: "rgba(0, 0, 0, .125)" }
                  }],
                },
                legend: { display: false },
                tooltips: {
                  callbacks: {
                    label: function (tooltipItem, data) {
                      return new Intl.NumberFormat('vi-VN').format(tooltipItem.yLabel) + ' VNĐ';
                    }
                  }
                }
              }
            });

            const orderStatusLabels = JSON.parse('${data.orderStatusLabelsJson}');
            const orderStatusValues = JSON.parse('${data.orderStatusValuesJson}');
            const ctxBar = document.getElementById("myPieChart");

            const statusMap = {
              CANCELLED: "Đã hủy",
              DELIVERED: "Đã giao",
              FAILED: "Thất bại",
              PENDING: "Chờ xử lý",
              SHIPPING: "Đang giao"
            };

            const convertOrderStatusLabels = orderStatusLabels.map(status => statusMap[status] || status);

            const myBarChart = new Chart(ctxBar, {
              type: 'bar',
              data: {
                labels: convertOrderStatusLabels,
                datasets: [{
                  label: "Số lượng",
                  data: orderStatusValues,
                  backgroundColor: [
                    '#dc3545', '#198754', '#6c757d', '#ffc107', '#0dcaf0', '#6610f2'
                  ],
                  borderWidth: 1
                }]
              },
              options: {
                scales: {
                  xAxes: [{ gridLines: { display: false }, ticks: { fontStyle: 'bold' } }],
                  yAxes: [{ ticks: { beginAtZero: true, callback: function (value) { if (value % 1 === 0) { return value; } } } }]
                },
                legend: { display: false },
                plugins: {
                  datalabels: {
                    anchor: 'end', align: 'top', color: '#292b2c',
                    font: { weight: 'bold', size: 13 },
                    formatter: function (value) { return value; }
                  }
                }
              },
              plugins: [ChartDataLabels]
            });
          </script>
        </body>

        </html>