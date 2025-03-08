package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import service.OrderService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {
    private OrderService orderService = new OrderService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Customer customer = (Customer) session.getAttribute("UserLogin");

        // Kiểm tra giỏ hàng và đăng nhập
        if (cart == null || cart.getItems().isEmpty() || customer == null) {
            response.sendRedirect("cart/Cart.jsp");
            return;
        }

        // Tính tổng giá trị đơn hàng
        BigDecimal totalPrice = cart.getItems().stream()
                .map(item -> item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Tạo đơn hàng
        Order order = new Order();
        order.setCustomerID(customer);
        order.setStatus("Pending");
        orderService.createOrder(order);

        // Tạo danh sách OrderDetail
        List<OrderDetail> orderDetails = cart.getItems().stream().map(item -> {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderID(order);
            orderDetail.setProductID(item.getProduct());
            orderDetail.setQuantity(item.getQuantity());
            orderDetail.setPrice(item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            return orderDetail;
        }).collect(Collectors.toList());

        // Lưu danh sách OrderDetail vào database
        orderService.addOrderDetails(orderDetails);

        // Xóa giỏ hàng khỏi session và chuyển hướng
        session.removeAttribute("cart");
        response.sendRedirect("success.jsp");
    }

}
