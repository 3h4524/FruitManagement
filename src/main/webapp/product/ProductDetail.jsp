<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .size-btn { margin: 5px; padding: 10px 15px; border: 1px solid #ddd; cursor: pointer; border-radius: 5px; }
        .size-btn.active { background-color: #6f42c1; color: white; }
        .product-image { max-height: 400px; object-fit: contain; }
        .size-container { display: flex; flex-wrap: wrap; justify-content: center; gap: 10px; }
        .quantity-controls { display: flex; align-items: center; justify-content: center; }
        .btn-light { border: 1px solid #ccc; }
        .cart-icon { position: relative; cursor: pointer; }
        .cart-count {
            position: absolute;
            top: -5px; right: -5px;
            background-color: purple;
            color: white;
            border-radius: 50%;
            width: 20px; height: 20px;
            text-align: center;
            font-size: 14px;
            line-height: 20px;
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <!-- Biểu tượng giỏ hàng -->
    <div class="text-end">
        <a href="${pageContext.request.contextPath}/cart/Cart.jsp" class="cart-icon">
            🛍 <span id="cartCount" class="cart-count">${sessionScope.cartCount}</span>
        </a>
    </div>

    <div class="row mt-3">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-md-5 text-center">
            <img src="${productDetails[0].imageURL}" alt="Sản phẩm" class="img-fluid product-image">
        </div>

        <!-- Thông tin sản phẩm -->
        <div class="col-md-7">
            <h3>${productDetails[0].productName}</h3>
            <p>${productDetails[0].description}</p>

            <h4 class="text-danger">Giá: <span id="productPrice">${productDetails[0].price} VND</span></h4>
            <p class="text-secondary" id="stockCount">Còn lại: ${productDetails[0].stock}</p>

            <!-- Form thêm vào giỏ hàng -->
            <form action="carts" method="post">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" id="productId" name="productId" value="${productDetails[0].productId}">
                <input type="hidden" id="size" name="size" value="">

                <!-- Chọn kích thước -->
                <div class="mb-3">
                    <label class="fw-bold">Chọn kích thước:</label>
                    <div class="size-container" id="sizeOptions">
                        <c:forEach var="entry" items="${productDetails}">
                            <button type="button" class="size-btn" data-size="${entry.size}" data-price="${entry.price}" data-stock="${entry.stock}" data-productid="${entry.productId}">
                                    ${entry.size}
                            </button>
                        </c:forEach>
                    </div>
                </div>

                <!-- Chọn số lượng -->
                <div class="quantity-controls mb-3">
                    <label class="fw-bold me-2">Số lượng:</label>
                    <button type="button" id="decreaseQty" class="btn btn-light">-</button>
                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="${productDetails[0].stock}" class="form-control text-center mx-2" style="width: 60px;">
                    <button type="button" id="increaseQty" class="btn btn-light">+</button>
                </div>

                <!-- Nút thêm vào giỏ -->
                <div class="text-center">
                    <button type="submit" id="addToCartBtn" class="btn btn-outline-primary px-4 me-2">THÊM VÀO GIỎ</button>
                    <button type="submit" name="action" value="buyNow" class="btn btn-danger px-4">MUA NGAY</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        let selectedSize = "";

        // Chọn kích thước và cập nhật giá + số lượng
        $(".size-btn").click(function() {
            $(".size-btn").removeClass("active");
            $(this).addClass("active");

            let price = $(this).data("price");
            let stock = $(this).data("stock");
            selectedSize = $(this).data("size");

            $("#productPrice").text(price + " VND");
            $("#stockCount").text("Còn lại: " + stock);
            $("#quantity").attr("max", stock);
            $("#size").val(selectedSize);
        });

        // Nút tăng giảm số lượng
        $("#increaseQty").click(function() {
            let maxQty = parseInt($("#quantity").attr("max"));
            let currentQty = parseInt($("#quantity").val());
            if (currentQty < maxQty) $("#quantity").val(currentQty + 1);
        });
        $("#decreaseQty").click(function() {
            let currentQty = parseInt($("#quantity").val());
            if (currentQty > 1) $("#quantity").val(currentQty - 1);
        });

        // Kiểm tra trước khi submit form
        $("#addToCartBtn").click(function(event) {
            if ($("#size").val() === "") {
                alert("Vui lòng chọn kích thước!");
                event.preventDefault();
            }
        });
    });
</script>

</body>
</html>
