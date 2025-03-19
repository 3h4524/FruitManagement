<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<head>
    <title>Order Details</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-center text-primary">Order Details</h2>

    <table class="table table-bordered table-hover table-striped text-center shadow">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>Product Name</th>
            <th>Size</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="orderDetail" items="${orderDetails}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${orderDetail.productName}</td>
                <td>${orderDetail.size}</td>
                <td><fmt:formatNumber value="${orderDetail.price}" type="currency" currencySymbol="VND"/></td>
                <td>${orderDetail.quantity}</td>
                <td>
                    <fmt:formatNumber value="${orderDetail.price * orderDetail.quantity}" type="currency" currencySymbol="VND"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="text-center mt-3">
        <a href="${pageContext.request.contextPath}/order?action=listOrder" class="btn btn-secondary">Back to Order List</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
