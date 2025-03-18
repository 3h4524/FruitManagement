<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<c:set var="user" value="${sessionScope.user}"/>
<c:set var="page" value="${param.page}" />
<c:if test="${empty page}">
  <c:set var="page" value="/user/UserProfile.jsp" />
</c:if>
<html>
<head>
  <title>Tài khoản của tôi</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-4">
  <h2 class="text-center mb-4">Tài khoản của bạn</h2>

  <div class="row">
    <!-- Menu bên trái -->
    <div class="col-md-3">
      <div class="list-group">
        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserProfile.jsp" class="list-group-item list-group-item-action">Chỉnh sửa hồ sơ</a>
        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserAddress.jsp" class="list-group-item list-group-item-action">Địa chỉ</a>
        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp" class="list-group-item list-group-item-action">Đổi mật khẩu</a>
        <a href="${pageContext.request.contextPath}/logout" class="list-group-item list-group-item-action text-danger">Đăng xuất</a>
      </div>

    </div>

    <!-- Nội dung hiển thị -->
    <div class="col-md-9">
      <jsp:include page="/${page}" flush="true"/>
    </div>
    <% System.out.println("Current Page: " + request.getParameter("page")); %>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>