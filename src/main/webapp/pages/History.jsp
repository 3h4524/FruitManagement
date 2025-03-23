<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
  <title>Lịch sử phát triển của Fruitiverse</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #2e8b57;
      --primary-light: #3c9d74;
      --primary-dark: #247048;
      --accent-color: #FFA500;
      --text-color: #333;
      --light-gray: #f5f5f5;
      --white: #fff;
      --border-color: #e0e0e0;
    }

    body {
      background-color: var(--light-gray);
      min-height: 100vh;
      color: var(--text-color);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .account-container {
      padding: 40px 0;
    }

    .account-title {
      font-weight: 700;
      color: var(--primary-color);
      margin-bottom: 1.5rem;
    }

    .account-sidebar {
      background-color: var(--white);
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }

    .account-sidebar .list-group-item {
      border-left: none;
      border-right: none;
      padding: 12px 20px;
      transition: all 0.2s ease;
      color: var(--text-color);
    }

    .account-sidebar .list-group-item:first-child {
      border-top: none;
    }

    .account-sidebar .list-group-item:last-child {
      border-bottom: none;
    }

    .account-sidebar .list-group-item:hover {
      background-color: var(--light-gray);
      color: var(--primary-color);
    }

    .account-sidebar .list-group-item.active {
      background-color: var(--primary-color);
      color: var(--white);
      border-color: var(--primary-color);
    }

    .account-content {
      background-color: var(--white);
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      padding: 20px;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }

    .btn-success {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-success:hover {
      background-color: var(--primary-dark);
      border-color: var(--primary-dark);
    }

    .btn-outline-primary {
      color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .btn-outline-primary:hover {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      color: var(--white);
    }

    .form-control:focus {
      border-color: var(--primary-light);
      box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
    }

    .forgot-password-link {
      color: var(--primary-color);
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .forgot-password-link:hover {
      color: var(--primary-dark);
      text-decoration: underline;
    }

    h4 {
      color: var(--primary-color);
    }

    .input-group-text {
      background-color: var(--light-gray);
      border-color: var(--border-color);
    }

    .alert-success {
      background-color: rgba(46, 139, 87, 0.1);
      border-color: rgba(46, 139, 87, 0.2);
      color: var(--primary-dark);
    }

    /* Additional custom styles for the history page */
    .history-header {
      background-color: var(--primary-color);
      color: var(--white);
      padding: 60px 0;
      text-align: center;
      margin-bottom: 40px;
      border-radius: 0 0 20px 20px;
    }

    .history-section {
      margin-bottom: 50px;
    }

    .timeline-item {
      position: relative;
      padding-left: 30px;
      margin-bottom: 30px;
      border-left: 3px solid var(--primary-color);
      padding-bottom: 20px;
    }

    .timeline-date {
      position: absolute;
      left: -15px;
      background-color: var(--primary-color);
      color: white;
      padding: 5px 15px;
      border-radius: 20px;
      font-weight: bold;
      top: 0;
    }

    .timeline-content {
      background-color: var(--white);
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
      margin-top: 25px;
    }

    .fruit-icon {
      font-size: 2.5rem;
      color: var(--accent-color);
      margin-bottom: 15px;
    }

    .milestone-card {
      background-color: var(--white);
      border-radius: 10px;
      box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
      padding: 25px;
      height: 100%;
      transition: transform 0.3s ease;
      border-top: 4px solid var(--primary-color);
    }

    .milestone-card:hover {
      transform: translateY(-5px);
    }

    .values-section {
      background-color: rgba(46, 139, 87, 0.05);
      padding: 40px;
      border-radius: 10px;
      margin: 40px 0;
    }

    .value-item {
      text-align: center;
      margin-bottom: 30px;
    }

    .value-icon {
      font-size: 2rem;
      color: var(--primary-color);
      margin-bottom: 15px;
      background-color: rgba(46, 139, 87, 0.1);
      width: 70px;
      height: 70px;
      line-height: 70px;
      border-radius: 50%;
      display: inline-block;
    }

    .founders-section img {
      border-radius: 10px;
      box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
    }

    .quote-section {
      background-color: var(--primary-light);
      color: var(--white);
      padding: 50px 0;
      text-align: center;
      border-radius: 10px;
      margin: 40px 0;
    }

    .quote-marks {
      font-size: 5rem;
      line-height: 0;
      opacity: 0.2;
      font-family: Georgia, serif;
    }
  </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<header class="history-header">
  <div class="container">
    <h1 class="display-4 fw-bold">Lịch Sử Phát Triển</h1>
    <p class="lead">Hành trình phát triển của Fruitiverse - Từ ý tưởng đến cửa hàng trái cây hàng đầu</p>
  </div>
</header>

<div class="container">
  <div class="row">
    <div class="col-lg-3 mb-4">
      <div class="account-sidebar">
        <div class="list-group">
          <a href="#" class="list-group-item active">
            <i class="fas fa-history me-2"></i> Lịch Sử Phát Triển
          </a>
          <a href="#" class="list-group-item">
            <i class="fas fa-store me-2"></i> Về Chúng Tôi
          </a>
          <a href="<%= request.getContextPath()%>/products?action=find" class="list-group-item">
            <i class="fas fa-apple-alt me-2"></i> Sản Phẩm
          </a>
          <a href="#" class="list-group-item">
            <i class="fas fa-leaf me-2"></i> Chính Sách
          </a>
          <a href="https://www.facebook.com/nextmorningiwillforgether" class="list-group-item">
            <i class="fas fa-phone-alt me-2"></i> Liên Hệ
          </a>
        </div>
      </div>
    </div>

    <div class="col-lg-9">
      <div class="account-content">
        <h2 class="account-title">Câu Chuyện Của Fruitiverse</h2>

        <div class="history-section">
          <div class="mb-4">
            <p>Fruitiverse là câu chuyện về niềm đam mê với trái cây tươi ngon và sứ mệnh mang đến những sản phẩm chất lượng cao nhất cho mọi gia đình. Hãy cùng chúng tôi điểm lại những cột mốc quan trọng trong hành trình phát triển:</p>
          </div>

          <div class="timeline">
            <div class="timeline-item">
              <div class="timeline-date">2015</div>
              <div class="timeline-content">
                <h4>Khởi Nguồn Ý Tưởng</h4>
                <p>Fruitiverse bắt đầu từ một ý tưởng đơn giản của hai người bạn đại học Minh và Hà - những người luôn trăn trở về việc tìm nguồn trái cây sạch, an toàn và có nguồn gốc rõ ràng. Từ những buổi thảo luận tại quán cà phê nhỏ ở Hà Nội, ý tưởng về một cửa hàng trái cây khác biệt bắt đầu hình thành.</p>
              </div>
            </div>

            <div class="timeline-item">
              <div class="timeline-date">2016</div>
              <div class="timeline-content">
                <h4>Cửa Hàng Đầu Tiên</h4>
                <p>Cửa hàng Fruitiverse đầu tiên chính thức khai trương tại một con phố nhỏ ở quận Hai Bà Trưng, Hà Nội. Với diện tích khiêm tốn 30m², cửa hàng chỉ bán 5 loại trái cây địa phương được tuyển chọn kỹ lưỡng. Mặc dù quy mô nhỏ, nhưng chất lượng sản phẩm và dịch vụ tận tâm đã nhanh chóng tạo được tiếng vang.</p>
              </div>
            </div>

            <div class="timeline-item">
              <div class="timeline-date">2018</div>
              <div class="timeline-content">
                <h4>Mở Rộng Và Phát Triển</h4>
                <p>Sau hai năm hoạt động thành công, Fruitiverse đã mở thêm hai cửa hàng mới tại Hà Nội và bắt đầu phát triển mạng lưới nhà cung cấp từ các vùng nông nghiệp trọng điểm. Đây cũng là thời điểm chúng tôi bắt đầu nhập khẩu các loại trái cây đặc sản từ nước ngoài, mở rộng danh mục sản phẩm lên hơn 50 loại trái cây quanh năm.</p>
              </div>
            </div>

            <div class="timeline-item">
              <div class="timeline-date">2020</div>
              <div class="timeline-content">
                <h4>Vượt Qua Thách Thức</h4>
                <p>Đại dịch COVID-19 là thời điểm khó khăn nhưng cũng mở ra cơ hội mới. Fruitiverse nhanh chóng chuyển đổi mô hình kinh doanh, đẩy mạnh dịch vụ giao hàng tận nhà và ra mắt nền tảng thương mại điện tử. Doanh số trực tuyến tăng 300% trong năm này, đặt nền móng cho chiến lược phát triển số trong tương lai.</p>
              </div>
            </div>

            <div class="timeline-item">
              <div class="timeline-date">2022</div>
              <div class="timeline-content">
                <h4>Mở Rộng Toàn Quốc</h4>
                <p>Fruitiverse bắt đầu mở rộng ra các thành phố lớn như Hồ Chí Minh, Đà Nẵng, Nha Trang và Cần Thơ. Hệ thống 15 cửa hàng trên toàn quốc được thiết lập, cùng với trung tâm phân phối hiện đại đầu tiên tại Long Biên, Hà Nội, áp dụng công nghệ bảo quản tiên tiến giúp kéo dài thời gian tươi ngon của trái cây.</p>
              </div>
            </div>

            <div class="timeline-item">
              <div class="timeline-date">2024</div>
              <div class="timeline-content">
                <h4>Hiện Tại Và Tương Lai</h4>
                <p>Đến nay, Fruitiverse đã phát triển thành chuỗi 30 cửa hàng trên toàn quốc với hơn 200 nhân viên. Chúng tôi tự hào cung cấp hơn 100 loại trái cây từ khắp nơi trên thế giới, đồng thời vẫn duy trì cam kết về chất lượng và nguồn gốc rõ ràng. Kế hoạch trong tương lai của chúng tôi là mở rộng sang các nước Đông Nam Á và phát triển dòng sản phẩm chế biến từ trái cây.</p>
              </div>
            </div>
          </div>
        </div>

        <div class="values-section">
          <h3 class="text-center mb-4">Giá Trị Cốt Lõi</h3>
          <div class="row">
            <div class="col-md-4">
              <div class="value-item">
                <div class="value-icon">
                  <i class="fas fa-leaf"></i>
                </div>
                <h5>Tự Nhiên</h5>
                <p>Cam kết cung cấp trái cây tự nhiên, không hóa chất độc hại, tôn trọng quy luật tự nhiên.</p>
              </div>
            </div>
            <div class="col-md-4">
              <div class="value-item">
                <div class="value-icon">
                  <i class="fas fa-handshake"></i>
                </div>
                <h5>Trung Thực</h5>
                <p>Minh bạch về nguồn gốc sản phẩm, giá cả và quy trình sản xuất với khách hàng.</p>
              </div>
            </div>
            <div class="col-md-4">
              <div class="value-item">
                <div class="value-icon">
                  <i class="fas fa-heart"></i>
                </div>
                <h5>Tận Tâm</h5>
                <p>Luôn đặt lợi ích và trải nghiệm của khách hàng lên hàng đầu trong mọi quyết định.</p>
              </div>
            </div>
          </div>
        </div>

        <div class="founders-section mb-5">
          <h3 class="mb-4">Người Sáng Lập</h3>
          <div class="row">
            <div class="col-md-6">
              <div class="founders-content">
                <h4>Nguyễn Văn Minh & Trần Thị Hà</h4>
                <p>Hai người bạn đại học với niềm đam mê về nông nghiệp sạch và thực phẩm lành mạnh. Minh với nền tảng kinh doanh và Hà với kiến thức về khoa học thực phẩm đã kết hợp hoàn hảo để xây dựng nên Fruitiverse.</p>
                <p>Trước khi thành lập Fruitiverse, cả hai đã dành 2 năm du lịch khắp các vùng nông nghiệp Việt Nam để tìm hiểu về kỹ thuật canh tác và kết nối với các nhà sản xuất địa phương.</p>
              </div>
            </div>
            <div class="col-md-6">
              <img src="/api/placeholder/500/300" alt="Người sáng lập Fruitiverse" class="img-fluid">
            </div>
          </div>
        </div>

        <div class="quote-section">
          <div class="container">
            <span class="quote-marks">"</span>
            <p class="lead fw-normal mb-0">Chúng tôi tin rằng mỗi miếng trái cây không chỉ là thực phẩm mà còn là sự kết nối giữa thiên nhiên và con người, giữa người nông dân và người tiêu dùng.</p>
            <p class="mt-3 fw-bold">- Nguyễn Văn Minh, Đồng sáng lập Fruitiverse</p>
          </div>
        </div>

        <div class="row mb-4">
          <h3 class="mb-4">Những Cột Mốc Đáng Nhớ</h3>
          <div class="col-md-4 mb-4">
            <div class="milestone-card">
              <div class="fruit-icon">
                <i class="fas fa-award"></i>
              </div>
              <h5>2019</h5>
              <p>Giải thưởng "Thương hiệu trái cây tin cậy" do Hiệp hội Nông sản Việt Nam trao tặng.</p>
            </div>
          </div>
          <div class="col-md-4 mb-4">
            <div class="milestone-card">
              <div class="fruit-icon">
                <i class="fas fa-users"></i>
              </div>
              <h5>2021</h5>
              <p>Đạt mốc 100.000 khách hàng thành viên trên toàn quốc.</p>
            </div>
          </div>
          <div class="col-md-4 mb-4">
            <div class="milestone-card">
              <div class="fruit-icon">
                <i class="fas fa-seedling"></i>
              </div>
              <h5>2023</h5>
              <p>Khởi động dự án "Vườn Trái Cây Cộng Đồng" tại 5 tỉnh thành trên cả nước.</p>
            </div>
          </div>
        </div>

        <div class="text-center mt-5">
          <h4>Cùng Chúng Tôi Viết Tiếp Câu Chuyện</h4>
          <p class="mb-4">Fruitiverse không chỉ là một cửa hàng trái cây mà còn là một cộng đồng yêu thích lối sống lành mạnh và bền vững. Chúng tôi luôn tìm kiếm những đối tác và khách hàng cùng chung tầm nhìn để cùng nhau phát triển.</p>
          <a href="#" class="btn btn-primary me-2">Tham Gia Cùng Chúng Tôi</a>
          <a href="https://www.facebook.com/nextmorningiwillforgether" class="btn btn-outline-primary">Liên Hệ Ngay</a>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>