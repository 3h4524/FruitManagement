<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2e8b57;
            --primary-light: #3c9d74;
            --primary-dark: #247048;
            --accent-color: #FFA500;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #fff;
            --border-color: #e0e0e0;
        }

        body {
            background-color: var(--light-gray);
            color: var(--text-color);
            font-family: Arial, sans-serif;
        }

        .success-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 0;
        }

        .success-card {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border: none;
            background-color: var(--white);
        }

        .success-header {
            background-color: var(--primary-color);
            padding: 25px 20px;
            text-align: center;
            color: var(--white);
            position: relative;
        }

        .success-icon {
            font-size: 48px;
            margin-bottom: 10px;
            display: inline-block;
            animation: pulse 2s infinite;
        }

        .success-title {
            font-size: 24px;
            font-weight: 600;
            margin: 0;
        }

        .success-body {
            padding: 30px 25px;
            text-align: center;
        }

        .success-message {
            font-size: 16px;
            margin-bottom: 25px;
            color: #555;
        }

        .order-details {
            background-color: var(--light-gray);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
        }

        .order-details p {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 15px;
        }

        .order-details p:last-child {
            margin-bottom: 0;
            font-weight: bold;
            color: var(--primary-color);
            font-size: 18px;
        }

        .btn-continue {
            background-color: var(--primary-color);
            border: none;
            color: var(--white);
            padding: 12px 30px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(46, 139, 87, 0.3);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-continue:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 139, 87, 0.4);
        }

        .btn-continue i {
            margin-right: 8px;
            font-size: 18px;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }

        .wave-bottom {
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            overflow: hidden;
            line-height: 0;
        }

        .wave-bottom svg {
            position: relative;
            display: block;
            width: calc(100% + 1.3px);
            height: 18px;
        }

        .wave-bottom .shape-fill {
            fill: var(--white);
        }

        @media (max-width: 768px) {
            .success-container {
                margin: 30px 15px;
            }

            .success-title {
                font-size: 22px;
            }

            .success-icon {
                font-size: 42px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="success-container">
        <div class="success-card">
            <div class="success-header">
                <i class="fas fa-check-circle success-icon"></i>
                <h2 class="success-title">Đặt hàng thành công!</h2>
                <div class="wave-bottom">
                    <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                        <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" class="shape-fill"></path>
                    </svg>
                </div>
            </div>
            <div class="success-body">
                <p class="success-message">Cảm ơn bạn đã mua hàng. Đơn hàng của bạn đã được xử lý thành công và sẽ sớm được giao đến bạn.</p>

                <c:if test="${not empty orderId}">
                    <div class="order-details">
                        <p>
                            <span><i class="fas fa-receipt"></i> Mã đơn hàng:</span>
                            <span>${orderId}</span>
                        </p>
                        <p>
                            <span><i class="fas fa-money-bill-wave"></i> Tổng tiền:</span>
                            <span>${totalPrice} VNĐ</span>
                        </p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/products" method="get">
                    <input type="hidden" name="action" value="find">
                    <button class="btn btn-continue" type="submit">
                        <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>