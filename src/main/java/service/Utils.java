package service;

import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.Base64;
import org.mindrot.jbcrypt.BCrypt;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Properties;

public class Utils {
    // Password hashing and validation
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    public static boolean checkPassword(String inputPassword, String hashedPassword) {
        return BCrypt.checkpw(inputPassword, hashedPassword);
    }

    // Properties handling
    private static final Properties properties = new Properties();
    static {
        try (InputStream input = Utils.class.getClassLoader().getResourceAsStream("config.properties")){
            if (input == null) {
                throw new IOException("File config.properties not found");
            }
            properties.load(input);
        } catch (IOException e) {
            System.err.println("Error loading properties file: " + e.getMessage());
            throw new RuntimeException("Failed to load configuration properties", e);
        }
    }

    public static String getProperty(String key) {
        String value = properties.getProperty(key);
        if (value == null) {
            System.err.println("Warning: Property '" + key + "' not found in configuration");
        }
        return value;
    }

    // Method to explicitly reload properties if needed (e.g., after changing the file)
    public static void reloadProperties() {
        try (InputStream input = Utils.class.getClassLoader().getResourceAsStream("config.properties")){
            if (input == null) {
                throw new IOException("File config.properties not found");
            }
            properties.clear();
            properties.load(input);
        } catch (IOException e) {
            System.err.println("Error reloading properties file: " + e.getMessage());
            throw new RuntimeException("Failed to reload configuration properties", e);
        }
    }

    // String handling methods
    public static String capitalizeFirstLetter(String input) {
        if (input == null || input.isEmpty()) {
            return input;
        }
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
            if (!part.isEmpty()) {
                String normalizedPart = part.substring(0, 1).toUpperCase() + part.substring(1).toLowerCase();
                normalized.append(normalizedPart).append(" ");
            }
        }

        return normalized.toString().trim();
    }

    // Validation methods
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.isEmpty()) {
            return false;
        }
        String regex = "^(\\d{9}|\\d{10})$";
        return phone.matches(regex);
    }

    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
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

    public static boolean isValidEmail(String email) {
        if (email == null || email.isEmpty()) {
            return false;
        }
        String regex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email.matches(regex);
    }

    // Date and time handling
    public static String dateTimeFormat(Instant dateTime) {
        if (dateTime == null) {
            return "";
        }
        // Convert Instant to LocalDateTime with Vietnam timezone
        LocalDateTime localDateTime = LocalDateTime.ofInstant(dateTime, ZoneId.of("Asia/Ho_Chi_Minh"));

        // Format date and time
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");

        return localDateTime.format(formatter);
    }

    public static String formatTimestamp(Instant instant) {
        if (instant == null) return "N/A";
        LocalDateTime dateTime = LocalDateTime.ofInstant(instant, ZoneId.of("UTC"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        return dateTime.format(formatter);
    }

    // Address handling
    public static String[] splitAddressDetails(String address) {
        if (address == null || address.isEmpty()) {
            return new String[0];
        }
        return address.split(",");
    }

    // Security related methods
    public static String generateOTP(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < length; i++) {
            otp.append(random.nextInt(10)); // Only use numbers 0-9
        }
        return otp.toString();
    }

    public static String generateToken() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    public static String hashToken(String token) {
        return Base64.getEncoder().encodeToString(token.getBytes()); // Mã hóa đơn giản (có thể thay bằng SHA-256)
    }


    // URL handling
    public static String getCorrectRedirect(String referer, String targetURL) {
        if (referer != null && referer.contains("page=")) {
            return "/user/UserAccount.jsp?page=" + targetURL; // Keep the original URL if it has a "page" parameter
        }
        return "/" + targetURL;
    }

    // Data protection/privacy
    public static String maskEmail(String email) {
        if (email == null || !email.contains("@")) {
            return "Invalid Email";
        }

        String[] parts = email.split("@");
        String namePart = parts[0];
        String domainPart = parts[1];

        // Show first 2 characters and mask the rest with "*"
        if (namePart.length() > 2) {
            namePart = namePart.substring(0, 2) + "****";
        } else {
            namePart = namePart.charAt(0) + "****"; // If name is too short
        }

        return namePart + "@" + domainPart;
    }

    // OAuth specific utilities
    public static String buildGoogleAuthUrl() {
        String clientId = getProperty("google.clientId");
        String redirectUri = getProperty("google.redirectUri");
        String scope = getProperty("scope");

        if (clientId == null || redirectUri == null || scope == null) {
            throw new RuntimeException("Missing required OAuth properties in configuration");
        }

        return "https://accounts.google.com/o/oauth2/auth" +
                "?client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&response_type=code" +
                "&scope=" + scope;
    }

    // Method to URL encode parameters (useful for OAuth)
    public static String urlEncode(String value) {
        try {
            return java.net.URLEncoder.encode(value, "UTF-8");
        } catch (java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("Failed to URL encode: " + value, e);
        }
    }
}