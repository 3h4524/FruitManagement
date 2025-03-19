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
    <!-- Custom CSS for Orange and White Theme -->
    <style>
        /* General body styling */
        body {
            background-color: #ffffff;
            color: #333;
        }

        /* Orange header */
        h2.text-primary {
            color: #ff6200 !important; /* Orange tone */
            font-weight: bold;
        }

        /* Card styling */
        .card {
            border: 1px solid #ff6200;
            border-radius: 10px;
            background-color: #fff;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(255, 98, 0, 0.3);
        }

        .card-img-top {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .card-title {
            color: #ff6200;
            font-weight: 600;
        }

        .card-text {
            color: #555;
        }

        /* Buttons */
        .btn-primary {
            background-color: #ff6200;
            border-color: #ff6200;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #e55a00;
            border-color: #e55a00;
            color: #fff;
        }

        /* Form controls */
        .form-select, .form-control {
            border: 1px solid #ff6200;
            color: #333;
        }

        .form-select:focus, .form-control:focus {
            border-color: #ff6200;
            box-shadow: 0 0 0 0.2rem rgba(255, 98, 0, 0.25);
        }

        /* Alert */
        .alert-warning {
            background-color: #fff3e0;
            border-color: #ff6200;
            color: #ff6200;
        }

        /* Container */
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
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
<jsp:include page="/templates/footer.jsp"/>

</body>
</html>