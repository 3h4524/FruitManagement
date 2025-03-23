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
    <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductListCartcss.css"/>
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
    <!-- Custom CSS for Green and White Theme -->
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