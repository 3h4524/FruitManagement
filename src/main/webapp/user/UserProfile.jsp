<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Hồ sơ của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="profile-container">
    <h4 class="mb-4 border-bottom pb-3">Thông tin hồ sơ</h4>

    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="success" scope="session"/>
    </c:if>

    <c:set var="user" value="${sessionScope.UserLogin}"/>

    <form id="userForm" action="${pageContext.request.contextPath}/user/Confirm.jsp?type=updateProfile" method="post" class="row g-3">
        <div class="col-md-6">
            <label class="form-label">Email</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                <input type="email" name="email" class="form-control" value="${user.email}" required readonly/>
            </div>
        </div>

        <div class="col-md-6">
            <label class="form-label">Tên đăng nhập</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" name="name" class="form-control" value="${user.name}" required />
            </div>
        </div>

        <div class="col-md-6">
            <label class="form-label">Số điện thoại</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                <input type="text" name="phone" id="phone" class="form-control" value="${user.phone}" />
            </div>
            <small id="phoneError" class="text-danger d-none">
                <i class="fas fa-exclamation-circle"></i> Số điện thoại không hợp lệ!
            </small>
        </div>

        <div class="col-md-6">
            <label class="form-label">Địa chỉ</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                <c:choose>
                    <c:when test="${empty user.address}">
                        <input type="text" class="form-control" value="Chưa thiết lập địa chỉ" readonly />
                    </c:when>
                    <c:otherwise>
                        <input type="text" name="address" class="form-control" value="${user.address}" readonly />
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mt-2">
                <c:choose>
                    <c:when test="${empty user.address}">
                        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserSaveAddress.jsp" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-plus-circle"></i> Thêm địa chỉ
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserSaveAddress.jsp" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil-square"></i> Thay đổi địa chỉ
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="col-12 mt-4 text-center">
            <button type="submit" class="btn btn-success px-4 me-2">
                <i class="bi bi-check-circle"></i> Lưu thay đổi
            </button>
            <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary px-4">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
    </form>
</div>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/userValidate.js"></script>
</body>
</html>