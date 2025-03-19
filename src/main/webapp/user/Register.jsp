<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Đăng ký</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    /* Orange-White Theme */
    .bg-orange {
      background-color: #FFA520; /* Orange background */
    }
    .text-orange {
      color: #FFA520; /* Orange text */
    }
    .btn-orange {
      background-color: #FFA520;
      border-color: #FFA520;
      color: #FFFFFF; /* White text */
      transition: background-color 0.3s ease;
    }
    .btn-orange:hover {
      background-color: #e59400; /* Darker orange on hover */
      border-color: #e59400;
      color: #FFFFFF;
    }
    .btn-outline-orange {
      border-color: #FFA520;
      color: #FFA520;
    }
    .btn-outline-orange:hover {
      background-color: #FFA520;
      color: #FFFFFF;
    }
    .card-header {
      background-color: #FFF3E0; /* Light orange header */
      border-bottom: 2px solid #FFA520;
    }
    .card {
      border: 1px solid #FFA520; /* Orange border */
      background: linear-gradient(135deg, #FFFFFF 0%, #FFF8E1 100%); /* Subtle gradient */
    }
    .form-floating > label {
      color: #FFA520; /* Orange labels */
    }
    .form-control:focus {
      border-color: #FFA520;
      box-shadow: 0 0 0 0.25rem rgba(255, 165, 32, 0.25); /* Orange focus ring */
    }
    .alert-success {
      background-color: #FFF3E0; /* Light orange for success */
      border-color: #FFA520;
      color: #e59400;
    }
    .alert-danger {
      background-color: #FFE6E6; /* Light red for error */
      border-color: #DC3545;
      color: #DC3545;
    }
    a.text-orange:hover {
      color: #e59400; /* Darker orange on hover */
    }
  </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-5 py-5 min-vh-100">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow rounded">
        <div class="card-header text-center text-orange">
          <h3 class="mb-0">Đăng ký tài khoản</h3>
        </div>
        <div class="card-body p-4">
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
            <div class="form-floating mb-3">
              <input type="email" id="email" name="email" class="form-control"
                     placeholder="Nhập email" required />
              <label for="email">Email</label>
            </div>
            <div class="mb-3 d-flex justify-content-end">
              <button type="button" id="otpButton" class="btn btn-orange btn-sm" data-type="register">
                Nhận mã
              </button>
            </div>
            <small id="errorMessage" class="text-danger d-block mb-3"></small>

            <!-- Ô nhập OTP (ẩn ban đầu) -->
            <div id="otpField" class="form-floating mb-3" style="display: none;">
              <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
              <label>Nhập mã OTP</label>
            </div>

            <!-- Mật khẩu -->
            <div class="form-floating mb-3">
              <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required />
              <label>Mật khẩu</label>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="form-floating mb-3">
              <input type="password" name="confirmPassword" class="form-control"
                     placeholder="Xác nhận mật khẩu" required />
              <label>Xác nhận mật khẩu</label>
            </div>

            <!-- Tên đăng nhập -->
            <div class="form-floating mb-3">
              <input type="text" name="name" class="form-control" placeholder="Tên đăng nhập" required />
              <label>Tên đăng nhập</label>
            </div>

            <!-- Số điện thoại -->
            <div class="form-floating mb-3">
              <input type="text" name="phone" class="form-control" placeholder="Số điện thoại" required />
              <label>Số điện thoại</label>
            </div>

            <!-- Nút Đăng ký -->
            <div class="text-center mb-3">
              <button type="submit" class="btn btn-orange px-5">Đăng ký</button>
            </div>

            <!-- Link Đăng nhập -->
            <div class="text-center">
              <small>Đã có tài khoản?
                <a href="<%= request.getContextPath()%>/login" class="text-orange">Đăng nhập</a>
              </small>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/otp.js"></script>
</body>
</html>