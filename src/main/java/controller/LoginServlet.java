
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
        response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pasword = request.getParameter("password");
        User user = userService.getUserByEmail(email);
        HttpSession session = request.getSession();
        if(user != null && Utils.checkPassword(pasword, user.getPasswordHash())) {
            if(user.getStatus().equals("INACTIVE")){
                session.setAttribute("error", "Tài khoản này đã bị vô hiệu hóa.");
                response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            }
            session.setAttribute("UserLogin", user);
            response.sendRedirect("index.jsp");
        }else{
            session.setAttribute("error", "Email hoặc mật khẩu không đúng");
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
        }
    }
}
