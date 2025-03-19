<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Hồ sơ của tôi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Orange-White Theme */
        .bg-orange {
            background-color: #FFA520; /* Orange background */
        }
        .text-orange {
            color: #FFA520; /* Orange text */
        }
        .btn-orange {
            background-color: #FFA520;
            border-color: #FFA520;
            color: #FFFFFF; /* White text */
        }
        .btn-orange:hover {
            background-color: #e59400; /* Darker orange on hover */
            border-color: #e59400;
            color: #FFFFFF;
        }
        .btn-outline-orange {
            border-color: #FFA520;
            color: #FFA520;
        }
        .btn-outline-orange:hover {
            background-color: #FFA520;
            color: #FFFFFF;
        }
        .alert-success {
            background-color: #FFF3E0; /* Light orange for success */
            border-color: #FFA520;
            color: #e59400;
        }
        .alert-danger {
            background-color: #FFE6E6; /* Light red for error */
            border-color: #DC3545;
            color: #DC3545;
        }
        .form-floating > label {
            color: #FFA520; /* Orange labels */
        }
        .form-control:focus {
            border-color: #FFA520;
            box-shadow: 0 0 0 0.25rem rgba(255, 165, 32, 0.25); /* Orange focus ring */
        }
        a.text-orange:hover {
            color: #e59400; /* Darker orange on hover */
        }
    </style>
</head>
<body>
<div class="container mt-5 py-5 ">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow rounded">
                <div class="card-body p-4">
                    <h3 class="text-center text-orange mb-4">Hồ sơ của tôi</h3>

                    <!-- Alerts -->
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
                        <!-- Email -->
                        <div class="form-floating mb-3">
                            <input type="email" name="email" class="form-control" id="email"
                                   value="${user.email}" required readonly placeholder="Email"/>
                            <label for="email">Email</label>
                        </div>

                        <!-- Username -->
                        <div class="form-floating mb-3">
                            <input type="text" name="name" class="form-control" id="name"
                                   value="${user.name}" required placeholder="Tên đăng nhập"/>
                            <label for="name">Tên đăng nhập</label>
                        </div>

                        <!-- Phone -->
                        <div class="form-floating mb-3">
                            <input type="text" name="phone" class="form-control" id="phone"
                                   value="${user.phone}" placeholder="Số điện thoại"/>
                            <label for="phone">Số điện thoại</label>
                        </div>

                        <!-- Address -->
                        <div class="mb-3">
                            <label class="form-label text-orange">Địa chỉ</label>
                            <c:choose>
                                <c:when test="${empty user.address}">
                                    <div>
                                        <a href="${link}" class="text-orange me-2">Thêm địa chỉ</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="form-floating mb-2">
                                        <input type="text" name="address" class="form-control" id="address"
                                               value="${user.address}" readonly placeholder="Địa chỉ"/>
                                        <label for="address">Địa chỉ</label>
                                    </div>
                                    <a href="UserAccount.jsp?page=user/UserSaveAddress.jsp" class="text-orange me-2">Thay đổi địa chỉ</a>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Buttons -->
                        <div class="d-flex justify-content-center gap-3 mt-4">
                            <button type="submit" class="btn btn-orange px-4">Lưu</button>
                            <a href="${pageContext.request.contextPath}/users" class="btn btn-outline-orange px-4">Quay lại</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>