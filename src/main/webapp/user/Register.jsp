<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Đăng ký</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg rounded">
        <div class="card-header bg-primary text-white text-center">
          <h3>Đăng ký tài khoản</h3>
        </div>
        <div class="card-body">
          <!-- Thông báo lỗi -->
          <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
          </c:if>

          <!-- Thông báo thành công -->
          <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">${sessionScope.success}</div>
            <c:remove var="success" scope="session"/>
          </c:if>

          <form action="${pageContext.request.contextPath}/registers" method="post">
            <!-- Email + Nút nhận mã -->
            <div class="mb-3">
              <label class="form-label">Email</label>
              <div class="input-group">
                <input type="email" id="email" name="email" class="form-control" placeholder="Nhập email" required />
                <button type="button" id="otpButton" class="btn btn-warning" data-type="register">Nhận mã</button>
              </div>
              <small id="errorMessage" class="text-danger"></small>
            </div>

            <!-- Ô nhập OTP (ẩn ban đầu) -->
            <div id="otpField" class="mb-3" style="display: none;">
              <label class="form-label">Nhập mã OTP</label>
              <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Mật khẩu</label>
              <input type="password" name="password" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Xác nhận mật khẩu</label>
              <input type="password" name="confirmPassword" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Tên đăng nhập</label>
              <input type="text" name="name" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="phone" class="form-control" required/>
            </div>

            <div class="text-center">
              <button type="submit" class="btn btn-success px-4">Đăng ký</button>
              <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary px-4">Đăng nhập</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
<script>
  var contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/otp.js"></script>
</body>
</html>
