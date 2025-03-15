<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
  <title>${title}</title>
</head>
<body>

<%-- Nhúng Header --%>
<jsp:include page="templates/header.jsp"/>

<%-- Hiển thị nội dung từng trang con --%>
<div>
  <jsp:include page="${content}"/>
</div>

<%-- Nhúng Footer --%>
<jsp:include page="templates/footer.jsp"/>

</body>
</html>
