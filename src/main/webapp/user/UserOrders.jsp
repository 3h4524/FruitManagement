<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="service.OrderService" %>
<jsp:useBean id="orderService" class="service.OrderService" scope="page"/>
<c:set var="user" value="${sessionScope.UserLogin}"/>
<c:set var="orderDetails" value="${orderService.getOrderDetailsByUserId(user.id)}" scope="request"/>

<style>
    /* Order styling */
    .order-card {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        overflow: hidden;
    }

    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 15px;
        border-bottom: 1px solid #e0e0e0;
        background-color: #f8f9fa;
    }

    .order-status {
        font-weight: 600;
        color: #2e8b57;
    }

    .order-item {
        display: flex;
        padding: 15px;
        border-bottom: 1px solid #e0e0e0;
    }

    .order-item:last-child {
        border-bottom: none;
    }

    .item-image {
        width: 70px;
        height: 70px;
        margin-right: 15px;
        flex-shrink: 0;
    }

    .item-image img {
        width: 100%;
        height: 100%;
        object-fit: contain;
        border-radius: 4px;
    }

    .item-details {
        flex-grow: 1;
    }

    .item-name {
        font-weight: 600;
        margin-bottom: 5px;
        color: #333;
    }

    .item-specs {
        color: #666;
        font-size: 0.9em;
        margin-bottom: 5px;
    }

    .item-quantity {
        color: #666;
        font-size: 0.9em;
    }

    .item-price {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-end;
        min-width: 120px;
        text-align: right;
    }

    .price-current {
        font-weight: 600;
        color: #2e8b57;
        font-size: 1.1em;
    }

    .price-multiplier {
        color: #666;
        font-size: 0.9em;
        margin-top: 5px;
    }

    .order-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 15px;
        background-color: #f8f9fa;
        border-top: 1px solid #e0e0e0;
    }

    .order-total {
        font-weight: 600;
        color: #333;
    }

    .order-total-value {
        font-weight: 700;
        color: #2e8b57;
    }

    /* Empty state */
    .empty-state {
        text-align: center;
        padding: 40px 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .empty-state i {
        font-size: 40px;
        color: #2e8b57;
        margin-bottom: 15px;
    }

    .empty-state h3 {
        color: #333;
        margin-bottom: 10px;
    }

    .empty-state p {
        color: #666;
        margin-bottom: 20px;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .order-item {
            flex-direction: column;
        }

        .item-image {
            margin-right: 0;
            margin-bottom: 10px;
        }

        .item-price {
            align-items: flex-start;
            margin-top: 10px;
        }

        .order-footer {
            flex-direction: column;
            align-items: flex-start;
        }

        .order-total {
            margin-bottom: 10px;
        }
        .orders-container{
            padding: 20px;
            width: 100%
        }
    }
</style>

<div class="orders-container">
<h4 class="mb-4 border-bottom pb-3">Đơn hàng của tôi</h4>

<c:choose>
    <c:when test="${empty orderDetails}">
        <div class="empty-state">
            <i class="bi bi-box-open"></i>
            <h3>Bạn chưa có đơn hàng nào!</h3>
            <p>Hãy tiếp tục mua sắm để tạo đơn hàng mới.</p>
            <a href="${pageContext.request.contextPath}/shop.jsp" class="btn btn-success">Mua sắm ngay</a>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Group orders by orderID -->
        <c:set var="currentOrderId" value=""/>
        <c:set var="orderTotal" value="0"/>

        <c:forEach var="detail" items="${orderDetails}" varStatus="status">
            <c:if test="${currentOrderId != detail.orderID.id}">
                <!-- Close previous order card if not the first -->
                <c:if test="${!status.first && currentOrderId != ''}">
                    <div class="order-footer">
                        <div class="order-total">
                            Tổng số tiền (${orderItemCount} sản phẩm):
                            <span class="order-total-value">₫<fmt:formatNumber value="${orderTotal}" pattern="#,###"/></span>
                        </div>
                        <div>
                            <button class="btn btn-success">Mua lại</button>
                        </div>
                    </div>
                    </div>
                </c:if>

                <!-- Set new current order and reset total -->
                <c:set var="currentOrderId" value="${detail.orderID.id}"/>
                <c:set var="orderTotal" value="0"/>
                <c:set var="orderItemCount" value="0"/>

                <!-- Start new order card -->
                <div class="order-card">
                <div class="order-header">
                    <div>
                        <strong>Fruitiverse</strong>
                    </div>
                    <div class="order-status">
                            ${detail.orderID.status}
                    </div>
                </div>
            </c:if>

            <!-- Add item to order and update total -->
            <c:set var="orderTotal" value="${orderTotal + detail.price}"/>
            <c:set var="orderItemCount" value="${orderItemCount + 1}"/>

            <div class="order-item">
                <div class="item-image">
                    <img src="${detail.productVariantID.productID.imageURL}" alt="${detail.productVariantID.productID.name}">
                </div>
                <div class="item-details">
                    <div class="item-name">${detail.productVariantID.productID.name}</div>
                    <div class="item-specs">
                            ${detail.productVariantID.size}
                    </div>
                    <div class="item-quantity">x${detail.quantity}</div>
                </div>
                <div class="item-price">
                    <div class="price-current">₫<fmt:formatNumber value="${detail.price}" pattern="#,###"/></div>
                    <div class="price-multiplier">₫<fmt:formatNumber value="${detail.productVariantID.price}" pattern="#,###"/></div>
                </div>
            </div>

            <!-- Close the last order card -->
            <c:if test="${status.last}">
                <div class="order-footer">
                    <div class="order-total">
                        Tổng số tiền (${orderItemCount} sản phẩm):
                        <span class="order-total-value">₫<fmt:formatNumber value="${orderTotal}" pattern="#,###"/></span>
                    </div>
                    <div>
                        <button class="btn btn-success">Mua lại</button>
                    </div>
                </div>
                </div>
            </c:if>
        </c:forEach>
    </c:otherwise>
</c:choose>
</div>