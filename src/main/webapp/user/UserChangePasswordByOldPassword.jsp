<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.Utils" %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đổi mật khẩu</title>
  <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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
      color: var(--text-color);
    }

    .password-change-container {
      padding: 20px;
      width: 100%;
    }

    h4 {
      color: var(--primary-color);
      font-weight: 600;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }

    .btn-outline-primary {
      color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-outline-primary:hover {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      color: var(--white);
    }

    .form-control:focus {
      border-color: var(--primary-light);
      box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
    }

    .input-group-text {
      background-color: var(--light-gray);
      border-color: var(--border-color);
    }

    .forgot-password-link {
      color: var(--primary-color);
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .forgot-password-link:hover {
      color: var(--primary-dark);
      text-decoration: underline;
    }

    .alert-success {
      background-color: rgba(46, 139, 87, 0.1);
      border-color: rgba(46, 139, 87, 0.2);
      color: var(--primary-dark);
    }
  </style>
</head>
<body>
<div class="password-change-container">
  <h4 class="mb-4 border-bottom pb-3">Đổi mật khẩu</h4>

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

  <div class="row justify-content-center">
    <div class="col-lg-8">
      <form action="${pageContext.request.contextPath}/users?action=update&type=changePasswordByOldPassword" method="post" class="password-form">
        <div class="mb-3">
          <label for="oldPassword" class="form-label">Mật khẩu cũ:</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock"></i></span>
            <input type="password" id="oldPassword" name="oldPassword" class="form-control" required>
            <button class="btn btn-outline-primary toggle-password" type="button" data-target="oldPassword">
              <i class="bi bi-eye"></i>
            </button>
          </div>
        </div>

        <div class="mb-3">
          <label for="newPassword" class="form-label">Mật khẩu mới:</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
            <input type="password" id="newPassword" name="newPassword" class="form-control" required>
            <button class="btn btn-outline-primary toggle-password" type="button" data-target="newPassword">
              <i class="bi bi-eye"></i>
            </button>
          </div>
          <div class="form-text">Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số.</div>
        </div>

        <div class="mb-4">
          <label for="confirmPassword" class="form-label">Xác nhận mật khẩu:</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
            <button class="btn btn-outline-primary toggle-password" type="button" data-target="confirmPassword">
              <i class="bi bi-eye"></i>
            </button>
          </div>
        </div>

        <div class="d-grid gap-2">
          <button type="submit" class="btn btn-primary py-2">
            <i class="bi bi-check-circle-fill me-2"></i>Đổi mật khẩu
          </button>
        </div>
      </form>

      <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/user/UserTwoStepVerification.jsp?" class="forgot-password-link">
          <i class="bi bi-key me-1"></i>Quên mật khẩu? Đổi bằng email
        </a>
      </div>
    </div>
  </div>
</div>

<script>
  document.querySelectorAll('.toggle-password').forEach(button => {
    button.addEventListener('click', function() {
      const targetId = this.getAttribute('data-target');
      const inputField = document.getElementById(targetId);
      const icon = this.querySelector('i');

      if (inputField.type === 'password') {
        inputField.type = 'text';
        icon.classList.remove('bi-eye');
        icon.classList.add('bi-eye-slash');
      } else {
        inputField.type = 'password';
        icon.classList.remove('bi-eye-slash');
        icon.classList.add('bi-eye');
      }
    });
  });
</script>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>