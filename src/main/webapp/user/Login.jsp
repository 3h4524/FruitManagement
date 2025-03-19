<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Đăng nhập</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
    .toggle-password {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      color: #FFA520;
    }
    .form-check-label {
      color: #FFA520;
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
          <h3 class="mb-0">Đăng nhập</h3>
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

          <form action="<%= request.getContextPath()%>/login" method="POST">
            <!-- Email -->
            <div class="form-floating mb-3 position-relative">
              <input type="text" id="email" name="email" class="form-control" placeholder="Email" required />
              <label for="email">Email</label>
            </div>

            <!-- Mật khẩu -->
            <div class="form-floating mb-3 position-relative">
              <input type="password" id="password" name="password" class="form-control" placeholder="Mật khẩu" required />
              <label for="password">Mật khẩu</label>
              <span class="toggle-password" onclick="togglePassword()">
                <i class="bi bi-eye"></i>
              </span>
            </div>

            <!-- Quên mật khẩu -->
            <div class="text-end mb-3">
              <a href="<%= request.getContextPath()%>/user/UserTwoStepVerification.jsp" class="text-orange">
                Quên mật khẩu?
              </a>
            </div>

            <!-- Remember me -->
            <div class="form-check mb-3">
              <input type="checkbox" name="remember-me" id="remember-me" class="form-check-input" />
              <label for="remember-me" class="form-check-label">Ghi nhớ tôi</label>
            </div>

            <!-- Nút Đăng nhập -->
            <div class="text-center mb-3">
              <button type="submit" class="btn btn-orange px-5">Đăng nhập</button>
            </div>

            <!-- Link Đăng ký -->
            <div class="text-center">
              <small>Chưa có tài khoản?
                <a href="<%= request.getContextPath()%>/registers" class="text-orange">Đăng ký</a>
              </small>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function togglePassword() {
    var passwordInput = document.getElementById("password");
    var toggleIcon = document.querySelector(".toggle-password i");
    if (passwordInput.type === "password") {
      passwordInput.type = "text";
      toggleIcon.classList.remove("bi-eye");
      toggleIcon.classList.add("bi-eye-slash");
    } else {
      passwordInput.type = "password";
      toggleIcon.classList.remove("bi-eye-slash");
      toggleIcon.classList.add("bi-eye");
    }
  }
</script>
</body>
</html>