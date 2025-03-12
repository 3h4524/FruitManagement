<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đăng ký</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
  <script>
    let otpCooldown = 60; // Thời gian chờ nhận lại OTP
    let otpTimer;

    function requestOTP() {
      let email = document.getElementById("email").value;
      let otpField = document.getElementById("otpField");
      let otpButton = document.getElementById("otpButton");
      let errorMessage = document.getElementById("errorMessage");

      if (!email.trim()) {
        errorMessage.innerText = "Vui lòng nhập email trước khi nhận mã OTP!";
        return;
      }

      // Xóa thông báo lỗi trước đó
      errorMessage.innerText = "";

      otpButton.disabled = true;
      otpButton.innerText = "Đang gửi...";

      fetch('${pageContext.request.contextPath}/users?action=generateOtp', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'email=' + encodeURIComponent(email)
      })
              .then(response => response.text())
              .then(data => {
                if (data.startsWith("success")) {
                  alert("Mã OTP đã được gửi! Vui lòng kiểm tra email.");
                  otpField.style.display = "block"; // Hiện ô nhập OTP
                  startOTPTimer(otpButton);
                } else if (data.startsWith("error:")) {
                  errorMessage.innerText = data.substring(6); // Hiển thị lỗi từ server
                  otpButton.disabled = false;
                  otpButton.innerText = "Nhận mã";
                } else {
                  errorMessage.innerText = "Lỗi không xác định! Vui lòng thử lại.";
                  otpButton.disabled = false;
                  otpButton.innerText = "Nhận mã";
                }
              })
              .catch(error => {
                errorMessage.innerText = "Không thể gửi yêu cầu! Kiểm tra kết nối mạng.";
                otpButton.disabled = false;
                otpButton.innerText = "Nhận mã";
              });
    }

    function startOTPTimer(button) {
      button.disabled = true;
      otpCooldown = 60;
      otpTimer = setInterval(() => {
        button.innerText = "Nhận mã (" + otpCooldown + "s)";
        otpCooldown--;
        if (otpCooldown < 0) {
          clearInterval(otpTimer);
          button.innerText = "Nhận mã";
          button.disabled = false;
        }
      }, 1000);
    }
  </script>
</head>
<body>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card shadow-lg rounded">
        <div class="card-header bg-primary text-white text-center">
          <h3>Đăng ký tài khoản</h3>
        </div>
        <div class="card-body">
          <!-- Thông báo lỗi -->
          <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
          </c:if>

          <!-- Thông báo thành công -->
          <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">${sessionScope.success}</div>
            <c:remove var="success" scope="session"/>
          </c:if>

          <form action="${pageContext.request.contextPath}/registers" method="post">
            <!-- Email + Nút nhận mã -->
            <div class="mb-3">
              <label class="form-label">Email</label>
              <div class="input-group">
                <input type="email" id="email" name="email" class="form-control" placeholder="Nhập email" required />
                <button type="button" id="otpButton" class="btn btn-warning" onclick="requestOTP()">Nhận mã</button>
              </div>
              <small id="errorMessage" class="text-danger"></small>
            </div>

            <!-- Ô nhập OTP (ẩn ban đầu) -->
            <div id="otpField" class="mb-3" style="display: none;">
              <label class="form-label">Nhập mã OTP</label>
              <input type="text" name="otp" class="form-control" placeholder="Nhập mã OTP" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Mật khẩu</label>
              <input type="password" name="password" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Xác nhận mật khẩu</label>
              <input type="password" name="confirmPassword" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Tên đăng nhập</label>
              <input type="text" name="name" class="form-control" required />
            </div>

            <div class="mb-3">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="phone" class="form-control" />
            </div>

            <div class="text-center">
              <button type="submit" class="btn btn-success px-4">Đăng ký</button>
              <a href="<%= request.getContextPath()%>/login" class="btn btn-secondary px-4">Đăng nhập</a>
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
