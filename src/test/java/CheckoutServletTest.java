import com.fasterxml.jackson.databind.ObjectMapper;
import controller.CheckoutServlet;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import service.CartService;
import service.MailService;
import service.OrderService;
import service.WebConfigLoader;

import java.io.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.*;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class CheckoutServletTest {

    private CheckoutServlet checkoutServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private OrderService orderService;
    private CartService cartService;
    private MailService mailService;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        checkoutServlet = new CheckoutServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);
        orderService = mock(OrderService.class);
        cartService = mock(CartService.class);
        mailService = mock(MailService.class);
        objectMapper = new ObjectMapper();

        checkoutServlet.init();
    }

    @Test
    void testCheckout_WithEmptyCart() throws Exception {
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("cart")).thenReturn(null);
        when(response.getWriter()).thenReturn(new PrintWriter(new StringWriter()));

        checkoutServlet.doPost(request, response);

        verify(response).sendRedirect(anyString());
    }

    @Test
    void testCheckout_WithValidCart() throws Exception {
        when(request.getSession()).thenReturn(session);
        Cart cart = new Cart();
        Map<Integer, CartItem> items = new HashMap<>();
        ProductVariant variant = new ProductVariant();
        variant.setPrice(new BigDecimal("100.00"));
        CartItem cartItem = new CartItem(1, variant);
        items.put(1, cartItem);
        cart.setItems(items);
        User user = new User();
        user.setEmail("test@example.com");

        when(session.getAttribute("cart")).thenReturn(cart);
        when(session.getAttribute("UserLogin")).thenReturn(user);
        when(response.getWriter()).thenReturn(new PrintWriter(new StringWriter()));

        checkoutServlet.doPost(request, response);

        verify(orderService).createOrder(any(Order.class));
    }
}
