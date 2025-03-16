package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import service.InventoryService;
import service.OrderService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {
    private OrderService orderService;

    public void init(){
        orderService = new OrderService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("UserLogin");

        // Kiểm tra giỏ hàng và đăng nhập
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath()+ "/cart/Cart.jsp");
            return;
        }

        // Tính tổng giá trị đơn hàng
        BigDecimal totalPrice = cart.getItems().values().stream()
                .map(item -> item.getProductVariant().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Tạo đơn hàng
        Order order = new Order();
        order.setUserID(user);
        order.setOrderDate(Instant.now());
        order.setStatus("Pending");
        order.setTotalAmount(totalPrice);
        orderService.createOrder(order);

        // Tạo danh sách OrderDetail
        List<OrderDetail> orderDetails = cart.getItems().values().stream().map(item -> {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderID(order);
            orderDetail.setProductVariantID(item.getProductVariant());
            orderDetail.setQuantity(item.getQuantity());
            orderDetail.setPrice(item.getProductVariant().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            return orderDetail;
        }).collect(Collectors.toList());

        // Lưu danh sách OrderDetail vào database
        orderService.addOrderDetails(orderDetails);
        session.removeAttribute("cart");
        request.setAttribute("orderId", order.getId());
        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("/cart/Success.jsp").forward(request, response);
    }

}
