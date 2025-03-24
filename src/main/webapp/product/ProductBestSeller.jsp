<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 24/03/2025
  Time: 12:11 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sản phẩm bán chạy</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductListCartcss.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductPaginationcss.css"/>
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container">
    <h2 class="text-primary text-center mb-4">Danh Sách Sản Phẩm Bán Chạy</h2>
    <div class="row">
        <c:set var="products" value="${requestScope.products}"/>
        <c:set var="pageSize" value="12"/>
        <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
        <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
        <c:set var="end" value="${start + pageSize}"/>
        <c:set var="totalProducts" value="${products.size()}"/>
        <c:set var="totalPages" value="${Math.ceil(totalProducts / pageSize)}"/>
        <c:forEach var="product" items="${requestScope.products}" varStatus="status">
            <c:if test="${status.index >= start && status.index < end}">
                <div class="col-md-3 mb-4">
                    <div class="card" style="--animation-order: ${status.index + 1}">
                        <a href="products?action=productDetail&productId=${product['productId']}"
                           class="text-decoration-none text-dark">
                            <img src="${product['imageURL']}" class="card-img-top"
                                 style="height: 200px; object-fit: cover;">
                            <div class="card-body">
                                <h5 class="card-title">${product['productName']}</h5>
                                <p class="card-text">Giá: <fmt:formatNumber value="${product['productPrice']}"
                                                                            pattern="#,###"/> VND</p>
                            </div>
                        </a>
                        <div class="card-footer text-center">
                            <form action="AddToCartServlet" method="post">
                                <input type="hidden" name="productId" value="${product['productId']}">
                                <button type="submit" class="btn btn-primary">Thêm vào giỏ hàng</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="${pageContext.request.contextPath}/products?action=productBestSeller&page=${currentPage - 1}"><i
                    class="fas fa-chevron-left"></i> Previous</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${currentPage == i}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/products?action=productBestSeller&page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="${pageContext.request.contextPath}/products?action=productBestSeller&page=${currentPage + 1}">Next <i
                    class="fas fa-chevron-right"></i></a>
        </c:if>
    </div>
</div>
<jsp:include page="/templates/footer.jsp"/>

</body>
</html>
