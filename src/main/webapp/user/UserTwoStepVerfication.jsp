<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="service.Utils" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Xác Minh Hai Bước</title>
  <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
    body {
      background-color: #f8f9fa;
      min-height: 100vh;
    }
    .card {
      border-radius: 12px;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }
    .btn-primary, .btn-success {
      transition: 0.3s;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body class="d-flex justify-content-center align-items-center">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card">
        <h3 class="mb-4 text-center">Xác Minh Hai Bước</h3>

        <!-- Thông báo lỗi / thành công -->
        <c:if test="${not empty sessionScope.error}">
          <div class="alert alert-danger">${sessionScope.error}</div>
          <c:remove var="error" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.success}">
          <div class="alert alert-success">${sessionScope.success}</div>
          <c:remove var="success" scope="session"/>
        </c:if>

        <!-- Hiển thị email bị che -->
        <div class="mb-3 text-center">
          <p><i class="bi bi-envelope"></i> <strong>${sessionScope.maskedEmail}</strong></p>
        </div>

        <!-- Form lấy mã OTP -->
        <form action="<%= request.getContextPath()%>/users?action=sendOtp" method="post" class="mb-3">
          <div class="input-group">
            <input type="hidden" name="email" value="${sessionScope.email}">
            <button type="submit" class="btn btn-primary w-100">📩 Lấy mã xác nhận</button>
          </div>
        </form>

        <!-- Form nhập mã OTP -->
        <form action="<%= request.getContextPath()%>/users?action=verifyOtp" method="post">
          <div class="mb-3">
            <label class="form-label">Mã xác nhận (OTP)</label>
            <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
          </div>

          <div class="text-center">
            <button type="submit" class="btn btn-success w-100">✅ Xác nhận</button>
            <a href="<%= request.getContextPath()%>/login" class="btn btn-secondary w-100 mt-2">Hủy</a>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
