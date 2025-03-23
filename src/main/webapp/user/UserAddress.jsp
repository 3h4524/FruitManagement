<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Quản lý địa chỉ</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
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

    .btn-success {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-success:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }

    .address-card {
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 1rem;
      background-color: var(--white);
      transition: all 0.2s ease;
    }

    .address-card:hover {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .text-primary {
      color: var(--primary-color) !important;
    }

    .text-primary:hover {
      color: var(--primary-dark) !important;
      text-decoration: underline;
    }

    .alert-success {
      background-color: rgba(46, 139, 87, 0.1);
      border-color: rgba(46, 139, 87, 0.2);
      color: var(--primary-dark);
    }

    .btn-danger {
      background-color: #dc3545;
      border-color: #dc3545;
    }

    .btn-danger:hover {
      background-color: #bb2d3b;
      border-color: #b02a37;
    }
  </style>
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<div class="container">
  <h4 class="mb-3 d-flex justify-content-between align-items-center">
    <span><i class="bi bi-geo-alt-fill me-2"></i>Địa chỉ của tôi</span>
    <c:if test="${empty user.address}">
      <a href="${pageContext.request.contextPath}/user/UserSaveAddress.jsp" class="btn btn-danger btn-sm">
        <i class="bi bi-plus-circle me-1"></i>Thêm địa chỉ mới
      </a>
    </c:if>
  </h4>
  <hr class="mb-4">

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

  <c:if test="${not empty user.address}">
    <div class="address-card d-flex justify-content-between align-items-center mb-3">
      <div>
        <div class="mb-1">
          <strong class="fs-5">${user.name}</strong>
          <span class="badge bg-success ms-2">Mặc định</span>
        </div>
        <div class="text-muted mb-1">
          <i class="bi bi-telephone me-1"></i>${user.phone}
        </div>
        <div class="text-muted">
          <i class="bi bi-house me-1"></i>${user.address}
        </div>
      </div>
      <div>
        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserSaveAddress.jsp" class="btn btn-outline-primary btn-sm">
          <i class="bi bi-pencil me-1"></i>Cập nhật
        </a>
      </div>
    </div>
  </c:if>

  <c:if test="${empty user.address}">
    <div class="text-center py-5">
      <i class="bi bi-geo-alt text-muted" style="font-size: 3rem;"></i>
      <p class="text-muted mt-3">Bạn chưa có địa chỉ nào</p>
      <a href="${pageContext.request.contextPath}/user/UserSaveAddress.jsp" class="btn btn-primary mt-2">
        <i class="bi bi-plus-circle me-1"></i>Thêm địa chỉ mới
      </a>
    </div>
  </c:if>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>