<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="service.Utils" %>
<jsp:useBean id="userService" class="service.UserService" scope="page" />
<%
    if(session.getAttribute("users") == null){
        session.setAttribute("users", userService.getAllUser());
    }
%>
<html>
<head>
    <title>Danh sách người dùng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">Danh sách người dùng</h2>

    <!-- Tìm kiếm -->
    <form action="users" method="get" class="mb-3 d-flex justify-content-center">
        <input type="hidden" name="action" value="find">
        <input type="text" name="name" class="form-control w-25 me-2" placeholder="Nhập tên người dùng">
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
    </form>
    <c:set var="users" value="${sessionScope.users}"/>
    <c:set var="pageSize" value="10"/>
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
    <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
    <c:set var="end" value="${start + pageSize}"/>
    <c:set var="totalUsers" value="${users.size()}"/>
    <c:set var="totalPages" value="${Math.ceil(totalUsers / pageSize)}"/>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Tài khoản</th>
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Địa chỉ</th>
            <th>Ngày đăng ký</th>
            <th>Trạng thái</th>
            <th>Vai trò</th>
            <th></th>
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
                    <td>
                            <span class="badge ${user.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">
                                    ${user.status}
                            </span>
                    </td>
                    <td>${user.role}</td>
                    <td>
                        <a href="users?action=update&id=${user.id}" class="btn btn-warning btn-sm">Sửa</a>
                        <c:choose>
                            <c:when test="${user.status == 'INACTIVE'}">
                                <a href="users?action=restore&id=${user.id}" class="btn btn-success btn-sm">Khôi phục</a>
                            </c:when>
                            <c:otherwise>
                                <a href="users?action=delete&id=${user.id}" class="btn btn-danger btn-sm">Xóa</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <nav class="d-flex justify-content-center">
        <ul class="pagination">
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="users?page=${currentPage - 1}">«</a>
                </li>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="users?page=${i}">${i}</a>
                </li>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="users?page=${currentPage + 1}">»</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<!-- Bootstrap JS -->
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>
