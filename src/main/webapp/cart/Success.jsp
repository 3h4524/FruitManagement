<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
        .card-header {
            background-color: #FFF3E0; /* Light orange header */
            border-bottom: 2px solid #FFA520;
        }
        .card {
            border: 1px solid #FFA520; /* Orange border */
            background: linear-gradient(135deg, #FFFFFF 0%, #FFF8E1 100%); /* Subtle gradient */
        }
    </style>
</head>
<body>
<div class="container mt-5 py-5 min-vh-100">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow rounded">
                <div class="card-header text-center text-orange">
                    <h2 class="mb-0">🎉 Đặt hàng thành công!</h2>
                </div>
                <div class="card-body text-center p-4">
                    <p>Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được xử lý.</p>

                    <c:if test="${not empty orderId}">
                        <p><strong>Mã đơn hàng:</strong> ${orderId}</p>
                        <p><strong>Tổng tiền:</strong> ${totalPrice} VNĐ</p>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/products" method="get">
                        <input type="hidden" name="action" value="find">
                        <button class="btn btn-orange px-4" type="submit">🛒 Tiếp tục mua sắm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>