<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="service.Utils" %>
<jsp:useBean id="userService" class="service.UserService" scope="page" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System | Users</title>
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

        .badge-active {
            background-color: #dff7ee;
            color: #25a56a;
        }

        .badge-inactive {
            background-color: #ffebef;
            color: #ff617d;
        }

        .badge-role {
            background-color: #e7f5ff;
            color: #3498db;
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

        .btn-warning {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--white);
        }

        .btn-warning:hover {
            background-color: #e69500;
            border-color: #e69500;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(255, 165, 0, 0.2);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.2);
        }

        .btn-success {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-success:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(46, 139, 87, 0.2);
        }

        /* Search container */
        .search-container {
            background-color: var(--white);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.04);
        }

        .action-buttons .btn {
            padding: 8px 12px;
            margin: 0 2px;
        }

        .action-buttons .btn i {
            margin-right: 5px;
        }

        /* Alerts */
        .alert {
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 20px;
            border-left: 4px solid;
        }

        .alert-danger {
            background-color: #fff2f5;
            border-color: #ff617d;
            color: #dc3545;
        }

        .alert-warning {
            background-color: #fff8e6;
            border-color: #FFA500;
            color: #856404;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .search-container .input-group {
                width: 100% !important;
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

            .action-buttons .btn {
                padding: 6px 10px;
                font-size: 12px;
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
                <h2 class="page-title">User List</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products?action=find"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Users</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="container">
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <!-- Search Container -->
        <div class="card search-container">
            <div class="card-body p-0">
                <form action="users" method="get" class="p-4 mb-0" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="search">
                    <div class="row align-items-end">
                        <div class="col-md-3">
                            <div class="form-group mb-md-0 mb-3">
                                <label for="searchType" class="form-label">Search By</label>
                                <select name="searchType" id="searchType" class="form-select">
                                    <option value="id">ID</option>
                                    <option value="name">Name</option>
                                    <option value="phone">Phone</option>
                                    <option value="email">Email</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="form-group mb-md-0 mb-3">
                                <label for="searchValue" class="form-label">Search Value</label>
                                <input type="text" name="searchValue" id="searchValue" class="form-control" placeholder="Enter search keyword" required>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-1"></i> Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <c:set var="users" value="${sessionScope.users}"/>
        <c:set var="pageSize" value="10"/>
        <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
        <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
        <c:set var="end" value="${start + pageSize}"/>
        <c:set var="totalUsers" value="${users.size()}"/>
        <c:set var="totalPages" value="${Math.ceil(totalUsers / pageSize)}"/>

        <!-- Users Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5><i class="fas fa-users me-2"></i>User List</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty users}">
                        <div class="alert alert-warning m-4 text-center">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            No users found.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-hover table-striped">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Registration Date</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Role</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${users}" varStatus="status">
                                    <c:if test="${status.index >= start && status.index < end}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.name}</td>
                                            <td>${user.email}</td>
                                            <td>${user.phone}</td>
                                            <td>${user.address}</td>
                                            <td>${Utils.dateTimeFormat(user.registrationDate)}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${user.status == 'ACTIVE'}">
                                                        <span class="badge badge-active">
                                                            <i class="fas fa-check-circle me-1"></i> Active
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-inactive">
                                                            <i class="fas fa-times-circle me-1"></i> Inactive
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge badge-role">
                                                    <i class="fas fa-user-tag me-1"></i> ${user.role}
                                                </span>
                                            </td>
                                            <td class="text-center action-buttons">
                                                <a href="${pageContext.request.contextPath}/users?action=update&id=${user.id}" class="btn btn-primary btn-sm" style="width: 100px;">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <c:choose>
                                                    <c:when test="${user.status == 'INACTIVE'}">
                                                        <a href="${pageContext.request.contextPath}/users?action=restore&id=${user.id}" class="btn btn-outline-primary btn-sm" style="width: 100px;">
                                                            <i class="fas fa-undo"></i> Restore
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}" class="btn btn-outline-danger btn-sm" style="width: 100px;">
                                                            <i class="fas fa-trash"></i> Delete
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty users and totalPages > 1}">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="users?page=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true"><i class="fas fa-chevron-left"></i></span>
                            </a>
                        </li>
                    </c:if>

                    <c:if test="${currentPage > 2}">
                        <li class="page-item"><a class="page-link" href="users?page=1">1</a></li>
                        <c:if test="${currentPage > 3}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>
                    </c:if>

                    <c:if test="${currentPage > 1}">
                        <li class="page-item"><a class="page-link" href="users?page=${currentPage - 1}">${currentPage - 1}</a></li>
                    </c:if>

                    <li class="page-item active"><span class="page-link">${currentPage}</span></li>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item"><a class="page-link" href="users?page=${currentPage + 1}">${currentPage + 1}</a></li>
                    </c:if>

                    <c:if test="${currentPage < totalPages - 1}">
                        <c:if test="${currentPage < totalPages - 2}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>
                        <li class="page-item"><a class="page-link" href="users?page=${totalPages}">${totalPages}</a></li>
                    </c:if>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="users?page=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true"><i class="fas fa-chevron-right"></i></span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<jsp:include page="/templates/footer.jsp"/>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font Awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<script>
    // Form validation
    function validateForm() {
        let searchType = document.getElementById("searchType").value;
        let searchValue = document.getElementById("searchValue").value.trim();

        if (searchValue === "") {
            alert("Please enter a search keyword!");
            return false;
        }

        if (searchType === "id") {
            if (!/^\d+$/.test(searchValue)) {
                alert("ID must be a positive integer!");
                return false;
            }
        } else if (searchType === "phone") {
            if (!/^\d{10,11}$/.test(searchValue)) {
                alert("Phone number must be 10-11 digits!");
                return false;
            }
        } else if (searchType === "email") {
            let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(searchValue)) {
                alert("Invalid email format!");
                return false;
            }
        }

        return true;
    }

    // Add table row hover effect
    document.addEventListener('DOMContentLoaded', function() {
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