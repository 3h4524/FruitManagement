<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Chỉnh sửa thông tin người dùng</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

    body {
      background-color: var(--light-gray);
      color: var(--text-color);
      font-family: Arial, sans-serif;
    }

    .container {
      margin-top: 30px;
      margin-bottom: 30px;
    }

    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
    }

    .card-body {
      padding: 30px;
    }

    .page-title {
      color: var(--primary-color);
      font-weight: 700;
      margin-bottom: 1.5rem;
      position: relative;
      padding-bottom: 10px;
    }

    .page-title:after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 60px;
      height: 3px;
      background-color: var(--accent-color);
    }

    .form-label {
      font-weight: 600;
      color: var(--text-color);
      margin-bottom: 8px;
      display: block;
    }

    .form-control {
      border-radius: 8px;
      padding: 12px 15px;
      border: 1px solid var(--border-color);
      transition: all 0.3s ease;
    }

    .form-control:focus {
      border-color: var(--primary-light);
      box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
    }

    .form-control[readonly] {
      background-color: var(--light-gray);
    }

    .btn {
      padding: 12px 20px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-success {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-success:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(36, 112, 72, 0.2);
    }

    .btn-secondary {
      transition: all 0.3s ease;
    }

    .btn-secondary:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(108, 117, 125, 0.2);
    }

    .text-primary {
      color: var(--primary-color) !important;
    }

    .text-primary:hover {
      color: var(--primary-dark) !important;
      text-decoration: underline;
    }

    .alert-success {
      background-color: rgba(46, 139, 87, 0.1);
      border-color: rgba(46, 139, 87, 0.2);
      color: var(--primary-dark);
      border-radius: 8px;
      padding: 15px;
    }

    .alert-danger {
      background-color: rgba(220, 53, 69, 0.1);
      border-color: rgba(220, 53, 69, 0.2);
      border-radius: 8px;
      padding: 15px;
    }

    .modal-content {
      border-radius: 12px;
      border: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .modal-header {
      background-color: var(--primary-light);
      color: var(--white);
      border-bottom: none;
      padding: 15px 20px;
    }

    .modal-title {
      font-weight: 600;
    }

    .modal-body {
      padding: 25px;
    }

    .address-link {
      display: flex;
      align-items: center;
      text-decoration: none;
      color: var(--primary-color);
      font-weight: 500;
      margin-top: 8px;
      transition: all 0.3s ease;
    }

    .address-link:hover {
      color: var(--primary-dark);
      transform: translateX(3px);
    }

    .address-link i {
      margin-right: 5px;
    }
  </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card">
        <div class="card-body">
          <h2 class="text-center page-title">Chỉnh sửa thông tin</h2>

          <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
              <i class="fas fa-exclamation-circle me-2"></i>
                ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
          </c:if>
          <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
              <i class="fas fa-check-circle me-2"></i>
                ${sessionScope.success}
            </div>
            <c:remove var="success" scope="session"/>
          </c:if>

          <form action="${pageContext.request.contextPath}/user/Confirm.jsp?type=updateUser" method="post">
            <div class="mb-4">
              <label class="form-label">
                <i class="fas fa-envelope me-2 text-muted"></i>Email
              </label>
              <input type="email" name="email" class="form-control" value="${user.email}" required readonly/>
            </div>

            <div class="mb-4">
              <label class="form-label">
                <i class="fas fa-user me-2 text-muted"></i>Tên đăng nhập
              </label>
              <input type="text" name="name" class="form-control" value="${user.name}" required />
            </div>

            <div class="mb-4">
              <label class="form-label">
                <i class="fas fa-phone me-2 text-muted"></i>Số điện thoại
              </label>
              <input type="text" name="phone" class="form-control" value="${user.phone}" />
            </div>

            <div class="mb-4">
              <label class="form-label">
                <i class="fas fa-map-marker-alt me-2 text-muted"></i>Địa chỉ
              </label>
              <input type="text" name="address" id="addressField" class="form-control" value="${user.address}" readonly />
              <input type="hidden" name="addressHidden" id="addressHidden" value="${user.address}" />
              <a href="#" class="address-link" data-bs-toggle="modal" data-bs-target="#addressModal">
                <i class="fas fa-edit"></i> Thay đổi địa chỉ
              </a>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">
              <button type="submit" class="btn btn-success px-4">
                <i class="fas fa-save me-2"></i>Lưu
              </button>
              <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary px-4">
                <i class="fas fa-arrow-left me-2"></i>Quay lại
              </a>
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
        <h5 class="modal-title">
          <i class="fas fa-map-marked-alt me-2"></i>Quản lý địa chỉ
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addressForm">
          <div class="mb-3">
            <label class="form-label">Nhập địa chỉ</label>
            <div id="geocoder" class="mb-2"></div>
            <input type="hidden" id="userAddress" class="form-control" value="${user.address}">
          </div>
          <div class="mb-3">
            <label class="form-label">
              <i class="fas fa-road me-2 text-muted"></i>Số nhà & Đường
            </label>
            <input type="text" id="street" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">
              <i class="fas fa-landmark me-2 text-muted"></i>Phường/Xã
            </label>
            <input type="text" id="ward" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">
              <i class="fas fa-city me-2 text-muted"></i>Quận/Huyện
            </label>
            <input type="text" id="district" class="form-control" required/>
          </div>
          <div class="mb-3">
            <label class="form-label">
              <i class="fas fa-map me-2 text-muted"></i>Thành phố/Tỉnh
            </label>
            <input type="text" id="city" class="form-control" required/>
          </div>
          <div class="d-flex justify-content-center gap-2 mt-4">
            <button type="button" id="saveAddress" class="btn btn-success">
              <i class="fas fa-save me-2"></i>Lưu địa chỉ
            </button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              <i class="fas fa-times me-2"></i>Hủy
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/geocoder.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
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