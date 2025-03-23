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

            .select-all-container {
                margin: 10px 0;
                display: flex;
                align-items: center;
            }

            .select-all-container input {
                margin-right: 10px;
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
                <div class="select-all-container">
                    <input type="checkbox" id="select-all" onchange="toggleSelectAll()">
                    <label for="select-all">Chọn tất cả</label>
                </div>

                <div id="cart-items-container">
                    <c:forEach var="entry" items="${cart.items}">
                        <c:set var="cartItem" value="${entry.value}"/>
                        <c:set var="productVariant" value="${cartItem.productVariant}"/>
                        <c:set var="product" value="${productVariant.productID}"/>

                        <div class="cart-item" id="item-${productVariant.id}">
                            <input type="checkbox" class="select-item" data-id="${productVariant.id}" data-price="${productVariant.price}" data-quantity="${cartItem.quantity}" onchange="updateTotalPrice()">
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

                            <p>
                                <span id="subtotal-${productVariant.id}">${cartItem.quantity} x ${productVariant.price} VND = ${cartItem.quantity * productVariant.price} VND</span>
                            </p>

                            <button type="button" onclick="deleteCartItem(${productVariant.id})" class="remove-btn">🗑 Xóa</button>
                        </div>
                    </c:forEach>
                </div>

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

    <script>
        let timeoutMap = {}; // Store timeout for each product to prevent multiple AJAX calls

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
            $.ajax({
                url: "${pageContext.request.contextPath}/carts",
                type: "POST",
                data: {
                    action: "delete",
                    productVariantId: productVariantId
                },
                success: function(response) {
                    // Remove item from DOM
                    $("#item-" + productVariantId).remove();

                    // Update cart count
                    let newCartCount = response.cartCount || 0;
                    $("#cartCount").text(newCartCount);

                    // Recalculate total price
                    updateTotalPrice();

                    // Check if cart is empty
                    if ($('.cart-item').length === 0) {
                        $('.cart-container').html('<h2>🛒 Giỏ Hàng Của Bạn</h2>' +
                            '<a href="${pageContext.request.contextPath}/products?action=find" class="btn btn-outline-dark">← Quay lại cửa hàng</a>' +
                            '<p class="text-danger">🛑 Giỏ hàng trống!</p>');
                    }
                },
                error: function() {
                    alert("Lỗi không thể xóa sản phẩm!");
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