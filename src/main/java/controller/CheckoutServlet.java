        package controller;

        import com.fasterxml.jackson.databind.ObjectMapper;
        import config.Config;
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
        import java.net.URLEncoder;
        import java.nio.charset.StandardCharsets;
        import java.text.SimpleDateFormat;
        import java.time.Instant;
        import java.util.*;
        import java.util.logging.Logger;
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
            public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                    return;
                }


                try{
                    //Đọc JSON từ request
                    Map<String, Object> jsonMap =  objectMapper.readValue(request.getReader(), Map.class);
                    List<Integer> selectedIds = (List<Integer>) jsonMap.get("selectedItems");
                    String paymentMethod = (String) jsonMap.get("paymentMethod");

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
                            .map(item -> (item.getProductVariant().getDiscountPrice() != null ? item.getProductVariant().getDiscountPrice() : item.getProductVariant().getPrice()).multiply(BigDecimal.valueOf(item.getQuantity())))
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
                        orderDetail.setPrice((item.getProductVariant().getDiscountPrice() != null ? item.getProductVariant().getDiscountPrice() : item.getProductVariant().getPrice()).multiply(BigDecimal.valueOf(item.getQuantity())));
                        return orderDetail;
                    }).collect(Collectors.toList());

                    orderService.addOrderDetails(orderDetails);

                    if("vnpay".equals(paymentMethod)){
                        String vnpayUrl = createVnpayPaymentUrl(request, order.getId(), totalPrice);

                        selectedIds.forEach(id -> cartService.removeCartItem(cart, id));
                        session.setAttribute("cart", cart);
                        Integer cartCount = cartService.getTotalQuantity(cart);
                        session.setAttribute("cartCount", cartCount);

                        // Trả về URL thanh toán

                        Map<String, Object> paymentResponse = new HashMap<>();
                        paymentResponse.put("paymentUrl", vnpayUrl);
                        sendSuccessResponse(response, paymentResponse);
                    } else {
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
                    }
                }catch (Exception e){
                    sendErrorResponse(response, "Lỗi khi xử lý thanh toán: " + e.getMessage());
                }
            }

            private String createVnpayPaymentUrl(HttpServletRequest request, Integer orderId, BigDecimal totalAmount) throws Exception {
                String vnp_Version = "2.1.0";
                String vnp_Command = "pay";
                String orderType = "other";
                long totalPriceLong = totalAmount.longValue() * 100;
                String bankCode = request.getParameter("bankCode");
                String vnp_TxnRef = orderId.toString();
                String vnp_IpAddr = Config.getIpAddress(request);

                String vnp_TmnCode = Config.vnp_TmnCode;
                Map<String, String> vnp_Params = new HashMap<>();
                vnp_Params.put("vnp_Version", vnp_Version);
                vnp_Params.put("vnp_Command", vnp_Command);
                vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                vnp_Params.put("vnp_Amount", String.valueOf(totalPriceLong));
                vnp_Params.put("vnp_CurrCode", "VND");

                if (bankCode != null && !bankCode.isEmpty()) {
                    vnp_Params.put("vnp_BankCode", bankCode);
                }
                vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
                vnp_Params.put("vnp_OrderType", orderType);

                String locate = request.getParameter("language");
                if (locate != null && !locate.isEmpty()) {
                    vnp_Params.put("vnp_Locale", locate);
                } else {
                    vnp_Params.put("vnp_Locale", "vn");
                }
                vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
                vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                String vnp_CreateDate = formatter.format(cld.getTime());
                vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                cld.add(Calendar.MINUTE, 15);
                String vnp_ExpireDate = formatter.format(cld.getTime());
                vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

                List fieldNames = new ArrayList(vnp_Params.keySet());
                Collections.sort(fieldNames);
                StringBuilder hashData = new StringBuilder();
                StringBuilder query = new StringBuilder();
                Iterator itr = fieldNames.iterator();
                while (itr.hasNext()) {
                    String fieldName = (String) itr.next();
                    String fieldValue = (String) vnp_Params.get(fieldName);
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        //Build hash data
                        hashData.append(fieldName);
                        hashData.append('=');
                        hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        //Build query
                        query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                        query.append('=');
                        query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        if (itr.hasNext()) {
                            query.append('&');
                            hashData.append('&');
                        }
                    }
                }

                String queryUrl = query.toString();
                String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
                queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

                return paymentUrl;
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
