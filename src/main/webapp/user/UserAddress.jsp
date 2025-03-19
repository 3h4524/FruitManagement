<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Quản lý địa chỉ</title>
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
    }
    .btn-orange:hover {
      background-color: #e59400; /* Darker orange on hover */
      border-color: #e59400;
      color: #FFFFFF;
    }
    .card {
      border: 1px solid #FFA520; /* Orange border */
    }
    .card-header {
      background-color: #FFF3E0; /* Light orange header */
      border-bottom: 2px solid #FFA520;
    }
    a.text-orange:hover {
      color: #e59400; /* Darker orange on hover */
    }
  </style>
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<div class="container mt-4 py-5">
  <div class="row justify-content-center">
    <div class="col-md-12">
      <div class="card shadow rounded">
        <div class="card-header text-center text-orange">
          <h4 class="mb-0 d-flex justify-content-between align-items-center">
            Địa chỉ của tôi
            <c:if test="${empty user.address}">
              <a href="<%= request.getContextPath()%>/user/UserSaveAddress.jsp" class="btn btn-orange btn-sm">
                ➕ Thêm địa chỉ mới
              </a>
            </c:if>
          </h4>
        </div>
        <div class="card-body p-4">
          <c:if test="${not empty user.address}">
            <h5 class="text-orange mb-3">Địa chỉ</h5>
            <div class="p-3 border rounded bg-white d-flex justify-content-between align-items-center">
              <div>
                <strong>${user.name}</strong> | <span class="text-muted">${user.phone}</span> <br>
                <span class="text-muted">${user.address}</span>
              </div>
              <div>
                <a href="UserAccount.jsp?page=user/UserSaveAddress.jsp" class="text-orange me-2">Cập nhật</a>
              </div>
            </div>
          </c:if>
          <c:if test="${empty user.address}">
            <p class="text-center text-muted">Chưa có địa chỉ nào được thêm.</p>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>