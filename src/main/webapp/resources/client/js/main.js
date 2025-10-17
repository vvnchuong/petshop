(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });



    // Product Quantity
    function formatNumber(num) {
        return num.toLocaleString('vi-VN');
    }

    function updateTotals() {
        let totalPrice = 0;
        $('.quantity-input').each(function () {
            let quantity = parseInt($(this).val()) || 1;
            let price = parseFloat($(this).closest('tr').find('.product-price').data('price'));
            let lineTotal = price * quantity;

            $(this).closest('tr').find('.line-total').text(formatNumber(lineTotal) + ' đ');
            totalPrice += lineTotal;
        });

        $('#total-price').text(formatNumber(totalPrice) + ' đ');
        $('#grand-total').text(formatNumber(totalPrice) + ' đ');
    }

    // Hàm gọi API cập nhật server
    function saveQuantity(id, quantity) {
        $.post("/cart/update", { id: id, quantity: quantity })
            .done(() => console.log("Đã lưu " + id + " = " + quantity))
            .fail(() => alert("Lỗi lưu số lượng!"));
    }

    $(document).ready(function () {
        $('.btn-plus, .btn-minus').on('click', function () {
            let input = $(this).closest('.quantity').find('.quantity-input');
            let currentVal = parseInt(input.val()) || 1;
            if ($(this).hasClass('btn-plus')) {
                input.val(currentVal + 1);
            } else if (currentVal > 1) {
                input.val(currentVal - 1);
            }
            updateTotals();

            const cartId = $(this).closest('tr').find('input[type=hidden]').val();
            saveQuantity(cartId, input.val());
        });

        $('.quantity-input').on('change', function () {
            let qty = parseInt($(this).val()) || 1;
            if (qty < 1) qty = 1;
            $(this).val(qty);
            updateTotals();

            const cartId = $(this).closest('tr').find('input[type=hidden]').val();
            saveQuantity(cartId, qty);
        });

        updateTotals();
    });

})(jQuery);

// count number product types
document.addEventListener("DOMContentLoaded", function () {
    const addToCartBtn = document.getElementById("addToCartBtn");
    const quantityInput = document.querySelector(".product-detail-quantity input");

    if (!addToCartBtn || !quantityInput) return;

    addToCartBtn.addEventListener("click", function () {
        const slug = this.dataset.slug;
        const quantity = parseInt(quantityInput.value) || 1;

        const url = "/cart/" + encodeURIComponent(slug);

        fetch(url, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Requested-With": "XMLHttpRequest"
            },
            body: "quantity=" + quantity
        })
        .then(res => {
            if (!res.ok) throw new Error("HTTP status " + res.status);
            return res.json();
        })
        .then(data => {
            console.log(data.message);

            let badge = document.getElementById("cartBadge");
            if (!badge) {
                badge = document.createElement("span");
                badge.id = "cartBadge";
                badge.className = "position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1";
                badge.style.cssText = "top:-5px;left:15px;height:20px;min-width:20px;";
                document.querySelector("a[href='/cart']").appendChild(badge);
            }
            badge.innerText = data.cartQuantity;
        })
        .catch(err => {
            console.error("Error adding product to cart:", err);
            alert("Thêm sản phẩm vào giỏ hàng thất bại!");
        });
    });
});

// delete product in cart detail
$(document).ready(function () {
    $(".btn-delete").on("click", function () {
        const btn = $(this);
        const slug = btn.data("slug");

        $.ajax({
            url: "/cart/delete/" + slug,
            type: "POST",
            headers: { "X-CSRF-TOKEN": "${_csrf.token}" },
            success: function () {
                btn.closest("tr").remove();

                let badge = document.getElementById("cartBadge");
                if (badge) {
                    let currentQty = parseInt(badge.innerText) || 0;
                    badge.innerText = Math.max(currentQty - 1, 0);
                    if (currentQty - 1 <= 0) badge.remove();
                }

                if ($("tbody tr").length === 0) {
                    $(".table-responsive").hide();
                    $("#emptyCartMessage").show();
                }

                updateTotal();
            },
            error: function () {
                alert("Error to delete product!");
            }
        });
    });

    function updateTotal() {
        let total = 0;
        $(".line-total").each(function () {
            const value = $(this).text().replace(/[^\d]/g, "");
            total += parseInt(value) || 0;
        });
        $("#total-price, #grand-total").text(total.toLocaleString() + " đ");
    }
});

