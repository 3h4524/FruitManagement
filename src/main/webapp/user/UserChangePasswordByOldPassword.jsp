<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.Utils" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đổi mật khẩu</title>
  <link href="<%= request.getContextPath()%>/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #ffffff; /* Nền trắng */
      min-height: 100vh;
    }
    .card {
      border-radius: 12px;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
      padding: 20px;
    }
    h3 {
      font-weight: bold;
      color: #333;
      text-align: center;
    }
    .btn-primary {
      background-color: #007bff;
      border: none;
      transition: 0.3s;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
    .forgot-password {
      display: inline-block;
      margin-top: 10px;
      font-size: 14px;
      color: #007bff;
      text-decoration: none;
    }
    .forgot-password:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body class="d-flex justify-content-center align-items-center">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-5">
      <div class="card">
        <h3 class="mb-4">Đổi mật khẩu</h3>

        <!-- Thông báo lỗi / thành công -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="alert alert-success">${success}</div>
        </c:if>

        <!-- Form đổi mật khẩu -->
        <form action="<%= request.getContextPath()%>/users?action=changePassword" method="post">
          <div class="mb-3">
            <label for="oldPassword" class="form-label">Mật khẩu cũ:</label>
            <input type="password" id="oldPassword" name="oldPassword" class="form-control" required>
          </div>
          <div class="mb-3">
            <label for="newPassword" class="form-label">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" required>
          </div>
          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
          </div>

          <button type="submit" class="btn btn-primary w-100 py-2">Đổi mật khẩu</button>
        </form>

        <!-- Link đổi mật khẩu bằng email -->
        <div class="text-center mt-3">
          <a href="<%= request.getContextPath()%>/user/UserForgotPassword.jsp?" class="forgot-password">
            🔑 Quên mật khẩu? Đổi bằng email
          </a>
        </div>

      </div>
    </div>
  </div>
</div>

<script src="<%= request.getContextPath()%>/js/bootstrap.bundle.min.js"></script>
</body>
</html>
