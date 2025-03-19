<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="user" class="model.User" scope="session"/>

<html>
<head>
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        .links {
            margin-bottom: 20px;
        }
        .links a {
            text-decoration: none;
            background: #007bff;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            margin: 5px;
            display: inline-block;
        }
        .links a:hover {
            background: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background: #f2f2f2;
        }
        .action-links a {
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            margin-right: 5px;
        }
        .edit {
            background: #28a745;
            color: white;
        }
        .delete {
            background: #dc3545;
            color: white;
        }
        .edit:hover {
            background: #218838;
        }
        .delete:hover {
            background: #c82333;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            text-decoration: none;
            background: #007bff;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            margin: 3px;
            display: inline-block;
        }
        .pagination a:hover {
            background: #0056b3;
        }
        .pagination strong {
            padding: 8px 12px;
            background: #343a40;
            color: white;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container">
    <h2>Welcome, ${user.name}</h2>
    <h2>Product List</h2>

    <div class="links">
        <a href="${pageContext.request.contextPath}/users">Go to Users Page</a>
        <a href="${pageContext.request.contextPath}/products?action=create">Add New Product</a>
        <a href="${pageContext.request.contextPath}/inventory">InventoryLog</a>
    </div>

    <c:set var="products" value="${requestScope.products}"/>
    <c:set var="pageSize" value="10"/>
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
    <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
    <c:set var="end" value="${start + pageSize}"/>
    <c:set var="totalProducts" value="${products.size()}"/>
    <c:set var="totalPages" value="${Math.ceil(totalProducts / pageSize)}"/>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Import Date</th>
            <th>Views</th>
            <th>Action</th>
        </tr>
        <c:forEach var="product" items="${products}" varStatus="status">
            <c:if test="${status.index >= start && status.index < end}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.description}</td>
                    <td>${product.importDate}</td>
                    <td>${product.imageURL}</td>
                    <td>
                            ${applicationScope.productViewCount[product.id] != null ? applicationScope.productViewCount[product.id] : 0}
                    </td>
                    <td class="action-links">
                        <a href="${pageContext.request.contextPath}/products?action=update&productId=${product.id}" class="edit">Edit</a>
                        <a href="${pageContext.request.contextPath}/products?action=delete&productId=${product.id}" class="delete">Delete</a>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </table>

    <div class="pagination">
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
</div>
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>