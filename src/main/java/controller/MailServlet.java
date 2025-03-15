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
}