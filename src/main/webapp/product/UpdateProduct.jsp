<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Product</title>
</head>
<body>
<h2>Update Product - ${product.name}</h2>

<p><strong>Product ID:</strong> ${product.id}</p>
<p><strong>Description:</strong> ${product.description}</p>
<p><strong>Image URL:</strong> <a href="${product.imageURL}" target="_blank">View Image</a></p>
<p><strong>Import Date:</strong> ${product.importDate}</p>

<label>Size:</label>
<select id="sizeSelect">
    <option value="">-- Chọn size --</option>
    <c:forEach var="variant" items="${productVariants}">
        <option value="${variant.size}" data-price="${variant.price}">${variant.size}</option>
    </c:forEach>
</select>

<p><strong>Selected Price:</strong> <span id="price">Chưa chọn</span></p>

<script>
    document.getElementById("sizeSelect").addEventListener("change", function() {
        let selectedOption = this.options[this.selectedIndex];
        let price = selectedOption.getAttribute("data-price");
        document.getElementById("price").innerText = price ? price + " VND" : "Chưa chọn";
    });
</script>
</body>
</html>
