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
import java.util.Map;

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
            request.getRequestDispatcher("cart/Cart.jsp").forward(request, response);
        }

        String action = request.getParameter("action");
        if(action == null) {
            action = "";
        }

        if("getCartCount".equalsIgnoreCase(action)){
            Map<Integer, CartItem> cartItem = cart.getItems();
            int totalQuantity = 0;
            if(cartItem != null){
                for(CartItem item : cartItem.values()){
                    totalQuantity += item.getQuantity();
                }
            }
            response.getWriter().print(String.valueOf(totalQuantity));
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
        switch (action) {
            case "addToCart":
                addToCart(request, response);
                break;
            case "delete":
                removeCart(request, response);
                break;
            case "buyNow":
                break;
            case "update":
                updateCart(request, response);
                break;
        }
        request.getRequestDispatcher("/cart/Cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String size = request.getParameter("size");

        ProductVariant productVariant = productVariantService.getVariantByProductAndSize(productId, size);
        if(productVariant != null) {
            Hibernate.initialize(productVariant.getProductID());
            CartItem cartItem = new CartItem(quantity, productVariant);
            cartService.addCartItem(cart, cartItem);
        }
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        String productVariantIdStr = request.getParameter("productVariantId");
        String quantityStr = request.getParameter("quantity");

        if (productVariantIdStr == null || quantityStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số!");
            return;
        }

        int productVariantId = Integer.parseInt(productVariantIdStr);
        int quantity = Integer.parseInt(quantityStr);


        cartService.updateCartItemQuantity(cart, productVariantId, quantity);
    }

    private void removeCart(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        int productVariantId = Integer.parseInt(request.getParameter("productVariantId"));

        cartService.removeCartItem(cart, productVariantId);
    }
}
