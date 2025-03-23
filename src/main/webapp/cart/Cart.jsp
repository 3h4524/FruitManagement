<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>

    <style>
        /* General body styling */
        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Cart container styling */
        .cart-container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border-radius: 16px;
            animation: slideIn 0.5s ease forwards;
        }

        /* Headings */
        .cart-header {
            color: #2e8b57;
            font-weight: 700;
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 15px;
            text-align: center;
            font-size: 2.2rem;
        }

        .cart-header::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #2e8b57, #5BBD8C);
            border-radius: 2px;
        }

        .section-title {
            color: #2e8b57;
            font-weight: 600;
            margin: 1.5rem 0 1rem;
            font-size: 1.5rem;
        }

        /* Cart items */
        .cart-items-wrapper {
            margin: 30px 0;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            margin-bottom: 8px;
            border-bottom: 1px solid #e0e0e0;
            background-color: #fff;
            transition: all 0.3s ease;
            position: relative;
        }

        .cart-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .cart-item:hover {
            background-color: #f9fafb;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.05);
        }

        .product-info {
            flex: 2;
            padding-left: 15px;
        }

        .product-name {
            font-weight: 600;
            color: #333;
            margin: 0;
            font-size: 1.1rem;
        }

        .product-variant {
            color: #666;
            font-size: 0.9rem;
            margin-top: 4px;
        }

        /* Quantity controls */
        .quantity-control {
            display: flex;
            align-items: center;
            flex: 1;
            justify-content: center;
        }

        .quantity-btn {
            width: 36px;
            height: 36px;
            background-color: #f1f8f3;
            border: 1px solid #cbe3d7;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            color: #2e8b57;
        }

        .quantity-btn:hover {
            background-color: #2e8b57;
            color: white;
            border-color: #2e8b57;
        }

        .quantity-input {
            width: 60px;
            height: 36px;
            text-align: center;
            border: 1px solid #cbe3d7;
            border-radius: 8px;
            font-weight: 600;
            color: #2e8b57;
            margin: 0 10px;
        }

        /* Price and subtotal */
        .price-info {
            flex: 1;
            text-align: right;
            padding-right: 15px;
        }

        .price {
            font-weight: 600;
            color: #2e8b57;
            font-size: 1.1rem;
            margin-bottom: 4px;
        }

        .subtotal {
            font-size: 0.9rem;
            color: #666;
        }

        /* Remove button */
        .remove-btn {
            background-color: #fff;
            color: #dc3545;
            border: 1px solid #f8d7da;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .remove-btn:hover {
            background-color: #dc3545;
            color: white;
            border-color: #dc3545;
        }

        /* Total price */
        .total-price-container {
            padding: 20px 25px;
            border-radius: 12px;
            background: linear-gradient(145deg, #f1f8f3, #e7f4eb);
            margin: 2rem 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 6px 15px rgba(46, 139, 87, 0.1);
        }

        .total-price-label {
            font-size: 1.2rem;
            color: #333;
            font-weight: 600;
        }

        .total-price-value {
            font-weight: 700;
            color: #2e8b57;
            font-size: 1.8rem;
        }

        /* Checkout button */
        .btn-checkout {
            display: block;
            margin: 2rem auto;
            width: 250px;
            background: linear-gradient(135deg, #3c9d74, #2e8b57);
            color: white;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 700;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: 0 6px 15px rgba(46, 139, 87, 0.2);
        }

        .btn-checkout:hover {
            background: linear-gradient(135deg, #2e8b57, #267349);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(46, 139, 87, 0.3);
        }

        .btn-checkout:disabled {
            background: linear-gradient(135deg, #a6a6a6, #858585);
            color: #eeeeee;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        /* Select all container */
        .select-all-container {
            margin: 15px 0;
            padding: 15px;
            background-color: #f1f8f3;
            border-radius: 12px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.03);
        }

        .select-all-container input {
            margin-right: 10px;
            width: 20px;
            height: 20px;
            accent-color: #2e8b57;
        }

        .select-all-container label {
            font-weight: 600;
            color: #2e8b57;
            margin-bottom: 0;
        }

        /* Payment options */
        .payment-options {
            margin: 1.5rem 0;
            padding: 20px;
            background-color: #f1f8f3;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.03);
        }

        .payment-method-title {
            color: #2e8b57;
            font-weight: 600;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }

        .payment-method {
            margin: 15px 0;
            padding: 15px;
            border-radius: 8px;
            background-color: white;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.03);
        }

        .payment-method:hover {
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.07);
            transform: translateY(-2px);
        }

        .payment-method-radio {
            width: 20px;
            height: 20px;
            accent-color: #2e8b57;
        }

        .payment-method-label {
            font-weight: 500;
            color: #444;
            margin-bottom: 0;
            flex: 1;
        }

        .payment-icon {
            font-size: 1.5rem;
            color: #2e8b57;
            margin-right: 5px;
        }

        /* Back to store button */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.2s ease;
            margin-bottom: 20px;
            border: 2px solid #e0e0e0;
            color: #444;
            background-color: white;
        }

        .btn-back:hover {
            background-color: #f1f8f3;
            border-color: #2e8b57;
            color: #2e8b57;
        }

        /* Empty cart message */
        .empty-cart {
            text-align: center;
            padding: 50px 20px;
            background-color: #f9fafb;
            border-radius: 12px;
            margin: 30px 0;
        }

        .empty-cart-icon {
            font-size: 4rem;
            color: #a6a6a6;
            margin-bottom: 20px;
        }

        .empty-cart-message {
            font-size: 1.4rem;
            font-weight: 600;
            color: #666;
            margin-bottom: 30px;
        }

        .btn-shop-now {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #3c9d74, #2e8b57);
            color: white;
            border: none;
            box-shadow: 0 6px 15px rgba(46, 139, 87, 0.2);
        }

        .btn-shop-now:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(46, 139, 87, 0.3);
        }

        /* Checkbox styling */
        .select-item {
            width: 20px;
            height: 20px;
            accent-color: #2e8b57;
            cursor: pointer;
        }

        /* Animations */
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Individual item animation */
        .cart-item {
            animation: fadeIn 0.5s ease forwards;
            animation-delay: calc(var(--animation-order) * 0.1s);
            opacity: 0;
        }

        /* Adding animation delay for each item */
        #cart-items-container > div:nth-child(1) { --animation-order: 1; }
        #cart-items-container > div:nth-child(2) { --animation-order: 2; }
        #cart-items-container > div:nth-child(3) { --animation-order: 3; }
        #cart-items-container > div:nth-child(4) { --animation-order: 4; }
        #cart-items-container > div:nth-child(5) { --animation-order: 5; }
        #cart-items-container > div:nth-child(6) { --animation-order: 6; }
        #cart-items-container > div:nth-child(7) { --animation-order: 7; }
        #cart-items-container > div:nth-child(8) { --animation-order: 8; }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .cart-container {
                width: 95%;
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .cart-item {
                flex-wrap: wrap;
                padding: 15px;
            }

            .product-info {
                flex: 100%;
                order: 1;
                padding-left: 0;
                margin-bottom: 15px;
            }

            .quantity-control {
                flex: 1;
                order: 2;
                justify-content: flex-start;
            }

            .price-info {
                flex: 1;
                order: 3;
                text-align: right;
                padding-right: 0;
            }

            .action-buttons {
                flex: 100%;
                order: 4;
                margin-top: 15px;
                display: flex;
                justify-content: flex-end;
            }
        }

        @media (max-width: 576px) {
            .cart-header {
                font-size: 1.8rem;
            }

            .total-price-value {
                font-size: 1.5rem;
            }

            .btn-checkout {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="cart-container">
    <h2 class="cart-header"><i class="fas fa-shopping-cart"></i> Giỏ Hàng Của Bạn</h2>
    <a href="${pageContext.request.contextPath}/products?action=find" class="btn btn-back">
        <i class="fas fa-arrow-left"></i> Quay lại cửa hàng
    </a>

    <c:set var="cart" value="${sessionScope.cart}"/>
    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="empty-cart">
                <div class="empty-cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="empty-cart-message">Giỏ hàng của bạn đang trống</div>
                <a href="${pageContext.request.contextPath}/products?action=find" class="btn-shop-now">
                    <i class="fas fa-store"></i> Bắt đầu mua sắm
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="select-all-container">
                <input type="checkbox" id="select-all" onchange="toggleSelectAll()">
                <label for="select-all">Chọn tất cả sản phẩm</label>
            </div>

            <div class="cart-items-wrapper">
                <div id="cart-items-container">
                    <c:forEach var="entry" items="${cart.items}">
                        <c:set var="cartItem" value="${entry.value}"/>
                        <c:set var="productVariant" value="${cartItem.productVariant}"/>
                        <c:set var="product" value="${productVariant.productID}"/>

                        <div class="cart-item" id="item-${productVariant.id}">
                            <input type="checkbox" class="select-item" data-id="${productVariant.id}" data-price="${productVariant.price}" data-quantity="${cartItem.quantity}" onchange="updateTotalPrice()">

                            <div class="product-info">
                                <div class="product-name">${product.name}</div>
                                <div class="product-variant">Kích cỡ: ${productVariant.size}</div>
                            </div>

                            <div class="quantity-control">
                                <button type="button"
                                        onclick="changeQuantity(-1, ${productVariant.id}, ${productVariant.price})"
                                        class="quantity-btn">
                                    <i class="fas fa-minus"></i>
                                </button>
                                <input type="number" id="quantity-${productVariant.id}" class="quantity-input"
                                       name="quantity" value="${cartItem.quantity}" min="1"
                                       oninput="validateQuantity(${productVariant.id}, ${productVariant.price})">
                                <button type="button"
                                        onclick="changeQuantity(1, ${productVariant.id}, ${productVariant.price})"
                                        class="quantity-btn">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>

                            <div class="price-info">
                                <div class="price">${productVariant.price} VND</div>
                                <div class="subtotal" id="subtotal-${productVariant.id}">
                                    Tổng: ${cartItem.quantity * productVariant.price} VND
                                </div>
                            </div>

                            <div class="action-buttons">
                                <button type="button" onclick="deleteCartItem(${productVariant.id})" class="remove-btn">
                                    <i class="fas fa-trash-alt"></i> Xóa
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

<<<<<<< HEAD
                <h3 class="total-price">💰 Tổng tiền: 0 VND</h3>
                <form action="${pageContext.request.contextPath}/checkout" method="post" onsubmit="return prepareCheckout()">
                    <input type="hidden" name="selectedItems" id="selectedItems" value="">
                    <div class="payment-options" style="margin: 20px 0;">
                        <h4>Phương thức thanh toán:</h4>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                            <label class="form-check-label" for="cod">
                                💵 Thanh toán khi nhận hàng (COD)
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="vnpay">
                            <label class="form-check-label" for="vnpay">
                                💳 Thanh toán qua VNPay
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn-checkout" id="checkout-button" disabled>✅ Thanh Toán</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
=======
            <div class="total-price-container">
                <div class="total-price-label">Tổng tiền:</div>
                <div class="total-price-value">0 VND</div>
            </div>
>>>>>>> cd5bb39673201e297a5c5d5f43927b0e0fdb0f13

            <form action="${pageContext.request.contextPath}/checkout" method="post" onsubmit="return prepareCheckout()">
                <input type="hidden" name="selectedItems" id="selectedItems" value="">

                <div class="payment-options">
                    <div class="payment-method-title">Phương thức thanh toán</div>

                    <div class="payment-method">
                        <input class="payment-method-radio" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                        <label class="payment-method-label" for="cod">
                            <i class="fas fa-money-bill-wave payment-icon"></i> Thanh toán khi nhận hàng (COD)
                        </label>
                    </div>

                    <div class="payment-method">
                        <input class="payment-method-radio" type="radio" name="paymentMethod" id="vnpay" value="vnpay">
                        <label class="payment-method-label" for="vnpay">
                            <i class="fas fa-credit-card payment-icon"></i> Thanh toán qua VNPay
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn-checkout" id="checkout-button" disabled>
                    <i class="fas fa-check-circle"></i> Tiến hành thanh toán
                </button>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<script>
    let timeoutMap = {}; // Store timeout for each product to prevent multiple AJAX calls

    // Function to change quantity of a product
    function changeQuantity(amount, productVariantId, price) {
        let quantityInput = document.getElementById("quantity-" + productVariantId);

        let currentQuantity = parseInt(quantityInput.value) || 1;
        let newQuantity = Math.max(1, currentQuantity + amount); // Ensure quantity doesn't go below 1
        quantityInput.value = newQuantity;

        if (timeoutMap[productVariantId]) clearTimeout(timeoutMap[productVariantId]);

<<<<<<< HEAD
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
                        // Update the quantity data attribute
                        $(".select-item[data-id='" + productVariantId + "']").data('quantity', newQuantity);

                        // Update the subtotal
                        let subtotal = newQuantity * price;
                        $("#subtotal-" + productVariantId).text(newQuantity + ' x ' + price + ' VND = ' + subtotal + ' VND');

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

        // Function to calculate and update the total price of selected items
        function updateTotalPrice() {
            let total = 0;
            let selectedCount = 0;

            // Loop through each selected cart item and add its subtotal to the total
            $('.select-item:checked').each(function () {
                let price = parseInt($(this).data('price'));
                let quantity = parseInt($(this).data('quantity'));
                total += price * quantity;
                selectedCount++;
            });

            // Update the displayed total price
            $('.total-price').text('💰 Tổng tiền: ' + total + ' VND');

            // Enable/disable checkout button based on selections
            if (selectedCount > 0) {
                $('#checkout-button').prop('disabled', false);
            } else {
                $('#checkout-button').prop('disabled', true);
            }

            // Update select all checkbox
            updateSelectAllCheckbox();
        }

        function prepareCheckout() {
            let selectedItems = [];
            $('.select-item:checked').each(function() {
                selectedItems.push($(this).data('id'));
            });

            if (selectedItems.length === 0) {
                alert("Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
                return false;
            }

            let paymentMethod = $('input[name="paymentMethod"]:checked').val();

            // Prepare the data to send
            let data = {
                selectedItems: selectedItems,
                paymentMethod: paymentMethod
            };

            // Send the AJAX request
            $.ajax({
                url: "${pageContext.request.contextPath}/checkout",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function(response) {
                    if (response.error) {
                        alert(response.error);
                    } else if (response.paymentUrl) {
                        window.location.href = response.paymentUrl;
                    } else {

<<<<<<< HEAD
                        // Redirect to success page
                        window.location.href = response.redirectURL;
=======
                        window.location.href = response.redirectURL + "?orderId=" + response.orderId + "&totalPrice=" + response.totalPrice;
>>>>>>> c836193 (add order management)
                    }
                },
                error: function(xhr, status, error) {
                    alert("Lỗi khi xử lý thanh toán: " + error);
                }
            });

            return false;
        }


        function deleteCartItem(productVariantId) {
=======
        timeoutMap[productVariantId] = setTimeout(function () {
            // Send AJAX request to update the cart
>>>>>>> cd5bb39673201e297a5c5d5f43927b0e0fdb0f13
            $.ajax({
                url: "${pageContext.request.contextPath}/carts",
                type: "POST",
                data: {
                    action: "update",
                    quantity: newQuantity,
                    productVariantId: productVariantId
                },
                success: function (response) {
                    // Update the quantity data attribute
                    $(".select-item[data-id='" + productVariantId + "']").data('quantity', newQuantity);

                    // Update the subtotal
                    let subtotal = newQuantity * price;
                    $("#subtotal-" + productVariantId).text("Tổng: " + subtotal + " VND");

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
                    // Update the quantity data attribute
                    $(".select-item[data-id='" + productVariantId + "']").data('quantity', newQuantity);

                    // Update the subtotal
                    let subtotal = newQuantity * price;
                    $("#subtotal-" + productVariantId).text("Tổng: " + subtotal + " VND");

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

    // Function to calculate and update the total price of selected items
    function updateTotalPrice() {
        let total = 0;
        let selectedCount = 0;

        // Loop through each selected cart item and add its subtotal to the total
        $('.select-item:checked').each(function () {
            let price = parseInt($(this).data('price'));
            let quantity = parseInt($(this).data('quantity'));
            total += price * quantity;
            selectedCount++;
        });

        // Format total with thousand separators
        let formattedTotal = total.toLocaleString('vi-VN');

        // Update the displayed total price
        $('.total-price-value').text(formattedTotal + ' VND');

        // Enable/disable checkout button based on selections
        if (selectedCount > 0) {
            $('#checkout-button').prop('disabled', false);
        } else {
            $('#checkout-button').prop('disabled', true);
        }

        // Update select all checkbox
        updateSelectAllCheckbox();
    }

    function prepareCheckout() {
        let selectedItems = [];
        $('.select-item:checked').each(function() {
            selectedItems.push($(this).data('id'));
        });

        if (selectedItems.length === 0) {
            alert("Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
            return false;
        }

        let paymentMethod = $('input[name="paymentMethod"]:checked').val();

        // Prepare the data to send
        let data = {
            selectedItems: selectedItems,
            paymentMethod: paymentMethod
        };

        // Send the AJAX request
        $.ajax({
            url: "${pageContext.request.contextPath}/checkout",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            beforeSend: function() {
                // Disable button and show loading state
                $('#checkout-button').prop('disabled', true);
                $('#checkout-button').html('<i class="fas fa-spinner fa-spin"></i> Đang xử lý...');
            },
            success: function(response) {
                if (response.error) {
                    alert(response.error);
                    // Reset button state
                    $('#checkout-button').prop('disabled', false);
                    $('#checkout-button').html('<i class="fas fa-check-circle"></i> Tiến hành thanh toán');
                } else if (response.paymentUrl) {
                    window.location.href = response.paymentUrl;
                } else {
                    window.location.href = response.redirectURL + "?orderId=" + response.orderId + "&totalPrice=" + response.totalPrice;
                }
            },
            error: function(xhr, status, error) {
                alert("Lỗi khi xử lý thanh toán: " + error);
                // Reset button state
                $('#checkout-button').prop('disabled', false);
                $('#checkout-button').html('<i class="fas fa-check-circle"></i> Tiến hành thanh toán');
            }
        });

        return false;
    }

    function deleteCartItem(productVariantId) {
        // Show confirmation dialog
        if (!confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?")) {
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/carts",
            type: "POST",
            data: {
                action: "delete",
                productVariantId: productVariantId
            },
            beforeSend: function() {
                // Add visual feedback for delete operation
                $("#item-" + productVariantId).css('opacity', '0.5');
            },
            success: function(response) {
                // Remove item with animation
                $("#item-" + productVariantId).slideUp(300, function() {
                    $(this).remove();

                    // Update cart count
                    let newCartCount = response.cartCount || 0;
                    $("#cartCount").text(newCartCount);

                    // Recalculate total price
                    updateTotalPrice();

                    // Check if cart is empty
                    if ($('.cart-item').length === 0) {
                        $('.cart-container').html(`
                            <h2 class="cart-header"><i class="fas fa-shopping-cart"></i> Giỏ Hàng Của Bạn</h2>
                            <a href="${pageContext.request.contextPath}/products?action=find" class="btn btn-back">
                                <i class="fas fa-arrow-left"></i> Quay lại cửa hàng
                            </a>
                            <div class="empty-cart">
                                <div class="empty-cart-icon">
                                    <i class="fas fa-shopping-cart"></i>
                                </div>
                                <div class="empty-cart-message">Giỏ hàng của bạn đang trống</div>
                                <a href="${pageContext.request.contextPath}/products?action=find" class="btn-shop-now">
                                    <i class="fas fa-store"></i> Bắt đầu mua sắm
                                </a>
                            </div>
                        `);
                    }
                });
            },
            error: function() {
                alert("Lỗi không thể xóa sản phẩm!");
                // Restore opacity if delete fails
                $("#item-" + productVariantId).css('opacity', '1');
            }
        });
    }

    // Toggle all items selection
    function toggleSelectAll() {
        let isChecked = $('#select-all').prop('checked');
        $('.select-item').prop('checked', isChecked);
        updateTotalPrice();
    }

    // Update select all checkbox state based on individual selections
    function updateSelectAllCheckbox() {
        let totalItems = $('.select-item').length;
        let selectedItems = $('.select-item:checked').length;

        if (selectedItems === 0) {
            $('#select-all').prop('checked', false);
            $('#select-all').prop('indeterminate', false);
        } else if (selectedItems === totalItems) {
            $('#select-all').prop('checked', true);
            $('#select-all').prop('indeterminate', false);
        } else {
            $('#select-all').prop('indeterminate', true);
        }
    }
        // Initialize total price on page load
        $(document).ready(function() {
            updateTotalPrice();
        });
    </script>
    <jsp:include page="/templates/footer.jsp"/>

    </body>
    </html>