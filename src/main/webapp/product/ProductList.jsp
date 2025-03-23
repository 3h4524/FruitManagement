<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="user" class="model.User" scope="session"/>

<html>
<head>
    <title>Product List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductListcss.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container">
    <p class="welcome-text"><i class="fas fa-user-circle"></i> Welcome, ${user.name}</p>
    <h2>Product List</h2>

    <div class="links">
        <a href="${pageContext.request.contextPath}/users" class="btn"><i class="fas fa-users"></i> Users Page</a>
        <a href="${pageContext.request.contextPath}/products?action=create" class="btn"><i
                class="fas fa-plus-circle"></i> Add New Product</a>
        <a href="${pageContext.request.contextPath}/inventory" class="btn"><i class="fas fa-clipboard-list"></i>
            Inventory Log</a>
        <a href="${pageContext.request.contextPath}/order?action=topOrders" class="btn"><i class="fas fa-star"></i> Top Product</a>
    </div>

    <c:set var="products" value="${requestScope.products}"/>
    <c:set var="pageSize" value="10"/>
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
    <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
    <c:set var="end" value="${start + pageSize}"/>
    <c:set var="totalProducts" value="${products.size()}"/>
    <c:set var="totalPages" value="${Math.ceil(totalProducts / pageSize)}"/>

    <div class="table-responsive">
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Import Date</th>
                <th>Views</th>
                <th>Actions</th> <!-- Combined column header -->
            </tr>
            <c:forEach var="product" items="${products}" varStatus="status">
                <c:if test="${status.index >= start && status.index < end}">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.description}</td>
                        <td>${product.importDate}</td>
                        <td>
                                ${applicationScope.productViewCount[product.id] != null ? applicationScope.productViewCount[product.id] : 0}
                        </td>
                        <td class="action-links"> <!-- Combined cell for both buttons -->
                            <a href="${pageContext.request.contextPath}/products?action=update&productId=${product.id}"
                               class="btn edit"><i class="fas fa-edit"></i> Edit</a>
                            <c:choose>
                                <c:when test="${!product.isDeleted}">
                                    <a href="${pageContext.request.contextPath}/products?action=delete&productId=${product.id}"
                                       class="btn btn-danger delete">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/products?action=delete&productId=${product.id}"
                                       class="btn btn-success restore">
                                        <i class="fas fa-trash-restore"></i> Restore
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
    </div>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/products?page=${currentPage - 1}"><i
                    class="fas fa-chevron-left"></i> Previous</a>
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
            <a href="${pageContext.request.contextPath}/products?page=${currentPage + 1}">Next <i
                    class="fas fa-chevron-right"></i></a>
        </c:if>
    </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>