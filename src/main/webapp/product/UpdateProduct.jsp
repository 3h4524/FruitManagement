<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <script>
        function showConfirmation() {
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
        body { font-family: Arial, sans-serif; text-align: center; background-color: #f4f4f4; }
        h1 { margin: 20px 0; }
        table { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
        input { width: 100%; padding: 8px; margin: 5px 0; border: 1px solid #ccc; border-radius: 5px; }
        input[type="button"] { background-color: #007BFF; color: white; padding: 10px; border: none; cursor: pointer; }
        input[type="button"]:hover { background-color: #0056b3; }
        .modal { display: none; position: fixed; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.4); justify-content: center; align-items: center; }
        .modal.show { display: flex; }
        .modal-content { background: white; padding: 20px; border-radius: 12px; text-align: center; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); width: 50%; }
        .close { color: red; font-size: 28px; cursor: pointer; float: right; }
        .buttons button { padding: 10px 20px; margin: 5px; border: none; cursor: pointer; }
        .confirm { background-color: #28a745; color: white; }
        .cancel { background-color: #dc3545; color: white; }
    </style>
</head>
<body>
<h1>Product Management</h1>
<center>
    <form id="productForm" action="products" method="post">
        <table border="0" cellpadding="5">
            <tr><th>Product Name:</th><td><input type="text" id="name" name="name" required/></td></tr>
            <tr><th>Price:</th><td><input type="number" id="price" name="price" step="0.01" required/></td></tr>
            <tr><th>Size:</th><td><input type="text" id="size" name="size" required/></td></tr>
            <tr><th>Description:</th><td><input type="text" id="description" name="description" required/></td></tr>
            <tr><th>Stock:</th><td><input type="number" id="stock" name="stock" required/></td></tr>
            <tr><th>ImgURL:</th><td><input type="text" id="imageURL" name="ImageURL"/></td></tr>
            <tr><th>Date:</th><td><input type="date" id="importDate" name="importDate" required/></td></tr>
            <tr><td colspan="2" align="center"><input type="button" value="Next" onclick="showConfirmation()"/></td></tr>
        </table>
    </form>
</center>
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
