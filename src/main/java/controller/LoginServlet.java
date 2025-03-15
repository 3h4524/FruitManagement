
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
        User user = (User) session.getAttribute("user");
        if(user == null) {
            user = new User();
            session.setAttribute("user", user);
        }
        response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = userService.getUserByEmail(email);

        if(user != null && Utils.checkPassword(password, user.getPasswordHash())) {
            if(user.getStatus().equals("INACTIVE")){
                request.getSession().setAttribute("error", "Tài khoản này đã bị vô hiệu hóa.");
                response.sendRedirect(request.getContextPath() + "/page?view=user/Login.jsp");
                return;
            }
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("index.jsp");
        } else {
            request.getSession().setAttribute("error", "Email hoặc mật khẩu không đúng.");
            response.sendRedirect(request.getContextPath() + "/page?view=user/Login.jsp");
        }
    }
}
