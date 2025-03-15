<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Quản lý địa chỉ</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<div class="container mt-4">
  <h4 class="mb-3 d-flex justify-content-between">
    Địa chỉ của tôi
    <c:if test="${empty user.address}">
      <a href="<%= request.getContextPath()%>/user/UserSaveAddress.jsp" class="btn btn-danger btn-sm">➕ Thêm địa chỉ mới</a>
    </c:if>
  </h4>
  <hr>



  <c:if test="${not empty user.address}">
    <h5>Địa chỉ</h5>
    <div class="p-3 border rounded d-flex justify-content-between align-items-center">
      <div>
        <strong>${user.name}</strong> | <span class="text-muted">${user.phone}</span> <br>
        <span class="text-muted">${user.address}</span>
      </div>
      <div>
        <a href="UserAccount.jsp?page=user/UserSaveAddress.jsp" class="text-primary me-2">Cập nhật</a>
      </div>
    </div>
  </c:if>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
