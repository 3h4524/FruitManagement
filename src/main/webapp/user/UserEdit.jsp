<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Chỉnh sửa thông tin người dùng</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg rounded">
        <div class="card-body">
          <h2 class="text-center text-primary">Chỉnh sửa thông tin</h2>

          <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
          </c:if>
          <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">${sessionScope.success}</div>
            <c:remove var="success" scope="session"/>
          </c:if>

          <form action="${pageContext.request.contextPath}/user/Confirm.jsp?type=updateUser" method="post">
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
              <input type="text" name="address" id="addressField" class="form-control" value="${user.address}" readonly />
              <input type="hidden" name="addressHidden" id="addressHidden" value="${user.address}" />
              <a href="#" class="text-primary" data-bs-toggle="modal" data-bs-target="#addressModal">Thay đổi địa chỉ</a>
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

<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Quản lý địa chỉ</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addressForm">
          <div class="mb-3">
            <label class="form-label">Số nhà & Đường</label>
            <input type="text" id="street" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Phường/Xã</label>
            <input type="text" id="ward" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Quận/Huyện</label>
            <input type="text" id="district" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">Thành phố/Tỉnh</label>
            <input type="text" id="city" class="form-control" required/>
          </div>
          <div class="text-center">
            <button type="button" id="saveAddress" class="btn btn-success">Lưu địa chỉ</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    let addressModal = new bootstrap.Modal(document.getElementById("addressModal"));
    let addressField = document.getElementById("addressField");
    let addressHidden = document.getElementById("addressHidden");

    document.querySelector("[data-bs-target='#addressModal']").addEventListener("click", function () {
      let address = addressHidden.value;
      if (address) {
        let parts = address.split(", ");
        document.getElementById("street").value = parts[0] || "";
        document.getElementById("ward").value = parts[1] || "";
        document.getElementById("district").value = parts[2] || "";
        document.getElementById("city").value = parts[3] || "";
      }
    });

    document.getElementById("saveAddress").addEventListener("click", function () {
      let street = document.getElementById("street").value.trim();
      let ward = document.getElementById("ward").value.trim();
      let district = document.getElementById("district").value.trim();
      let city = document.getElementById("city").value.trim();

      if (!street || !ward || !district || !city) {
        alert("Vui lòng nhập đầy đủ thông tin địa chỉ!");
        return;
      }

      let fullAddress = street + ", " + ward + ", " + district + ", " + city;
      addressField.value = fullAddress;
      addressHidden.value = fullAddress;
      addressModal.hide();
    });
  });
</script>

</body>
</html>
