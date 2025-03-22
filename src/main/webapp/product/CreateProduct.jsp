<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
    <style>
        :root {
            --primary: #4361ee;
            --primary-hover: #3a56d4;
            --secondary: #2b2d42;
            --success: #2ecc71;
            --success-hover: #27ae60;
            --danger: #e74c3c;
            --danger-hover: #c0392b;
            --light-gray: #f8f9fa;
            --border: #e1e4e8;
            --text: #333;
            --text-light: #666;
            --white: #ffffff;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 8px 15px rgba(0, 0, 0, 0.15);
            --radius: 8px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: var(--light-gray);
            color: var(--text);
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }

        h1, h2 {
            color: var(--secondary);
            margin: 30px 0;
            font-weight: 600;
            text-align: center;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 15px;
            display: flex;
            justify-content: center;
        }

        .form-box {
            background: var(--white);
            padding: 30px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            width: 100%;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px;
        }

        th {
            text-align: left;
            padding: 5px;
            font-weight: 500;
            color: var(--secondary);
            width: 30%;
            vertical-align: top;
        }

        td {
            padding: 5px;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            font-size: 16px;
            font-family: 'Poppins', Arial, sans-serif;
            transition: border 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }

        .btn {
            display: inline-block;
            padding: 12px 20px;
            background: var(--primary);
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
            width: 100%;
            margin-top: 15px;
        }

        .btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        a {
            color: var(--primary);
            text-decoration: none;
            display: inline-block;
            margin: 15px 0;
            text-align: center;
            width: 100%;
            transition: all 0.3s ease;
        }

        a:hover {
            color: var(--primary-hover);
        }

        .message {
            text-align: center;
            margin: 10px 0;
            padding: 10px;
            border-radius: var(--radius);
        }

        .success {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success);
        }

        .error {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
        }

        /* Modal styling */
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
            z-index: 1000;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background: var(--white);
            padding: 30px;
            border-radius: var(--radius);
            width: 90%;
            max-width: 500px;
            text-align: left;
            box-shadow: var(--shadow-hover);
        }

        .modal-content h2 {
            margin-top: 0;
            text-align: center;
        }

        .modal-content p {
            margin: 10px 0;
            line-height: 1.6;
        }

        .modal-content p b {
            color: var(--secondary);
        }

        .close {
            color: var(--danger);
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .close:hover {
            color: var(--danger-hover);
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 25px;
        }

        .confirm {
            background: var(--success);
            color: var(--white);
            padding: 10px 20px;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-weight: 500;
            font-family: 'Poppins', Arial, sans-serif;
            transition: all 0.3s ease;
        }

        .confirm:hover {
            background: var(--success-hover);
            transform: translateY(-2px);
        }

        .cancel {
            background: var(--danger);
            color: var(--white);
            padding: 10px 20px;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-weight: 500;
            font-family: 'Poppins', Arial, sans-serif;
            transition: all 0.3s ease;
        }

        .cancel:hover {
            background: var(--danger-hover);
            transform: translateY(-2px);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .form-box {
                padding: 20px 15px;
            }

            table {
                border-spacing: 0 10px;
            }

            th, td {
                display: block;
                width: 100%;
                padding: 3px 0;
            }

            th {
                font-weight: 600;
            }

            input, button, .btn {
                padding: 10px;
                font-size: 14px;
            }

            .modal-content {
                padding: 20px;
                width: 95%;
            }
        }
    </style>
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
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<h1>Product Management</h1>

<c:if test="${not empty message}">
    <div class="message success">${message}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="message error">${error}</div>
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
                    <td><input type="text" id="size" name="size" required/></td>
                </tr>
                <tr>
                    <th>Description:</th>
                    <td><input type="text" id="description" name="description" required/></td>
                </tr>
                <tr>
                    <th>Stock:</th>
                    <td><input type="number" id="stock" name="stock" required/></td>
                </tr>
                <tr>
                    <th>Image URL:</th>
                    <td><input type="text" id="imageURL" name="imageURL"/></td>
                </tr>
                <tr>
                    <th>Import Date:</th>
                    <td><input type="datetime-local" id="importDate" name="importDate" required/></td>
                </tr>
            </table>
            <button type="button" class="btn" onclick="showConfirmation()">Create Product</button>
        </form>
    </div>
</div>

<a href="${pageContext.request.contextPath}/products">← Back to Product List</a>

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
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>