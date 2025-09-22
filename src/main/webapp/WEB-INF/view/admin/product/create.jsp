<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content=" - Dự án Petshop" />
                <meta name="author" content="" />
                <title>Thêm sản phẩm mới</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const productFile = $("#productFile");
                        productFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#productPreview").attr("src", imgURL);
                            $("#productPreview").css({ "display": "block" });
                        });
                    });
                </script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h3>Thêm sản phẩm mới</h3>
                                    <hr />
                                    <form:form method="post" action="/admin/product/create" modelAttribute="newProduct"
                                        enctype="multipart/form-data">
                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Tên sản phẩm</div>
                                                <form:input type="text" class="form-control" path="name" />
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Mô tả sản phẩm</div>
                                                <form:input type="text" class="form-control" path="description" />
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Giá</div>
                                                <form:input type="text" class="form-control" path="price" />
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <div class="mb-3 col-12 col-md-6">
                                                <div class="form-label">Số lượng</div>
                                                <form:input type="text" class="form-control" path="stock" />
                                            </div>
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Dành cho</label>
                                            <form:select class="form-select" path="subcategory.petType.id"
                                                id="petSelect">
                                                <form:option value="1">Mèo</form:option>
                                                <form:option value="2">Chó</form:option>
                                            </form:select>
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Danh mục</label>
                                            <form:select class="form-select" path="subcategory.category.id"
                                                id="categorySelect">
                                                <form:option value="1">Thức ăn</form:option>
                                                <form:option value="2">Vệ sinh</form:option>
                                                <form:option value="3">Phụ kiện</form:option>
                                            </form:select>
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Danh mục phụ</label>
                                            <form:select class="form-select" path="subcategory.id"
                                                id="subcategorySelect">
                                                <form:option value="1" data-pet="1" data-category="1">Hạt cho mèo
                                                </form:option>
                                                <form:option value="2" data-pet="1" data-category="1">Pate cho mèo
                                                </form:option>
                                                <form:option value="3" data-pet="1" data-category="1">Súp thưởng
                                                </form:option>
                                                <form:option value="4" data-pet="1" data-category="2">Cát vệ sinh
                                                </form:option>
                                                <form:option value="5" data-pet="1" data-category="2">Sữa tắm mèo
                                                </form:option>
                                                <form:option value="6" data-pet="1" data-category="3">Phụ kiện mèo
                                                </form:option>
                                                <form:option value="7" data-pet="2" data-category="1">Hạt cho chó
                                                </form:option>
                                                <form:option value="8" data-pet="2" data-category="1">Pate cho chó
                                                </form:option>
                                                <form:option value="9" data-pet="2" data-category="1">Bánh thưởng
                                                </form:option>
                                                <form:option value="10" data-pet="2" data-category="2">Sữa tắm chó
                                                </form:option>
                                                <form:option value="11" data-pet="2" data-category="2">Chăm sóc
                                                    tai/mắt/miệng</form:option>
                                                <form:option value="12" data-pet="2" data-category="3">Phụ kiện chó
                                                </form:option>
                                            </form:select>
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Thương hiệu</label>
                                            <form:select class="form-select" path="brand.id">
                                                <form:option value="1">Royal Canin</form:option>
                                                <form:option value="2">Pedigree</form:option>
                                                <form:option value="3">Whiskas</form:option>
                                                <form:option value="4">Sanicat</form:option>
                                                <form:option value="5">SOS</form:option>
                                                <form:option value="6">Me-O</form:option>
                                                <form:option value="7">SmartHeart</form:option>
                                            </form:select>
                                        </div>

                                        <div class="mb-3 col-12 col-md-6">
                                            <label for="productFile" class="form-label">Ảnh sản phẩm</label>
                                            <input type="file" class="form-control" id="productFile" name="productFile"
                                                accept=".png, .jpg, .jpeg">
                                        </div>
                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="product preview"
                                                id="productPreview">
                                        </div>

                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Thêm mới</button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>

                <!-- Script lọc Danh mục phụ -->
                <script>
                    const petSelect = document.querySelector('#petSelect');
                    const categorySelect = document.querySelector('#categorySelect');
                    const subcategorySelect = document.querySelector('#subcategorySelect');

                    function filterSubcategories() {
                        const pet = petSelect.value.toString();
                        const category = categorySelect.value.toString();
                        let firstVisible = null;

                        Array.from(subcategorySelect.options).forEach(option => {
                            const optionPet = option.getAttribute('data-pet');
                            const optionCategory = option.getAttribute('data-category');

                            if (optionPet === pet && optionCategory === category) {
                                option.style.display = "block";
                                if (!firstVisible) firstVisible = option;
                            } else {
                                option.style.display = "none";
                            }
                        });

                        if (firstVisible) subcategorySelect.value = firstVisible.value;
                    }

                    petSelect.addEventListener('change', filterSubcategories);
                    categorySelect.addEventListener('change', filterSubcategories);

                    filterSubcategories();
                </script>
            </body>

            </html>