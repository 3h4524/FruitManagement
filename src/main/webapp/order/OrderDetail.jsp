<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System | Order Details</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
            intent="WELCOME"
            chat-title="FruitShopBot"
            agent-id="17a68f67-ccc6-4fe8-ab13-0d52e4591475"
            language-code="vi"
    ></df-messenger>
    <!-- Custom Styles -->
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

        /* Main Content Area */
        .main-content {
            padding: 30px 0;
        }

        .page-header {
            padding: 30px 0 20px;
            background-color: var(--white);
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .page-title {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 0;
            position: relative;
            display: inline-block;
        }

        .page-title::after {
            content: "";
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 60px;
            height: 3px;
            background-image: linear-gradient(to right, var(--primary-light), var(--primary-color));
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-top: 10px;
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .card-header {
            background-color: var(--white);
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 20px;
        }

        .card-header h5 {
            margin-bottom: 0;
            font-weight: 600;
            color: var(--primary-dark);
        }

        .card-body {
            padding: 0;
        }

        /* Table Styling */
        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background-color: var(--primary-color);
            color: var(--white);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            padding: 16px;
            letter-spacing: 0.5px;
            border: none;
            border-bottom: 2px solid rgba(255,255,255,0.1);
            text-align: center; /* Center all header text */
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            border-color: var(--border-color);
            color: var(--text-color);
            font-weight: 500;
            text-align: center; /* Center all body text */
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(46, 139, 87, 0.03);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(46, 139, 87, 0.08);
            transition: all 0.3s ease;
        }

        /* Buttons */
        .btn {
            padding: 10px 20px;
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

        /* Responsive */
        @media (max-width: 992px) {
            .stats-card {
                margin-bottom: 15px;
            }
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 20px 0 15px;
            }

            .table thead th {
                font-size: 12px;
                padding: 12px 10px;
            }

            .table tbody td {
                padding: 12px 10px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="page-title">Order Details</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?action=find"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/order?action=listOrder">Orders</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Order Details</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="container">
        <!-- Order Details Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5><i class="fas fa-clipboard-list me-2"></i>Order Details</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>PRODUCT NAME</th>
                            <th>SIZE</th>
                            <th>PRICE</th>
                            <th>QUANTITY</th>
                            <th>TOTAL PRICE</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="orderDetail" items="${orderDetails}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${orderDetail.productName}</td>
                                <td>${orderDetail.size}</td>
                                <td>
                                    <fmt:formatNumber value="${orderDetail.price}" type="currency" currencySymbol="VND"/>
                                </td>
                                <td>${orderDetail.quantity}</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${orderDetail.price * orderDetail.quantity}" type="currency" currencySymbol="VND"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/order?action=listOrder" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Order List
            </a>
        </div>
    </div>
</div>

<jsp:include page="/templates/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>