
package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.UserService;
import service.Utils;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "userServlet", value = "/users")
public class UserServlet extends HttpServlet {
    private UserService userService;
    public void init(){
        userService = new UserService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch(action){
            case "search":
                searchUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            case "restore":
                restoreUser(request, response);
                break;
                default:
                userList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch(action){
            case "create":
                createUser(request, response);
                break;
            case "update":
                saveUpdateUser(request, response);
                break;
        }
    }
    public void userList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.getAllUser();
        HttpSession session = request.getSession();
        session.setAttribute("users", users);
        request.getRequestDispatcher("user/UserList.jsp").forward(request, response);
    }
    public void createUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("UserLogin");

        if (user == null) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        String name = user.getName() != null ? user.getName().trim() : "";
        String email = user.getEmail() != null ? user.getEmail().trim() : "";
        String password = user.getPasswordHash() != null ? user.getPasswordHash().trim() : "";

        // Kiểm tra thông tin có đầy đủ không
        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tên đăng nhập đã tồn tại chưa
        if (userService.getUserByEmail(email) != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu và cập nhật lại cho Customer
        user.setPasswordHash(Utils.hashPassword(password));

        // Lưu vào database
        if (userService.addUser(user)) {
            request.setAttribute("success", "Đăng ký thành công!");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error", "Đăng ký không thành công. Vui lòng thử lại!");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }

    public void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = userService.deleteUser(id);
        response.sendRedirect(request.getContextPath() + "/users");
//        if (success) {
//            request.setAttribute("success", "Xóa người dùng thành công!");
//        } else {ute("error", "Xóa người dùng thất bại!");
////        }
//            request.setAttrib
//        request.getRequestDispatcher("users").forward(request, response);
    }
    public void searchUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.getUserById(id);
        request.setAttribute("users", user);
        request.getRequestDispatcher("UserList.jsp").forward(request, response);
    }
    public void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.getUserById(id);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        request.getRequestDispatcher("/user/UserEdit.jsp").forward(request, response);
    }
    public void saveUpdateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user.getName() == null || user.getEmail() == null || user.getName().isEmpty() || user.getEmail().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("user/UserEdit.jsp").forward(request, response);
            return;
        }
        if(userService.getUserByEmail(user.getEmail()) != null){
            request.setAttribute("error", "Email đã tồn tại");
            request.getRequestDispatcher("user/UserEdit.jsp").forward(request, response);
            return;
        }
        boolean success = userService.updateUser(user);
        if(success){
            request.setAttribute("success", "Cập nhật thông thành công");
        }else{
            request.setAttribute("error", "Cập nhật thất bại");
        }
        request.getRequestDispatcher("users").forward(request, response);
    }
    public void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        boolean isMatch = Utils.checkPassword(oldPassword, user.getPasswordHash());
        if (isMatch) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            if(newPassword.equals(confirmPassword)){
                newPassword = Utils.hashPassword(newPassword);
                user.setPasswordHash(newPassword);
                request.setAttribute("success", "Cập nhật mật khẩu mới thành công");
            }else{
                request.setAttribute("error", "Mật khẩu nhập lại không khớp với mật khẩu đã nhập");
            }
        }else{
            request.setAttribute("error", "Mật khẩu cũ không đúng");
        }
        request.getRequestDispatcher("UserChangePassword.jsp").forward(request, response);
    }
    public void restoreUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userService.restoreUser(id);
        response.sendRedirect(request.getContextPath() + "/users");
    }
}
