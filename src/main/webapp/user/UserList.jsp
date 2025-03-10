<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 10/03/2025
  Time: 10:17 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User list</title>
</head>
<body>
<form action="users" method="get">
    <input type="hidden" name="action" value="find">
    Enter User Name: <input type="text" name="name">
    <input type="submit" value="search">
</form>
<a href="<%= request.getContextPath()%>/user/UserCreateAddress.jsp">Create</a>
<h1>User List</h1>
<c:set var="pageSize" value="10"/>
<c:set var="currentPage" value="${param.page != null ? param.page : 1}"/>
<c:set var="start" value="${(currentPage - 1) * pageSize}"/>
<c:set var="end" value="${start + pageSize}"/>
<c:set var="totalUsers" value="${users.size()}"/>
<c:set var="totalPages" value="${Math.ceil(totalUsers / pageSize)}"/>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Registration Date</th>
        <th>Status</th>
        <th>Role</th>
    </tr>
    <c:forEach var="user" items="${customers}" varStatus="status">
        <c:if test="${status.index >= start && status.index < end}">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.phone}</td>
                <td>${user.address}</td>
                <td>${user.registrationDate}</td>
                <td>${user.status}</td>
                <td>${user.role}</td>
                <td><a href="users?action=edit&id=${user.id}">Edit</a>
                    <a href="#" onclick="doDelete('${user.id}')">Delete</a></td>
            </tr>
        </c:if>
    </c:forEach>
    <div>
        <c:if test="${currentPage > 1}">
            <a href="<%= request.getContextPath()%>/users?page=${currentPage - 1}">Previous</a>

        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${currentPage == i}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="<%= request.getContextPath()%>/users?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="<%= request.getContextPath()%>/users?page=${currentPage + 1}">Next</a>
        </c:if>
    </div>
</table>
</body>
</html>
