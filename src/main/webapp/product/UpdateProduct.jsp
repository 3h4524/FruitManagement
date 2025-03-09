<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
<center>
    <h1>Products Management</h1>
    <h2>
        <a href="//products?action=products">List All Products</a>
    </h2>
</center>
<%
    if (request.getAttribute("error") != null) {
        String error = (String) request.getAttribute("error");
%>
<script>alert("<%= error %>");</script>
<%
    }
%>
<div align="center">
    <form method="post">
        <table border="1" cellpadding="5">
            <caption>
                <h2>
                    Edit Products
                </h2>
            </caption>
            <c:set var="product" value="${requestScope.product}"/>
            <c:if test="${product != null}">
                <input type="hidden" name="id" value="<c:out
                               value='${product.id}' />"/>
            </c:if>
            <tr>
                <th>Product Name:</th>
                <td>
                    <input type="text" name="name" size="45"
                           value="<c:out value='${product.name}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Price:</th>
                <td>
                    <input type="text" name="price" size="45"
                           value="<c:out value='${product.price}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Description</th>
                <td>
                    <input type="text" name="description" size="45"
                           value="<c:out value='${product.description}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Stock</th>
                <td>
                    <input type="text" name="stock" size="15"
                           value="<c:out value='${product.stock}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Import Date</th>
                <td>
                    <input type="datetime-local" name="import_date" size="45"
                           value="<c:out value='${product.importDate}' />"
                    />
                </td>
            </tr>
            <tr>

                <td colspan="2" align="center">
                    <input type="submit" value="Save"/>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
