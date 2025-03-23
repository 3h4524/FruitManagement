
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
    private UserService userService;
    public void init(){
        userService = new UserService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("googleClientId", Utils.getProperty("google.clientId"));
        request.setAttribute("googleRedirectUri", Utils.getProperty("google.redirectUri"));
        request.getRequestDispatcher("/user/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        User user = userService.getUserByEmail(email);
        HttpSession session = request.getSession();
        if(user == null || !Utils.checkPassword(password, user.getPasswordHash())) {
            session.setAttribute("error", "Email hoặc mật khẩu không đúng");
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }
        if(user.getStatus().equals("INACTIVE")){
            session.setAttribute("error", "Tài khoản này đã bị vô hiệu hóa.");
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }
        if(rememberMe != null && rememberMe.equals("on")){
            String token = Utils.generateToken();
            String hashToken = Utils.hashToken(token);
            Cookie cookie = new Cookie("accessToken", token); // Lưu token vào cookie
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            cookie.setHttpOnly(true); // Bảo mật chống XSS
            cookie.setSecure(true); // Chỉ gửi qua HTTPS
            response.addCookie(cookie);
            user.setRememberToken(hashToken);
            userService.updateUser(user);
        }
        session.setAttribute("UserLogin", user);
        response.sendRedirect("index.jsp");
    }

}
