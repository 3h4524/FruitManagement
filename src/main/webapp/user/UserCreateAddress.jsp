<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/03/2025
  Time: 12:21 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">Thêm địa chỉ mới</h2>

  <form action="users" method="post">
    <input type="hidden" name="action" value="create">

    <div class="mb-3">
      <label for="address" class="form-label">Địa chỉ</label>
      <input type="text" class="form-control" name="address" id="address" required>
    </div>

    <div class="mb-3">
      <label for="city" class="form-label">Tỉnh / Thành phố</label>
      <input class="text" name="city" id="city" required/>
    </div>
    <div class="mb-3">
      <label for="district" class="form-label">Quận / Huyện</label>
      <input class="text" name="district" id="district" required/>
    </div>
    <div class="mb-3">
      <label for="ward" class="form-label">Phường / Xã</label>
      <input class="text" name="ward" id="ward" required/>
    </div>
    <div class="mb-3">
      <label for="addressDetail" class="form-label">Phường / Xã</label>
      <input class="text" name="addressDetail" id="addressDetail" required/>
    </div>
    <button type="submit" class="btn btn-dark">Lưu địa chỉ</button>
    <a href="UserAddressList.jsp" class="btn btn-secondary">Hủy</a>
  </form>
</div>
</body>
</html>
