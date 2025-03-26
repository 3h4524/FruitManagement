package service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import model.OrderDetail;

import java.math.BigDecimal;
import java.util.List;
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

    public static boolean sendOrderConfirmation(String recipientEmail, String orderId, String name, List<OrderDetail> orderDetails, BigDecimal totalAmount) {
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
            StringBuilder emailContent = new StringBuilder();
            emailContent.append("<h2>Chào ").append(name).append(",</h2>")
                    .append("<p>Cảm ơn bạn đã đặt hàng tại cửa hàng của chúng tôi!</p>")
                    .append("<p><b>Mã đơn hàng:</b> ").append(orderId).append("</p>")
                    .append("<p><b>Tổng tiền:</b> ").append(totalAmount).append(" VND</p>")
                    .append("<h3>Chi tiết đơn hàng:</h3>")
                    .append("<table border='1' cellpadding='8' cellspacing='0' style='border-collapse: collapse; width: 100%;'>")
                    .append("<tr style='background-color: #f2f2f2;'>")
                    .append("<th>Tên sản phẩm</th><th>Số lượng</th><th>Giá</th><th>Tổng</th></tr>");

            for(OrderDetail item : orderDetails) {
                emailContent.append("<tr>")
                        .append("<td>").append(item.getProductVariantID().getProduct().getName()).append("</td>")
                        .append("<td>").append(item.getQuantity()).append("</td>")
                        .append("<td>").append(item.getProductVariantID().getPrice()).append(" VND</td>")
                        .append("<td>").append(item.getPrice()).append(" VND</td>")
                        .append("<tr>");
            }

            emailContent.append("</table>")
                    .append("<p>Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>")
                    .append("<p>Trân trọng,</p>")
                    .append("<p><b>Đội ngũ hỗ trợ</b></p>");

            message.setContent(emailContent.toString(), "text/html; charset=UTF-8");

            Transport.send(message);
            return true;  // ✅ Gửi thành công
        } catch (MessagingException e) {
            e.printStackTrace();
            return false; // ❌ Gửi thất bại
        }
    }
}
