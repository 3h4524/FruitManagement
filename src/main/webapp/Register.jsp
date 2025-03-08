<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/03/2025
  Time: 4:18 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div align="center">
  <form action="users?action=create" method="post">
    <table border="1" cellpadding="5">
      <caption>
        <h2>
          Đăng ký
        </h2>
      </caption>
      <tr>
        <th>Tên đăng nhập</th>
        <td>
          <input type="text" name="name" size="45" required/>
        </td>
      </tr>
      <tr>
        <th>Password</th>
        <td>
          <input type="password" name="password" size="45" required/>
        </td>
      </tr>
      <tr>
        <th>Email</th>
        <td>
          <input type="text" name="email" size="45" required/>
        </td>
      </tr>
      <tr>
        <th>Số điện thoại</th>
        <td>
          <input type="text" name="phone" size="45"/>
        </td>
      </tr>
      <tr>
        <th>Địa chỉ</th>
        <td>
          <input type="text" name="address" size="15"/>
        </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <input type="submit" value="Đăng ký"/>
        </td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>
