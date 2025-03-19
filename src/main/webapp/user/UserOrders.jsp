<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="service.OrderService" %>
<jsp:useBean id="orderService" class="service.OrderService" scope="page" />
<c:set var="user" value="${sessionScope.UserLogin}"/>
<c:set var="orderDetails" value="${orderService.getOrderByUserId(user.id)}" scope="request"/>
<html>
<head>
    <title>Đơn hàng của tôi</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 20px;
            text-align: center;
        }
        h2 {
            color: #343a40;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        img {
            width: 80px;
            height: 80px;
            border-radius: 5px;
        }
        .empty-message {
            color: #dc3545;
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Danh sách đơn hàng của bạn</h2>


<c:choose>
    <c:when test="${empty orderDetails}">
        <p class="empty-message">📦 Bạn chưa có đơn hàng nào!</p>
    </c:when>
    <c:otherwise>
        <table>
            <tr>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Size</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Tổng</th>
            </tr>
            <c:forEach var="detail" items="${orderDetails}">
                <tr>
                    <td>
                        <img src="${detail.productVariantID.productID.imageURL}"
                             alt="${detail.productVariantID.productID.name}">
                    </td>
                    <td>${detail.productVariantID.productID.name}</td>
                    <td>${detail.productVariantID.size}</td>
                    <td>${detail.quantity}</td>
                    <td><fmt:formatNumber value="${detail.productVariantID.price}" type="currency" currencySymbol="₫"/></td>
                    <td><fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="₫"/></td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
