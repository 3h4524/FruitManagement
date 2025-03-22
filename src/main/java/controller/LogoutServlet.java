package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.UserService;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {
    private UserService userService;
    public void init(){
        userService = new UserService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("UserLogin"); // Lấy user trước khi hủy session
            session.invalidate(); // Hủy session
        }

        // Nếu có user, xóa token trong database
        if (user != null) {
            user.setRememberToken(null);
            userService.updateUser(user);
        }
        Cookie cookie = new Cookie("accessToken", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}