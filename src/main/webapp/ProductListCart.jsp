<%--
  Created by IntelliJ IDEA.
  User: LEGION
  Date: 3/8/2025
  Time: 9:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Product, model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="products" scope="request" type="java.util.List" />
<jsp:useBean id="categories" scope="request" type="java.util.List" />

<html>
<head>
    <title>Danh sách sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

</head>
<body>

<div class="container mt-4">
    <h2 class="text-center mb-4">Danh sách sản phẩm</h2>

    <form method="GET" action="ProductListCart" class="row mb-4">
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
                    <a href="ProductDetailServlet?productID=${product.id}" class="text-decoration-none text-dark">
                        <img src="${product.imageURL}" class="card-img-top" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">Giá: ${product.price} VND</p>
                        </div>
                    </a>
                    <div class="card-footer text-center">
                        <form action="AddToCartServlet" method="post">
                            <input type="hidden" name="productID" value="${product.id}">
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

</body>
</html>