<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Đăng ký</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg rounded">
        <div class="card-header bg-primary text-white text-center">
          <h3>Đăng ký tài khoản</h3>
        </div>
        <div class="card-body">
          <c:set var="error" value="${requestScope.error}"/>
          <c:if test="${error != null}">
            <div class="alert alert-danger">${error}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/registers" method="post">
            <div class="mb-3">
              <label class="form-label">Email</label>
              <input type="email" name="email" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Mật khẩu</label>
              <input type="password" name="password" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Tên đăng nhập</label>
              <input type="text" name="name" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="phone" class="form-control" />
            </div>

            <div class="mb-3">
              <label class="form-label">Địa chỉ</label>
              <input type="text" name="address" class="form-control" />
            </div>

            <div class="text-center">
              <button type="submit" class="btn btn-success px-4">Đăng ký</button>
              <a href="<%= request.getContextPath()%>/login" class="btn btn-secondary px-4">Đăng nhập</a>
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
