<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Hồ sơ của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>


<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg rounded">
                <div class="card-body">
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger">${sessionScope.error}</div>
                        <c:remove var="error" scope="session"/>
                    </c:if>

                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success">${sessionScope.success}</div>
                        <c:remove var="success" scope="session"/>
                    </c:if>
                    <c:set var="user" value="${sessionScope.UserLogin}"/>
                    <form action="${pageContext.request.contextPath}/user/Confirm.jsp?type=updateProfile" method="post">

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="${user.email}" required readonly/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" name="name" class="form-control" value="${user.name}" required />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${user.phone}" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <c:choose>
                                <c:when test="${empty user.address}">
                                    <a href="${link}" class="text-primary me-2">Thêm địa chỉ</a>
                                </c:when>
                                <c:otherwise>
                                    <input type="text" name="address" class="form-control" value="${user.address}" readonly />
                                    <a href="UserAccount.jsp?page=user/UserSaveAddress.jsp" class="text-primary me-2">Thay đổi địa chỉ</a>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success px-4">Lưu</button>
                            <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary px-4">Quay lại</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
