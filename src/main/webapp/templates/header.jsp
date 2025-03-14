
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<div class="top-bar">
  <div class="Logo">
    <a href="#"><img src="<%= request.getContextPath()%>/images/Logo.PNG"></a>
  </div>

  <div class="navbar_1" id="navbar">
    <a href="#">Trang chủ</a>
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
  </div>
  <div class="box_search">
    <input class="search_input" type="text" placeholder="Tìm kiếm...">
    <button class="search-button">🔍Tìm</button>
  </div>
  <div class="auth">
    <div class="dropdown">
      <a href="#">⌵ AA</a>
      <div class="dropdown-user">
        <a href="#">Đăng nhập</a>
        <a href="#">Đăng ký</a>
      </div>
    </div>
    <span class="cart">🛒</span>
  </div>
</div>
<div class="line"></div>

</body>
</html>
