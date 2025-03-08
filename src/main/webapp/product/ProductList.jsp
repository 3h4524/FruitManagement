<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="user" class="model.Customer" scope="session"/>
<html>
<head>
    <title>Product List</title>
</head>
<body>
<h2>Welcome ${user.name}</h2>
<h2>Product List</h2>
<a href="${pageContext.request.contextPath}/products?action=create">Add new product</a>

<c:set var="products" value="${requestScope.products}"/>
<c:set var="pageSize" value="10"/>
<c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
<c:set var="start" value="${(currentPage - 1) * pageSize}"/>
<c:set var="end" value="${start + pageSize}"/>
<c:set var="totalProducts" value="${products.size()}"/>
<c:set var="totalPages" value="${Math.ceil(totalProducts / pageSize)}"/>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Description</th>
        <th>Stock</th>
        <th>Import Date</th>
        <th>Views</th> <!-- Thêm cột số lần xem -->
        <th>Action</th>
    </tr>
    <c:forEach var="product" items="${products}" varStatus="status">
        <c:if test="${status.index >= start && status.index < end}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.description}</td>
                <td>${product.stock}</td>
                <td>${product.importDate}</td>
                <td>
                        ${applicationScope.productViewCount[product.id] != null ? applicationScope.productViewCount[product.id] : 0}
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/products?action=update&id=${product.id}">Edit</a>
                    <a href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}">Delete</a>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</table>

<!-- Phân trang -->
<div>
    <c:if test="${currentPage > 1}">
        <a href="${pageContext.request.contextPath}/products?page=${currentPage - 1}">Previous</a>
    </c:if>

    <c:forEach var="i" begin="1" end="${totalPages}">
        <c:choose>
            <c:when test="${currentPage == i}">
                <strong>${i}</strong>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/products?page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="${pageContext.request.contextPath}/products?page=${currentPage + 1}">Next</a>
    </c:if>
</div>
</body>
</html>
