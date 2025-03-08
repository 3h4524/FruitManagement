<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/03/2025
  Time: 11:47 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý địa chỉ</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap/bootstrap.min.css">
    <script src="<%= request.getContextPath()%>/js/bootstrap/bootstrap.bundle.min.js"></script>
</head>
<body>
<c:set var="customer" value="${sessionScope.customer}"/>
<c:set var="addresses" value="${customer.address}"/>
<div class="container mt-4">
<c:choose>
    <!-- Nếu chưa có địa chỉ -->
    <c:when test="${empty addresses}">
        <a href="UserCreateAddress.jsp">Thêm địa chỉ mới</a>
    </c:when>
    <c:otherwise>

    </c:otherwise>
</div>
</body>
</html>
