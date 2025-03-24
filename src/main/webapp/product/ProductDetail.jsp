<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
    <style>
        :root {
            --primary-color: #2e8b57;
            --primary-light: #3c9d74;
            --primary-dark: #236744;
            --accent-color: #f8f9fa;
        }

        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Container styling */
        .product-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
            margin-top: 40px;
            margin-bottom: 40px;
        }

        /* Product image styling */
        .product-image-container {
            position: relative;
            height: 450px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba(46, 139, 87, 0.05);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .product-image {
            max-height: 400px;
            max-width: 100%;
            object-fit: contain;
            transition: transform 0.4s ease;
        }

        .product-image-container:hover .product-image {
            transform: scale(1.05);
        }

        /* Product info styling */
        .product-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 1.2rem;
            position: relative;
            padding-bottom: 12px;
            font-size: 2rem;
        }

        .product-title::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 80px;
            height: 3px;
            background-color: var(--primary-color);
            border-radius: 2px;
        }

        .product-description {
            color: #555;
            font-size: 1.05rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .product-price {
            color: var(--primary-light) !important;
            font-weight: 700;
            font-size: 1.8rem;
            margin-top: 1.5rem;
            margin-bottom: 0.8rem;
        }

        .stock-info {
            font-size: 0.95rem;
            color: #666;
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .stock-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            background-color: #28a745;
            border-radius: 50%;
            margin-right: 8px;
        }

        .product-divider {
            height: 1px;
            background-color: #eee;
            margin: 20px 0;
        }

        /* Size selection */
        .option-label {
            font-weight: 600;
            color: #444;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }

        .size-container {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin: 1rem 0 1.5rem;
        }

        .size-btn {
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            cursor: pointer;
            border-radius: 10px;
            background-color: #fff;
            transition: all 0.25s ease;
            font-weight: 500;
            min-width: 60px;
            text-align: center;
        }

        .size-btn:hover {
            border-color: var(--primary-light);
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(46, 139, 87, 0.15);
        }

        .size-btn.active {
            background-color: var(--primary-light);
            color: white;
            border-color: var(--primary-light);
            box-shadow: 0 5px 10px rgba(46, 139, 87, 0.25);
        }

        /* Quantity control */
        .quantity-controls {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
        }

        .quantity-btn {
            border: 1px solid #e0e0e0;
            background-color: #f8f9fa;
            color: #333;
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: bold;
            border-radius: 8px;
            transition: all 0.2s ease;
        }

        .quantity-btn:hover {
            background-color: #e9ecef;
        }

        .quantity-input {
            width: 70px;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            height: 44px;
            margin: 0 10px;
        }

        .quantity-label {
            margin-right: 15px;
            font-weight: 600;
            color: #444;
            font-size: 1.1rem;
        }

        /* Action buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 2rem;
        }

        .btn-add-to-cart {
            flex: 1;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            font-weight: 600;
            padding: 14px 20px;
            border-radius: 10px;
            background-color: white;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-add-to-cart:hover {
            background-color: rgba(46, 139, 87, 0.1);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(46, 139, 87, 0.2);
        }

        .btn-buy-now {
            flex: 1;
            background-color: var(--primary-color);
            border: none;
            color: #fff;
            font-weight: 600;
            padding: 14px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-buy-now:hover {
            background-color: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(46, 139, 87, 0.3);
        }

        /* Animation for page load */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.6s ease forwards;
        }

        .fade-in-delay-1 {
            animation: fadeIn 0.6s ease 0.2s forwards;
            opacity: 0;
        }

        .fade-in-delay-2 {
            animation: fadeIn 0.6s ease 0.4s forwards;
            opacity: 0;
        }

        /* Responsive adjustments */
        @media (max-width: 991px) {
            .product-image-container {
                height: 400px;
                margin-bottom: 30px;
            }
        }

        @media (max-width: 768px) {
            .product-container {
                padding: 20px;
            }

            .product-image-container {
                height: 350px;
            }

            .action-buttons {
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .product-title {
                font-size: 1.6rem;
            }

            .product-image-container {
                height: 300px;
            }

            .size-container {
                justify-content: space-between;
            }

            .size-btn {
                padding: 10px 16px;
                min-width: 50px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="container product-container fade-in">
    <div class="row">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-lg-5 mb-4 mb-lg-0">
            <div class="product-image-container">
                <img src="${productDetails[0].imageURL}" alt="${productDetails[0].productName}" class="product-image">
            </div>
        </div>

        <!-- Thông tin sản phẩm -->
        <div class="col-lg-7 fade-in-delay-1">
            <h1 class="product-title">${productDetails[0].productName}</h1>
            <p class="product-description">${productDetails[0].description}</p>

            <div class="product-divider"></div>

            <h2 class="product-price"><span id="productPrice">${productDetails[0].originalPrice} ${productDetails[0].discountPrice}</span> VND</h2>
            <div class="stock-info">
                <span class="stock-indicator"></span>
                <span id="stockCount">Còn lại: ${productDetails[0].stock} sản phẩm</span>
            </div>

            <!-- Form thêm vào giỏ hàng -->
            <form action="carts" method="get" class="fade-in-delay-2">
                <input type="hidden" id="productId" name="productId" value="${productDetails[0].productId}">
                <input type="hidden" id="size" name="size" value="">

                <!-- Chọn kích thước -->
                <div class="mb-4">
                    <label class="option-label">Chọn kích thước:</label>
                    <div class="size-container" id="sizeOptions">
                        <c:forEach var="entry" items="${productDetails}">
                            <button type="button" class="size-btn" data-size="${entry.size}" data-price="${entry.originalPrice}"
                                    data-discount="${entry.discountPrice}"
                                    data-stock="${entry.stock}" data-productid="${entry.productId}">
                                    ${entry.size}
                            </button>
                        </c:forEach>
                    </div>
                </div>

                <!-- Chọn số lượng -->
                <div class="mb-4">
                    <label class="option-label">Số lượng:</label>
                    <div class="quantity-controls">
                        <button type="button" id="decreaseQty" class="quantity-btn">-</button>
                        <input type="number" id="quantity" name="quantity" value="1" min="1"
                               max="${productDetails[0].stock}" class="quantity-input">
                        <button type="button" id="increaseQty" class="quantity-btn">+</button>
                    </div>
                </div>

                <!-- Nút thêm vào giỏ -->
                <div class="action-buttons">
                    <button type="button" id="addToCartBtn" class="btn-add-to-cart">
                        <i class="fas fa-shopping-cart"></i>
                        THÊM VÀO GIỎ
                    </button>
                    <button type="submit" name="action" value="buyNow" class="btn-buy-now">
                        <i class="fas fa-bolt"></i>
                        MUA NGAY
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        let selectedSize = "";

        // Chọn kích thước và cập nhật giá + số lượng
        $(".size-btn").click(function () {
            $(".size-btn").removeClass("active");
            $(this).addClass("active");

            let originalPrice = $(this).data("price");
            let discountPrice = $(this).data("discount");
            let stock = $(this).data("stock");
            selectedSize = $(this).data("size");

            $("#productPrice").text(originalPrice +"  " + discountPrice);
            $("#stockCount").text("Còn lại: " + stock + " sản phẩm");
            $("#quantity").attr("max", stock);
            $("#size").val(selectedSize);

            // Reset quantity to 1 when changing size
            $("#quantity").val(1);

            // Update stock indicator color
            if (stock > 10) {
                $(".stock-indicator").css("background-color", "#28a745"); // Green
            } else if (stock > 5) {
                $(".stock-indicator").css("background-color", "#ffc107"); // Yellow
            } else {
                $(".stock-indicator").css("background-color", "#dc3545"); // Red
            }
        });

        // Nút tăng giảm số lượng
        $("#increaseQty").click(function () {
            let maxQty = parseInt($("#quantity").attr("max"));
            let currentQty = parseInt($("#quantity").val());
            if (currentQty < maxQty) $("#quantity").val(currentQty + 1);
        });

        $("#decreaseQty").click(function () {
            let currentQty = parseInt($("#quantity").val());
            if (currentQty > 1) $("#quantity").val(currentQty - 1);
        });

        // Validate quantity input
        $("#quantity").on('input', function() {
            let maxQty = parseInt($(this).attr("max"));
            let currentQty = parseInt($(this).val());

            if (isNaN(currentQty) || currentQty < 1) {
                $(this).val(1);
            } else if (currentQty > maxQty) {
                $(this).val(maxQty);
            }
        });

        // Kiểm tra trước khi submit form
        $("#addToCartBtn").click(function (event) {
            event.preventDefault();

            if ($("#size").val() === "") {
                alert("Vui lòng chọn kích thước!");
                return;
            }

            let productId = $("#productId").val();
            let size = $("#size").val();
            let quantity = $("#quantity").val();

            $.ajax({
                type: "POST",
                url: "carts",
                data: {
                    action: "addToCart",
                    productId: productId,
                    size: size,
                    quantity: quantity
                },
                success: function (response) {
                    let newCartCount = response.cartCount || 0;
                    $("#cartCount").text(newCartCount);

                    // Show success toast instead of alert
                    const successToast = `
                        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
                            <div class="toast show" role="alert" aria-live="assertive" aria-atomic="true">
                                <div class="toast-header bg-success text-white">
                                    <strong class="me-auto"><i class="fas fa-check-circle"></i> Thành công</strong>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                                </div>
                                <div class="toast-body">
                                    Đã thêm sản phẩm vào giỏ hàng thành công!
                                </div>
                            </div>
                        </div>
                    `;

                    $('body').append(successToast);
                    setTimeout(() => {
                        $('.toast').toast('hide');
                        setTimeout(() => {
                            $('.toast').parent().remove();
                        }, 500);
                    }, 3000);
                },
                error: function () {
                    alert("Có lỗi xảy ra, vui lòng thử lại");
                }
            });
        });

        // Highlight the first size by default
        if ($(".size-btn").length > 0) {
            $(".size-btn:first").click();
        }
    });
</script>

<jsp:include page="/templates/footer.jsp"/>
</body>
</html>
