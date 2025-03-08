package service;

import org.mindrot.jbcrypt.BCrypt;

public class Utils {
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }
    public static boolean checkPassword(String inputPassword, String hashedPassword) {
        return BCrypt.checkpw(inputPassword, hashedPassword);
    }
}
