<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="service.Utils" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác thực 2 bước</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-color);
        }

        .verification-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            width: 100%;
            max-width: 450px;
        }

        h3 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.6rem 1rem;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .btn-success {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.6rem 1rem;
        }

        .btn-success:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .verification-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .masked-email {
            background-color: var(--light-gray);
            padding: 0.75rem;
            border-radius: 6px;
            margin: 1rem 0;
            text-align: center;
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="verification-card">
    <div class="text-center">
        <i class="bi bi-shield-lock verification-icon"></i>
        <h3>Quên Mật Khẩu</h3>
    </div>

    <!-- Thông báo lỗi / thành công -->
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="success" scope="session"/>
    </c:if>

    <c:choose>
        <c:when test="${not empty sessionScope.UserLogin and not empty sessionScope.UserLogin.email}">
            <p class="text-center">Chúng tôi sẽ gửi mã xác nhận đến:</p>
            <div class="masked-email">
                <i class="bi bi-envelope me-2"></i>${Utils.maskEmail(sessionScope.UserLogin.email)}
            </div>
            <input type="hidden" id="email" value="${sessionScope.UserLogin.email}">
        </c:when>
        <c:otherwise>
            <div class="mb-3">
                <label class="form-label">
                    <i class="bi bi-envelope me-1"></i>Nhập email của bạn
                </label>
                <input type="email" id="email" class="form-control" placeholder="Nhập email" required />
            </div>
        </c:otherwise>
    </c:choose>

    <button id="otpButton" class="btn btn-primary w-100 mb-3" data-type="forgot-password">
        <i class="bi bi-send me-1"></i>Lấy mã xác nhận
    </button>
    <p id="errorMessage" class="text-danger text-center mt-2"></p>

    <hr class="my-3">

    <!-- Form nhập OTP -->
    <form action="${pageContext.request.contextPath}/mails?action=verifyOtp" method="post">
        <div class="mb-3" id="otpField">
            <label class="form-label">
                <i class="bi bi-key me-1"></i>Mã xác nhận (OTP)
            </label>
            <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
        </div>
        <button type="submit" class="btn btn-success w-100 mb-2">
            <i class="bi bi-check-circle me-1"></i>Xác nhận
        </button>
    </form>

    <c:if test="${!sessionScope.isLoggedIn}">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary w-100">
            <i class="bi bi-arrow-left me-1"></i>Quay lại đăng nhập
        </a>
    </c:if>
</div>

<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/otp.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>