<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="service.Utils" %>

<head>
    <title>Order List</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center text-primary">Order List</h2>

    <table class="table table-bordered table-hover table-striped text-center shadow">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>Customer Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Order Date</th>
            <th>Status</th>
            <th>Total Amount</th>
            <th>Order Detail</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}" varStatus="status">
            <tr>
                <td>${(currentPage - 1) * pageSize + status.index + 1}</td>
                <td>${order.userName}</td>
                <td>${order.userPhone}</td>
                <td>${order.userAddress}</td>
                <td>${Utils.formatTimestamp(order.orderDate)}</td>
                <td>${order.status}</td>
                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VND"/></td>
                <td><a href="${pageContext.request.contextPath}/order?action=detail&orderId=${order.orderId}">Detail</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 2}">
                <li class="page-item"><a class="page-link" href="order?action=listOrder&page=1&pageSize=${pageSize}">1</a></li>
                <li class="page-item disabled"><span class="page-link">...</span></li>
            </c:if>

            <c:if test="${currentPage > 1}">
                <li class="page-item"><a class="page-link" href="order?action=listOrder&page=${currentPage - 1}&pageSize=${pageSize}">${currentPage - 1}</a></li>
            </c:if>

            <li class="page-item active"><span class="page-link">${currentPage}</span></li>

            <c:if test="${hasNext}">
                <li class="page-item"><a class="page-link" href="order?action=listOrder&page=${currentPage + 1}&pageSize=${pageSize}">${currentPage + 1}</a></li>
            </c:if>
        </ul>
    </nav>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>