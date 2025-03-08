<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 3/8/2025
  Time: 12:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }

        h1 {
            color: #333;
        }

        .product-info {
            margin: 10px 0;
            font-size: 18px;
        }

        .price {
            color: #e74c3c;
            font-weight: bold;
        }

        .product-image {
            width: 100%;
            max-height: 250px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 10px;
        }

        form {
            margin-top: 15px;
        }

        input {
            width: 50px;
            text-align: center;
            font-size: 16px;
        }

        button {
            background: #27ae60;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        button:hover {
            background: #2ecc71;
        }

        .back {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #3498db;
            font-size: 16px;
        }

        .back:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Product Detail</h1>
    <c:set var="product" value="${requestScope.product}"/>
    <c:choose>
        <c:when test="${not empty product}">
            <img src="${product.imageURL}" alt="${product.name}" class="product-image">
            <p class="product-info"><strong>ID:</strong> ${product.id}</p>
            <p class="product-info"><strong>Name:</strong> ${product.name}</p>
            <p class="product-info price"><strong>Price:</strong>${product.price}VND</p>
            <p class="product-info"><strong>Description:</strong>${product.description}</p>

            <form action="/cart" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" value="1" min="1" required>
                <button type="submit">Buy Now</button>
            </form>
        </c:when>
        <c:otherwise>
            <p style="color:red;">Product not found.</p>
        </c:otherwise>
    </c:choose>
    <a href="/products" class="back">← Back to Products</a>
</div>

</body>
</html>
