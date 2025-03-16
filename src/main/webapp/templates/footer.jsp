<%--
    Document   : footer
    Created on : Feb 15, 2025, 6:35:54 PM
    Author     : LEGION
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath()%>/css/footercss.css"/>
</head>
<body>
<div class="footer"> <!--content footer-->
  <div class="Logo-footer">
    <a href="#"><img src="images/Logo.PNG" alt="Bett88Fruit Logo"></a>
  </div>
  <div class="gioithieu">
    <h2>Giới Thiệu</h2>
    <p>Fruitiverse là shop Trái cây tươi ngon mỗi ngày! Chúng tôi cung cấp đa dạng các loại trái cây chất lượng cao, đảm bảo an toàn và giàu dinh dưỡng. Hãy đến và trải nghiệm</p>
    <div class="Bct">
      <a href="#"><img src="images/chungnhan.png" alt="Chứng nhận Bộ Công Thương"></a>
    </div>
  </div>
  <div>
    <h2>Chăm sóc khách hàng</h2>
    <p>🏠 Đại Học FPT Đà Nẵng</p>
    <p>☎ 0938 706 66 46</p>
    <p>✉ fruitiverse@gmail.com</p>
  </div>
  <div>
    <h2>Follow US</h2>
    <p>
      <a href="#"><i class="fab fa-facebook fa-2x" style="color: #1877F2;"></i></a>
      <a href="#"><i class="fab fa-instagram fa-2x" style="color: #E1306C;"></i></a>
      <a href="#"><i class="fab fa-tiktok fa-2x" style="color: #000;"></i></a>
    </p>
  </div>
  <h5>&copy; Copyright 2025 <span style="color: #FFA520;">Fruitiverse.com</span></h5>
</div>
</body>
</html>
