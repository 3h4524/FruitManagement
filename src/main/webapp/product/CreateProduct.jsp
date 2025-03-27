<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --secondary: #10b981;
            --background: #f4f4f5;
            --text-dark: #18181b;
            --text-light: #52525b;
            --border: #e4e4e7;
            --white: #ffffff;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 10px 15px rgba(0, 0, 0, 0.15);
            --radius: 12px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--text-dark);
            line-height: 1.6;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
            padding: 0 15px;
        }

        .card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 35px;
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-5px);
        }

        .form-title {
            text-align: center;
            color: var(--primary);
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-light);
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 16px;
            background-color: var(--white);
        }

        .btn {
            width: 100%;
            padding: 14px;
            background-color: var(--primary);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .btn:hover {
            background-color: var(--primary-hover);
            transform: translateY(-2px);
        }

        .back-link {
            display: block;
            text-align: center;
            color: var(--primary);
            text-decoration: none;
            margin-top: 20px;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: var(--primary-hover);
        }

        .message {
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .message.success {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--secondary);
        }

        .message.error {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        @media (max-width: 600px) {
            .container {
                margin: 20px auto;
            }

            .card {
                padding: 25px;
            }

            .form-title {
                font-size: 20px;
            }
        }

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

        .close {
            color: var(--text-light);
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close:hover {
            color: var(--text-dark);
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 25px;
        }

        .confirm, .cancel {
            padding: 10px 20px;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .confirm {
            background-color: var(--secondary);
            color: var(--white);
        }

        .confirm:hover {
            background-color: #0ca678;
        }

        .cancel {
            background-color: var(--danger, #ef4444);
            color: var(--white);
        }

        .cancel:hover {
            background-color: #dc2626;
        }

    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<div class="container">
    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <div class="card">
        <h1 class="form-title">Thêm Sản Phẩm Mới</h1>
        <form id="productForm" action="products" method="post">
            <input type="hidden" name="action" value="create"/>


            <div class="form-group">
                <label for="name" class="form-label">Tên sản phẩm</label>
                <input type="text" id="name" name="name" class="form-input" required/>
            </div>

            <div class="form-group">
                <label for="price" class="form-label">Giá</label>
                <input type="number" id="price" name="price" step="0.01" class="form-input" required/>
            </div>

            <div class="form-group">
                <label for="size" class="form-label">Kích thước</label>
                <input type="text" id="size" name="size" class="form-input" required/>
            </div>

            <div class="form-group">
                <label for="description" class="form-label">Mô tả</label>
                <input type="text" id="description" name="description" class="form-input" required/>
            </div>

            <div class="form-group">
                <label for="stock" class="form-label">Số lượng tồn kho</label>
                <input type="number" id="stock" name="stock" class="form-input" required/>
            </div>

            <div class="form-group">
                <label for="imageURL" class="form-label">Đường dẫn hình ảnh (tùy chọn)</label>
                <input type="text" id="imageURL" name="imageURL" class="form-input"/>
            </div>

            <div class="form-group">
                <label for="importDate" class="form-label">Ngày nhập hàng</label>
                <input type="datetime-local" id="importDate" name="importDate" class="form-input" required/>
            </div>

            <button type="button" class="btn" onclick="showConfirmation()">Tạo sản phẩm</button>
        </form>
    </div>

    <a href="${pageContext.request.contextPath}/products" class="back-link">← Quay lại danh sách sản phẩm</a>
</div>

<div id="confirmationModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Xác nhận thông tin sản phẩm</h2>
        <p><b>Tên sản phẩm:</b> <span id="confirmName"></span></p>
        <p><b>Giá:</b> <span id="confirmPrice"></span></p>
        <p><b>Kích thước:</b> <span id="confirmSize"></span></p>
        <p><b>Mô tả:</b> <span id="confirmDescription"></span></p>
        <p><b>Số lượng tồn kho:</b> <span id="confirmStock"></span></p>
        <p><b>Đường dẫn hình ảnh:</b> <span id="confirmImageURL"></span></p>
        <p><b>Ngày nhập hàng:</b> <span id="confirmImportDate"></span></p>
        <div class="buttons">
            <button class="confirm" onclick="submitForm()">Xác nhận</button>
            <button class="cancel" onclick="closeModal()">Hủy</button>
        </div>
    </div>
</div>


<!-- Giữ nguyên phần script và modal từ code gốc -->
<script>
    function showConfirmation() {
        const fields = ["name", "price", "size", "description", "stock", "importDate"];
        for (let field of fields) {
            if (document.getElementById(field).value.trim() === "") {
                alert("Vui lòng điền đầy đủ thông tin!");
                return;
            }
        }
        document.getElementById("confirmName").innerText = document.getElementById("name").value;
        document.getElementById("confirmPrice").innerText = document.getElementById("price").value;
        document.getElementById("confirmSize").innerText = document.getElementById("size").value;
        document.getElementById("confirmDescription").innerText = document.getElementById("description").value;
        document.getElementById("confirmStock").innerText = document.getElementById("stock").value;
        document.getElementById("confirmImageURL").innerText = document.getElementById("imageURL").value || "Không có";
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
<jsp:include page="/templates/footer.jsp"/>
</body>
</html>