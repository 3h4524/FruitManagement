<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 10/03/2025
  Time: 4:56 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="UserLogin" class="model.User" scope="session"/>
<jsp:setProperty name="UserLogin" property="*"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Thông tin sản phẩm vừa nhập:</h2>
Name: ${UserLogin.name} <br>
Price: ${UserLogin.email} <br>
<form action="${pageContext.request.contextPath}/registers" method="post">
  <input type="submit" value="Submit"/>
</form>
</body>
</html>
