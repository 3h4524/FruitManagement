package service;

import org.mindrot.jbcrypt.BCrypt;
import java.security.SecureRandom;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class Utils {
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }
    public static boolean checkPassword(String inputPassword, String hashedPassword) {
        return BCrypt.checkpw(inputPassword, hashedPassword);
    }
    public static String capitalizeFirstLetter(String input) {
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }

    public static String normalizeName(String name) {
        if (name == null || name.isEmpty()) {
            return "";
        }
        name = name.replaceAll("[^a-z A-Z]", "");
        String[] parts = name.trim().split("\\s+");

        StringBuilder normalized = new StringBuilder();
        for (String part : parts) {
            String normalizedPart = part.substring(0, 1).toUpperCase() + part.substring(1).toLowerCase();
            normalized.append(normalizedPart).append(" ");
        }

        return normalized.toString().trim();
    }
    public static boolean isValidPhone(String phone) {
        String regex = "^(\\d{9}|\\d{10})$";
        return phone.matches(regex);
    }
    public static boolean isValidPassword(String password) {
        if (password.length() < 8) {
            return false;
        }
        String upperCasePattern = ".*[A-Z].*";
        String digitPattern = ".*[0-9].*";
        String specialCharPattern = ".*[^a-zA-Z0-9].*";

        boolean hasUpperCase = password.matches(upperCasePattern);
        boolean hasDigit = password.matches(digitPattern);
        boolean hasSpecialChar = password.matches(specialCharPattern);

        return hasUpperCase && hasDigit && hasSpecialChar;
    }

    public static String dateTimeFormat(Instant dateTime) {
        if (dateTime == null) {
            return "";
        }
        // Chuyển Instant sang LocalDateTime với múi giờ Việt Nam
        LocalDateTime localDateTime = LocalDateTime.ofInstant(dateTime, ZoneId.of("Asia/Ho_Chi_Minh"));

        // Định dạng ngày giờ
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        return localDateTime.format(formatter);
    }
    public static String[] splitAddressDetails(String address){
        return address.split(",");
    }
    public static String generateOTP(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(10)); // Chỉ lấy số từ 0-9
        }
        return otp.toString();
    }
    public static String getCorrectRedirect(String referer, String targetURL){
        if (referer != null && referer.contains("page=")) {
            return "/user/UserAccount.jsp?page=" + targetURL; // Giữ nguyên URL của referer nếu có tham số "page"
        }
        return "/" + targetURL;
    }
    public static String maskEmail(String email) {
        if (email == null || !email.contains("@")) {
            return "Invalid Email";
        }

        String[] parts = email.split("@");
        String namePart = parts[0];
        String domainPart = parts[1];

        // Hiển thị 2 ký tự đầu và che phần còn lại bằng "*"
        if (namePart.length() > 2) {
            namePart = namePart.substring(0, 2) + "****";
        } else {
            namePart = namePart.charAt(0) + "****"; // Nếu tên quá ngắn
        }

        return namePart + "@" + domainPart;
    }

    public static String formatTimestamp(Instant instant) {
        if (instant == null) return "N/A";
        LocalDateTime dateTime = LocalDateTime.ofInstant(instant, ZoneId.of("UTC"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        return dateTime.format(formatter);
    }


}
