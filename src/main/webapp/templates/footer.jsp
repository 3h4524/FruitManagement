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
  <style>
    /* Embedded CSS with orange-white theme */
    .footer {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      align-items: flex-start;
      background-color: #ffdca8; /* White background */
      padding: 20px;
      text-align: center;
    }

    .Logo-footer img {
      width: 180px;
      height: auto;
    }

    .gioithieu p {
      max-width: 300px;
      text-align: justify;
      line-height: 1.6;
      font-weight: 600;
      color: #333; /* Dark gray for readability on white */
    }

    .Bct img {
      width: 140px;
      height: auto;
      margin-top: 10px;
    }

    h2 {
      font-size: 20px;
      color: #FFFFFF; /* Orange for headings */
      margin-bottom: 10px;
    }

    h5 {
      width: 100%;
      height: 10px;
      text-align: center;
      margin-top: 20px;
      font-size: 16px;
      margin-bottom: 0px;
      color: #FFFFFF; /* Orange for copyright text */
    }

    .footer p {
      color: #333; /* Dark gray for paragraph text */
    }

    .footer p a i {
      margin: 0 10px;
      transition: color 0.3s ease; /* Smooth color transition on hover */
    }

    /* Custom hover effects for social icons */
    .footer p a .fa-facebook:hover {
      color: #FFFFFF !important; /* Orange on hover */
    }

    .footer p a .fa-instagram:hover {
      color: #FFFFFF !important; /* Orange on hover */
    }

    .footer p a .fa-tiktok:hover {
      color: #FFFFFF !important; /* Orange on hover */
    }
  </style>
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
  <h5>© Copyright 2025 <span style="color: #FFA520;">Fruitiverse.com</span></h5>
</div>
</body>
</html>