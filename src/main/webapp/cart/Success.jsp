<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ page contentType="text/html; charset=UTF-8" %>
    <title>Đặt hàng thành công</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
            max-width: 400px;
        }
        h2 {
            color: #28a745;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            color: white;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🎉 Đặt hàng thành công!</h2>
    <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được xử lý.</p>

    <c:if test="${not empty orderId}">
        <p><strong>Mã đơn hàng:</strong> ${param.orderId}</p>
        <p><strong>Tổng tiền:</strong> ${param.totalPrice} VNĐ</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/products" method="get">
        <input type="hidden" name="action" value="find">
        <button class="btn" type="submit">🛒 Tiếp tục mua sắm</button>
    </form>
</div>
</body>
</html>
