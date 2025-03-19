<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fruit Shop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/headercss.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<div class="fs-top-bar">
  <div class="fs-logo">
    <a href="${pageContext.request.contextPath}/products?action=find">
      <img src="${pageContext.request.contextPath}/images/Logo.PNG" alt="Fruit Shop Logo">
    </a>
  </div>
  <div class="fs-search-container">
    <div class="fs-search-box">
      <form action="products" method="GET">
        <input type="hidden" name="action" value="find">
        <div class="fs-search-wrapper">
          <span class="fs-search-icon"><i class="fa-solid fa-magnifying-glass"></i></span>
          <input type="text" name="searchName" value="${param.searchName}" placeholder="Tìm kiếm sản phẩm tươi ngon...">
          <button type="submit" class="fs-search-button">Tìm</button>
        </div>
      </form>
    </div>
  </div>
  <div class="fs-auth">
    <c:if test="${user == null}">
      <a href="${pageContext.request.contextPath}/login" class="fs-auth-user">
        <i class="fa-solid fa-user"></i> Đăng nhập
      </a>
      <span class="fs-auth-separator">|</span>
      <a href="${pageContext.request.contextPath}/registers" class="fs-auth-register">
        <i class="fa-solid fa-user-plus"></i> Đăng ký
      </a>
    </c:if>
    <c:if test="${user != null}">
      <div class="fs-dropdown">
        <a href="#">
          <i class="fa-solid fa-user-circle"></i> ${user.name}
        </a>
        <div class="fs-dropdown-content">
          <a href="${pageContext.request.contextPath}/user/UserAccount.jsp">
            <i class="fa-solid fa-id-card"></i> Tài khoản của tôi
          </a>
          <a href="${pageContext.request.contextPath}/orders?action=myOrders">
            <i class="fa-solid fa-clipboard-list"></i> Đơn hàng của tôi
          </a>
          <a href="${pageContext.request.contextPath}/logout">
            <i class="fa-solid fa-sign-out-alt"></i> Đăng xuất
          </a>
        </div>
      </div>
    </c:if>
    <a href="${pageContext.request.contextPath}/cart/Cart.jsp" class="cart-icon">
      <i class="fa-solid fa-shopping-basket"></i>
      <span id="cartCount" class="cart-count">${sessionScope.cartCount}</span>
    </a>
  </div>
</div>
<div class="fs-line"></div>
<div class="fs-navbar" id="navbar_1">
  <a href="${pageContext.request.contextPath}/products?action=find">
    <i class="fa-solid fa-home"></i> Trang chủ
  </a>
  <div class="fs-dropdown">
    <a href="products?action=find">
      <i class="fa-solid fa-apple-whole"></i> Sản Phẩm
    </a>
    <div class="fs-dropdown-content">
      <a href="products?action=find">Tất cả sản phẩm</a>
      <a href="products?action=find&categoryId=1&searchName=&sort=price_asc">Trái cây nhiệt đới</a>
      <a href="products?action=find&categoryId=2&searchName=&sort=price_asc">Trái cây ôn đới</a>
      <a href="products?action=find&categoryId=3&searchName=&sort=price_asc">Trái cây cận nhiệt đới</a>
      <a href="products?action=find&categoryId=4&searchName=&sort=price_asc">Trái cây theo mùa</a>
      <a href="products?action=find&categoryId=5&searchName=&sort=price_asc">Trái cây quanh năm</a>
      <a href="products?action=find&categoryId=6&searchName=&sort=price_asc">Trái cây hữu cơ</a>
      <a href="products?action=find&categoryId=7&searchName=&sort=price_asc">Trái cây nhập khẩu</a>
      <a href="products?action=find&categoryId=8&searchName=&sort=price_asc">Trái cây địa phương</a>
    </div>
  </div>
  <a href="${pageContext.request.contextPath}/promotions">
    <i class="fa-solid fa-tag"></i> Khuyến Mãi
  </a>
  <div class="fs-dropdown">
    <a href="#">
      <i class="fa-solid fa-seedling"></i> Khám Phá
    </a>
    <div class="fs-dropdown-content">
      <a href="${pageContext.request.contextPath}/about/history">Lịch Sử Phát triển</a>
      <a href="${pageContext.request.contextPath}/about/project">Giới Thiệu về dự án</a>
      <a href="${pageContext.request.contextPath}/about/nutrition">Dinh dưỡng trái cây</a>
    </div>
  </div>
  <a href="${pageContext.request.contextPath}/contact">
    <i class="fa-solid fa-envelope"></i> Liên Hệ
  </a>
  <c:if test="${user != null && user.role == 'admin'}">
    <div class="fs-dropdown">
      <a href="#">
        <i class="fa-solid fa-user-shield"></i> Quản lý
      </a>
      <div class="fs-dropdown-content">
        <a href="${pageContext.request.contextPath}/users"><i class="fa-solid fa-users"></i> Người dùng</a>
        <a href="${pageContext.request.contextPath}/products"><i class="fa-solid fa-boxes-stacked"></i> Sản phẩm</a>
        <a href="${pageContext.request.contextPath}/order?action=listOrder"><i class="fa-solid fa-file-invoice"></i> Đơn hàng</a>
        <a href="${pageContext.request.contextPath}/inventory"><i class="fa-solid fa-warehouse"></i> Kho hàng</a>
        <a href="${pageContext.request.contextPath}/stats"><i class="fa-solid fa-chart-line"></i> Thống kê</a>
      </div>
    </div>
  </c:if>
</div>
<script>
  // Sticky Navigation
  window.addEventListener('scroll', function () {
    var navbar = document.querySelector('.fs-navbar');
    var topBarHeight = document.querySelector('.fs-top-bar').offsetHeight + document.querySelector('.fs-line').offsetHeight;

    if (window.scrollY > topBarHeight) {
      navbar.classList.add('fs-fixed-navbar');
    } else {
      navbar.classList.remove('fs-fixed-navbar');
    }
  });

  // Update cart count via AJAX (if needed)
  function updateCartCount() {
    fetch('${pageContext.request.contextPath}/cart/count')
            .then(response => response.json())
            .then(data => {
              document.getElementById('cartCount').textContent = data.count;
            })
            .catch(error => console.error('Error updating cart count:', error));
  }

  // You can call updateCartCount() periodically or after specific actions
</script>
</body>
</html>