<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/03/2025
  Time: 10:52 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Profile</title>
</head>
<body>
<c:set var="customer" value="${sessionScope.customer}"/>
<div align="center">
    <form action="users?action=update" method="post">
        <table border="1" cellpadding="5">
            <caption>
                <h2>
                    Chỉnh sửa hồ sơ
                </h2>
            </caption>
            <tr>
                <th>Tên đăng nhập</th>
                <td>
                    <input type="text" name="name" size="45"
                           value="<c:out value='${customer.name}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Email</th>
                <td>
                    <input type="text" name="email" size="45"
                           value="<c:out value='${customer.email}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Số điện thoại</th>
                <td>
                    <input type="text" name="phone" size="45"
                           value="<c:out value='${customer.phone}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Địa chỉ</th>
                <td>
                    <input type="text" name="address" size="15"
                           value="<c:out value='${customer.address}' />"
                    />
                </td>
            </tr>
            <tr>

                <td colspan="2" align="center">
                    <input type="submit" value="Lưu"/>
                </td>
            </tr>
        </table>
    </form>
</div>
</form>
</body>
</html>
