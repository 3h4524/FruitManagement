package service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.math.BigDecimal;
import java.util.Properties;

public class MailService {
    private static final String EMAIL_SENDER = WebConfigLoader.getProperty("email.sender");
    private static final String EMAIL_PASSWORD = WebConfigLoader.getProperty("email.password");
    public static boolean sendOTP(String recipientEmail, String otp) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_SENDER, EMAIL_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_SENDER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Mã OTP của bạn");
            message.setText("Mã OTP của bạn là: " + otp);

            Transport.send(message);
            return true;  // ✅ Gửi thành công
        } catch (MessagingException e) {
            e.printStackTrace();
            return false; // ❌ Gửi thất bại
        }
    }

    public static boolean sendOrderConfirmation(String recipientEmail, String orderId, String name, BigDecimal totalAmount) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_SENDER, EMAIL_PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_SENDER));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Xác nhận đơn hàng #" + orderId);

            // Nội dung email
            String emailContent = "<h2>Chào " + name + ",</h2>"
                    + "<p>Cảm ơn bạn đã đặt hàng tại cửa hàng của chúng tôi!</p>"
                    + "<p><b>Mã đơn hàng:</b> " + orderId + "</p>"
                    + "<p><b>Tổng tiền:</b> " + totalAmount + " VND</p>"
                    + "<p>Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>"
                    + "<p>Trân trọng,</p>"
                    + "<p><b>Đội ngũ hỗ trợ</b></p>";

            message.setContent(emailContent, "text/html; charset=UTF-8");

            Transport.send(message);
            return true;  // ✅ Gửi thành công
        } catch (MessagingException e) {
            e.printStackTrace();
            return false; // ❌ Gửi thất bại
        }
    }
}
