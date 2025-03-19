<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Update Product</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #2e8b57;
            --primary-light: #3c9d74;
            --primary-dark: #247048;
            --accent-color: #FFA500;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #fff;
            --border-color: #e0e0e0;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 8px 15px rgba(0, 0, 0, 0.15);
            --radius: 8px;
            --danger: #e74c3c;
            --danger-hover: #c0392b;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: var(--light-gray);
            color: var(--text-color);
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }

        h2 {
            color: var(--primary-color);
            margin: 30px 0;
            font-weight: 600;
            text-align: center;
            position: relative;
            padding-bottom: 10px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 3px;
            background-color: var(--primary-color);
            border-radius: 2px;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 15px;
        }

        form {
            background: var(--white);
            padding: 30px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            max-width: 800px;
            margin: auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: 500;
            display: block;
            margin: 15px 0 5px;
            color: var(--primary-dark);
            font-size: 15px;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin: 5px 0 5px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 16px;
            font-family: 'Poppins', Arial, sans-serif;
            transition: all 0.3s ease;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(60, 157, 116, 0.1);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        a {
            color: var(--primary-color);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            margin: 5px 0;
            transition: all 0.3s ease;
        }

        a i {
            margin-right: 5px;
        }

        a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 15px 0;
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border: 1px solid var(--border-color);
        }

        th {
            background: var(--primary-color);
            color: var(--white);
            font-weight: 500;
        }

        .btn, button, input[type="submit"] {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 20px;
            background: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            font-family: 'Poppins', Arial, sans-serif;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: var(--shadow);
        }

        .btn:hover, button:hover, input[type="submit"]:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .btn i, button i, input[type="submit"] i {
            margin-right: 8px;
        }

        input[type="submit"] {
            background: var(--accent-color);
            width: 100%;
            margin-top: 25px;
            font-weight: 600;
        }

        input[type="submit"]:hover {
            background: #e69500;
        }

        button[onclick="removeRow(this)"] {
            background: var(--danger);
            padding: 8px 12px;
            font-size: 14px;
        }

        button[onclick="removeRow(this)"]:hover {
            background: var(--danger-hover);
        }

        button[onclick="addRow()"] {
            margin: 15px 0;
            padding: 10px 16px;
        }

        .image-preview {
            margin-top: 10px;
            display: flex;
            align-items: center;
        }

        .image-preview a {
            margin-left: 10px;
        }

        .form-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .form-header h3 {
            color: var(--primary-color);
            font-weight: 600;
        }

        .form-header a {
            font-weight: 500;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            form {
                padding: 20px 15px;
            }

            input, textarea, button, .btn, input[type="submit"] {
                font-size: 14px;
                padding: 10px;
            }

            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="container">
    <h2>Update Product</h2>

    <form action="products" method="post">
        <div class="form-header">
            <h3><i class="fas fa-tag"></i> ${product.name}</h3>
            <a href="${pageContext.request.contextPath}/products" class="btn"><i class="fas fa-arrow-left"></i> Back to List</a>
        </div>

        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="productId" value="${product.id}"/>

        <div class="form-group">
            <label for="name"><i class="fas fa-shopping-bag"></i> Name:</label>
            <input type="text" id="name" name="name" value="${product.name}" required/>
        </div>

        <div class="form-group">
            <label for="description"><i class="fas fa-align-left"></i> Description:</label>
            <textarea id="description" name="description" required>${product.description}</textarea>
        </div>

        <div class="form-group">
            <label for="imageURL"><i class="fas fa-image"></i> Image URL:</label>
            <input type="text" id="imageURL" name="imageURL" value="${product.imageURL}" required/>
            <div class="image-preview">
                <a href="${product.imageURL}" target="_blank"><i class="fas fa-external-link-alt"></i> View Image</a>
            </div>
        </div>

        <div class="form-group">
            <label for="importDate"><i class="fas fa-calendar-alt"></i> Import Date:</label>
            <input type="date" id="importDate" name="importDate" value="${product.importDate}" required/>
        </div>

        <div class="form-group">
            <label><i class="fas fa-list-alt"></i> Size, Price & Quantity:</label>
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
                        <td><button type="button" onclick="removeRow(this)"><i class="fas fa-trash"></i> Remove</button></td>
                    </tr>
                </c:forEach>
            </table>
            <button type="button" onclick="addRow()"><i class="fas fa-plus"></i> Add Size</button>
        </div>

        <input type="submit" value="Update Product"/>
    </form>
</div>

<script>
    function addRow() {
        let table = document.querySelector("table");
        let newRow = table.insertRow();
        newRow.innerHTML = `
            <td><input type="text" name="sizes" required/></td>
            <td><input type="number" name="prices" required/></td>
            <td><input type="number" name="quantities" required/></td>
            <td><button type="button" onclick="removeRow(this)"><i class="fas fa-trash"></i> Remove</button></td>
        `;
    }

    function removeRow(button) {
        // Instead of removing the row, set quantity to 0
        let row = button.parentElement.parentElement;
        let quantityInput = row.querySelector('input[name="quantities"]');
        quantityInput.value = 0;

        // Optionally, you can add a visual indication that the item is marked for zero quantity
        row.style.backgroundColor = "#ffeeee";

        // Change the button text to indicate it can be restored
        button.innerHTML = '<i class="fas fa-undo"></i> Restore';
        button.onclick = function() { restoreRow(this); };
    }

    function restoreRow(button) {
        // Restore the row to normal state
        let row = button.parentElement.parentElement;
        row.style.backgroundColor = "";

        // Reset the button to original state
        button.innerHTML = '<i class="fas fa-trash"></i> Remove';
        button.onclick = function() { removeRow(this); };

        // Clear the quantity field for user input
        let quantityInput = row.querySelector('input[name="quantities"]');
        quantityInput.value = "";
        quantityInput.focus();
    }

</script>
<jsp:include page="/templates/footer.jsp"/>

</body>
</html>