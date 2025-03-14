<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Kiểm tra xem người dùng đã đăng nhập chưa
    String email = (String) session.getAttribute("email");
    boolean isLoggedIn = (email != null);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác Minh Email</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="d-flex justify-content-center align-items-center" style="height: 100vh; background-color: #f8f9fa;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow p-4">
                <h3 class="mb-3 text-center">Xác Minh Email</h3>

                <!-- Thông báo lỗi / thành công -->
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger">${sessionScope.error}</div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <!-- Form lấy mã OTP -->
                <form action="<%= request.getContextPath()%>/users?action=generateOtp" method="post">
                    <div class="mb-3 text-center">
                        <c:choose>
                            <c:when test="<%= isLoggedIn %>">
                                <!-- Nếu đã đăng nhập, hiển thị email bị che -->
                                <p><strong>${sessionScope.maskedEmail}</strong></p>
                                <input type="hidden" name="email" value="${sessionScope.email}">
                            </c:when>
                            <c:otherwise>
                                <!-- Nếu chưa đăng nhập, cho nhập email -->
                                <label class="form-label">Nhập email của bạn</label>
                                <input type="email" name="email" class="form-control" placeholder="Nhập email" required />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button type="submit" id="otpButton" class="btn btn-primary w-100" data-type="forgot-password">Lấy mã xác nhận</button>
                </form>

                <hr>

                <!-- Form nhập OTP -->
                <form action="<%= request.getContextPath()%>/users?action=verifyOtp" method="post">
                    <div class="mb-3">
                        <label class="form-label">Mã xác nhận (OTP)</label>
                        <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
                    </div>
                    <button type="submit" class="btn btn-success w-100">Xác nhận</button>
                </form>

                <a href="<%= request.getContextPath()%>/login" class="btn btn-secondary w-100 mt-2">Hủy</a>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/otp.js"></script>
</body>
</html>
