<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Giỏ Hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa; /* Màu nền sáng */
            font-family: Arial, sans-serif;
        }

        .cart-container {
            width: 80%;
            margin: auto;
            padding: 2%;
            background: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 2%;
            border-bottom: 1px solid #ddd;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 5%;
        }

        .quantity-control button {
            width: 10%;
            height: 30%;
            background-color: #eee;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        .quantity-control input {
            width: 15%;
            text-align: center;
            border: 1px solid #ccc;
        }

        .remove-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 1% 3%;
            cursor: pointer;
        }

        .total-price {
            font-weight: bold;
            color: #000;
            font-size: 120%;
        }

        .btn-checkout {
            display: block;
            margin: auto;
            width: 200px; /* Độ rộng cố định */
            background-color: #ff0000;
            color: white;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            text-align: center;
        }


        .btn-checkout:hover {
            background-color: #cc0000;
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="cart-container">
    <h2>🛒 Giỏ Hàng Của Bạn</h2>
    <a href="${pageContext.request.contextPath}/products?action=find" class="btn btn-outline-dark">← Quay lại cửa
        hàng</a>

    <c:set var="cart" value="${sessionScope.cart}"/>
    <c:choose>
        <c:when test="${empty cart.items}">
            <p class="text-danger">🛑 Giỏ hàng trống!</p>
        </c:when>
        <c:otherwise>
            <c:set var="totalPrice" value="0"/>
            <c:forEach var="entry" items="${cart.items}">
                <c:set var="cartItem" value="${entry.value}"/>
                <c:set var="productVariant" value="${cartItem.productVariant}"/>
                <c:set var="product" value="${productVariant.productID}"/>

                <div class="cart-item">
                    <p>🛒 ${product.name} - ${productVariant.size}</p>

                    <div class="quantity-control">
                        <button type="button"
                                onclick="changeQuantity(-1, ${productVariant.id}, ${productVariant.price})"
                                class="btn btn-light">-
                        </button>
                        <input type="number" id="quantity-${productVariant.id}" name="quantity"
                               value="${cartItem.quantity}" min="1"
                               oninput="validateQuantity(${productVariant.id}, ${productVariant.price})">
                        <button type="button" onclick="changeQuantity(1, ${productVariant.id}, ${productVariant.price})"
                                class="btn btn-light">+
                        </button>
                    </div>


                    <p>${cartItem.quantity} x ${productVariant.price} VND =
                        <c:set var="subtotal" value="${cartItem.quantity * productVariant.price}"/>
                            ${subtotal} VND
                    </p>

                    <form action="${pageContext.request.contextPath}/carts" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="productVariantId" value="${productVariant.id}">
                        <button type="submit" class="remove-btn">🗑 Xóa</button>
                    </form>
                </div>

                <c:set var="totalPrice" value="${totalPrice + subtotal}"/>
            </c:forEach>

            <h3 class="total-price">💰 Tổng tiền: ${totalPrice} VND</h3>
            <form action="<%= request.getContextPath() %>/checkout" method="post">
                <button type="submit" class="btn-checkout">✅ Thanh Toán</button>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<script>let timeoutMap = {}; // Store timeout for each product to prevent multiple AJAX calls

// Function to change quantity of a product
function changeQuantity(amount, productVariantId, price) {
    let quantityInput = document.getElementById("quantity-" + productVariantId);

    let currentQuantity = parseInt(quantityInput.value) || 1;
    let newQuantity = Math.max(1, currentQuantity + amount); // Ensure quantity doesn't go below 1
    quantityInput.value = newQuantity;

    if (timeoutMap[productVariantId]) clearTimeout(timeoutMap[productVariantId]);

    timeoutMap[productVariantId] = setTimeout(function () {
        // Send AJAX request to update the cart
        $.ajax({
            url: "${pageContext.request.contextPath}/carts",
            type: "POST",
            data: {
                action: "update",
                quantity: newQuantity,
                productVariantId: productVariantId
            },
            success: function (response) {
                // On success, update the item's subtotal and total price
                let subtotal = newQuantity * price;

                // Update the subtotal in the cart item
                $(quantityInput).closest('.cart-item').find('p:last-of-type').text(
                    newQuantity + ' x ' + price + ' VND = ' + subtotal + ' VND'
                );
                let newCartCount = response.cartCount || 0;
                $("#cartCount").text(newCartCount);

                // Recalculate total price
                updateTotalPrice();
            },
            error: function () {
                alert("Lỗi không thể cập nhật giỏ hàng!");
            }
        });
    }, 500); // Delay AJAX request by 500ms to prevent rapid calls
}

function validateQuantity(productVariantId, price) {
    let quantityInput = document.getElementById("quantity-" + productVariantId);
    let newQuantity = parseInt(quantityInput.value) || 1;

    // Ensure the quantity is at least 1
    if (newQuantity < 1) {
        quantityInput.value = 1;
        newQuantity = 1;
    }

    if (timeoutMap[productVariantId]) clearTimeout(timeoutMap[productVariantId]);

    timeoutMap[productVariantId] = setTimeout(function () {
        // Send AJAX request to update the cart
        $.ajax({
            url: "${pageContext.request.contextPath}/carts",
            type: "POST",
            data: {
                action: "update",
                quantity: newQuantity,
                productVariantId: productVariantId
            },
            success: function (response) {
                // On success, update the item's subtotal and total price
                let subtotal = newQuantity * price;

                // Update the subtotal in the cart item
                $(quantityInput).closest('.cart-item').find('p:last-of-type').text(
                    newQuantity + ' x ' + price + ' VND = ' + subtotal + ' VND'
                );

                let newCartCount = response.cartCount || 0;
                $("#cartCount").text(newCartCount);
                // Recalculate total price
                updateTotalPrice();
            },
            error: function () {
                alert("Lỗi không thể cập nhật giỏ hàng!");
            }
        });
    }, 500); // Delay AJAX request by 500ms to prevent rapid calls
}

// Function to calculate and update the total price of all items in the cart
function updateTotalPrice() {
    let total = 0;

    // Loop through each cart item and add its subtotal to the total
    $('.cart-item').each(function () {
        let priceText = $(this).find('p:last-of-type').text();
        let price = parseInt(priceText.split('=')[1].trim().split(' ')[0]); // Extract subtotal value
        total += price; // Add subtotal to total
    });

    // Update the displayed total price
    $('.total-price').text('💰 Tổng tiền: ' + total + ' VND');
}
</script>
<jsp:include page="/templates/footer.jsp"/>

</body>
</html>
