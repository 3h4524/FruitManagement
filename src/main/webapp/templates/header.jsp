
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP Page</title>
  <link rel="stylesheet" href="<%= request.getContextPath()%>/css/headercss.css">
  <script>
    window.addEventListener('scroll', function() {
      var navbar = document.querySelector('.navbar');
      var topBarHeight = document.querySelector('.top-bar').offsetHeight;
      if (window.scrollY > topBarHeight) {
        navbar.classList.add('fixed-navbar');
      } else {
        navbar.classList.remove('fixed-navbar');
      }
    });
  </script>
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<div class="top-bar">
  <div class="Logo">
    <a href="${pageContext.request.contextPath}/index.jsp"><img src="<%= request.getContextPath()%>/images/Logo.PNG"></a>
  </div>

  <div class="navbar_1" id="navbar">
    <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
    <div class="dropdown">
      <a href="#">⌵ Sản Phẩm</a>
      <div class="dropdown-content">
        <a href="#">Cherry Nhập Khẩu</a>
        <a href="#">Nho Sữa Hàn Quốc</a>
        <a href="#">Táo Nhật Bản</a>
        <a href="#">Dâu Tây, Việt Quất</a>
        <a href="#">Kiwi</a>
      </div>
    </div>
    <a href="#">Khuyễn Mãi</a>
    <div class="dropdown">
      <a href="#">⌵ Khám Phá</a>
      <div class="dropdown-content">
        <a href="#">Lịch Sử Phát triển</a>
        <a href="#">Giới Thiệu về dự án</a>
      </div>
    </div>
    <a href="#">Liên Hệ</a>
    <div class="dropdown">
      <a href="#">⌵ Quản lý</a>
      <div class="dropdown-content">
        <a href="${pageContext.request.contextPath}/users">Người dùng</a>
        <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
      </div>
    </div>
  </div>
  <div class="box_search">
    <input class="search_input" type="text" placeholder="Tìm kiếm...">
    <button class="search-button">🔍Tìm</button>
  </div>
  <div class="auth">
    <div class="dropdown">
      <c:if test="${user == null}">
        <a href="#">⌵ AA</a>
      </c:if>
      <c:if test="${user != null}">
        <a href="#">${user.name}</a>
      </c:if>
      <div class="dropdown-user">
        <c:if test="${user == null}">
          <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
          <a href="${pageContext.request.contextPath}/registers">Đăng ký</a>
        </c:if>
        <c:if test="${user != null}">
          <a href="${pageContext.request.contextPath}/user/UserAccount.jsp">Tài khoản của tôi</a>
          <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </c:if>
      </div>
    </div>

    <a href="${pageContext.request.contextPath}/cart/Cart.jsp" class="cart-icon">
      🛍 <span id="cartCount" class="cart-count">${sessionScope.cartCount}</span>
    </a>  </div>
</div>
<div class="line"></div>

</body>
</html>
