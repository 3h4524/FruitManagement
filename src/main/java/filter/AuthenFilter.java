package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import service.UserService;
import service.Utils;

import java.io.IOException;
import java.util.Set;

@WebFilter("/*")
public class AuthenFilter implements Filter {
    private UserService userService = new UserService();
    private static final Set<String> FUNC_FOR_USER = Set.of(
            "/carts", "/cart/Cart.jsp", "/products?action=find", "/product/ProductListCart.jsp",
            "/product/ProductDetail.jsp", "/checkout", "/cart/Success.jsp", "/PaymentResult.jsp", "/vnpayReturn", "/user/UserAccount.jsp", "/user/UserOrders.jsp"
    );
    private static final Set<String> FUNC_FOR_ADMIN = Set.of(
            "/products", "/users", "/product/CreateProduct.jsp",
            "/product/ProductList.jsp", "/product/UpdateProduct.jsp", "/inventory", "/order", "/user/UserAccount.jsp"
    );

    private boolean isStaticResource(String path) {
        return path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".jpg") || path.endsWith(".png")
                || path.endsWith(".gif") || path.endsWith(".woff") || path.endsWith(".woff2") || path.endsWith(".ttf");
    }

    private boolean isPublicPage(String path, String queryString) {
        return path.startsWith("/login") || path.startsWith("/register")
                || path.endsWith("ProductListCart.jsp") || path.startsWith("/index.jsp")
                || (path.equals("/products") && queryString != null && queryString.startsWith("action=find"))
                || path.endsWith("/header.jsp") || path.endsWith("/footer.jsp")
                || path.equals("/user/Login.jsp")
                || path.equals("/user/Register.jsp")
                || (path.equals("/products") && queryString != null && queryString.startsWith("action=productDetail"))
                || path.equals("/mails")
                || path.equals("/accessDenied/AccessDenied.jsp")
                || path.equals("/logout")
                || path.equals("/user/Confirm.jsp")
                || path.equals("/pages/History.jsp");
    }

    private boolean isUserAuthorized(String role, String path, String queryString) {
        return "Customer".equalsIgnoreCase(role) && (FUNC_FOR_USER.contains(path) ||
                (path.equals("/products") && queryString != null &&
                        (queryString.startsWith("action=find") || queryString.startsWith("action=productDetail"))
                )
        );
    }

    private boolean isAdminAuthorized(String role, String path) {
        return "Admin".equalsIgnoreCase(role) && FUNC_FOR_ADMIN.contains(path);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        User userLogin = (session != null) ? (User) session.getAttribute("UserLogin") : null;
        if (userLogin == null) {
            Cookie[] cookies = req.getCookies();
            if(cookies != null) {
                for(Cookie cookie : cookies) {
                    if(cookie.getName().equals("accessToken")) {
                        String token = cookie.getValue();
                        if (token != null && !token.isEmpty()) { // Kiểm tra token không rỗng
                            String hashToken = Utils.hashToken(token);
                            userLogin = userService.getUserByToken(hashToken);
                            if (userLogin != null) {
                                session = req.getSession(true); // Tạo session mới nếu chưa có
                                session.setAttribute("UserLogin", userLogin);
                            }
                        }
                        break;
                    }
                }
            }
        }
        String path = req.getServletPath();
        String queryString = req.getQueryString();

        if (isStaticResource(path) || isPublicPage(path, queryString)) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }


        if(userLogin == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = userLogin.getRole();

        if (isUserAuthorized(role, path, queryString) || isAdminAuthorized(role, path)) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/accessDenied/AccessDenied.jsp");
        }
    }
}
