<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Dinh dưỡng trái cây - Fruitiverse</title>
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

        h4 {
            color: var(--primary-color);
        }

        /* Custom styles for the nutrition page */
        .nutrition-header {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 60px 0;
            text-align: center;
            margin-bottom: 40px;
            border-radius: 0 0 20px 20px;
        }

        .nutrition-section {
            margin-bottom: 50px;
        }

        .fruit-category {
            background-color: rgba(46, 139, 87, 0.05);
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            border-left: 5px solid var(--primary-color);
        }

        .fruit-card {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
            padding: 20px;
            height: 100%;
            transition: transform 0.3s ease;
            border-top: 4px solid var(--accent-color);
            margin-bottom: 20px;
        }

        .fruit-card:hover {
            transform: translateY(-5px);
        }

        .fruit-icon {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 15px;
            text-align: center;
        }

        .nutrition-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1rem;
        }

        .nutrition-table th,
        .nutrition-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .nutrition-table th {
            background-color: var(--primary-light);
            color: var(--white);
        }

        .nutrition-table tr:nth-child(even) {
            background-color: rgba(46, 139, 87, 0.05);
        }

        .nutrition-table tr:hover {
            background-color: rgba(46, 139, 87, 0.1);
        }

        .benefit-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .benefit-icon {
            background-color: rgba(46, 139, 87, 0.1);
            color: var(--primary-color);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .benefit-content {
            flex: 1;
        }

        .recommendation-section {
            background-color: var(--light-gray);
            padding: 30px;
            border-radius: 10px;
            margin: 40px 0;
        }

        .info-box {
            background-color: rgba(255, 165, 0, 0.1);
            border-left: 4px solid var(--accent-color);
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .seasonal-chart {
            background-color: var(--white);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .seasonal-month {
            padding: 10px;
            text-align: center;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .season-active {
            background-color: rgba(46, 139, 87, 0.2);
            border-color: var(--primary-color);
            color: var(--primary-dark);
            font-weight: bold;
        }

        .tips-section {
            background-color: rgba(46, 139, 87, 0.05);
            padding: 30px;
            border-radius: 10px;
            margin: 30px 0;
        }

        .tip-card {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 20px;
            border-left: 3px solid var(--primary-color);
        }
    </style>
</head>
<body>
<jsp:include page="/templates/header.jsp"/>
<header class="nutrition-header">
    <div class="container">
        <h1 class="display-4 fw-bold">Dinh Dưỡng Trái Cây</h1>
        <p class="lead">Khám phá giá trị dinh dưỡng và lợi ích sức khỏe từ trái cây tại Fruitiverse</p>
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
                    <a href="#" class="list-group-item">
                        <i class="fas fa-store me-2"></i> Về Chúng Tôi
                    </a>
                    <a href="<%= request.getContextPath()%>/products?action=find" class="list-group-item">
                        <i class="fas fa-apple-alt me-2"></i> Sản Phẩm
                    </a>
                    <a href="#" class="list-group-item active">
                        <i class="fas fa-seedling me-2"></i> Dinh Dưỡng
                    </a>
                    <a href="https://www.facebook.com/nextmorningiwillforgether" class="list-group-item">
                        <i class="fas fa-phone-alt me-2"></i> Liên Hệ
                    </a>
                </div>
            </div>
        </div>

        <div class="col-lg-9">
            <div class="account-content">
                <h2 class="account-title">Giá Trị Dinh Dưỡng Của Trái Cây</h2>

                <div class="nutrition-section">
                    <p>Tại Fruitiverse, chúng tôi tin rằng hiểu biết về giá trị dinh dưỡng của trái cây là bước đầu tiên để có một chế độ ăn uống cân bằng và lành mạnh. Mỗi loại trái cây không chỉ mang đến hương vị thơm ngon mà còn chứa những dưỡng chất thiết yếu cho cơ thể.</p>

                    <div class="info-box mt-4">
                        <h5 class="mb-2"><i class="fas fa-lightbulb me-2"></i> Bạn có biết?</h5>
                        <p class="mb-0">Theo Tổ chức Y tế Thế giới (WHO), việc tiêu thụ ít nhất 400g trái cây và rau quả mỗi ngày có thể giúp giảm nguy cơ mắc các bệnh tim mạch, ung thư, tiểu đường và béo phì.</p>
                    </div>
                </div>

                <div class="fruit-category">
                    <h3 class="mb-4">Nhóm Trái Cây Nhiệt Đới</h3>
                    <p>Việt Nam được thiên nhiên ưu đãi với khí hậu nhiệt đới, mang đến đa dạng các loại trái cây giàu dinh dưỡng quanh năm.</p>

                    <div class="row mt-4">
                        <div class="col-md-6 mb-4">
                            <div class="fruit-card">
                                <div class="fruit-icon">
                                    <i class="fas fa-dragon"></i>
                                </div>
                                <h4>Thanh Long</h4>
                                <p>Thanh long là "siêu trái cây" với hàm lượng chất chống oxy hóa cao, giàu vitamin C và các nhóm vitamin B. Đặc biệt, thanh long ruột đỏ còn chứa lycopene - chất có khả năng chống ung thư.</p>
                                <h5 class="mt-3">Giá trị dinh dưỡng (100g):</h5>
                                <table class="nutrition-table">
                                    <tr>
                                        <td>Calo</td>
                                        <td>60 kcal</td>
                                    </tr>
                                    <tr>
                                        <td>Carbohydrate</td>
                                        <td>13g</td>
                                    </tr>
                                    <tr>
                                        <td>Chất xơ</td>
                                        <td>3g</td>
                                    </tr>
                                    <tr>
                                        <td>Vitamin C</td>
                                        <td>9% RDI</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="fruit-card">
                                <div class="fruit-icon">
                                    <i class="fas fa-lemon"></i>
                                </div>
                                <h4>Xoài</h4>
                                <p>Được mệnh danh là "vua của các loại trái cây", xoài không chỉ thơm ngon mà còn giàu vitamin A, C và chất chống oxy hóa. Một quả xoài cung cấp hơn 100% nhu cầu vitamin C hàng ngày.</p>
                                <h5 class="mt-3">Giá trị dinh dưỡng (100g):</h5>
                                <table class="nutrition-table">
                                    <tr>
                                        <td>Calo</td>
                                        <td>60 kcal</td>
                                    </tr>
                                    <tr>
                                        <td>Carbohydrate</td>
                                        <td>15g</td>
                                    </tr>
                                    <tr>
                                        <td>Chất xơ</td>
                                        <td>1.6g</td>
                                    </tr>
                                    <tr>
                                        <td>Vitamin A</td>
                                        <td>25% RDI</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="fruit-category">
                    <h3 class="mb-4">Nhóm Trái Cây Nhập Khẩu</h3>
                    <p>Để đa dạng hóa lựa chọn, Fruitiverse tự hào cung cấp các loại trái cây nhập khẩu chất lượng cao từ những nguồn uy tín trên thế giới.</p>

                    <div class="row mt-4">
                        <div class="col-md-6 mb-4">
                            <div class="fruit-card">
                                <div class="fruit-icon">
                                    <i class="fas fa-apple-alt"></i>
                                </div>
                                <h4>Táo Fuji Nhật Bản</h4>
                                <p>Táo Fuji nổi tiếng với vị ngọt đậm đà và giòn tan. Loại táo này giàu chất xơ hòa tan pectin, giúp giảm cholesterol và cải thiện sức khỏe đường ruột.</p>
                                <h5 class="mt-3">Giá trị dinh dưỡng (100g):</h5>
                                <table class="nutrition-table">
                                    <tr>
                                        <td>Calo</td>
                                        <td>52 kcal</td>
                                    </tr>
                                    <tr>
                                        <td>Carbohydrate</td>
                                        <td>14g</td>
                                    </tr>
                                    <tr>
                                        <td>Chất xơ</td>
                                        <td>2.4g</td>
                                    </tr>
                                    <tr>
                                        <td>Vitamin C</td>
                                        <td>8% RDI</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="fruit-card">
                                <div class="fruit-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <h4>Kiwi New Zealand</h4>
                                <p>Kiwi là một trong những loại trái cây giàu vitamin C nhất, với hàm lượng gấp đôi cam. Ngoài ra, kiwi còn chứa enzyme actinidin giúp hỗ trợ tiêu hóa protein.</p>
                                <h5 class="mt-3">Giá trị dinh dưỡng (100g):</h5>
                                <table class="nutrition-table">
                                    <tr>
                                        <td>Calo</td>
                                        <td>61 kcal</td>
                                    </tr>
                                    <tr>
                                        <td>Carbohydrate</td>
                                        <td>15g</td>
                                    </tr>
                                    <tr>
                                        <td>Chất xơ</td>
                                        <td>3g</td>
                                    </tr>
                                    <tr>
                                        <td>Vitamin C</td>
                                        <td>154% RDI</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tips-section">
                    <h3 class="mb-4 text-center">Lợi Ích Sức Khỏe Từ Trái Cây</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="benefit-item">
                                <div class="benefit-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <div class="benefit-content">
                                    <h5>Sức khỏe tim mạch</h5>
                                    <p>Nhiều loại trái cây như việt quất, dâu tây và lựu chứa chất chống oxy hóa giúp giảm viêm và hỗ trợ sức khỏe tim mạch. Chất xơ trong trái cây cũng giúp giảm cholesterol xấu.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="benefit-item">
                                <div class="benefit-icon">
                                    <i class="fas fa-brain"></i>
                                </div>
                                <div class="benefit-content">
                                    <h5>Cải thiện trí nhớ</h5>
                                    <p>Các loại quả mọng như dâu tây, việt quất và cherry chứa flavonoid, giúp cải thiện trí nhớ và làm chậm quá trình suy giảm nhận thức do tuổi tác.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="benefit-item">
                                <div class="benefit-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <div class="benefit-content">
                                    <h5>Tăng cường miễn dịch</h5>
                                    <p>Vitamin C trong các loại trái cây như cam, chanh, kiwi giúp tăng cường hệ miễn dịch, hỗ trợ cơ thể chống lại các bệnh nhiễm trùng.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="benefit-item">
                                <div class="benefit-icon">
                                    <i class="fas fa-weight"></i>
                                </div>
                                <div class="benefit-content">
                                    <h5>Kiểm soát cân nặng</h5>
                                    <p>Trái cây giàu chất xơ, giúp tạo cảm giác no lâu, giảm cảm giác thèm ăn và hỗ trợ kiểm soát cân nặng hiệu quả.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="seasonal-chart">
                    <h3 class="mb-4 text-center">Bảng Mùa Vụ Trái Cây</h3>
                    <p class="text-center mb-4">Tại Fruitiverse, chúng tôi ưu tiên cung cấp trái cây theo mùa để đảm bảo hương vị tươi ngon nhất và giá thành hợp lý nhất.</p>
                    <div class="row">
                        <div class="col-md-3 col-6">
                            <div class="seasonal-month">
                                <h5>Tháng 1-3</h5>
                                <p>Dâu tây, Bưởi, Thanh long</p>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="seasonal-month season-active">
                                <h5>Tháng 4-6</h5>
                                <p>Vải, Nhãn, Xoài, Dứa</p>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="seasonal-month">
                                <h5>Tháng 7-9</h5>
                                <p>Sầu riêng, Măng cụt, Mít</p>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="seasonal-month">
                                <h5>Tháng 10-12</h5>
                                <p>Cam, Quýt, Bưởi, Hồng</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="recommendation-section">
                    <h3 class="mb-4">Khuyến Nghị Tiêu Thụ</h3>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="tip-card">
                                <h5><i class="fas fa-utensils me-2"></i> Người lớn</h5>
                                <p>Nên tiêu thụ ít nhất 2-3 phần trái cây mỗi ngày. Một phần tương đương với 1 quả táo cỡ vừa, 1 quả chuối, 2 quả kiwi nhỏ hoặc 1 cốc trái cây cắt nhỏ.</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="tip-card">
                                <h5><i class="fas fa-child me-2"></i> Trẻ em</h5>
                                <p>Trẻ em từ 4-8 tuổi nên tiêu thụ 1-1.5 phần trái cây mỗi ngày. Trẻ em từ 9-13 tuổi nên tiêu thụ 1.5-2 phần trái cây mỗi ngày.</p>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="tip-card">
                                <h5><i class="fas fa-calendar-alt me-2"></i> Đa dạng hóa</h5>
                                <p>Để đảm bảo cơ thể nhận được đầy đủ các dưỡng chất, nên tiêu thụ nhiều loại trái cây khác nhau, với màu sắc phong phú. Mỗi màu sắc trong trái cây đại diện cho các nhóm dưỡng chất khác nhau:</p>
                                <ul>
                                    <li><strong>Đỏ (dâu tây, cherry):</strong> Lycopene, anthocyanin - chống oxy hóa, bảo vệ tim mạch</li>
                                    <li><strong>Cam/Vàng (cam, xoài):</strong> Beta-carotene, vitamin C - tăng cường miễn dịch, sức khỏe mắt</li>
                                    <li><strong>Xanh (kiwi, táo xanh):</strong> Lutein, zeaxanthin - sức khỏe mắt, ngăn ngừa thoái hóa điểm vàng</li>
                                    <li><strong>Tím/Xanh đậm (việt quất, nho):</strong> Resveratrol, anthocyanin - chống lão hóa, bảo vệ não</li>
                                    <li><strong>Trắng (chuối, lê):</strong> Quercetin, potassium - sức khỏe tim mạch, cân bằng điện giải</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tips-section">
                    <h3 class="mb-4 text-center">Lưu Ý Khi Tiêu Thụ Trái Cây</h3>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="tip-card">
                                <h5><i class="fas fa-clock me-2"></i> Thời điểm tốt nhất</h5>
                                <p>Nên ăn trái cây vào buổi sáng hoặc giữa các bữa ăn để hấp thu dưỡng chất tốt nhất và tránh đầy hơi.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="tip-card">
                                <h5><i class="fas fa-shower me-2"></i> Rửa kỹ trước khi ăn</h5>
                                <p>Luôn rửa kỹ trái cây dưới vòi nước sạch để loại bỏ hóa chất bảo quản và vi khuẩn có hại.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="tip-card">
                                <h5><i class="fas fa-balance-scale me-2"></i> Cân đối đường</h5>
                                <p>Mặc dù lành mạnh, trái cây vẫn chứa đường tự nhiên. Người mắc bệnh tiểu đường nên tham khảo ý kiến bác sĩ.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-5">
                    <h4>Tư Vấn Dinh Dưỡng Cá Nhân</h4>
                    <p class="mb-4">Tại Fruitiverse, chúng tôi cung cấp dịch vụ tư vấn dinh dưỡng cá nhân hóa để giúp bạn xây dựng chế độ ăn trái cây phù hợp với nhu cầu sức khỏe và mục tiêu cá nhân.</p>
                    <a href="#" class="btn btn-primary me-2">Đăng Ký Tư Vấn</a>
                    <a href="<%= request.getContextPath()%>/products?action=find" class="btn btn-outline-primary">Mua Sắm Ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/templates/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>