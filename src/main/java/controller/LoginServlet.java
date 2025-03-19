
package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.UserService;
import service.Utils;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cookie[] cookies = request.getCookies();
        String email = null;
        String token = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberEmail".equals(cookie.getName())) {
                    email = cookie.getValue();
                }
                if ("rememberToken".equals(cookie.getName())) {
                    token = cookie.getValue();
                }
            }
        }

        if (email != null && token != null) {
            User user = userService.getUserByEmail(email);
            if (user != null && userService.isValidToken(user.getId(), token)) {
                session.setAttribute("UserLogin", user);
                response.sendRedirect("index.jsp");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/user/Login.jsp");

        response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // Lấy giá trị từ checkbox "Remember Me"

        User user = userService.getUserByEmail(email);
        HttpSession session = request.getSession();

        if (user != null && Utils.checkPassword(password, user.getPasswordHash())) {
            if (user.getStatus().equals("INACTIVE")) {
                session.setAttribute("error", "Tài khoản này đã bị vô hiệu hóa.");
                response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
                return;
            }

            session.setAttribute("UserLogin", user);

            if ("on".equals(remember)) {
                String token = Utils.generateToken(); // Tạo token ngẫu nhiên
                userService.saveRememberToken(user.getId(), token); // Lưu token vào DB

                Cookie emailCookie = new Cookie("rememberEmail", email);
                Cookie tokenCookie = new Cookie("rememberToken", token);

                emailCookie.setMaxAge(7 * 24 * 60 * 60);  // Lưu 7 ngày
                tokenCookie.setMaxAge(7 * 24 * 60 * 60);

                response.addCookie(emailCookie);
                response.addCookie(tokenCookie);
            }

            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("error", "Email hoặc mật khẩu không đúng");
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
        }
    }
}
