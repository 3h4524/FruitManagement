<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.ProductService" %>
<jsp:useBean id="productService" class="service.ProductService" scope="page"/>
<c:set var="products" value="${productService.getAllProducts()}" scope="request"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chào Mừng Đến Với Fruitiverse</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductListCartcss.css"/>
    <style>
        :root {
            --primary-color: #2e8b57;
            --primary-light: #3c9d74;
            --primary-dark: #247048;
            --accent-color: #FFA500;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #fff;
            --border-color: #e0e0e0;
        }

        /* Fullscreen banner */
        .hero-section {
            height: 100vh; /* Full screen height */
            background: url('https://img.freepik.com/free-photo/top-view-sour-green-tangerines-light-background_140725-79917.jpg?t=st=1742448384~exp=1742451984~hmac=682f23b8937da51515e6545b44bcec399a9a287f9942e84ae1468b1c732b6e65&w=1380') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: var(--white);
            position: relative;
        }

        /* Overlay để dễ đọc chữ */
        .overlay {
            background: rgba(0, 0, 0, 0.4);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }

        .intro-title {
            font-size: 3rem;
            font-weight: bold;
            text-shadow: 3px 3px 6px rgba(46, 139, 87, 0.8);
        }

        .intro-text {
            font-size: 1.25rem;
            text-shadow: 2px 2px 4px rgba(46, 139, 87, 0.7);
        }

        /* Button style */
        .btn-green {
            border-color: var(--primary-color);
            background-color: var(--white);
            color: var(--primary-color);
            font-size: 1.5rem;
            padding: 15px 30px;
            border-radius: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(46, 139, 87, 0.6);
        }

        .btn-green:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            color: var(--white);
            box-shadow: 0 6px 16px rgba(46, 139, 87, 0.8);
            transform: translateY(-2px);
        }

        /* View more button styling */
        .view-more-container {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 40px;
        }

        .btn-view-more {
            background-color: var(--primary-light);
            border-color: var(--primary-light);
            color: var(--white);
            font-size: 1.2rem;
            padding: 12px 35px;
            border-radius: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(46, 139, 87, 0.4);
        }

        .btn-view-more:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            color: var(--white);
            box-shadow: 0 6px 16px rgba(46, 139, 87, 0.6);
            transform: translateY(-2px);
        }

        /* Add animation for cards */
        .card {
            animation: fadeIn 0.5s ease forwards;
            animation-delay: calc(var(--animation-order) * 0.1s);
            opacity: 0;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<!-- Banner Full Màn Hình -->
<section class="hero-section">
    <div class="overlay">
        <h2 class="intro-title mb-4">Chào Mừng Đến Với Fruitiverse</h2>
        <p class="intro-text mb-5">
            Fruitiverse - Shop trái cây tươi ngon mỗi ngày! Chúng tôi tự hào mang đến những loại trái cây chất lượng cao, an toàn và giàu dinh dưỡng. Hãy khám phá thế giới trái cây tươi mát cùng chúng tôi!
        </p>
        <button onclick="scrollToProducts()" class="btn btn-green">
            Bắt Đầu Mua Sắm
        </button>
    </div>
</section>

<!-- Danh sách sản phẩm - giới hạn 20 sản phẩm -->
<section id="products-section" class="products-section">
    <div class="container">
        <h2 class="text-primary text-center mb-4">Danh Sách Sản Phẩm</h2>
        <div class="row">
            <c:forEach var="product" items="${products}" varStatus="status">
                <c:if test="${status.index < 20}">
                    <div class="col-md-3 mb-4">
                        <div class="card" style="--animation-order: ${status.index + 1}">
                            <a href="products?action=productDetail&productId=${product.id}" class="text-decoration-none text-dark">
                                <img src="${product.imageURL}" class="card-img-top" style="height: 200px; object-fit: cover;">
                                <div class="card-body">
                                    <h5 class="card-title">${product.name}</h5>
                                    <p class="card-text">Giá: ${product.price} VND</p>
                                </div>
                            </a>
                            <div class="card-footer text-center">
                                <form action="AddToCartServlet" method="post">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- Nút "Xem thêm" -->
        <div class="view-more-container">
            <a href="${pageContext.request.contextPath}/products?action=find" class="btn btn-view-more">
                Xem Thêm Sản Phẩm <i class="bi bi-arrow-right"></i>
            </a>
        </div>
    </div>
</section>

<jsp:include page="/templates/footer.jsp"/>
<!-- JavaScript để cuộn xuống -->
<script>
    function scrollToProducts() {
        document.getElementById("products-section").scrollIntoView({ behavior: "smooth" });
    }

    // Add animation delay for each card
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card');
        cards.forEach((card, index) => {
            card.style.setProperty('--animation-order', index + 1);
        });
    });
</script>
</body>
</html>