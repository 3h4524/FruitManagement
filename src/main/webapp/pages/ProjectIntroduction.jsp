<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới Thiệu Dự Án Fruitiverse</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
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

        /* Additional custom styles for the project page */
        .project-header {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 60px 0;
            text-align: center;
            margin-bottom: 40px;
            border-radius: 0 0 20px 20px;
        }

        .feature-card {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            padding: 25px;
            margin-bottom: 30px;
            height: 100%;
            transition: transform 0.3s ease;
            border-bottom: 4px solid var(--accent-color);
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            background-color: rgba(46, 139, 87, 0.1);
            width: 80px;
            height: 80px;
            line-height: 80px;
            text-align: center;
            border-radius: 50%;
            display: inline-block;
        }

        .mission-section {
            background-color: rgba(255, 165, 0, 0.1);
            padding: 40px;
            border-radius: 10px;
            margin: 40px 0;
            border-left: 5px solid var(--accent-color);
        }

        .project-goals {
            counter-reset: goal-counter;
            list-style-type: none;
            padding-left: 0;
        }

        .project-goals li {
            position: relative;
            padding-left: 50px;
            margin-bottom: 25px;
            counter-increment: goal-counter;
        }

        .project-goals li::before {
            content: counter(goal-counter);
            position: absolute;
            left: 0;
            top: 0;
            background-color: var(--primary-color);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            text-align: center;
            line-height: 35px;
            font-weight: bold;
        }

        .tech-card {
            background-color: var(--white);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            border-top: 3px solid var(--primary-color);
        }

        .progress-section {
            background-color: var(--primary-light);
            color: var(--white);
            padding: 40px;
            border-radius: 10px;
            margin: 40px 0;
        }

        .progress-bar {
            background-color: var(--accent-color);
        }

        .team-card {
            text-align: center;
            background-color: var(--white);
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .team-card:hover {
            transform: translateY(-5px);
        }

        .team-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px;
            background-color: var(--primary-light);
            color: var(--white);
            font-size: 50px;
            line-height: 120px;
            text-align: center;
        }

        .contact-info {
            background-color: var(--white);
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .contact-method {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .contact-icon {
            background-color: var(--primary-light);
            color: var(--white);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            text-align: center;
            line-height: 50px;
            font-size: 20px;
            margin-right: 15px;
        }

        .roadmap-section {
            position: relative;
            padding-left: 30px;
            border-left: 3px dashed var(--primary-color);
            margin: 30px 0;
        }

        .roadmap-item {
            position: relative;
            margin-bottom: 40px;
        }

        .roadmap-date {
            position: absolute;
            left: -50px;
            background-color: var(--accent-color);
            color: var(--white);
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            top: 0;
        }

        .roadmap-content {
            background-color: var(--white);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }
    </style>
</head>
<body>
<header class="project-header">
    <div class="container">
        <h1 class="display-4 fw-bold">Giới Thiệu Dự Án</h1>
        <p class="lead">Fruitiverse - Kết nối yêu thương từ vườn đến bàn ăn</p>
    </div>
</header>

<div class="container">
    <div class="row">
        <div class="col-lg-3 mb-4">
            <div class="account-sidebar">
                <div class="list-group">
                    <a href="#" class="list-group-item">
                        <i class="fas fa-history me-2"></i> Lịch Sử Phát Triển
                    </a>
                    <a href="#" class="list-group-item active">
                        <i class="fas fa-store me-2"></i> Giới Thiệu Dự Án
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fas fa-apple-alt me-2"></i> Sản Phẩm
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fas fa-leaf me-2"></i> Chính Sách
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fas fa-phone-alt me-2"></i> Liên Hệ
                    </a>
                </div>
            </div>
        </div>

        <div class="col-lg-9">
            <div class="account-content">
                <h2 class="account-title">Dự Án Fruitiverse</h2>

                <div class="mb-4">
                    <p>Dự án website Fruitiverse là bước đột phá số hóa của chuỗi cửa hàng trái cây Fruitiverse, nhằm mở rộng phạm vi tiếp cận và nâng cao trải nghiệm mua sắm cho khách hàng. Dự án này không chỉ là một nền tảng thương mại điện tử đơn thuần mà còn là không gian kết nối giữa người tiêu dùng với những sản phẩm trái cây chất lượng cao và câu chuyện đằng sau mỗi sản phẩm.</p>
                </div>

                <div class="mission-section mb-5">
                    <h3 class="mb-4">Tầm Nhìn & Sứ Mệnh</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <h5>Tầm Nhìn</h5>
                            <p>Trở thành nền tảng trực tuyến hàng đầu về trái cây chất lượng cao tại Việt Nam, góp phần nâng cao nhận thức về thực phẩm lành mạnh và hỗ trợ phát triển nông nghiệp bền vững.</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Sứ Mệnh</h5>
                            <p>Kết nối người tiêu dùng với những sản phẩm trái cây tươi ngon, an toàn và giàu dinh dưỡng thông qua một hệ thống mua sắm trực tuyến thuận tiện, minh bạch và đáng tin cậy.</p>
                        </div>
                    </div>
                </div>

                <h3 class="mb-4">Tính Năng Nổi Bật</h3>
                <div class="row mb-5">
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <h5>Mua Sắm Trực Tuyến</h5>
                            <p>Mua sắm trái cây dễ dàng với giao diện thân thiện, thanh toán an toàn và giao hàng tận nơi trong ngày.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-seedling"></i>
                            </div>
                            <h5>Truy Xuất Nguồn Gốc</h5>
                            <p>Quét mã QR để biết chi tiết về nguồn gốc, quy trình canh tác và hành trình của trái cây từ vườn đến tay bạn.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <h5>Đặt Hàng Định Kỳ</h5>
                            <p>Tự động nhận trái cây tươi ngon hàng tuần với gói đăng ký linh hoạt, tiết kiệm thời gian và công sức.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-gift"></i>
                            </div>
                            <h5>Quà Tặng Trái Cây</h5>
                            <p>Dịch vụ thiết kế và giao quà tặng trái cây sang trọng, phù hợp cho mọi dịp đặc biệt.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-book-open"></i>
                            </div>
                            <h5>Thư Viện Dinh Dưỡng</h5>
                            <p>Kho tàng thông tin về giá trị dinh dưỡng, lợi ích sức khỏe và cách chế biến từng loại trái cây.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h5>Cộng Đồng Fruitiverse</h5>
                            <p>Kết nối với những người yêu thích trái cây, chia sẻ công thức và kinh nghiệm sử dụng trái cây.</p>
                        </div>
                    </div>
                </div>

                <h3 class="mb-4">Mục Tiêu Dự Án</h3>
                <ul class="project-goals mb-5">
                    <li>
                        <h5>Mở Rộng Kênh Bán Hàng</h5>
                        <p>Tăng doanh số bán hàng trực tuyến lên 50% tổng doanh thu trong năm 2025 thông qua nền tảng website mới.</p>
                    </li>
                    <li>
                        <h5>Nâng Cao Trải Nghiệm Khách Hàng</h5>
                        <p>Xây dựng hệ thống đặt hàng và thanh toán trực tuyến thuận tiện, đơn giản với tốc độ xử lý nhanh chóng.</p>
                    </li>
                    <li>
                        <h5>Minh Bạch Thông Tin</h5>
                        <p>Cung cấp thông tin đầy đủ, chính xác về sản phẩm, giúp khách hàng đưa ra quyết định mua sắm sáng suốt.</p>
                    </li>
                    <li>
                        <h5>Xây Dựng Cộng Đồng</h5>
                        <p>Tạo dựng không gian trực tuyến cho những người yêu thích lối sống lành mạnh, trao đổi và chia sẻ kinh nghiệm.</p>
                    </li>
                    <li>
                        <h5>Phát Triển Bền Vững</h5>
                        <p>Hỗ trợ các nhà sản xuất địa phương, khuyến khích phương pháp canh tác hữu cơ và giảm thiểu tác động môi trường.</p>
                    </li>
                </ul>

                <div class="progress-section mb-5">
                    <h3 class="mb-4">Tiến Độ Dự Án</h3>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <h6 class="mb-0">Thiết Kế Giao Diện</h6>
                            <span>100%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <h6 class="mb-0">Phát Triển Front-end</h6>
                            <span>85%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <h6 class="mb-0">Phát Triển Back-end</h6>
                            <span>70%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 70%" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <h6 class="mb-0">Tích Hợp Thanh Toán</h6>
                            <span>60%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div>
                        <div class="d-flex justify-content-between mb-2">
                            <h6 class="mb-0">Kiểm Thử & Tối Ưu</h6>
                            <span>40%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>

                <h3 class="mb-4">Công Nghệ Sử Dụng</h3>
                <div class="row mb-5">
                    <div class="col-md-6 mb-4">
                        <div class="tech-card">
                            <h5>Front-end</h5>
                            <ul>
                                <li>HTML5, CSS3, JavaScript</li>
                                <li>React.js & Redux</li>
                                <li>Bootstrap 5</li>
                                <li>SCSS</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="tech-card">
                            <h5>Back-end</h5>
                            <ul>
                                <li>Node.js & Express</li>
                                <li>MongoDB</li>
                                <li>JWT Authentication</li>
                                <li>RESTful API</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="tech-card">
                            <h5>Thanh Toán & Bảo Mật</h5>
                            <ul>
                                <li>VNPay & Momo Integration</li>
                                <li>SSL Certification</li>
                                <li>Data Encryption</li>
                                <li>GDPR Compliance</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="tech-card">
                            <h5>Triển Khai & Quản Lý</h5>
                            <ul>
                                <li>AWS Cloud Services</li>
                                <li>Docker & Kubernetes</li>
                                <li>CI/CD Pipeline</li>
                                <li>Google Analytics</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <h3 class="mb-4">Lộ Trình Phát Triển</h3>
                <div class="roadmap-section mb-5">
                    <div class="roadmap-item">
                        <div class="roadmap-date">Q1 2025</div>
                        <div class="roadmap-content">
                            <h5>Ra Mắt Phiên Bản Beta</h5>
                            <p>Phát hành phiên bản thử nghiệm của website với các tính năng cơ bản cho nhóm người dùng đầu tiên.</p>
                        </div>
                    </div>
                    <div class="roadmap-item">
                        <div class="roadmap-date">Q2 2025</div>
                        <div class="roadmap-content">
                            <h5>Chính Thức Ra Mắt</h5>
                            <p>Ra mắt phiên bản đầy đủ của website, tích hợp đầy đủ hệ thống thanh toán và giao hàng.</p>
                        </div>
                    </div>
                    <div class="roadmap-item">
                        <div class="roadmap-date">Q3 2025</div>
                        <div class="roadmap-content">
                            <h5>Phát Triển Ứng Dụng Di Động</h5>
                            <p>Phát hành ứng dụng di động trên các nền tảng iOS và Android, tích hợp với website.</p>
                        </div>
                    </div>
                    <div class="roadmap-item">
                        <div class="roadmap-date">Q4 2025</div>
                        <div class="roadmap-content">
                            <h5>Mở Rộng Ra Thị Trường Quốc Tế</h5>
                            <p>Phát triển phiên bản đa ngôn ngữ và mở rộng dịch vụ giao hàng quốc tế, bắt đầu với các nước Đông Nam Á.</p>
                        </div>
                    </div>
                </div>

                <h3 class="mb-4">Đội Ngũ Phát Triển</h3>
                <div class="row mb-5">
                    <div class="col-md-4 mb-4">
                        <div class="team-card">
                            <div class="team-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <h5>Nguyễn Thanh Tùng</h5>
                            <p class="text-muted">Project Manager</p>
                            <p>Quản lý dự án với hơn 8 năm kinh nghiệm phát triển các nền tảng thương mại điện tử.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="team-card">
                            <div class="team-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <h5>Trần Minh Anh</h5>
                            <p class="text-muted">Lead Developer</p>
                            <p>Chuyên gia phát triển full-stack với kinh nghiệm xây dựng các ứng dụng web quy mô lớn.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="team-card">
                            <div class="team-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <h5>Lê Thị Hương</h5>
                            <p class="text-muted">UI/UX Designer</p>
                            <p>Nhà thiết kế giao diện người dùng với đam mê tạo ra những trải nghiệm số trực quan và thân thiện.</p>
                        </div>
                    </div>
                </div>

                <h3 class="mb-4">Liên Hệ & Hợp Tác</h3>
                <div class="contact-info mb-5">
                    <p>Chúng tôi luôn mong muốn được kết nối với các đối tác và khách hàng để cùng nhau phát triển dự án Fruitiverse. Nếu bạn có ý tưởng, đề xuất hoặc mong muốn hợp tác, hãy liên hệ với chúng tôi qua các kênh sau:</p>

                    <div class="contact-method">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <h5 class="mb-1">Email</h5>
                            <p class="mb-0">project@fruitiverse.com</p>
                        </div>
                    </div>

                    <div class="contact-method">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div>
                            <h5 class="mb-1">Điện Thoại</h5>
                            <p class="mb-0">+84 987 654 321</p>
                        </div>
                    </div>

                    <div class="contact-method">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div>
                            <h5 class="mb-1">Văn Phòng Dự Án</h5>
                            <p class="mb-0">Tầng 15