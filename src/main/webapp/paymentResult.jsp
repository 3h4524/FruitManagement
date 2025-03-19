<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 18/03/2025
  Time: 7:46 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Kết quả thanh toán</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<section style="margin-top: 50px; text-align: center;">
    <div>
        <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:150:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Review-empty.png"
             alt="Transaction Status"
             style="width: 120px; height: 120px; margin-bottom: 20px;">
    </div>

    <!-- Giao dịch thành công -->
    <c:if test="${transResult eq true}">
        <div>
            <h3 style="font-weight: bold; color: #28a745;">
                Bạn đã giao dịch thành công!
                <i class="fas fa-check-circle"></i>
            </h3>
            <p style="font-size: 18px; margin-top: 15px;">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
            <strong style="color: red; font-size: 24px;">0383459560</strong>
        </div>
    </c:if>

    <!-- Giao dịch thất bại -->
    <c:if test="${transResult eq false}">
        <div>
            <h3 style="font-weight: bold; color: #dc3545;">
                Đơn hàng giao dịch thất bại!
            </h3>
            <p style="font-size: 18px; margin-top: 15px;">Cảm ơn quý khách đã dùng dịch vụ của chúng tôi.</p>
            <p style="font-size: 18px;">Liên hệ tổng đài để được tư vấn:</p>
            <strong style="color: red; font-size: 24px;">0383456xxx</strong>
        </div>
    </c:if>

    <!-- Đang xử lý giao dịch -->
    <c:if test="${transResult == null}">
        <div>
            <h3 style="font-weight: bold; color: #ffc107;">
                Chúng tôi đã tiếp nhận đơn hàng, xin chờ quá trình xử lý!
            </h3>
            <p style="font-size: 18px; margin-top: 15px;">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
            <strong style="color: red; font-size: 24px;">0383456xxx</strong>
        </div>
    </c:if>
</section>
<a href="${pageContext.request.contextPath}/index.jsp">Quay về trang chủ</a>
</body>
</html>
