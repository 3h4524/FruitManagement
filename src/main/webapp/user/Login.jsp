<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Đăng nhập</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .login-container {
      display: flex;
      flex-direction: column;
      background: white;
      padding: 30px;
      width: 500px;
      text-align: center;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .login-container h2 {
      margin-bottom: 20px;
    }

    .input-group {
      margin-bottom: 15px;
      text-align: center;
      position: relative;
    }

    .input-group input {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      width: 96%;
      margin: auto;
      display: block;
    }

    .input-group .toggle-password {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
    }

    .remember-me {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      width: 90%;
      margin: auto;
      font-size: 14px;
    }

    .remember-me input {
      margin-right: 5px;
    }

    button {
      width: 100%;
      padding: 10px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      margin: 10px auto;
      display: block;
    }

    .login-btn {
      background-color: #007bff;
      border: none;
      color: white;
    }

    .login-btn:hover {
      background-color: #0056b3;
      box-shadow: 0 0 3px #007bff;
    }

    .sign-up-btn {
      background-color: white;
      border: 1px solid #6c757d;
      color: #6c757d;
    }

    .sign-up-btn:hover {
      color: #007bff;
      border-color: #007bff;
      box-shadow: 0 0 3px #007bff;
    }

    .forget-password {
      display: block;
      font-size: 14px;
      color: #007bff;
      text-decoration: none;
      text-align: right;
      width: 90%;
      margin: 0 0 30px auto;
    }

  </style>
</head>
<body>
<div class="login-container">
  <h2>Đăng nhập</h2>
  <form action="login" method="POST">
    <div class="input-group">
      <input type="text" id="email" name="email" placeholder="Email" required>
    </div>
    <div class="input-group">
      <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
      <span class="toggle-password" onclick="togglePassword()">
        <i class="bi bi-eye"></i>
      </span>
    </div>
    <div class="forget-password">
      <a href="#">Quên mật khẩu?</a>
    </div>
    <div class="remember-me">
      <input type="checkbox" name="remember-me" id="remember-me">
      <label for="remember-me">Remember me</label>
    </div>
    <button type="submit" class="login-btn">Đăng nhập</button>
  </form>
  <form action="<%= request.getContextPath()%>/registers">
    <button type="submit" class="sign-up-btn">Đăng ký</button>
  </form>
</div>

<script>
  function togglePassword() {
    var passwordInput = document.getElementById("password");
    var toggleIcon = document.querySelector(".toggle-password i");
    if (passwordInput.type === "password") {
      passwordInput.type = "text";
      toggleIcon.classList.remove("bi-eye");
      toggleIcon.classList.add("bi-eye-slash");
    } else {
      passwordInput.type = "password";
      toggleIcon.classList.remove("bi-eye-slash");
      toggleIcon.classList.add("bi-eye");
    }
  }
</script>
</body>
</html>
