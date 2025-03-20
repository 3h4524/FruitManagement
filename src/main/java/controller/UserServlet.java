
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
                updateUserEdit(request, response);
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
                saveUpdate(request, response);
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
    public void updateUserEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userService.getUserById(id);
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        request.getRequestDispatcher("/user/UserEdit.jsp").forward(request, response);
    }
    public void saveUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        System.out.println(type != null ? type : "null");
        if (type == null) {
            type = "";
        }
        switch (type){
            case "changePassword":
                changePassword(request, response);
                break;
            case "changePasswordByOldPassword":
                changePasswordByOldPassword(request, response);
                break;
            case "saveAddress":
                updateAddressUser(request, response);
                break;
            case "updateProfile":
                updateUserProfile(request, response);
                break;
            case "updateUser":
                updateUser(request, response);
                break;
        }
    }
    public void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // 1️⃣ Lấy contextPath để đảm bảo đường dẫn đúng
        String contextPath = request.getContextPath();

        // 2️⃣ Kiểm tra dữ liệu hợp lệ
        if (user == null || user.getName() == null || user.getEmail() == null ||
                user.getName().isEmpty() || user.getEmail().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            response.sendRedirect(contextPath + "/user/UserEdit.jsp");
            return;
        }
        // 3️⃣ Cập nhật thông tin
        boolean success = userService.updateUser(user);

        // 4️⃣ Đặt thông báo vào session
        if (success) {
            session.setAttribute("success", "Cập nhật thông tin thành công!");
        } else {
            session.setAttribute("error", "Cập nhật thất bại, vui lòng thử lại!");
        }

        // 5️⃣ Chuyển hướng về đúng trang dựa vào type
        response.sendRedirect(contextPath + "/user/UserEdit.jsp");
    }
    public void updateUserProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("UserLogin");
        // 1️⃣ Lấy contextPath để đảm bảo đường dẫn đúng
        String contextPath = request.getContextPath();

        // 2️⃣ Kiểm tra dữ liệu hợp lệ
        if (user == null || user.getName() == null || user.getEmail() == null ||
                user.getName().isEmpty() || user.getEmail().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            response.sendRedirect(contextPath + "/user/UserAccount.jsp?page=user/UserProfile.jsp");
            return;
        }

        boolean success = userService.updateUser(user);

        // 4️⃣ Đặt thông báo vào session
        if (success) {
            session.setAttribute("success", "Cập nhật thông tin thành công!");
            session.setAttribute("UserLogin", user);
        } else {
            session.setAttribute("error", "Cập nhật thất bại, vui lòng thử lại!");
        }

        // 5️⃣ Chuyển hướng về đúng trang dựa vào type
        response.sendRedirect(contextPath + "/user/UserAccount.jsp?page=user/UserProfile.jsp");
    }

    public void restoreUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userService.restoreUser(id);
        response.sendRedirect(request.getContextPath() + "/users");
    }
    public void updateAddressUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            response.sendRedirect(contextPath + "/user/UserAccount.jsp?page=user/UserSaveAddress.jsp");
            return;
        }

        // 4️⃣ Ghép địa chỉ hoàn chỉnh
        String address = street.trim() + ", " + ward.trim() + ", " + district.trim() + ", " + city.trim();

        // 5️⃣ Cập nhật địa chỉ cho user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("UserLogin");

        if (user != null) {
            user.setAddress(address);
            session.setAttribute("UserLogin", user);
        } else {
            session.setAttribute("error", "Không tìm thấy thông tin người dùng.");
        }

        // 6️⃣ Kiểm tra tham số "page" trong URL của referer
        session.setAttribute("success", "Thay đổi thành công");
        response.sendRedirect(contextPath + "/user/UserAccount.jsp?page=user/UserSaveAddress.jsp");
    }

    public void changePasswordByOldPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("UserLogin");

        // Kiểm tra nếu có trường nào bị bỏ trống
        if (oldPassword == null || newPassword == null || confirmPassword == null ||
                oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {

            session.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
            response.sendRedirect("user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp");
            return; // Kết thúc phương thức ngay sau khi redirect
        }

        boolean isMatch = Utils.checkPassword(oldPassword, user.getPasswordHash());

        if (isMatch) {
            if (userService.changePassword(user, newPassword, confirmPassword)) {
                session.removeAttribute("UserLogin"); // Xóa thuộc tính session trước
                String successMessage = "Đổi mật khẩu thành công, vui lòng đăng nhập lại!";
                session.setAttribute("success", successMessage);
                response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
                return;
            } else {
                session.setAttribute("error", "Mật khẩu nhập lại không đúng");
            }
        }
        session.setAttribute("error", "Mật khẩu cũ không đúng");
        // Chỉ redirect lại nếu không đổi mật khẩu thành công
        response.sendRedirect("user/UserAccount.jsp?page=user/UserChangePasswordByOldPassword.jsp");
    }

    public void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();

        // Kiểm tra xem người dùng có đăng nhập không
        User user = (User) session.getAttribute("UserLogin");
        boolean isLoggedIn = (user != null);

        // Nếu chưa đăng nhập, lấy User từ session tạm
        if (!isLoggedIn) {
            user = (User) session.getAttribute("UserIsNotLoggedIn");
        }

        // Kiểm tra người dùng hợp lệ và mật khẩu mới hợp lệ
        if (user != null && userService.changePassword(user, newPassword, confirmPassword)) {
            String successMessage = "Đổi mật khẩu thành công, vui lòng đăng nhập lại!";

            // Nếu người dùng đã đăng nhập, xóa thông tin đăng nhập
            if (isLoggedIn) {
                session.removeAttribute("UserLogin");
            } else {
                session.invalidate(); // Xóa toàn bộ session nếu chưa đăng nhập
                session = request.getSession(true); // Tạo session mới để lưu thông báo
            }

            session.setAttribute("success", successMessage);
            response.sendRedirect(request.getContextPath() + "/user/Login.jsp");
            return;
        }

        // Nếu mật khẩu xác nhận không hợp lệ
        session.setAttribute("error", "Mật khẩu nhập lại không đúng hoặc không hợp lệ.");
        response.sendRedirect(request.getContextPath() + "/user/UserChangePassword.jsp");
    }
}
