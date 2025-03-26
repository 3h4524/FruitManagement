package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cart;
import model.CartItem;
import model.ProductVariant;
import org.hibernate.Hibernate;
import service.CartService;
import service.ProductService;
import service.ProductVariantService;

import java.io.IOException;

@WebServlet(name = "cartServlet", value = "/carts")
public class CartServlet extends HttpServlet {

    ProductService productService;
    CartService cartService;
    ProductVariantService productVariantService;

    @Override
    public void init() throws ServletException {
        productVariantService =  new ProductVariantService();
        productService = new ProductService();
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        if (action.equalsIgnoreCase("buyNow")) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String size = request.getParameter("size");

                // Kiểm tra nếu size bị null
                if (size == null || size.isEmpty()) {
                    request.setAttribute("error", "Bạn chưa chọn kích thước!");
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                    return;
                }

                ProductVariant productVariant = productVariantService.getVariantByProductAndSize(productId, size);

                // Kiểm tra nếu sản phẩm tồn tại
                if (productVariant == null) {
                    request.setAttribute("error", "Sản phẩm không tồn tại hoặc hết hàng!");
                    request.getRequestDispatcher("productDetail.jsp").forward(request, response);
                    return;
                }

                // Thêm vào giỏ hàng
                CartItem cartItem = new CartItem(quantity, productVariant);
                cartService.addCartItem(cart, cartItem);

                // Cập nhật session
                session.setAttribute("cart", cart);
                session.setAttribute("cartCount", cartService.getTotalQuantity(cart));

                // Chuyển hướng đến trang giỏ hàng
                response.sendRedirect("cart/Cart.jsp");
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Dữ liệu không hợp lệ!");
                request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String xRequestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(xRequestedWith);

        switch (action) {
            case "addToCart":
                addToCart(request, response);
                if(isAjax){
                    return;
                }
            case "delete":
                removeCart(request, response);
                break;
            case "buyNow":
                break;
            case "update":
                updateCart(request, response);
                break;
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String size = request.getParameter("size");

        ProductVariant productVariant = productVariantService.getVariantByProductAndSize(productId, size);
        if(productVariant != null) {
            Hibernate.initialize(productVariant.getProduct());
            CartItem cartItem = new CartItem(quantity, productVariant);
            cartService.addCartItem(cart, cartItem);
        }
        int cartCount = cartService.getTotalQuantity(cart);
        session.setAttribute("cartCount", cartCount);

        String jsonResponse = "{\"cartCount\": " + cartCount + "}";

        // Đặt header chính xác
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }


    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        String productVariantIdStr = request.getParameter("productVariantId");
        String quantityStr = request.getParameter("quantity");

        // Check for missing parameters
        if (productVariantIdStr == null || quantityStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số!");
            return;
        }

        int productVariantId = Integer.parseInt(productVariantIdStr);
        int quantity = Integer.parseInt(quantityStr);

        // Update the quantity of the item in the cart
        cartService.updateCartItemQuantity(cart, productVariantId, quantity);

        // Get the updated cart count (total number of items)
        int cartCount = cartService.getTotalQuantity(cart);
        session.setAttribute("cartCount", cartCount);

        // Create JSON response with the cart count
        String jsonResponse = "{\"success\": true, \"cartCount\": " + cartCount + "}";

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Send the JSON response
        response.getWriter().write(jsonResponse);
    }

    private void removeCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        int productVariantId = Integer.parseInt(request.getParameter("productVariantId"));

        cartService.removeCartItem(cart, productVariantId);
        int cartCount = cartService.getTotalQuantity(cart);
        session.setAttribute("cartCount", cartCount);
        response.sendRedirect(request.getContextPath()+"/cart/Cart.jsp");
    }
}
