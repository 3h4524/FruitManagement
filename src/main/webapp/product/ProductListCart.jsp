<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Product, model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="productService" scope="page" class="service.ProductService"/>
<%
    if (request.getAttribute("products") == null) {
        request.setAttribute("products", productService.getAllProducts());
    }
    if(request.getAttribute("categories") == null){
        request.setAttribute("categories", productService.getAllCategories());
    }
%>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
    <!-- Custom CSS for Green and White Theme -->
    <style>
        /* General body styling */
        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Container styling */
        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-top: 30px;
            margin-bottom: 30px;
        }

        /* Only include product-specific styles here */
        /* Header styling */
        h2.text-primary {
            color: #2e8b57 !important;
            font-weight: 700;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 10px;
        }

        h2.text-primary::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background-color: #2e8b57;
        }

        /* Card styling */
        .card {
            border: none;
            border-radius: 12px;
            background-color: #fff;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 20px rgba(46, 139, 87, 0.15);
        }

        .card-img-top {
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            transition: transform 0.5s ease;
            height: 200px;
            object-fit: cover;
        }

        .card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 1.25rem 1.25rem;
        }

        .card-title {
            color: #2e8b57;
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 0.75rem;
            overflow: visible;
            white-space: normal;
            line-height: 1.4;
            min-height: 2.8em;
        }

        .card-text {
            color: #555;
            font-weight: 500;
            margin-bottom: 0.75rem;
        }

        .card-footer {
            background-color: #fff;
            border-top: 1px solid rgba(46, 139, 87, 0.1);
            padding: 1rem;
        }

        /* Buttons */
        .btn-primary {
            background-color: #3c9d74;
            border-color: #3c9d74;
            color: #fff;
            font-weight: 500;
            padding: 0.6rem 1.5rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .btn-primary:hover, .btn-primary:focus {
            background-color: #2e8b57;
            border-color: #2e8b57;
            color: #fff;
            box-shadow: 0 4px 8px rgba(46, 139, 87, 0.3);
            transform: translateY(-2px);
        }

        /* Form controls */
        .form-select, .form-control {
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            color: #333;
            padding: 0.6rem 1rem;
            transition: all 0.2s ease;
        }

        .form-select:focus, .form-control:focus {
            border-color: #3c9d74;
            box-shadow: 0 0 0 0.25rem rgba(60, 157, 116, 0.15);
        }

        /* Filter section */
        .row.g-3.mb-4 {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            margin-bottom: 2rem !important;
        }

        /* Alert */
        .alert-warning {
            background-color: #edf7f0;
            border-color: #c8e6d7;
            color: #2e8b57;
            border-radius: 8px;
            padding: 1rem;
        }

        /* Link styling */
        a.text-decoration-none.text-dark {
            display: block;
            height: 100%;
        }

        /* Dialog flow messenger styling */
        df-messenger {
            --df-messenger-bot-message: #3c9d74;
            --df-messenger-button-titlebar-color: #3c9d74;
            --df-messenger-chat-background-color: #fafafa;
            --df-messenger-font-color: white;
            --df-messenger-send-icon: #3c9d74;
            --df-messenger-user-message: #e6e6e6;
            --df-messenger-minimized-chat-close-icon-color: #3c9d74;
        }

        /* Animation for page load */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card {
            animation: fadeIn 0.5s ease forwards;
            animation-delay: calc(var(--animation-order) * 0.1s);
            opacity: 0;
        }

        /* Adding animation delay for each card */
        .col-md-3:nth-child(1) .card { --animation-order: 1; }
        .col-md-3:nth-child(2) .card { --animation-order: 2; }
        .col-md-3:nth-child(3) .card { --animation-order: 3; }
        .col-md-3:nth-child(4) .card { --animation-order: 4; }
        .col-md-3:nth-child(5) .card { --animation-order: 5; }
        .col-md-3:nth-child(6) .card { --animation-order: 6; }
        .col-md-3:nth-child(7) .card { --animation-order: 7; }
        .col-md-3:nth-child(8) .card { --animation-order: 8; }
    </style>
</head>
<body>
<!-- Include the header JSP file -->
<jsp:include page="/templates/header.jsp"/>

<!-- Main content starts here -->
<div class="container mt-4">
    <h2 class="text-center text-primary mb-4">Danh sách sản phẩm</h2>

    <!-- Bộ lọc & Tìm kiếm -->
    <form method="GET" action="products" class="row g-3 mb-4">
        <input type="hidden" name="action" value="find">
        <div class="col-md-3">
            <select name="categoryId" class="form-select">
                <option value="" ${empty param.categoryId ? 'selected' : ''}>Tất cả danh mục</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category.id}" ${param.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-3">
            <input type="text" name="searchName" value="${param.searchName}" class="form-control" placeholder="Tìm theo tên sản phẩm...">
        </div>
        <div class="col-md-3">
            <select name="sort" class="form-select">
                <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Giá: Thấp → Cao</option>
                <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Giá: Cao → Thấp</option>
                <option value="name_asc" ${param.sort == 'name_asc' ? 'selected' : ''}>Tên: A → Z</option>
                <option value="name_desc" ${param.sort == 'name_desc' ? 'selected' : ''}>Tên: Z → A</option>
            </select>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-primary w-100">Lọc & Tìm kiếm</button>
        </div>
    </form>

    <c:choose>
        <c:when test="${empty products}">
            <div class="alert alert-warning text-center">
                Không có sản phẩm nào phù hợp!
            </div>
        </c:when>
        <c:otherwise>
            <!-- Danh sách sản phẩm -->
            <div class="row">
                <c:forEach var="product" items="${products}">
                    <div class="col-md-3 mb-4">
                        <div class="card">
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
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Include the footer JSP file -->
<jsp:include page="/templates/footer.jsp"/>

<!-- Add any additional scripts here -->
<script>
    // Any additional JavaScript can go here
</script>
</body>
</html>