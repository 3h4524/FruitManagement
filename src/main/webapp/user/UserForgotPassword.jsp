<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Quên Mật Khẩu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg rounded">
                <div class="card-body">
                    <h3 class="text-center mb-4">Quên Mật Khẩu</h3>

                    <!-- Hiển thị thông báo lỗi hoặc thành công -->
                    <c:if test="${not empty sessionScope.error}">
                        <div class="alert alert-danger">${sessionScope.error}</div>
                        <c:remove var="error" scope="session"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.success}">
                        <div class="alert alert-success">${sessionScope.success}</div>
                        <c:remove var="success" scope="session"/>
                    </c:if>

                    <!-- Form nhập email -->
                    <form action="<%= request.getContextPath()%>/users?action=generateOtp" method="post">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <div class="input-group">
                                <input type="email" id="email" name="email" class="form-control" placeholder="Nhập email của bạn"
                                       value="${requestScope.email}" required />
                                <button type="submit" class="btn btn-primary">Lấy mã xác nhận</button>
                            </div>
                        </div>

                        <!-- Form nhập mã OTP -->

                    </form>
                    <form action="<%= request.getContextPath()%>/users?action=verifyOtp" method="post">
                        <div class="mb-3">
                            <label class="form-label">Mã xác nhận (OTP)</label>
                            <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success px-4">Xác nhận</button>
                            <a href="<%= request.getContextPath()%>/login" class="btn btn-secondary px-4">Hủy</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
