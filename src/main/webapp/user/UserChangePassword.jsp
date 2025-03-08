<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/03/2025
  Time: 4:23 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đổi mật khẩu</title>
</head>
<body>
<form action="users?update" method="post">
  <label>Mật khẩu cũ:</label>
  <input type="password" id="oldPassword" name="oldPassword" required>

  <label>Mật khẩu mới:</label>
  <input type="password" id="newPassword" name="newPassword" required>

  <label>Xác nhận mật khẩu:</label>
  <input type="password" id="confirmPassword" name="confirmPassword" required>

  <button type="submit" class="btn">Đổi mật khẩu</button>
</form>

</body>
</html>
