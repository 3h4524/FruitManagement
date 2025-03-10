<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
  <h2 class="text-center mb-4">Tài khoản của bạn</h2>

  <div class="row">
    <!-- Menu bên trái -->
    <div class="col-md-3">
      <div class="list-group">
        <a href="UserAccount.jsp?page=user/UserProfile.jsp" class="list-group-item list-group-item-action">Thông tin cá nhân</a>
        <a href="UserAccount.jsp?page=user/UserEdit.jsp" class="list-group-item list-group-item-action">Chỉnh sửa thông tin</a>
        <a href="UserAccount.jsp?page=user/UserChangePassword.jsp" class="list-group-item list-group-item-action">Đổi mật khẩu</a>
        <a href="<%= request.getContextPath()%>/logout" class="list-group-item list-group-item-action text-danger">Đăng xuất</a>

      </div>

    </div>

    <!-- Nội dung hiển thị -->
    <div class="col-md-9">
      <jsp:include page="/${page}" flush="true"/>
    </div>
    <% System.out.println("Current Page: " + request.getParameter("page")); %>
  </div>
</div>
</body>
</html>
