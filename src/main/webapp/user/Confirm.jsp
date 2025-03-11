<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="user" class="model.User" scope="session"/>
<jsp:setProperty name="user" property="*"/>

<html>
<head>
    <title>Thông tin người dùng</title>
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
                <td>${user.email}</td>
            </tr>
            <tr>
                <th class="bg-light">Tên tài khoản:</th>
                <td>${user.name}</td>
            </tr>
            <tr>
                <th class="bg-light">Số điện thoại:</th>
                <td>${user.phone}</td>
            </tr>
            <tr>
                <th class="bg-light">Địa chỉ:</th>
                <td>${user.address}</td>
            </tr>
            </tbody>
        </table>

        <div class="d-flex justify-content-center mt-4">
            <form action="${pageContext.request.contextPath}/users?action=update" method="post">
                <button type="submit" class="btn btn-success px-4">Lưu</button>
            </form>
            <a href="javascript:window.history.back();" class="btn btn-secondary px-4 ms-3">Hủy</a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
