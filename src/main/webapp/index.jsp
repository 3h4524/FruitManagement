<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 08/03/2025
  Time: 2:31 CH
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    if(request.getAttribute("page") == null){
        request.setAttribute("content", "home.jsp");
        request.getRequestDispatcher("layout.jsp").forward(request, response);
//    }
%>
<html>
<head>
    <title>Fruitiverse | Shop bán trái cây hàng đầu Việt Nam</title>
</head>
<body>
</body>
</html>
