package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.UserService;
import service.Utils;

import java.io.IOException;
import java.time.Instant;

@WebServlet(name = "RegisterServlet", value = "/registers")
public class  RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath()+ "/user/Register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy UserLogin từ session, nếu chưa có thì tạo mới
        User user = (User) session.getAttribute("UserLogin");
        if (user == null) {
            user = new User();
        }

        // Lấy dữ liệu từ form và cập nhật vào user
        user.setName(request.getParameter("name").trim());
        user.setEmail(request.getParameter("email").trim());
        user.setPasswordHash(Utils.hashPassword(request.getParameter("password")));
        user.setPhone(request.getParameter("phone").trim());
        user.setStatus("ACTIVE");
        user.setRole("Customer");
        user.setRegistrationDate(Instant.now());

        // Lưu user vào session
        session.setAttribute("UserLogin", user);

        // Kiểm tra thông tin có đầy đủ không
        if (user.getName().isEmpty() || user.getEmail().isEmpty() || user.getPasswordHash().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            response.sendRedirect(request.getContextPath() + "/page?view=user/Register.jsp");
            return;
        }

        // Kiểm tra email đã tồn tại chưa
        if (userService.getUserByEmail(user.getEmail()) != null) {
            session.setAttribute("error", "Email đã tồn tại!");
            response.sendRedirect(request.getContextPath() + "/page?view=user/Register.jsp");
            return;
        }

        // Lưu vào database
        if (userService.addUser(user)) {
            session.setAttribute("success", "Đăng ký thành công!");
            response.sendRedirect(request.getContextPath() + "/page?view=home");
        } else {
            session.setAttribute("error", "Đăng ký không thành công. Vui lòng thử lại!");
            response.sendRedirect(request.getContextPath() + "/page?view=user/Register.jsp");
        }
    }
}
