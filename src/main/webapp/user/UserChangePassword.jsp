<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đổi mật khẩu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
  <df-messenger
          intent="WELCOME"
          chat-title="FruitShopBot"
          agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
          language-code="vi"
  ></df-messenger>
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
      background-color: #f8f9fa;
      color: var(--text-color);
      font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      min-height: 100vh;
      display: flex;
      align-items: center;
    }

    .card {
      border: none;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }

    .card-header {
      background-color: var(--white);
      border-bottom: 1px solid rgba(0,0,0,0.05);
      padding: 20px;
    }

    .card-title {
      color: var(--primary-dark);
      font-weight: 700;
      margin-bottom: 0;
      position: relative;
      display: inline-block;
    }

    .card-title::after {
      content: "";
      position: absolute;
      bottom: -8px;
      left: 0;
      width: 60px;
      height: 3px;
      background-image: linear-gradient(to right, var(--primary-light), var(--primary-color));
    }

    .btn {
      padding: 12px 24px;
      border-radius: 8px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(46, 139, 87, 0.2);
    }

    .form-control:focus {
      border-color: var(--primary-light);
      box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
    }

    .form-label {
      font-weight: 500;
      color: var(--primary-dark);
    }

    .alert-success {
      background-color: #dff7ee;
      border-color: #25a56a;
      color: #25a56a;
    }

    .alert-danger {
      background-color: #ffebef;
      border-color: #ff617d;
      color: #ff617d;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow">
        <div class="card-header bg-white">
          <h4 class="card-title"><i class="fas fa-key me-2"></i>Đổi mật khẩu</h4>
        </div>
        <div class="card-body p-4">
          <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
              <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
          </c:if>

          <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
              <i class="fas fa-check-circle me-2"></i>${sessionScope.success}
            </div>
            <c:remove var="success" scope="session"/>
          </c:if>

          <form action="${pageContext.request.contextPath}/users?action=update&type=changePassword" method="post">
            <div class="mb-4">
              <label for="newPassword" class="form-label">Mật khẩu mới:</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="fas fa-lock"></i></span>
                <input type="password" id="newPassword" name="newPassword" class="form-control" required>
              </div>
            </div>
            <div class="mb-4">
              <label for="confirmPassword" class="form-label">Xác nhận mật khẩu:</label>
              <div class="input-group">
                <span class="input-group-text bg-light"><i class="fas fa-lock-open"></i></span>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
              </div>
            </div>
            <button type="submit" class="btn btn-primary w-100">
              <i class="fas fa-save me-2"></i>Đổi mật khẩu
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>