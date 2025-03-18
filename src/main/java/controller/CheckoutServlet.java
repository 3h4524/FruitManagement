package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import service.CartService;
import service.InventoryService;
import service.MailService;
import service.OrderService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {
    private OrderService orderService;
    private CartService cartService;
    private ObjectMapper objectMapper;
    private MailService mailService;
    public void init(){
        orderService = new OrderService();
        cartService = new CartService();
        objectMapper = new ObjectMapper();
        mailService = new MailService();
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

        if(user == null){
            response.sendRedirect(request.getContextPath()+ "/login");
        }


        try{
            //Đọc JSON từ request
            Map<String, Object> jsonMap =  objectMapper.readValue(request.getReader(), Map.class);
            List<Integer> selectedIds = (List<Integer>) jsonMap.get("selectedItems");

            if(selectedIds == null || selectedIds.isEmpty()){
                sendErrorResponse(response, "Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
                return;
            }

            //Lọc các sản phẩm được chọn
            Map<Integer, CartItem> selectedItems = cart.getItems().entrySet().stream()
                            .filter(entry -> selectedIds.contains(entry.getKey()))
                            .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

            if(selectedItems.isEmpty()){
                sendErrorResponse(response, "Không tìm thấy sản phẩm hợp lệ trong giỏ hàng.");
                return;
            }

            //Tính tổng giá trị đơn hàng
            BigDecimal totalPrice = selectedItems.values().stream()
                    .map(item -> item.getProductVariant().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            // tạo đơn hàng
            Order order = new Order();
            order.setUserID(user);
            order.setOrderDate(Instant.now());
            order.setStatus("Pending");
            order.setTotalAmount(totalPrice);
            orderService.createOrder(order);

            //Tạo danh sách chi tiết đơn hàng
            List<OrderDetail>orderDetails = selectedItems.values().stream().map(item -> {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderID(order);
                orderDetail.setProductVariantID(item.getProductVariant());
                orderDetail.setQuantity(item.getQuantity());
                orderDetail.setPrice(item.getProductVariant().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
                return orderDetail;
            }).collect(Collectors.toList());

            orderService.addOrderDetails(orderDetails);

            //Gửi mail cho khách hàng
            mailService.sendOrderConfirmation(user.getEmail(), order.getId().toString(), user.getName(), orderDetails, totalPrice);

            //Xóa các sản phẩm đã thanh toán khỏi giỏ hàng
            selectedIds.forEach(id -> cartService.removeCartItem(cart, id));
            session.setAttribute("cart", cart);
            Integer cartCount = cartService.getTotalQuantity(cart);
            session.setAttribute("cartCount", cartCount);

            //Trả về thông tin đơn hàng dưới dạng JSON
            Map<String, Object> successResponse = new HashMap<>();
            successResponse.put("orderId", order.getId());
            successResponse.put("totalPrice", totalPrice);
            successResponse.put("redirectURL", request.getContextPath() + "/cart/Success.jsp");
            sendSuccessResponse(response, successResponse);

        }catch (Exception e){
            sendErrorResponse(response, "Lỗi khi xử lý thanh toán: " + e.getMessage());
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String error) throws IOException {
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        objectMapper.writeValue(response.getWriter(), error);
    }

    private void sendSuccessResponse(HttpServletResponse response, Map<String, Object> data) throws IOException {
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_OK);
        objectMapper.writeValue(response.getWriter(), data);
    }

}
