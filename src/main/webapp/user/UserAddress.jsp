<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Địa chỉ của tôi</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">Quản lý địa chỉ</h2>

    <div class="card p-4 shadow-sm">
        <form action="saveAddress" method="post">
            <div class="mb-3">
                <label class="form-label">Số nhà & Đường</label>
                <input type="text" name="street" class="form-control" placeholder="VD: 123 Nguyễn Văn Linh" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Phường/Xã</label>
                <input type="text" name="ward" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Quận/Huyện</label>
                <input type="text" name="district" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Thành phố/Tỉnh</label>
                <input type="text" name="city" class="form-control" required/>
            </div>

            <div class="mb-3">
                <label class="form-label">Mã bưu chính</label>
                <input type="text" name="zipcode" class="form-control" required/>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-success">Lưu địa chỉ</button>
                <a href="UserAccount.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>