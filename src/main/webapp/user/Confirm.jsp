<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="type" value="${param.type}" />

<c:if test="${type == 'updateUser'}">
    <jsp:useBean id="user" class="model.User" scope="session"/>
    <jsp:setProperty name="user" property="*"/>
</c:if>
<c:if test="${type == 'updateProfile'}">
    <jsp:useBean id="UserLogin" class="model.User" scope="session"/>
    <jsp:setProperty name="UserLogin" property="*"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận thông tin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        }

        body {
            background-color: #f8f9fa;
            color: var(--text-color);
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }

        .card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .card-header {
            background-color: var(--primary-color);
            color: var(--white);
            border-bottom: none;
            padding: 20px;
        }

        .card-title {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 0;
            position: relative;
            display: inline-block;
        }

        .card-title::after {
            content: "";
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background-image: linear-gradient(to right, var(--primary-light), var(--primary-color));
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background-color: rgba(46, 139, 87, 0.1);
            color: var(--primary-dark);
            font-weight: 600;
            border-color: var(--border-color);
        }

        .table td {
            border-color: var(--border-color);
            padding: 16px;
        }

        .btn {
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(46, 139, 87, 0.2);
        }

        .btn-outline-secondary {
            color: #6c757d;
            border-color: #6c757d;
        }

        .btn-outline-secondary:hover {
            background-color: #6c757d;
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(108, 117, 125, 0.2);
        }

        .page-header {
            padding: 20px 0;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="page-header">
        <h2 class="page-title text-center">Xác nhận thông tin</h2>
    </div>

    <div class="card shadow">
        <div class="card-header bg-white">
            <h4 class="card-title"><i class="fas fa-user me-2"></i>Thông tin người dùng</h4>
        </div>
        <div class="card-body p-4">
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <th width="30%">Email:</th>
                    <td>${type == 'updateUser' ? user.email : UserLogin.email}</td>
                </tr>
                <tr>
                    <th>Tên tài khoản:</th>
                    <td>${type == 'updateUser' ? user.name : UserLogin.name}</td>
                </tr>
                <tr>
                    <th>Số điện thoại:</th>
                    <td>${type == 'updateUser' ? user.phone : UserLogin.phone}</td>
                </tr>
                <tr>
                    <th>Địa chỉ:</th>
                    <td>${type == 'updateUser' ? user.address : UserLogin.address}</td>
                </tr>
                </tbody>
            </table>

            <div class="d-flex justify-content-center mt-4">
                <form action="${pageContext.request.contextPath}/users?action=update&type=${type}" method="post">
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="fas fa-save me-2"></i>Lưu
                    </button>
                </form>
                <a href="javascript:window.history.back();" class="btn btn-outline-secondary px-4 ms-3">
                    <i class="fas fa-times me-2"></i>Hủy
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>