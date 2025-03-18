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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="d-flex justify-content-center align-items-center" style="height: 100vh; background-color: #f8f9fa;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow p-4">
                <h3 class="mb-3 text-center">Quên Mật Khẩu</h3>

                <!-- Thông báo lỗi / thành công -->
                <c:choose>
                    <c:when test="${not empty sessionScope.UserLogin and not empty sessionScope.UserLogin.email}">
                        <p><strong>${Utils.maskEmail(sessionScope.UserLogin.email)}</strong></p>
                        <input type="hidden" id="email" value="${sessionScope.UserLogin.email}">
                    </c:when>
                    <c:otherwise>
                        <label class="form-label">Nhập email của bạn</label>
                        <input type="email" id="email" class="form-control" placeholder="Nhập email" required />
                    </c:otherwise>
                </c:choose>


            </div>
                <button id="otpButton" class="btn btn-primary w-100" data-type="forgot-password">Lấy mã xác nhận</button>
                <p id="errorMessage" class="text-danger text-center mt-2"></p>

                <hr>

                <!-- Form nhập OTP -->
                <form action="${pageContext.request.contextPath}/mails?action=verifyOtp" method="post">
                    <div class="mb-3" id="otpField">
                        <label class="form-label">Mã xác nhận (OTP)</label>
                        <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
                    </div>
                    <button type="submit" class="btn btn-success w-100">Xác nhận</button>
                </form>
                <c:if test="${!sessionScope.isLoggedIn}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary w-100 mt-2">Hủy</a>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/otp.js"></script>
</body>
</html>