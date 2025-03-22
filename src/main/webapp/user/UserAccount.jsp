<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<c:set var="page" value="${param.page}"/>
<c:if test="${empty page}">
    <c:set var="page" value="/user/UserProfile.jsp"/>
</c:if>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tài khoản của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
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
            min-height: 100vh;
            color: var(--text-color);
        }

        .account-container {
            padding: 40px 0;
        }

        .account-title {
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .account-sidebar {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .account-sidebar .list-group-item {
            border-left: none;
            border-right: none;
            padding: 12px 20px;
            transition: all 0.2s ease;
            color: var(--text-color);
        }

        .account-sidebar .list-group-item:first-child {
            border-top: none;
        }

        .account-sidebar .list-group-item:last-child {
            border-bottom: none;
        }

        .account-sidebar .list-group-item:hover {
            background-color: var(--light-gray);
            color: var(--primary-color);
        }

        .account-sidebar .list-group-item.active {
            background-color: var(--primary-color);
            color: var(--white);
            border-color: var(--primary-color);
        }

        .account-content {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .btn-success {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-success:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--white);
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
        }

        .forgot-password-link {
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .forgot-password-link:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        h4 {
            color: var(--primary-color);
        }

        .input-group-text {
            background-color: var(--light-gray);
            border-color: var(--border-color);
        }

        .alert-success {
            background-color: rgba(46, 139, 87, 0.1);
            border-color: rgba(46, 139, 87, 0.2);
            color: var(--primary-dark);
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="container account-container">
    <h2 class="text-center account-title">Tài khoản của bạn</h2>

    <div class="row g-4">
        <!-- Menu bên trái -->
        <div class="col-lg-3 col-md-4">
            <div class="account-sidebar">
                <div class="list-group">
                    <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserProfile.jsp"
                       class="list-group-item list-group-item-action ${fn:endsWith(page, 'UserProfile.jsp') ? 'active' : ''}">
                        <i class="bi bi-person-fill me-2"></i>Chỉnh sửa hồ sơ
                    </a>
                    <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserAddress.jsp"
                       class="list-group-item list-group-item-action ${fn:endsWith(page, 'UserAddress.jsp') ? 'active' : ''}">
                        <i class="bi bi-geo-alt-fill me-2"></i>Địa chỉ
                    </a>
                    <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp"
                       class="list-group-item list-group-item-action ${fn:endsWith(page, 'UserChangePasswordByOldPassword.jsp') ? 'active' : ''}">
                        <i class="bi bi-lock-fill me-2"></i>Đổi mật khẩu
                    </a>
                    <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserOrders.jsp"
                       class="list-group-item list-group-item-action ${fn:endsWith(page, 'UserOrders.jsp') ? 'active' : ''}">
                        <i class="bi bi-bag-check-fill me-2"></i>Đơn mua
                    </a>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="list-group-item list-group-item-action text-danger">
                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                    </a>
                </div>
            </div>
        </div>

        <!-- Nội dung hiển thị -->
        <div class="col-lg-9 col-md-8">
            <div class="account-content">
                <jsp:include page="/${page}" flush="true"/>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/templates/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>