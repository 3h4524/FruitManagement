<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Truy cập bị từ chối - Fruit Shop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/headercss.css"/>
    <style>
        .access-denied-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 50px 20px;
            text-align: center;
        }

        .access-denied-icon {
            font-size: 80px;
            color: #ff6b6b;
            margin-bottom: 20px;
        }

        .access-denied-title {
            font-size: 32px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .access-denied-message {
            font-size: 18px;
            color: #666;
            max-width: 600px;
            margin-bottom: 30px;
            line-height: 1.5;
        }

        .access-denied-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .home-button, .login-button {
            padding: 12px 25px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .home-button {
            background-color: #4CAF50;
            color: white;
            border: none;
        }

        .login-button {
            background-color: white;
            color: #333;
            border: 2px solid #ddd;
        }

        .home-button:hover {
            background-color: #3e8e41;
        }

        .login-button:hover {
            background-color: #f5f5f5;
            border-color: #ccc;
        }

        .fruit-decoration {
            position: absolute;
            opacity: 0.1;
            z-index: -1;
        }

        .fruit-1 {
            top: 10%;
            left: 5%;
            font-size: 50px;
            transform: rotate(-15deg);
        }

        .fruit-2 {
            bottom: 15%;
            right: 7%;
            font-size: 60px;
            transform: rotate(20deg);
        }

        .fruit-3 {
            top: 60%;
            left: 8%;
            font-size: 45px;
            transform: rotate(35deg);
        }

        .fruit-4 {
            top: 15%;
            right: 10%;
            font-size: 55px;
            transform: rotate(-25deg);
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<!-- Access Denied Content -->
<div class="access-denied-container">
    <!-- Decorative fruits background -->
    <div class="fruit-decoration fruit-1"><i class="fa-solid fa-apple-whole"></i></div>
    <div class="fruit-decoration fruit-2"><i class="fa-solid fa-lemon"></i></div>
    <div class="fruit-decoration fruit-3"><i class="fa-solid fa-strawberry"></i></div>
    <div class="fruit-decoration fruit-4"><i class="fa-solid fa-carrot"></i></div>

    <div class="access-denied-icon">
        <i class="fa-solid fa-lock"></i>
    </div>

    <h1 class="access-denied-title">Truy cập bị từ chối</h1>

    <p class="access-denied-message">
        Rất tiếc, bạn không có quyền truy cập vào trang này.
        Vui lòng đăng nhập với tài khoản có quyền truy cập phù hợp hoặc liên hệ với quản trị viên để được hỗ trợ.
    </p>

    <div class="access-denied-actions">
        <a href="${pageContext.request.contextPath}/products?action=find" class="home-button">
            <i class="fa-solid fa-home"></i> Trang chủ
        </a>
    </div>
</div>

<jsp:include page="/templates/footer.jsp"/>
</body>
</html>