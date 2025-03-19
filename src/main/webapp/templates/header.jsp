<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/headercss.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<div class="fs-top-bar">
    <div class="fs-logo">
        <a href="#"><img src="images/Logo.PNG" alt="Logo"></a>
    </div>
    <div class="fs-search-container">
        <div class="fs-search-box">
            <form action="products" method="GET">
                <input type="hidden" name="action" value="find">
                <div class="fs-search-wrapper">
                    <span class="fs-search-icon">🔍</span>
                    <input type="text" name="searchName" value="${param.searchName}" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit" class="fs-search-button">Tìm</button>
                </div>
            </form>
        </div>
    </div>
    <div class="fs-auth">
        <c:if test="${user == null}">
            <a href="#" class="fs-auth-user"><i class="fa-solid fa-user"></i> Đăng nhập</a>
            <span class="fs-auth-separator">|</span>
            <a href="#" class="fs-auth-register">Đăng ký</a>
        </c:if>
        <c:if test="${user == null}">
            <div class="fs-dropdown">
                <div class="fs-dropdown-content">
                    <a href="${pageContext.request.contextPath}/user/UserAccount.jsp">Tài khoản của tôi</a>
                    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                </div>
            </div>
        </c:if>
        <a href="${pageContext.request.contextPath}/cart/Cart.jsp" class="cart-icon">
            🛍 <span id="cartCount" class="cart-count">${sessionScope.cartCount}</span>
        </a>
    </div>
</div>
<div class="fs-line"></div>
<div class="fs-navbar" id="navbar_1">
    <a href="#">Trang chủ</a>
    <div class="fs-dropdown">
        <a href="products?action=find">Sản Phẩm</a>
        <div class="fs-dropdown-content">
            <a href="products?action=find">Tất cả sản phẩm</a>
            <a href="products?action=find&categoryId=1&searchName=&sort=price_asc">Tropical Fruits</a>
            <a href="products?action=find&categoryId=2&searchName=&sort=price_asc">Temperate Fruits</a>
            <a href="products?action=find&categoryId=3&searchName=&sort=price_asc">Subtropical Fruits</a>
            <a href="products?action=find&categoryId=4&searchName=&sort=price_asc">Seasonal Fruits</a>
            <a href="products?action=find&categoryId=5&searchName=&sort=price_asc">ALL-Season Fruits</a>
            <a href="products?action=find&categoryId=6&searchName=&sort=price_asc">Organic Fruits</a>
            <a href="products?action=find&categoryId=7&searchName=&sort=price_asc">Imported Fruits</a>
            <a href="products?action=find&categoryId=8&searchName=&sort=price_asc">Local Fruits</a>
        </div>
    </div>
    <a href="#">Khuyến Mãi</a>
    <div class="fs-dropdown">
        <a href="#">Khám Phá</a>
        <div class="fs-dropdown-content">
            <a href="#">Lịch Sử Phát triển</a>
            <a href="#">Giới Thiệu về dự án</a>
        </div>
    </div>
    <a href="#">Liên Hệ</a>
    <c:if test="${user != null}">
        <div class="fs-dropdown">
            <a href="#">Quản lý</a>
            <div class="fs-dropdown-content">
                <a href="${pageContext.request.contextPath}/users">Người dùng</a>
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/orders">Đơn hàng</a>
                <a href="${pageContext.request.contextPath}/inventory">Kho hàng</a>
            </div>
        </div>
    </c:if>
</div>
<script>
    window.addEventListener('scroll', function () {
        var navbar = document.querySelector('.fs-navbar');
        var topBarHeight = document.querySelector('.fs-top-bar').offsetHeight;
        if (window.scrollY > topBarHeight) {
            navbar.classList.add('fs-fixed-navbar');
        } else {
            navbar.classList.remove('fs-fixed-navbar');
        }
    });
</script>
</body>
</html>