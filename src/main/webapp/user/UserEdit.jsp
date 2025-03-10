<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Chỉnh sửa thông tin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg rounded">
        <div class="card-header bg-primary text-white text-center">
          <h3>Chỉnh sửa thông tin</h3>
        </div>
        <div class="card-body">
          <c:set var="user" value="${sessionScope.user}"/>
          <form action="${pageContext.request.contextPath}/user/Confirm.jsp" method="post">
            <c:set var="error" value="${requestScope.error}"/>
            <c:if test="${error != null}">
              <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="mb-3">
              <label class="form-label">Email</label>
              <input type="email" name="email" class="form-control" value="${user.email}" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Tên đăng nhập</label>
              <input type="text" name="name" class="form-control" value="${user.name}" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="phone" class="form-control" value="${user.phone}" />
            </div>

            <div class="mb-3">
              <label class="form-label">Địa chỉ</label>
              <input type="text" name="address" class="form-control" value="${user.address}" />
            </div>

            <div class="text-center">
              <button type="submit" class="btn btn-success px-4">Lưu</button>
              <a href="UserAccount.jsp?page=user/UserProfile.jsp" class="btn btn-secondary px-4">Hủy</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
