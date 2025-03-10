<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <script>
        function showConfirmation() {
            const fields = ["name", "price", "size", "description", "stock", "importDate"];
            for (let field of fields) {
                if (document.getElementById(field).value.trim() === "") {
                    alert("Please fill in all required fields!");
                    return;
                }
            }
            document.getElementById("confirmName").innerText = document.getElementById("name").value;
            document.getElementById("confirmPrice").innerText = document.getElementById("price").value;
            document.getElementById("confirmSize").innerText = document.getElementById("size").value;
            document.getElementById("confirmDescription").innerText = document.getElementById("description").value;
            document.getElementById("confirmStock").innerText = document.getElementById("stock").value;
            document.getElementById("confirmImageURL").innerText = document.getElementById("imageURL").value || "N/A";
            document.getElementById("confirmImportDate").innerText = document.getElementById("importDate").value;
            document.getElementById("confirmationModal").classList.add("show");
        }

        function closeModal() {
            document.getElementById("confirmationModal").classList.remove("show");
        }

        function submitForm() {
            document.getElementById("productForm").submit();
        }

    </script>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            text-align: center;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        h1 { margin: 20px 0; color: #343a40; }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: auto;
            padding: 20px;
        }
        .form-box {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 50%;
        }
        table {
            width: 100%;
            border-spacing: 10px;
        }
        th { text-align: left; }
        input {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }
        .btn {
            background-color: #007BFF;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .btn:hover { background-color: #0056b3; }
        .modal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
        .modal.show { display: flex; }
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 12px;
            width: 40%;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .close {
            color: red;
            font-size: 28px;
            cursor: pointer;
            float: right;
        }
        .buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 15px;
        }
        .confirm {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .confirm:hover { background-color: #218838; }
        .cancel {
            background-color: #dc3545;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .cancel:hover { background-color: #c82333; }
    </style>
</head>
<body>
<h1>Product Management</h1>

<c:if test="${not empty message}">
    <p style="color:green;">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<div class="container">
    <div class="form-box">
        <form id="productForm" action="products" method="post">
            <input type="hidden" name="action" value="create"/>
            <table>
                <tr>
                    <th>Product Name:</th>
                    <td><input type="text" id="name" name="name" required/></td>
                </tr>
                <tr>
                    <th>Price:</th>
                    <td><input type="number" id="price" name="price" step="0.01" required/></td>
                </tr>
                <tr>
                    <th>Size:</th>
                    <td><input type="text" id="size" name="size"required/></td>
                </tr>
                <tr>
                    <th>Description:</th>
                    <td><input type="text" id="description" name="description" required/></td>
                </tr>
                <tr>
                    <th>Stock:</th>
                    <td><input type="number" id="stock" name="stock"required/></td>
                </tr>
                <tr>
                    <th>ImgURL:</th>
                    <td><input type="text" id="imageURL" name="imageURL"/></td>
                </tr>
                <tr>
                    <th>Import Date:</th>
                    <td><input type="date" id="importDate" name="importDate" required/></td>
                </tr>
            </table>
            <button type="button" class="btn" onclick="showConfirmation()">Create Product</button>
        </form>
    </div>
</div>

<p><a href="${pageContext.request.contextPath}/products">← Back to Product List</a></p>

<div id="confirmationModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Confirm Product Details</h2>
        <p><b>Product Name:</b> <span id="confirmName"></span></p>
        <p><b>Price:</b> <span id="confirmPrice"></span></p>
        <p><b>Size:</b> <span id="confirmSize"></span></p>
        <p><b>Description:</b> <span id="confirmDescription"></span></p>
        <p><b>Stock:</b> <span id="confirmStock"></span></p>
        <p><b>Image URL:</b> <span id="confirmImageURL"></span></p>
        <p><b>Import Date:</b> <span id="confirmImportDate"></span></p>
        <div class="buttons">
            <button class="confirm" onclick="submitForm()">Confirm</button>
            <button class="cancel" onclick="closeModal()">Cancel</button>
        </div>
    </div>
</div>
</body>
</html>
