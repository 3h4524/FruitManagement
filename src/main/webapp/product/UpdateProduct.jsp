<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Update Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }
        table {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            margin-top: 10px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
        }
        button:hover {
            background-color: #0056b3;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<h2>Update Product - ${product.name}</h2>

<form action="products" method="post">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="productId" value="${product.id}"/>

    <label>Name:</label>
    <input type="text" name="name" value="${product.name}" required/>

    <label>Description:</label>
    <textarea name="description" required>${product.description}</textarea>

    <label>Image URL:</label>
    <input type="text" name="imageURL" value="${product.imageURL}" required/>
    <a href="${product.imageURL}" target="_blank">View Image</a>
    <label>Import Date:</label>
    <input type="date" name="importDate" value="${product.importDate}" required/>

    <label>Size, Price & Quantity:</label>
    <table>
        <tr>
            <th>Size</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Action</th>
        </tr>
        <c:forEach var="entry" items="${productVariants}">
            <tr>
                <td><input type="text" name="sizes" value="${entry.key.size}" required/></td>
                <td><input type="number" name="prices" value="${entry.key.price}" required/></td>
                <td><input type="number" name="quantities" value="${entry.value}" required/></td>
                <td><button type="button" onclick="removeRow(this)">Remove</button></td>
            </tr>
        </c:forEach>
    </table>
    <button type="button" onclick="addRow()">Add Size</button>

    <input type="submit" value="Update Product"/>
</form>

<script>
    function addRow() {
        let table = document.querySelector("table");
        let newRow = table.insertRow();
        newRow.innerHTML = `
            <td><input type="text" name="sizes" required/></td>
            <td><input type="number" name="prices" required/></td>
            <td><input type="number" name="quantities" required/></td>
            <td><button type="button" onclick="removeRow(this)">Remove</button></td>
        `;
    }

    function removeRow(button) {
        button.parentElement.parentElement.remove();
    }
</script>
</body>
</html>
