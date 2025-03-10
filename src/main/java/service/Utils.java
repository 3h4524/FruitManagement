package service;

import org.mindrot.jbcrypt.BCrypt;

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
    public boolean isValidPassword(String password) {
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
    public boolean isValidEmail(String email) {
        String emailPattern = "^[a-zA-Z0-9._%+-]+@gmail\\.com$";
        return email != null && email.matches(emailPattern);
    }
}
