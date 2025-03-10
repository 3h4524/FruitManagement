<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 10/03/2025
  Time: 4:56 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="user" class="model.User" scope="session"/>
<jsp:setProperty name="user" property="*"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Thông tin sản phẩm vừa nhập:</h2>
Email: ${user.email} <br>
Tên đăng nhập: ${user.name} <br>
Số điện thoại: ${user.phone}<br>
Địa chỉ: ${user.address} <br>
<form action="${pageContext.request.contextPath}/users?action=update" method="post">
  <input type="submit" value="Lưu"/>
</form>
</body>
</html>
