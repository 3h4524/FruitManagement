<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/8/2025
  Time: 12:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="product" class="model.Product" scope="session"/>
<jsp:setProperty name="product" property="*"/>

<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Product</title>
</head>
<body>
<Center>
    <h1>Confirm Product</h1>
    <table border="1">
        <tr>
            <th>Product Name:</th>
            <td>${product.name}</td>
        </tr>
        <tr>
            <th>Price:</th>
            <td>${product.price}</td>
        </tr>
        <tr>
            <th>Description:</th>
            <td>${product.description}</td>
        </tr>
        <tr>
            <th>Stock:</th>
            <td>${product.stock}</td>
        </tr>
        <tr>
            <th>Date Added:</th>
            <td>${product.importDate != null ? product.importDate : "N/A"}</td>
        </tr>
    </table>
    <br>
    <form action="${pageContext.Request.ContextPath}/products" method="post">
        <input type="hidden" name="action" value="create"/>
        <input type="submit" value="Save"/>
    </form>

    <br>
    <a href="ProductCreate.jsp"></a>
</Center>

</body>
</html>
