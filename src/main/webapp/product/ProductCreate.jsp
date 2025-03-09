<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
</head>
<body>
<center>
    <h1>Product Management</h1>
    <form action="confirm.jsp" method="post">
        <table border="1" cellpadding="5">
            <tr><th>Product Name:</th><td><input type="text" name="name" required/></td></tr>
            <tr><th>Price:</th><td><input type="number" name="price" step="0.01" required/></td></tr>
            <tr><th>Description:</th><td><input type="text" name="description" required/></td></tr>
            <tr><th>Stock:</th><td><input type="number" name="stock" required/></td></tr>
            <tr><th>ImgURL:</th><td><input type="text" name="ImageURL"/></td></tr>
            <tr><th>Date:</th><td><input type="Date" name="importDate" required/></td></tr>
            <tr><td colspan="2" align="center"><input type="submit" value="Next"/></td></tr>
        </table>
    </form>
</center>
</body>
</html>
