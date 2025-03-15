<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Hồ Sơ Người Dùng</title>
</head>
<body>

<nav>
  <ul>
    <li><a href="?page=/user/UserEdit.jsp">Hồ sơ</a></li>
    <li><a href="?page=/user/UserAddress.jsp">Địa chỉ</a></li>
    <li><a href="?page=/user/UserChangePassword.jsp">Đổi mật khẩu</a></li>
  </ul>
</nav>

<div id="content">
  <c:set var="page" value="${param.page}" />
  <c:choose>
    <c:when test="${page eq '/user/UserEdit.jsp'}">
      <jsp:include page="/user/UserEdit.jsp" />
    </c:when>
    <c:when test="${page eq '/user/UserAddress.jsp'}">
      <jsp:include page="/user/UserAddress.jsp" />
    </c:when>
    <c:when test="${page eq '/user/UserChangePassword.jsp'}">
      <jsp:include page="/user/UserChangePassword.jsp" />
    </c:when>
    <c:otherwise>
      <jsp:include page="/user/UserEdit.jsp" />
    </c:otherwise>
  </c:choose>
</div>

</body>
</html>
