<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
  <title>Đăng nhập</title>
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
      font-family: Arial, sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 0;
      justify-content: center;
    }

    .container {
      width: 100%;
      margin-top: 2rem;
      margin-bottom: 2rem;
    }

    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    .card-header {
      padding: 1.5rem;
      background-color: var(--primary-color) !important;
      border-bottom: none;
    }

    .card-body {
      padding: 2rem;
    }

    .form-label {
      font-weight: 500;
      color: var(--text-color);
      margin-bottom: 0.5rem;
    }

    .form-control {
      padding: 0.75rem;
      border: 1px solid var(--border-color);
      border-radius: 5px;
    }

    .form-control:focus {
      border-color: var(--primary-light);
      box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
    }

    .input-group-text {
      background-color: var(--light-gray);
      border-color: var(--border-color);
      cursor: pointer;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      color: var(--white);
      padding: 0.75rem 2rem;
      font-weight: 500;
      width: 100%;
      margin-bottom: 1rem;
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }

    .btn-secondary {
      background-color: var(--light-gray);
      border-color: var(--border-color);
      color: var(--text-color);
      padding: 0.75rem 2rem;
      font-weight: 500;
      width: 100%;
    }

    .btn-secondary:hover {
      background-color: #e6e6e6;
      border-color: #d5d5d5;
      color: var(--text-color);
    }

    .forgot-password-link {
      color: var(--primary-color);
      text-decoration: none;
      transition: color 0.3s ease;
      text-align: right;
      display: block;
      margin-bottom: 1.5rem;
    }

    .forgot-password-link:hover {
      color: var(--primary-dark);
      text-decoration: underline;
    }

    .remember-me {
      display: flex;
      align-items: center;
      margin-bottom: 1.5rem;
    }

    .remember-me input {
      margin-right: 0.5rem;
    }

    .alert {
      border-radius: 5px;
      padding: 1rem;
      margin-bottom: 1.5rem;
    }

    .alert-success {
      background-color: rgba(46, 139, 87, 0.1);
      border-color: rgba(46, 139, 87, 0.2);
      color: var(--primary-dark);
    }

    .alert-danger {
      background-color: rgba(220, 53, 69, 0.1);
      border-color: rgba(220, 53, 69, 0.2);
    }
  </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg">
        <div class="card-header text-white text-center">
          <h3 class="mb-0">Đăng nhập</h3>
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

          <form action="${pageContext.request.contextPath}/login" method="POST">
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="text" id="email" name="email" class="form-control" placeholder="Nhập email" required>
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Mật khẩu</label>
              <div class="input-group">
                <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                <span class="input-group-text" onclick="togglePassword()">
                  <i class="bi bi-eye"></i>
                </span>
              </div>
            </div>
            <a href="${pageContext.request.contextPath}/user/UserTwoStepVerification.jsp" class="forgot-password-link">Quên mật khẩu?</a>
            <div class="remember-me">
              <input type="checkbox" name="remember-me" id="remember-me">
              <label for="remember-me">Remember me</label>
            </div>
            <button type="submit" class="btn btn-primary">Đăng nhập</button>
          </form>
          <form action="${pageContext.request.contextPath}/registers">
            <button type="submit" class="btn btn-secondary">Đăng ký</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>

<script>
  function togglePassword() {
    var passwordInput = document.getElementById("password");
    var toggleIcon = document.querySelector(".input-group-text i");
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
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>