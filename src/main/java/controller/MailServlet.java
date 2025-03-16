package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.MailService;
import service.UserService;
import service.Utils;

import java.io.IOException;

@WebServlet(name = "MailServlet", value = "/mails")
public class MailServlet extends HttpServlet {
    private UserService userService;

    public void init(){
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch (action){
            case "sendOtp":
                sendOtp(request, response);
                break;
            case "verifyOtp":
                verifyOtp(request, response);
                break;
        }
    }
    private void sendOtp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String type = request.getParameter("type"); // 'register' hoặc 'forgot-password'
        HttpSession session = request.getSession();

        if (email == null || email.isEmpty()) {
            response.getWriter().write("error: Vui lòng nhập email");
            return;
        }

        User user = userService.getUserByEmail(email);
        if ("register".equals(type) && user != null) {
            response.getWriter().write("error: Email đã được đăng ký");
            return;
        } else if ("forgot-password".equals(type) && user == null) {
            response.getWriter().write("error: Không tìm thấy người dùng với email đã nhập");
            return;
        }

        // Tạo và gửi OTP
        String otp = Utils.generateOTP(6);
        boolean success = MailService.sendOTP(email, otp);
        if (success) {
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);
            session.setAttribute("otpExpiryTime", System.currentTimeMillis() + 5 * 60 * 1000); // OTP hết hạn sau 5 phút
            response.getWriter().write("success");
        } else {
            response.getWriter().write("error: Gửi OTP thất bại");
        }
    }

    public void verifyOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        User user = (User) session.getAttribute("UserLogin");
        boolean isLoggedIn = user != null;

        System.out.println("isLoggedIn: " + isLoggedIn);

        if (otp == null || otp.isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập OTP");
            response.sendRedirect(request.getContextPath() + "/user/UserTwoStepVerification.jsp");
            return;
        }

        String otpSession = (String) session.getAttribute("otp");
        Long otpExpiryTime = (Long) session.getAttribute("otpExpiryTime");

        // Kiểm tra OTP có tồn tại trong session không
        if (otpSession == null || otpExpiryTime == null) {
            session.setAttribute("error", "Không tìm thấy OTP. Vui lòng yêu cầu lại.");
            response.sendRedirect(request.getContextPath() + "/user/UserTwoStepVerification.jsp");
            return;
        }

        // Kiểm tra OTP có hết hạn chưa
        if (System.currentTimeMillis() > otpExpiryTime) {
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiryTime");
            session.setAttribute("error", "Mã OTP đã hết hạn. Vui lòng yêu cầu mã mới.");
            response.sendRedirect(request.getContextPath() + "/user/UserTwoStepVerification.jsp");
            return;
        }

        // Kiểm tra OTP có khớp không
        if (!otp.equals(otpSession)) {
            session.setAttribute("error", "Mã OTP không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/user/UserTwoStepVerification.jsp");
            return;
        }

        // Nếu người dùng chưa đăng nhập, lấy thông tin người dùng từ email
        if (!isLoggedIn) {
            user = userService.getUserByEmail(email);
            session.setAttribute("UserIsNotLoggedIn", user);
        }

        // Xóa OTP khỏi session sau khi sử dụng
        session.removeAttribute("otp");
        session.removeAttribute("otpExpiryTime");

        // Chuyển hướng đến trang đổi mật khẩu
        response.sendRedirect(request.getContextPath() + "/user/UserChangePassword.jsp");
    }
}