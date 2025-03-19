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
        .btn-orange {
            background-color: #FFA520; /* Orange */
            border-color: #FFA520;
            color: #FFFFFF; /* White text */
        }
        .btn-orange:hover {
            background-color: #e59400; /* Darker orange on hover */
            border-color: #e59400;
            color: #FFFFFF;
        }
        .btn-outline-orange {
            border-color: #FFA520;
            color: #FFA520;
        }
        .btn-outline-orange:hover {
            background-color: #FFA520;
            color: #FFFFFF;
        }
        .size-btn {
            padding: 8px 12px;
            border: 1px solid #FFA520; /* Orange border */
            border-radius: 5px;
            background-color: #FFFFFF; /* White background */
            color: #FFA520; /* Orange text */
        }
        .size-btn.active {
            background-color: #FFA520; /* Orange when active */
            color: #FFFFFF; /* White text */
        }
        .product-image {
            max-height: 400px;
            object-fit: contain;
        }
        .text-orange {
            color: #FFA520; /* Orange text */
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-4 py-5 min-vh-100"> <!-- Increased height with min-vh-100 and padding -->
    <div class="row mt-3">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-md-5 text-center">
            <img src="${productDetails[0].imageURL}" alt="Sản phẩm" class="img-fluid product-image">
        </div>

        <!-- Thông tin sản phẩm -->
        <div class="col-md-7 d-flex flex-column justify-content-center">
            <h3 class="text-orange">${productDetails[0].productName}</h3>
            <p>${productDetails[0].description}</p>

            <h4 class="text-danger">Giá: <span id="productPrice">${productDetails[0].price} VND</span></h4>
            <p class="text-muted" id="stockCount">Còn lại: ${productDetails[0].stock}</p>

            <!-- Form thêm vào giỏ hàng -->
            <form action="carts" method="post">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" id="productId" name="productId" value="${productDetails[0].productId}">
                <input type="hidden" id="size" name="size" value="">

                <!-- Chọn kích thước -->
                <div class="mb-4 text-center">
                    <label class="fw-bold text-orange mb-2">Chọn kích thước:</label>
                    <div class="d-flex flex-wrap justify-content-center gap-2" id="sizeOptions">
                        <c:forEach var="entry" items="${productDetails}">
                            <button type="button" class="size-btn btn btn-sm" data-size="${entry.size}"
                                    data-price="${entry.price}" data-stock="${entry.stock}"
                                    data-productid="${entry.productId}">
                                    ${entry.size}
                            </button>
                        </c:forEach>
                    </div>
                </div>

                <!-- Chọn số lượng -->
                <div class="mb-4 d-flex justify-content-center align-items-center">
                    <label class="fw-bold me-3 text-orange">Số lượng:</label>
                    <div class="input-group" style="width: 150px;">
                        <button type="button" id="decreaseQty" class="btn btn-outline-orange">-</button>
                        <input type="number" id="quantity" name="quantity" value="1" min="1"
                               max="${productDetails[0].stock}" class="form-control text-center">
                        <button type="button" id="increaseQty" class="btn btn-outline-orange">+</button>
                    </div>
                </div>

                <!-- Nút thêm vào giỏ và mua ngay -->
                <div class="d-flex justify-content-center gap-3">
                    <button type="button" id="addToCartBtn" class="btn btn-outline-orange px-4">THÊM VÀO GIỎ</button>
                    <button type="submit" name="action" value="buyNow" class="btn btn-orange px-4">MUA NGAY</button>
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

            let price = $(this).data("price");
            let stock = $(this).data("stock");
            selectedSize = $(this).data("size");

            $("#productPrice").text(price + " VND");
            $("#stockCount").text("Còn lại: " + stock);
            $("#quantity").attr("max", stock);
            $("#size").val(selectedSize);
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

        // Kiểm tra trước khi submit form
        $("#addToCartBtn").click(function (event) {
            event.preventDefault();
            let productId = $("#productId").val();
            let size = $("#size").val();
            let quantity = $("#quantity").val();

            if (size === "") {
                alert("Vui lòng chọn kích thước!");
                return;
            }

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
                    alert("Đã thêm giỏ hàng thành công");
                },
                error: function () {
                    alert("Có lỗi xảy ra, vui lòng thử lại");
                }
            });
        });
    });
</script>
<jsp:include page="/templates/footer.jsp"/>

</body>
</html>