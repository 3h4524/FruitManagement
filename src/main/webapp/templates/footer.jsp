<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <style>
    /* Footer styling */
    .footer {
      width: 100%;
      background-color: #f8f9fa;
      color: #333;
      font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
      padding: 40px 0 20px;
      margin-top: 50px;
      border-top: 1px solid rgba(46, 139, 87, 0.1);
    }

    .footer-container {
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 30px;
      padding: 0 20px;
    }

    .footer h2 {
      color: #2e8b57;
      font-weight: 600;
      font-size: 1.3rem;
      margin-bottom: 20px;
      position: relative;
      padding-bottom: 10px;
    }

    .footer h2:after {
      content: '';
      position: absolute;
      left: 0;
      bottom: 0;
      width: 50px;
      height: 2px;
      background-color: #3c9d74;
    }

    .footer p {
      color: #555;
      line-height: 1.6;
      margin-bottom: 10px;
      font-size: 0.95rem;
    }

    .Logo-footer img {
      max-width: 150px;
      height: auto;
      margin-bottom: 15px;
    }

    .gioithieu p {
      margin-bottom: 15px;
    }

    .Bct img {
      max-width: 120px;
      height: auto;
    }

    .social-links a {
      margin-right: 15px;
      transition: transform 0.3s ease;
      display: inline-block;
    }

    .social-links a:hover {
      transform: translateY(-5px);
    }

    .footer-bottom {
      text-align: center;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid rgba(46, 139, 87, 0.1);
      font-size: 0.9rem;
    }

    .footer-bottom span {
      color: #3c9d74;
      font-weight: 600;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      .footer-container {
        grid-template-columns: repeat(2, 1fr);
      }
    }

    @media (max-width: 480px) {
      .footer-container {
        grid-template-columns: 1fr;
      }
    }

    /* Animation for links */
    .footer a {
      transition: all 0.2s ease;
      text-decoration: none;
    }

    .footer a:hover {
      color: #3c9d74;
    }

    /* Customer care styling */
    .customer-care p {
      display: flex;
      align-items: center;
    }

    .customer-care i {
      margin-right: 10px;
      color: #3c9d74;
    }
  </style>
</head>
<body>
<div class="footer">
  <div class="footer-container">
    <div class="Logo-footer">
      <a href="#"><img src="images/Logo.png" alt="Fruitiverse Logo"></a>
      <p>Trái cây tươi ngon mỗi ngày</p>
    </div>

    <div class="gioithieu">
      <h2>Giới Thiệu</h2>
      <p>Fruitiverse là shop Trái cây tươi ngon mỗi ngày! Chúng tôi cung cấp đa dạng các loại trái cây chất lượng cao, đảm bảo an toàn và giàu dinh dưỡng.</p>
      <div class="Bct">
        <a href="#"><img src="images/chungnhan.png" alt="Chứng nhận Bộ Công Thương"></a>
      </div>
    </div>

    <div class="customer-care">
      <h2>Chăm sóc khách hàng</h2>
      <p><i class="fas fa-home"></i> Đại Học FPT Đà Nẵng</p>
      <p><i class="fas fa-phone"></i> 0938 706 66 46</p>
      <p><i class="fas fa-envelope"></i> fruitiverse@gmail.com</p>
    </div>

    <div>
      <h2>Follow US</h2>
      <div class="social-links">
        <a href="#"><i class="fab fa-facebook fa-2x" style="color: #1877F2;"></i></a>
        <a href="#"><i class="fab fa-instagram fa-2x" style="color: #E1306C;"></i></a>
        <a href="#"><i class="fab fa-tiktok fa-2x" style="color: #000;"></i></a>
      </div>
    </div>
  </div>

  <div class="footer-bottom">
    <h5>&copy; Copyright 2025 <span>Fruitiverse.com</span></h5>
  </div>
</div>
</body>
</html>