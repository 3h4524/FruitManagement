//package filter;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.User;
//
//import java.io.IOException;
//import java.util.Set;
//
//@WebFilter("/*")
//public class AuthenFilter implements Filter {
//    private static final Set<String> FUNC_FOR_USER = Set.of(
//            "/carts", "/cart/Cart.jsp", "/products?action=find", "/product/ProductListCart.jsp",
//            "/products?action=productDetail", "/product/ProductDetail.jsp", "/checkout", "/cart/Success.jsp"
//    );
//    private static final Set<String> FUNC_FOR_ADMIN = Set.of(
//            "/products", "/users", "/product/CreateProduct.jsp",
//            "/product/ProductList.jsp", "/product/UpdateProduct.jsp"
//    );
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpServletResponse res = (HttpServletResponse) response;
//        HttpSession session = req.getSession(false);
//
//        String path = req.getServletPath();
//        String queryString = req.getQueryString();
//        String fullPath = (queryString != null) ? path + "?" + queryString : path;
//
//        boolean isPublicPage = path.startsWith("/login") || path.startsWith("/register")
//                || path.endsWith("ProductListCart.jsp") || path.startsWith("/index.jsp")
//                || (path.equals("/products") && queryString != null && queryString.startsWith("action=find"));
//
//        if (isPublicPage) {
//            chain.doFilter(request, response);
//            return;
//        }
//
//        if (session == null) {
//            res.sendRedirect(req.getContextPath() + "/login");
//            return;
//        }
//
//        User userLogin = (User) session.getAttribute("UserLogin");
//        if (userLogin == null) {
//            res.sendRedirect(req.getContextPath() + "/login");
//            return;
//        }
//
//        String role = userLogin.getRole();
//
//        if ("User".equalsIgnoreCase(role) &&
//                (FUNC_FOR_USER.contains(path) || (path.equals("/products") && queryString != null && queryString.startsWith("action=find")))) {
//            chain.doFilter(request, response);
//        } else if ("Admin".equalsIgnoreCase(role) && FUNC_FOR_ADMIN.contains(path)) {
//            chain.doFilter(request, response);
//        } else {
//            res.sendRedirect(req.getContextPath() + "/accessDenied/AccessDenied.jsp");
//        }
//    }
//}
