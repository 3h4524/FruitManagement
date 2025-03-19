package controller;

import config.Config;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Order;
import service.OrderService;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet(name = "VnpayReturnServlet", value = "/vnpayReturn")
public class VnpayReturnServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(VnpayReturnServlet.class.getName());
    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Map<String, String> fields = new HashMap<>();

        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        fields.remove("vnp_SecureHash");
        fields.remove("vnp_SecureHashType");

        String signValue = Config.hashAllFields(fields);
        if (!signValue.equals(vnp_SecureHash)) {
            logger.warning("Invalid VNPay signature!");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid signature");
            return;
        }

        String orderId = request.getParameter("vnp_TxnRef");
        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Order ID");
            return;
        }

        Order order = orderService.getOrderById(Integer.parseInt(orderId));
        boolean transSuccess = "00".equals(request.getParameter("vnp_TransactionStatus"));

        order.setStatus(transSuccess ? "Completed" : "Cancelled");
        orderService.updateOrder(order);

        request.setAttribute("transResult", transSuccess);
        request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
    }
}
