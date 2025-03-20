<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chào Mừng Đến Với Fruitiverse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Green Theme matching paste.txt CSS variables */
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
            margin: 0;
            padding: 0;
            overflow: hidden; /* No scrolling */
            height: 100vh; /* Full viewport height */
            background: url('https://img.freepik.com/free-photo/top-view-sour-green-tangerines-light-background_140725-79917.jpg?t=st=1742448384~exp=1742451984~hmac=682f23b8937da51515e6545b44bcec399a9a287f9942e84ae1468b1c732b6e65&w=1380') no-repeat center center fixed;
            background-size: cover; /* Cover entire screen */
        }

        .text-green {
            color: var(--primary-color); /* Green text */
        }

        .btn-green {
            border-color: var(--primary-color);
            background-color: var(--white);
            color: var(--primary-color);
            transition: all 0.3s ease;
            font-size: 1.5rem; /* Larger button text */
            padding: 15px 30px; /* Larger padding */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 12px rgba(46, 139, 87, 0.6); /* Green glow */
        }

        .btn-green:hover {
            background-color: var(--primary-dark); /* Darker green on hover */
            border-color: var(--primary-dark);
            color: var(--white);
            box-shadow: 0 6px 16px rgba(46, 139, 87, 0.8); /* Stronger glow on hover */
            transform: translateY(-2px); /* Slight lift effect on hover */
        }

        .intro-text {
            color: var(--white); /* White text */
            font-size: 1.25rem; /* Larger paragraph text */
            text-shadow: 2px 2px 4px rgba(46, 139, 87, 0.7); /* Green shadow for contrast */
        }

        .intro-title {
            color: var(--white); /* White text */
            font-size: 3rem; /* Larger title */
            font-weight: bold;
            text-shadow: 3px 3px 6px rgba(46, 139, 87, 0.8); /* Stronger green shadow */
        }

        /* Adding a semi-transparent overlay to improve text readability */
        .content-overlay {
            background-color: rgba(0, 0, 0, 0.4);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
<div class="container h-100 d-flex align-items-center justify-content-center">
    <div class="col-md-8 text-center content-overlay">
        <h2 class="intro-title mb-4">Chào Mừng Đến Với Fruitiverse</h2>
        <p class="intro-text mb-5">
            Fruitiverse - Shop trái cây tươi ngon mỗi ngày! Chúng tôi tự hào mang đến những loại trái cây chất lượng cao, an toàn và giàu dinh dưỡng. Hãy khám phá thế giới trái cây tươi mát cùng chúng tôi!
        </p>
        <a href="<%= request.getContextPath()%>/products?action=find" class="btn btn-green">
            Bắt Đầu Mua Sắm
        </a>
    </div>
</div>
</body>
</html>