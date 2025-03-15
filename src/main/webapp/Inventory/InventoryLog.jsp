<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="service.Utils" %>


<html>
<head>
    <title>Inventory Log</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center text-primary">Inventory Log</h2>

    <table class="table table-bordered table-hover table-striped text-center shadow">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>Product Name</th>
            <th>Size</th>
            <th>Quantity Changed</th>
            <th>Action Type</th>
            <th>Action Date</th>
            <th>Store Location</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="log" items="${logs}" varStatus="status">
            <tr>
                <td>${(currentPage - 1) * pageSize + status.index + 1}</td>
                <td>${log.productName}</td>
                <td>${log.size}</td>
                <td>${log.quantityChanged}</td>
                <td>${log.actionType}</td>
                <td>${Utils.formatTimestamp(log.actionDate)}</td>
                <td>${log.storeLocation}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${currentPage > 2}">
                <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=1&pageSize=${pageSize}">1</a></li>
                <li class="page-item disabled"><span class="page-link">...</span></li>
            </c:if>

            <c:if test="${currentPage > 1}">
                <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=${currentPage - 1}&pageSize=${pageSize}">${currentPage - 1}</a></li>
            </c:if>

            <li class="page-item active"><span class="page-link">${currentPage}</span></li>

            <c:if test="${hasNextPage}">
                <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=${currentPage + 1}&pageSize=${pageSize}">${currentPage + 1}</a></li>
            </c:if>
        </ul>
    </nav>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
