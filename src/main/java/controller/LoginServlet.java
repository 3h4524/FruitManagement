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

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pasword = request.getParameter("password");
        User user = userService.getUserByEmail(email);
        if(user != null && Utils.checkPassword(pasword, user.getPasswordHash())) {
            if(user.getStatus().equals("INACTIVE")){
                request.setAttribute("message", "Tài khoản này đã bị vô hiệu hóa.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            HttpSession session = request.getSession();
            session.setAttribute("UserLogin", user);
            response.sendRedirect("index.jsp");
        }else{
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
