<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="service.Utils" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System | Log</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            border-color: var(--border-color);
            color: var(--text-color);
            font-weight: 500;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(46, 139, 87, 0.03);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(46, 139, 87, 0.08);
            transition: all 0.3s ease;
        }

        /* Status Badges */
        .badge {
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 30px;
        }

        .badge-add {
            background-color: #dff7ee;
            color: #25a56a;
        }

        .badge-remove {
            background-color: #ffebef;
            color: #ff617d;
        }

        .badge-adjust {
            background-color: #fff4e5;
            color: #ffa426;
        }

        /* Pagination */
        .pagination {
            margin-top: 30px;
            margin-bottom: 10px;
        }

        .page-item {
            margin: 0 3px;
        }

        .page-link {
            border-radius: 6px;
            padding: 10px 16px;
            color: var(--primary-color);
            border: 1px solid rgba(46, 139, 87, 0.2);
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .page-link:hover {
            background-color: var(--primary-light);
            color: var(--white);
            border-color: var(--primary-light);
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(46, 139, 87, 0.15);
        }

        .page-item.active .page-link {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            box-shadow: 0 5px 10px rgba(46, 139, 87, 0.2);
        }

        .page-item.disabled .page-link {
            color: #6c757d;
            border-color: #dee2e6;
        }

        /* Filters and Controls */
        .controls-area {
            padding: 20px;
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            margin-bottom: 30px;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            border-color: var(--border-color);
            box-shadow: none;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(46, 139, 87, 0.1);
        }

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

        /* Footer */
        .app-footer {
            background-color: var(--white);
            border-top: 1px solid var(--border-color);
            padding: 20px 0;
            margin-top: 40px;
        }

        /* Stats Cards */
        .stats-card {
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            background: linear-gradient(145deg, #fff, #f5f5f5);
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }

        .stats-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: rgba(46, 139, 87, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .stats-icon i {
            font-size: 24px;
            color: var(--primary-color);
        }

        .stats-info h3 {
            font-size: 20px;
            color: var(--primary-dark);
            margin-bottom: 5px;
            font-weight: 700;
        }

        .stats-info p {
            margin-bottom: 0;
            color: #6c757d;
            font-size: 14px;
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

            .controls-area {
                padding: 15px;
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
                <h2 class="page-title">Inventory Log</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?action=find"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="inventory">Inventory</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Log History</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="container">

        <!-- Inventory Log Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5><i class="fas fa-history me-2"></i>Inventory Log History</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-striped text-center">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Product Name</th>
                            <th>Size</th>
                            <th>Quantity Changed</th>
                            <th>Action Type</th>
                            <th>Action Date</th>
                            <th>Store Location</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="log" items="${logs}" varStatus="status">
                            <tr>
                                <td>${(currentPage - 1) * pageSize + status.index + 1}</td>
                                <td class="text-start">${log.productName}</td>
                                <td>${log.size}</td>
                                <td class="fw-bold">
                                    <c:choose>
                                        <c:when test="${log.actionType eq 'Add'}">+${log.quantityChanged}</c:when>
                                        <c:when test="${log.actionType eq 'Remove'}">-${log.quantityChanged}</c:when>
                                        <c:otherwise>${log.quantityChanged}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${log.actionType eq 'Add'}">
                                                <span class="badge badge-add">
                                                    <i class="fas fa-plus-circle me-1"></i> Add
                                                </span>
                                        </c:when>
                                        <c:when test="${log.actionType eq 'Remove'}">
                                                <span class="badge badge-remove">
                                                    <i class="fas fa-minus-circle me-1"></i> Remove
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="badge badge-adjust">
                                                    <i class="fas fa-sync-alt me-1"></i> Adjust
                                                </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${Utils.formatTimestamp(log.actionDate)}</td>
                                <td>${log.storeLocation}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="inventory?action=pagination&page=${currentPage - 1}&pageSize=${pageSize}" aria-label="Previous">
                            <span aria-hidden="true"><i class="fas fa-chevron-left"></i></span>
                        </a>
                    </li>
                </c:if>

                <c:if test="${currentPage > 2}">
                    <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=1&pageSize=${pageSize}">1</a></li>
                    <c:if test="${currentPage > 3}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    </c:if>
                </c:if>

                <c:if test="${currentPage > 1}">
                    <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=${currentPage - 1}&pageSize=${pageSize}">${currentPage - 1}</a></li>
                </c:if>

                <li class="page-item active"><span class="page-link">${currentPage}</span></li>

                <c:if test="${hasNextPage}">
                    <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=${currentPage + 1}&pageSize=${pageSize}">${currentPage + 1}</a></li>
                </c:if>

                <c:if test="${hasNextPage && pagesCount > currentPage + 1}">
                    <c:if test="${pagesCount > currentPage + 2}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    </c:if>
                    <li class="page-item"><a class="page-link" href="inventory?action=pagination&page=${pagesCount}&pageSize=${pageSize}">${pagesCount}</a></li>
                </c:if>

                <c:if test="${hasNextPage}">
                    <li class="page-item">
                        <a class="page-link" href="inventory?action=pagination&page=${currentPage + 1}&pageSize=${pageSize}" aria-label="Next">
                            <span aria-hidden="true"><i class="fas fa-chevron-right"></i></span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>


<jsp:include page="/templates/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    // Initialize any JS functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Add table row hover effect
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseover', () => {
                row.style.cursor = 'pointer';
            });
        });
    });
</script>
</body>
</html>