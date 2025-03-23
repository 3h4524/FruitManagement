<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        .success {
            color: #28a745;
        }
        .error {
            color: #dc3545;
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
    <c:choose>
        <c:when test="${transResult eq true}">
            <h2 class="success">✅ Thanh toán thành công!</h2>
            <p>Cảm ơn bạn đã thanh toán qua VNPay.</p>
            <p><strong>Mã đơn hàng:</strong> ${param.vnp_TxnRef}</p>
            <p><strong>Mã giao dịch:</strong> ${param.vnp_TransactionNo}</p>
            <p><strong>Số tiền:</strong> ${param.vnp_Amount / 100} VNĐ</p>
        </c:when>
        <c:otherwise>
            <h2 class="error">❌ Thanh toán thất bại!</h2>
            <p>Rất tiếc, giao dịch của bạn không thành công.</p>
            <p>Vui lòng thử lại hoặc chọn phương thức thanh toán khác.</p>
        </c:otherwise>
    </c:choose>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/products?action=find" class="btn">🛒 Tiếp tục mua sắm</a>
    </div>
</div>
</body>
</html>