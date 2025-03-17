<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.Utils" %>
<html>
<head>
    <title>Địa chỉ của tôi</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/@goongmaps/goong-geocoder/dist/goong-geocoder.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/@goongmaps/goong-geocoder/dist/goong-geocoder.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/geocoder.css">
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<c:set var="addressParts" value="${Utils.splitAddressDetails(user.address)}" />
<div class="container-fluid mt-4">
    <h2 class="text-center mb-4">Quản lý địa chỉ</h2>
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
                        <label class="form-label">Nhập địa chỉ</label>
                        <div id="geocoder"></div>
                        <input type="hidden" id="userAddress" value="${user.address}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số nhà & Đường</label>
                        <input type="text" id="street" name="street" class="form-control" value="${addressParts[0]}" required/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phường/Xã</label>
                        <input type="text" id="ward" name="ward" class="form-control" value="${addressParts[1]}" required/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quận/Huyện</label>
                        <input type="text" id="district" name="district" class="form-control" value="${addressParts[2]}" required/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thành phố/Tỉnh</label>
                        <input type="text" id="city" name="city" class="form-control" value="${addressParts[3]}" required/>
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
<script src="${pageContext.request.contextPath}/js/geocoder.js"></script>
<script>
    document.addEventListener("addressSelected", function (e) {
        console.log("Địa chỉ đã chọn:", e.detail);

        document.getElementById("street").value = e.detail.street || "";
        document.getElementById("ward").value = e.detail.ward || "";
        document.getElementById("district").value = e.detail.district || "";
        document.getElementById("city").value = e.detail.city || "";
    });


    // Khi xóa địa chỉ
    document.addEventListener("addressCleared", function () {
        document.getElementById("street").value = "";
        document.getElementById("ward").value = "";
        document.getElementById("district").value = "";
        document.getElementById("city").value = "";
    });
</script>
</body>
</html>
