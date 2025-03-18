<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đổi mật khẩu</title>
  <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg p-4">
        <h3 class="text-center">Đổi mật khẩu</h3>
        <c:if test="${not empty sessionScope.error}">
          <div class="alert alert-danger">${sessionScope.error}</div>
          <c:remove var="error" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.success}">
          <div class="alert alert-success">${sessionScope.success}</div>
          <c:remove var="success" scope="session"/>
        </c:if>
        <form action="${pageContext.request.contextPath}/users?action=update&type=changePassword" method="post">
          <div class="mb-3">
            <label for="newPassword" class="form-label">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" class="form-control" required>
          </div>
          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
          </div>
          <button type="submit" class="btn btn-primary w-100">Đổi mật khẩu</button>
        </form>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>