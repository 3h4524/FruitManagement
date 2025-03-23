package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jdk.jshell.execution.Util;
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
        String password = request.getParameter("password");
        // Lấy dữ liệu từ form và cập nhật vào user
        user.setName(request.getParameter("name").trim());
        user.setEmail(request.getParameter("email").trim());
        user.setPasswordHash(Utils.hashPassword(password));
        user.setPhone(request.getParameter("phone").trim());
        user.setStatus("ACTIVE");
        user.setRole("Customer");
        user.setRegistrationDate(Instant.now());

        // Lưu lại user vào session sau khi cập nhật dữ liệu
        session.setAttribute("UserLogin", user);

        // Kiểm tra thông tin có đầy đủ không
        if (user.getName().isEmpty() || user.getEmail().isEmpty() || user.getPasswordHash().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/user/Register.jsp").forward(request, response);
            return;
        }
        if(!Utils.isValidPassword(password)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, ít nhất 1 chữ viết hoa và số");
            request.getRequestDispatcher("/user/Register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tên đăng nhập đã tồn tại chưa
        if (userService.getUserByEmail(user.getEmail()) != null) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("/user/Register.jsp").forward(request, response);
            return;
        }

        // Lưu vào database
        if (userService.addUser(user)) {
            request.setAttribute("success", "Đăng ký thành công!");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error", "Đăng ký không thành công. Vui lòng thử lại!");
            request.getRequestDispatcher("/user/Register.jsp").forward(request, response);
        }
    }
}