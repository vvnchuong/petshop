<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <title>Cập nhật bài viết</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content=" - Dự án Petshop" />
    <meta name="author" content="" />

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/admin/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <script src="https://cdn.ckeditor.com/ckeditor5/35.4.0/classic/ckeditor.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
      .thumb-preview {
        width: 220px;
        max-height: 160px;
        object-fit: cover;
        border-radius: 6px;
        display: block;
        margin-top: 8px;
        border: 1px solid #dee2e6;
      }
      .required::after {
        content: " *";
        color: #d00;
        margin-left: 4px;
        font-weight: 600;
      }
      .helper {
        font-size: .9rem;
        color: #6c757d;
      }
      .editor-wrapper {
        border: 1px solid #dee2e6;
        border-radius: 6px;
        padding: 6px;
      }
      .ck-editor__editable .image img {
        max-width: 100%;
        height: auto;
      }
      .ck-error-text {
        color: #d00;
        font-size: .875em;
        margin-top: .25rem;
      }
    </style>

    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
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
                                <h4 class="card-title mb-3">Cập nhật bài viết</h4>
                                <hr />

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form:form action="/admin/news/update/${id}" method="post" modelAttribute="news"
                                    enctype="multipart/form-data" class="row g-3">

                                    <form:hidden path="thumbnail" />


                                    <div class="col-12">
                                        <label class="form-label required">Tiêu đề</label>
                                        <form:input path="title" cssClass="form-control" />
                                        <form:errors path="title" cssClass="text-danger" />
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label required">Nội dung</label>
                                        <div class="editor-wrapper">
                                            <form:textarea path="content" id="editor" cssClass="form-control" rows="12" />
                                        </div>
                                        <div class="form-text helper">Dùng công cụ chèn ảnh để upload ảnh vào bài, kéo thả
                                            để chỉnh kích thước (nếu editor hỗ trợ).</div>
                                        <form:errors path="content" cssClass="ck-error-text" />
                                    </div>

                                    <div class="col-md-6">
                                        <label class="form-label required">Thumbnail (ảnh bìa)</label>
                                        <input type="file" class="form-control" id="inputFile" name="inputFile"
                                            accept=".png,.jpg,.jpeg">
                                        <div class="helper">Để trống nếu không muốn thay đổi ảnh.</div>

                                        <c:set var="currentThumbUrl" value="/admin/images/thumbnail/${news.thumbnail}" />
                                        <img id="thumbImg" class="thumb-preview"
                                            style="${not empty news.thumbnail ? 'display:block;' : 'display:none;'}"
                                            src="${not empty news.thumbnail ? currentThumbUrl : ''}" alt="Thumbnail preview" />

                                        <form:errors path="thumbnail" cssClass="text-danger" />
                                    </div>

                                    <div class="col-12 mt-4">
                                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                                        <a href="/admin/news" class="btn btn-outline-secondary ms-2">Hủy</a>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="/admin/js/scripts.js"></script>

    <script>
        $(document).ready(function () {
            const $inputFile = $('#inputFile');
            const $preview = $('#thumbImg');
            const originalSrc = $preview.attr('src');
            const originalDisplay = $preview.css('display');

            $inputFile.on('change', function (e) {
                const file = e.target.files && e.target.files[0];
                if (file) {
                    $preview.attr('src', URL.createObjectURL(file));
                    $preview.css('display', 'block');
                } else {
                    $preview.attr('src', originalSrc);
                    $preview.css('display', originalDisplay);
                }
            });
        });
    </script>

    <script>
        function MyCustomUploadAdapterPlugin(editor) {
            editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                return new MyUploadAdapter(loader);
            };
        }

        class MyUploadAdapter {
            constructor(loader) {
                this.loader = loader;
                this.url = '/admin/news/upload-image';
            }
            upload() {
                return this.loader.file
                    .then(file => new Promise((resolve, reject) => {
                        this._initRequest();
                        this._initListeners(resolve, reject, file);
                        this._sendRequest(file);
                    }));
            }
            abort() {
                if (this.xhr) { this.xhr.abort(); }
            }
            _initRequest() {
                const xhr = this.xhr = new XMLHttpRequest();
                xhr.open('POST', this.url, true);
                xhr.responseType = 'json';
                const tokenMeta = document.querySelector('meta[name="_csrf"]');
                const headerMeta = document.querySelector('meta[name="_csrf_header"]');
                if (tokenMeta && headerMeta) {
                    const token = tokenMeta.getAttribute('content');
                    const header = headerMeta.getAttribute('content');
                    if (token && header) {
                        xhr.setRequestHeader(header, token);
                    }
                }
            }
            _initListeners(resolve, reject, file) {
                const xhr = this.xhr;
                const genericErrorText = 'Không thể upload file: ' + file.name + '.';
                xhr.addEventListener('error', () => reject(genericErrorText));
                xhr.addEventListener('abort', () => reject());
                xhr.addEventListener('load', () => {
                    const response = xhr.response;
                    if (!response || !response.url) {
                        return reject(response && response.error ? response.error.message : genericErrorText);
                    }
                    resolve({ default: response.url });
                });
            }
            _sendRequest(file) {
                const data = new FormData();
                data.append('upload', file);
                this.xhr.send(data);
            }
        }

        ClassicEditor
            .create(document.querySelector('#editor'), {
                extraPlugins: [MyCustomUploadAdapterPlugin],
                toolbar: [
                    'undo', 'redo', '|',
                    'bold', 'italic', 'link', 'blockQuote', '|',
                    'bulletedList', 'numberedList', '|',
                    'insertImage', 'imageUpload'
                ],
                image: {
                    resizeUnit: 'px',
                    toolbar: [
                        'imageStyle:inline', 'imageStyle:block', 'imageStyle:side',
                        '|',
                        'resizeImage'
                    ],
                    resizeOptions: [
                        { name: 'resizeImage:original', label: 'Gốc', value: null },
                        { name: 'resizeImage:50', label: '50%', value: '50%' },
                        { name: 'resizeImage:75', label: '75%', value: '75%' },
                    ]
                }
            })
            .catch(console.error);
    </script>

</body>

</html>