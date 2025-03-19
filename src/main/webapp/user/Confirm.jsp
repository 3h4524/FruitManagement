<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="type" value="${param.type}" />

    <c:if test="${type == 'updateUser'}">
        <jsp:useBean id="user" class="model.User" scope="session"/>
        <jsp:setProperty name="user" property="*"/>
    </c:if>
    <c:if test="${type == 'updateProfile'}">
        <jsp:useBean id="UserLogin" class="model.User" scope="session"/>
        <jsp:setProperty name="UserLogin" property="*"/>
    </c:if>

<html>
<head>
    <title>Xác nhận</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-lg p-4">
        <h2 class="text-center text-primary">Thông tin người dùng</h2>
        <table class="table table-bordered mt-3">
            <tbody>
            <tr>
                <th class="bg-light">Email:</th>
                <td>${type == 'updateUser' ? user.email : UserLogin.email}</td>
            </tr>
            <tr>
                <th class="bg-light">Tên tài khoản:</th>
                <td>${type == 'updateUser' ? user.name : UserLogin.name}</td>
            </tr>
            <tr>
                <th class="bg-light">Số điện thoại:</th>
                <td>${type == 'updateUser' ? user.phone : UserLogin.phone}</td>
            </tr>
            <tr>
                <th class="bg-light">Địa chỉ:</th>
                <td>${type == 'updateUser' ? user.address : UserLogin.address}</td>
            </tr>
            </tbody>
        </table>

        <div class="d-flex justify-content-center mt-4">
            <form action="${pageContext.request.contextPath}/users?action=update&type=${type}" method="post">
                <button type="submit" class="btn btn-success px-4">Lưu</button>
            </form>
            <a href="javascript:window.history.back();" class="btn btn-secondary px-4 ms-3">Hủy</a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
