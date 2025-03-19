<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Giỏ Hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* Orange-White Theme */
        .bg-orange {
            background-color: #FFA520; /* Orange background */
        }
        .text-orange {
            color: #FFA520; /* Orange text */
        }
        .btn-orange {
            background-color: #FFA520;
            border-color: #FFA520;
            color: #FFFFFF; /* White text */
            transition: background-color 0.3s ease;
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
        .card-header {
            background-color: #FFF3E0; /* Light orange header */
            border-bottom: 2px solid #FFA520;
        }
        .card {
            border: 1px solid #FFA520; /* Orange border */
        }
        .table thead th {
            background-color: #FFF3E0;
            color: #FFA520;
        }
        .table tbody tr:hover {
            background-color: #FFF8E1; /* Light orange hover */
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="container mt-5 py-5 min-vh-100">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow rounded">
                <div class="card-header text-center text-orange">
                    <h2 class="mb-0 text-orange">🛒 Giỏ Hàng Của Bạn</h2>
                </div>
                <div class="card-body p-4">
                    <a href="${pageContext.request.contextPath}/products?action=find"
                       class="btn btn-outline-orange mb-3">← Quay lại cửa hàng</a>

                    <c:set var="cart" value="${sessionScope.cart}"/>
                    <c:choose>
                        <c:when test="${empty cart.items}">
                            <p class="text-center text-danger">🛑 Giỏ hàng trống!</p>
                        </c:when>
                        <c:otherwise>
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Giá</th>
                                    <th>Thành tiền</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="totalPrice" value="0"/>
                                <c:forEach var="entry" items="${cart.items}">
                                    <c:set var="cartItem" value="${entry.value}"/>
                                    <c:set var="productVariant" value="${cartItem.productVariant}"/>
                                    <c:set var="product" value="${productVariant.productID}"/>
                                    <c:set var="subtotal" value="${cartItem.quantity * productVariant.price}"/>
                                    <c:set var="totalPrice" value="${totalPrice + subtotal}"/>

                                    <tr>
                                        <td>${product.name} - ${productVariant.size}</td>
                                        <td>
                                            <div class="input-group" style="width: 120px;">
                                                <button type="button" class="btn btn-outline-orange"
                                                        onclick="changeQuantity(-1, ${productVariant.id}, ${productVariant.price})">-</button>
                                                <input type="number" id="quantity-${productVariant.id}"
                                                       name="quantity" value="${cartItem.quantity}" min="1"
                                                       oninput="validateQuantity(${productVariant.id}, ${productVariant.price})"
                                                       class="form-control text-center">
                                                <button type="button" class="btn btn-outline-orange"
                                                        onclick="changeQuantity(1, ${productVariant.id}, ${productVariant.price})">+</button>
                                            </div>
                                        </td>
                                        <td>${productVariant.price} VND</td>
                                        <td>${subtotal} VND</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/carts" method="post">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="productVariantId" value="${productVariant.id}">
                                                <button type="submit" class="btn btn-danger btn-sm">🗑 Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${not empty cart.items}">
                    <div class="card-footer text-center">
                        <h3 class="total-price text-orange mb-3">💰 Tổng tiền: ${totalPrice} VND</h3>
                        <form action="<%= request.getContextPath() %>/checkout" method="post">
                            <button type="submit" class="btn btn-orange px-5">✅ Thanh Toán</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script>
    let timeoutMap = {}; // Store timeout for each product to prevent multiple AJAX calls

    function changeQuantity(amount, productVariantId, price) {
        let quantityInput = document.getElementById("quantity-" + productVariantId);
        let currentQuantity = parseInt(quantityInput.value) || 1;
        let newQuantity = Math.max(1, currentQuantity + amount); // Ensure quantity doesn't go below 1
        quantityInput.value = newQuantity;

        if (timeoutMap[productVariantId]) clearTimeout(timeoutMap[productVariantId]);

        timeoutMap[productVariantId] = setTimeout(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/carts",
                type: "POST",
                data: {
                    action: "update",
                    quantity: newQuantity,
                    productVariantId: productVariantId
                },
                success: function (response) {
                    let subtotal = newQuantity * price;
                    $(quantityInput).closest('tr').find('td:nth-child(4)').text(subtotal + ' VND');
                    let newCartCount = response.cartCount || 0;
                    $("#cartCount").text(newCartCount);
                    updateTotalPrice();
                },
                error: function () {
                    alert("Lỗi không thể cập nhật giỏ hàng!");
                }
            });
        }, 500);
    }

    function validateQuantity(productVariantId, price) {
        let quantityInput = document.getElementById("quantity-" + productVariantId);
        let newQuantity = parseInt(quantityInput.value) || 1;
        if (newQuantity < 1) {
            quantityInput.value = 1;
            newQuantity = 1;
        }

        if (timeoutMap[productVariantId]) clearTimeout(timeoutMap[productVariantId]);

        timeoutMap[productVariantId] = setTimeout(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/carts",
                type: "POST",
                data: {
                    action: "update",
                    quantity: newQuantity,
                    productVariantId: productVariantId
                },
                success: function (response) {
                    let subtotal = newQuantity * price;
                    $(quantityInput).closest('tr').find('td:nth-child(4)').text(subtotal + ' VND');
                    let newCartCount = response.cartCount || 0;
                    $("#cartCount").text(newCartCount);
                    updateTotalPrice();
                },
                error: function () {
                    alert("Lỗi không thể cập nhật giỏ hàng!");
                }
            });
        }, 500);
    }

    function updateTotalPrice() {
        let total = 0;
        $('.cart-item tr').each(function () {
            let subtotalText = $(this).find('td:nth-child(4)').text();
            let subtotal = parseInt(subtotalText.split(' ')[0]) || 0;
            total += subtotal;
        });
        $('.total-price').text('💰 Tổng tiền: ' + total + ' VND');
    }
</script>
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>