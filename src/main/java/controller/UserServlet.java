
package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.MailService;
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
            case "saveAddress":
                saveAddressUser(request, response);
                break;
            case "changePasswordByOldPassword":
                changePasswordByOldPassword(request, response);
                break;
            case "changePassword":
                changePassword(request, response);
                break;
            case "generateOtp":
                generateOtp(request, response);
                break;
            case "verifyOtp":
                verifyOtp(request, response);
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

        // 1️⃣ Lấy URL trang trước đó
        String referer = request.getHeader("Referer");
        String contextPath = request.getContextPath();

        // 2️⃣ Kiểm tra dữ liệu hợp lệ
        if (user == null || user.getName() == null || user.getEmail() == null ||
                user.getName().isEmpty() || user.getEmail().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            response.sendRedirect(referer != null ? referer : contextPath + "/user/UserEdit.jsp");
            return;
        }

        // 3️⃣ Cập nhật thông tin
        boolean success = userService.updateUser(user);

        // 4️⃣ Đặt thông báo vào session để tránh mất dữ liệu khi chuyển hướng
        if (success) {
            session.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            session.setAttribute("error", "Cập nhật thất bại, vui lòng thử lại!");
        }

        // 5️⃣ Chuyển hướng về trang trước đó hoặc UserEdit.jsp nếu không có referer
        String redirectUrl = contextPath + Utils.getCorrectRedirect(referer, "/user/UserEdit.jsp") ; // Mặc định
        response.sendRedirect(redirectUrl);
    }

    public void changePasswordByOldPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(oldPassword == null || newPassword == null || oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()){
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
            request.getRequestDispatcher("/user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp").forward(request, response);
            return;
        }
        boolean isMatch = Utils.checkPassword(oldPassword, user.getPasswordHash());
        if (isMatch) {
            if(userService.changePassword(user, newPassword, confirmPassword)){
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/user/Login.jsp?success=Đổi mật khẩu thành công, vui lòng đăng nhập lại!");
            }else{
                session.setAttribute("error", "Mật khẩu Nhập lại không đúng");
                response.sendRedirect(request.getContextPath() + "/user/UserChangePasswordByOldPassword.jsp");
            }
        }else{
            session.setAttribute("error", "Mật khẩu cũ không đúng");
        }
        request.getRequestDispatcher("/user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp").forward(request, response);
    }
    public void restoreUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userService.restoreUser(id);
        response.sendRedirect(request.getContextPath() + "/users");
    }
    public void saveAddressUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1️⃣ Lấy thông tin từ request
        String street = request.getParameter("street");
        String district = request.getParameter("district");
        String city = request.getParameter("city");
        String ward = request.getParameter("ward");

        // 2️⃣ Lấy đường dẫn trang trước đó
        String contextPath = request.getContextPath();
        String referer = request.getHeader("Referer");

        // 3️⃣ Kiểm tra dữ liệu hợp lệ
        if (street == null || street.isEmpty() || city == null || city.isEmpty() ||
                ward == null || ward.isEmpty() || district == null || district.isEmpty()) {
            request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin địa chỉ.");
            response.sendRedirect(referer != null ? referer : contextPath + "/user/UserAccount.jsp");
            return;
        }

        // 4️⃣ Ghép địa chỉ hoàn chỉnh
        String address = street.trim() + ", " + ward.trim() + ", " + district.trim() + ", " + city.trim();

        // 5️⃣ Cập nhật địa chỉ cho user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            user.setAddress(address);
            session.setAttribute("user", user);
        } else {
            session.setAttribute("error", "Không tìm thấy thông tin người dùng.");
        }

        // 6️⃣ Kiểm tra tham số "page" trong URL của referer
        String redirectUrl = contextPath + Utils.getCorrectRedirect(referer, "/user/UserEdit.jsp") ; // Mặc định
        response.sendRedirect(redirectUrl);
    }
    private void generateOtp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String type = request.getParameter("type"); // 'register' hoặc 'forgot-password'
        HttpSession session = request.getSession();

        if (email == null || email.isEmpty()) {
            response.getWriter().write("error: Vui lòng nhập email");
            return;
        }

        User user = userService.getUserByEmail(email);
        System.out.println(email != null ? email : "null");
        System.out.println(type != null ? type : "null");
        if ("register".equals(type)) {
            if (user != null) {
                response.getWriter().write("error: Email đã được đăng ký");
                return;
            }
        } else if ("forgot-password".equals(type)) {
            if (user == null) {
                response.getWriter().write("error: Không tìm thấy người dùng với email đã nhập");
                return;
            }
        } else {
            response.getWriter().write("error: Loại yêu cầu không hợp lệ");
            return;
        }

        // Tạo và gửi OTP
        String otp = Utils.generateOTP(6);
        boolean success = MailService.sendOTP(email, otp);
        if (success) {
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error: Gửi OTP thất bại");
        }
    }


    public void verifyOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        if(otp == null || otp.isEmpty()){
            session.setAttribute("error", "Vui lòng nhập OTP");
            response.sendRedirect(request.getContextPath() + "/user/UserForgotPassword.jsp");
            return;
        }
        String otpSession = (String) session.getAttribute("otp");
        if((otpSession != null || !otpSession.isEmpty()) && (otp.equals(otpSession))){
            User user = userService.getUserByEmail(email);
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/user/UserChangePassword.jsp");
        }else{
            session.setAttribute("error", "Mã otp không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/user/UserForgotPassword.jsp");
        }
    }

    public void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(userService.changePassword(user, newPassword, confirmPassword)){
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp?success=Đổi mật khẩu thành công, vui lòng đăng nhập lại!");
        }else{
            session.setAttribute("error", "Mật khẩu Nhập lại không đúng");
            response.sendRedirect(request.getContextPath() + "/user/UserChangPassword.jsp");
        }
    }
}
