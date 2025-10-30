<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="com.petshop.pet.utils.DateTimeUtil" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content=" - Dự án Petshop" />
                    <meta name="author" content="" />
                    <title>Dashboard</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="/admin/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">

                    <jsp:include page="../layout/header.jsp" />

                    <div id="layoutSidenav">

                        <jsp:include page="../layout/sidebar.jsp" />

                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Dashboard</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item active">Tổng quan</li>
                                    </ol>

                                    <div class="row">
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-primary text-white mb-4">
                                                <div class="card-body">Tổng số người dùng: ${totalUser}</div>
                                                <div
                                                    class="card-footer d-flex align-items-center justify-content-between">
                                                    <a class="small text-white stretched-link" href="/admin/users">
                                                        Xem chi tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-warning text-white mb-4">
                                                <div class="card-body">Tổng số sản phẩm: ${totalProduct}</div>
                                                <div
                                                    class="card-footer d-flex align-items-center justify-content-between">
                                                    <a class="small text-white stretched-link" href="/admin/products">Xem
                                                        chi
                                                        tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-success text-white mb-4">
                                                <div class="card-body">Tổng số đơn hàng: ${totalOrder}</div>
                                                <div
                                                    class="card-footer d-flex align-items-center justify-content-between">
                                                    <a class="small text-white stretched-link" href="/admin/orders">Xem
                                                        chi
                                                        tiết</a>
                                                    <div class="small text-white"><i class="fas fa-angle-right"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-info text-white mb-4">
                                                <div class="card-body">Doanh thu hôm nay:
                                                    <fmt:formatNumber value="${revenueToday}" type="number"
                                                        pattern="#,##0" /> VNĐ
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-secondary text-white mb-4">
                                                <div class="card-body">Đơn hàng mới hôm nay: ${ordersToday}</div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-dark text-white mb-4">
                                                <div class="card-body">Người dùng mới hôm nay: ${newUsersToday}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xl-12">
                                            <div class="card mb-4">
                                                <div class="card-header">
                                                    <i class="fas fa-chart-area me-1"></i>
                                                    Biểu đồ doanh thu 7 ngày gần nhất
                                                </div>
                                                <div class="card-body"><canvas id="myAreaChart" width="100%"
                                                        height="30"></canvas></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <i class="fas fa-table me-1"></i>
                                            Các đơn hàng mới nhất
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
                                                    <c:forEach items="${recentOrders}" var="order">
                                                        <tr>
                                                            <td>${order.id}</td>
                                                            <td>${order.receiverName}</td>
                                                            <td>${DateTimeUtil.formatInstant(order.createdAt)}</td>
                                                            <td>
                                                                <fmt:formatNumber value="${order.totalAmount}"
                                                                    type="number" pattern="#,##0 VNĐ" />
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${order.status.toString() eq 'PENDING'}">
                                                                        ${order.status.name}
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${order.status.toString() eq 'SHIPPING'}">
                                                                        ${order.status.name}
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${order.status.toString() eq 'DELIVERED'}">
                                                                        ${order.status.name}
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${order.status.toString() eq 'CANCELLED'}">
                                                                        ${order.status.name}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${order.status.name}
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

                    <script>
                        Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
                        Chart.defaults.global.defaultFontColor = '#292b2c';

                        const dateLabels = JSON.parse('${dateLabelsJson}');
                        const revenueValues = JSON.parse('${revenueValuesJson}');

                        var ctx = document.getElementById("myAreaChart");
                        var myLineChart = new Chart(ctx, {
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
                                    pointHoverRadius: 5,
                                    pointHoverBackgroundColor: "rgba(2,117,216,1)",
                                    pointHitRadius: 50,
                                    pointBorderWidth: 2,
                                    data: revenueValues,
                                }],
                            },
                            options: {
                                scales: {
                                    xAxes: [{
                                        time: {
                                            unit: 'date'
                                        },
                                        gridLines: {
                                            display: false
                                        },
                                        ticks: {
                                            maxTicksLimit: 7
                                        }
                                    }],
                                    yAxes: [{
                                        ticks: {
                                            min: 0,
                                            maxTicksLimit: 5,
                                            callback: function (value, index, values) {
                                                return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                                            }
                                        },
                                        gridLines: {
                                            color: "rgba(0, 0, 0, .125)",
                                        }
                                    }],
                                },
                                legend: {
                                    display: false
                                }
                            }
                        });
                    </script>
                </body>

                </html>