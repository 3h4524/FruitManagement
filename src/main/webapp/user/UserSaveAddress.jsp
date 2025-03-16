<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.Utils" %>
<html>
<head>
    <title>Địa chỉ của tôi</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap/bootstrap.min.css">
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<c:set var="addressParts" value="${Utils.splitAddressDetails(user.address)}" />
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Quản lý địa chỉ</h2>

    <!-- Đảm bảo nội dung không vượt quá 9 cột của Bootstrap -->
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
            <div class="card p-4 shadow-sm">
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger">${sessionScope.error}</div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <form action="<%= request.getContextPath()%>/users?action=update&type=saveAddress" method="post">
                    <div class="mb-3">
                        <label class="form-label">Số nhà & Đường</label>
                        <input type="text" name="street" class="form-control" placeholder="VD: 123 Nguyễn Văn Linh"
                                value="${addressParts[0]}" required/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Phường/Xã</label>
                        <input type="text" name="ward" class="form-control" value="${addressParts[1]}" required/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Quận/Huyện</label>
                        <input type="text" name="district" class="form-control" value="${addressParts[2]}" required/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Thành phố/Tỉnh</label>
                        <input type="text" name="city" class="form-control" value="${addressParts[3]}"required/>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success">Lưu địa chỉ</button>
                        <a href="<%= request.getHeader("Referer") != null ? request.getHeader("Referer") : "UserAccount.jsp?page=user/UserAddress.jsp" %>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
