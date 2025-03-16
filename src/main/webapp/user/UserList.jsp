<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="service.Utils" %>
<jsp:useBean id="userService" class="service.UserService" scope="page" />
<html>
<head>
    <title>Danh sách người dùng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap/bootstrap.min.css">
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-4">
    <h2 class="text-center mb-4">Danh sách người dùng</h2>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger">${sessionScope.error}</div>
        <c:remove var="error" scope="session"/>
    </c:if>
    <!-- Tìm kiếm -->
    <form action="users" method="get" class="mb-3 d-flex justify-content-center" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="search">

        <input type="text" name="searchValue" id="searchValue" class="form-control w-50 me-2" placeholder="Nhập từ khóa tìm kiếm" required>

        <button type="submit" class="btn btn-primary me-2">Tìm kiếm</button>

        <!-- Select nhỏ hơn và nằm bên phải nút tìm kiếm -->
        <select name="searchType" id="searchType" class="form-select w-25" style="max-width: 120px;">
            <option value="id">ID</option>
            <option value="name">Tên</option>
            <option value="phone">Số điện thoại</option>
            <option value="email">Email</option>
        </select>
    </form>

    <c:set var="users" value="${sessionScope.users}"/>
    <c:set var="pageSize" value="10"/>
    <c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
    <c:set var="start" value="${(currentPage - 1) * pageSize}"/>
    <c:set var="end" value="${start + pageSize}"/>
    <c:set var="totalUsers" value="${users.size()}"/>
    <c:set var="totalPages" value="${Math.ceil(totalUsers / pageSize)}"/>
    <c:choose>
        <c:when test="${empty users}">
            <div class="alert alert-warning text-center">
                Không tìm thấy người dùng nào.
            </div>
        </c:when>
        <c:otherwise>
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
                                <a href="${pageContext.request.contextPath}/users?action=update&id=${user.id}" class="btn btn-warning btn-sm">Sửa</a>
                                <c:choose>
                                    <c:when test="${user.status == 'INACTIVE'}">
                                        <a href="${pageContext.request.contextPath}/users?action=restore&id=${user.id}" class="btn btn-success btn-sm">Khôi phục</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/users?action=delete&id=${user.id}" class="btn btn-danger btn-sm">Xóa</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>


    <!-- Phân trang -->
    <c:if test="${not empty users and totalPages > 1}">
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
    </c:if>
</div>
<jsp:include page="/templates/footer.jsp"/>
<!-- Bootstrap JS -->
<script>
    function validateForm() {
        let searchType = document.getElementById("searchType").value;
        let searchValue = document.getElementById("searchValue").value.trim();

        if (searchValue === "") {
            alert("Vui lòng nhập từ khóa tìm kiếm!");
            return false;
        }

        if (searchType === "id") {
            if (!/^\d+$/.test(searchValue)) {
                alert("ID phải là số nguyên dương!");
                return false;
            }
        } else if (searchType === "phone") {
            if (!/^\d{10,11}$/.test(searchValue)) {
                alert("Số điện thoại phải có 10-11 chữ số!");
                return false;
            }
        } else if (searchType === "email") {
            let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(searchValue)) {
                alert("Email không hợp lệ!");
                return false;
            }
        }

        return true; // Cho phép gửi form nếu dữ liệu hợp lệ
    }
</script>
<script src="<%= request.getContextPath() %>/js/bootstrap.bundle.min.js"></script>
</body>
</html>
