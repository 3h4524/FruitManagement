<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.Utils" %>
<html>
<head>
    <title>Địa chỉ của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/@goongmaps/goong-geocoder/dist/goong-geocoder.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/@goongmaps/goong-geocoder/dist/goong-geocoder.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/geocoder.css">
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

        h4 {
            color: var(--primary-color);
            font-weight: 600;
        }

        .btn-success {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-success:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
        }

        .alert-success {
            background-color: rgba(46, 139, 87, 0.1);
            border-color: rgba(46, 139, 87, 0.2);
            color: var(--primary-dark);
        }

        .address-form-card {
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
        }
    </style>
</head>
<body>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<c:set var="addressParts" value="${Utils.splitAddressDetails(user.address)}" />
<div class="container">
    <h4 class="mb-3">
        <i class="bi bi-geo-alt-fill me-2"></i>Cập nhật địa chỉ
    </h4>
    <hr class="mb-4">

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="address-form-card">
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

                <form action="${pageContext.request.contextPath}/users?action=update&type=saveAddress" method="post">
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-search me-1"></i>Địa chỉ
                        </label>
                        <div id="geocoder" class="mb-2"></div>
                        <input type="hidden" id="userAddress" value="${user.address}">
                        <small class="text-muted">Tìm kiếm hoặc nhập trực tiếp thông tin địa chỉ bên dưới</small>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-house me-1"></i>Số nhà & Đường
                            </label>
                            <input type="text" id="street" name="street" class="form-control" value="${addressParts[0]}" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-geo me-1"></i>Phường/Xã
                            </label>
                            <input type="text" id="ward" name="ward" class="form-control" value="${addressParts[1]}" required/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-geo-alt me-1"></i>Quận/Huyện
                            </label>
                            <input type="text" id="district" name="district" class="form-control" value="${addressParts[2]}" required/>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="bi bi-building me-1"></i>Thành phố/Tỉnh
                            </label>
                            <input type="text" id="city" name="city" class="form-control" value="${addressParts[3]}" required/>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center gap-2 mt-4">
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-circle me-1"></i>Lưu địa chỉ
                        </button>
                        <a href="${pageContext.request.contextPath}/user/UserAccount.jsp?page=user/UserAddress.jsp" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i>Quay lại
                        </a>
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
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>