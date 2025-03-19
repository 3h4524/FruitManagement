<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chào Mừng Đến Với Fruitiverse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Orange-White Theme */
        body {
            margin: 0;
            padding: 0;
            overflow: hidden; /* No scrolling */
            height: 100vh; /* Full viewport height */
            background: url('https://i.fbcd.co/products/resized/resized-750-500/c-1000-designbundle-orange-fruit-banner4-09-07-02213e469c7edd56e579fc43078d78ca54b7a52b8f97759bf215806d935f68b0.jpg') no-repeat center center fixed;
            background-size: cover; /* Cover entire screen */
        }

        .text-orange {
            color: #FFA520; /* Orange text */
        }
        .btn-orange {
            border-color: #FFA520;
            background-color: #FFFFFF;
            color: #FFA520; /* White text */
            transition: all 0.3s ease;
            font-size: 1.5rem; /* Larger button text */
            padding: 15px 30px; /* Larger padding */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 12px rgba(255, 165, 32, 0.6); /* Orange glow */
        }
        .btn-orange:hover {
            background-color: #e59400; /* Darker orange on hover */
            border-color: #e59400;
            color: #FFFFFF;
            box-shadow: 0 6px 16px rgba(255, 165, 32, 0.8); /* Stronger glow on hover */
        }
        .intro-text {
            color: #FFFFFF; /* White text */
            font-size: 1.25rem; /* Larger paragraph text */
            text-shadow: 2px 2px 4px #FFA520; /* Orange shadow for contrast */
        }
        .intro-title {
            color: #FFFFFF; /* White text */
            font-size: 3rem; /* Larger title */
            font-weight: bold;
            text-shadow: 3px 3px 6px #FFA520; /* Stronger orange shadow */
        }
    </style>
</head>
<body>
<div class="container h-100 d-flex align-items-center justify-content-center">
    <div class="col-md-6 text-center">
        <h2 class="intro-title mb-4">Chào Mừng Đến Với Fruitiverse</h2>
        <p class="intro-text mb-4">
            Fruitiverse - Shop trái cây tươi ngon mỗi ngày! Chúng tôi tự hào mang đến những loại trái cây chất lượng cao, an toàn và giàu dinh dưỡng. Hãy khám phá thế giới trái cây tươi mát cùng chúng tôi!
        </p>
        <a href="<%= request.getContextPath()%>/products?action=find" class="btn btn-orange">
            Bắt Đầu Mua Sắm
        </a>
    </div>
</div>
</body>
</html>