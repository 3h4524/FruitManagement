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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    /* Orange-White Theme */
    .nav-tabs .nav-link {
      color: #FFA520; /* Orange text */
      border: none;
      padding: 10px 20px;
    }
    .nav-tabs .nav-link:hover {
      background-color: #FFF3E0; /* Light orange hover */
      color: #e59400; /* Darker orange */
    }
    .nav-tabs .nav-link.active {
      background-color: #FFA520; /* Orange background for active tab */
      color: #FFFFFF; /* White text */
      border: none;
      border-bottom: 3px solid #e59400; /* Darker orange underline */
    }
    .nav-tabs .nav-link.text-danger {
      color: #DC3545; /* Red for logout */
    }
    .nav-tabs .nav-link.text-danger:hover {
      background-color: #FFE6E6; /* Light red hover */
      color: #DC3545;
    }
    .bg-orange {
      background-color: #FFA520;
    }
    .text-orange {
      color: #FFA520;
    }
    .btn-orange {
      background-color: #FFA520;
      border-color: #FFA520;
      color: #FFFFFF;
    }
    .btn-orange:hover {
      background-color: #e59400;
      border-color: #e59400;
      color: #FFFFFF;
    }
    .card-header {
      background-color: #FFF3E0; /* Light orange header */
      border-bottom: 1px solid #FFA520;
    }
  </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-4 py-5 min-vh-100">
  <h2 class="text-center mb-4 text-orange">Tài khoản của bạn</h2>

  <!-- Tabbed Navigation -->
  <ul class="nav nav-tabs justify-content-center mb-4" role="tablist">
    <li class="nav-item">
      <a class="nav-link ${page == 'user/UserProfile.jsp' ? 'active' : ''}"
         href="<%= request.getContextPath()%>/user/UserAccount.jsp?page=user/UserProfile.jsp">
        Chỉnh sửa hồ sơ
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${page == 'user/UserAddress.jsp' ? 'active' : ''}"
         href="<%= request.getContextPath()%>/user/UserAccount.jsp?page=user/UserAddress.jsp">
        Địa chỉ
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${page == 'user/UserChangePasswordByOldPassword.jsp' ? 'active' : ''}"
         href="<%= request.getContextPath()%>/user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp">
        Đổi mật khẩu
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link text-danger" href="<%= request.getContextPath()%>/logout">
        Đăng xuất
      </a>
    </li>
  </ul>

  <!-- Content Area -->
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="card shadow-sm rounded">
        <div class="card-header text-center text-orange">
          <h5 class="mb-0 text-orange">Thông tin tài khoản</h5>
        </div>
        <div class="card-body p-4">
          <jsp:include page="/${page}" flush="true"/>
        </div>
      </div>
    </div>
  </div>
  <% System.out.println("Current Page: " + request.getParameter("page")); %>
</div>
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>