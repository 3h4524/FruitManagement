<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 10 Best-Selling Orders</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Roboto, Arial, sans-serif;
            font-size: 16px; /* Increased base font size */
        }
        .page-header {
            padding: 25px 0 20px; /* Increased padding */
            background-color: var(--white);
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px; /* Increased margin */
        }

        .page-title {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 0;
            position: relative;
            display: inline-block;
            font-size: 2rem; /* Increased title size */
        }

        .page-title::after {
            content: "";
            position: absolute;
            bottom: -8px; /* Increased spacing */
            left: 0;
            width: 70px; /* Increased line width */
            height: 3px; /* Increased thickness */
            background-image: linear-gradient(to right, var(--primary-light), var(--primary-color));
        }

        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-top: 12px; /* Increased margin */
            font-size: 1rem; /* Increased breadcrumb font size */
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }
        .container {
            margin-top: 30px; /* Increased margin-top */
        }
        .table thead th {
            background-color: #2e8b57;
            color: white;
            text-align: center;
            font-size: 1.1rem; /* Increased table header font size */
            padding: 12px; /* Increased padding for larger cells */
        }
        .table tbody td {
            text-align: center;
            font-size: 1.05rem; /* Increased table cell font size */
            padding: 10px; /* Increased padding for larger cells */
        }
        .table {
            width: 100%; /* Increased table width to full width */
            margin: 0 auto;
        }
        h2.text-center {
            font-size: 1.8rem; /* Increased "Top 10 Best-Selling Orders" title size */
            margin-bottom: 20px; /* Added more space below the title */
        }
        .btn {
            font-size: 1rem; /* Increased button font size */
            padding: 8px 16px; /* Increased button size */
        }
        .card {
            margin-bottom: 30px; /* Added more space below the card */
        }
        .table-responsive {
            padding: 10px; /* Added padding inside the table container */
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="page-title">Order List</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?action=find"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">topOrders</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <h2 class="text-center text-success my-4">Top 10 Best-Selling Orders</h2>
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Size</th>
                        <th>Total Ordered Quantity</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${topOrders}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td> <!-- STT -->
                            <td>${order[0]}</td> <!-- Product Name -->
                            <td>${order[1]}</td> <!-- Size -->
                            <td>${order[2]}</td> <!-- Total Ordered Quantity -->
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
            <i class="fas fa-arrow-left"></i> Back to Order List
        </a>
    </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>