package service;

import dao.GenericDAO;
import model.Product;
import model.User;

import java.util.List;

public class UserService {
    private GenericDAO<User> userDao = new GenericDAO<>(User.class);
    public List<User> getAllUser() {
        return userDao.getAll();
    }

    public User getUserById(int id) {
        return userDao.findById(id);
    }

    public boolean addUser(User user) {
        return userDao.insert(user);
    }

    public boolean updateUser(User user) {
        return userDao.update(user);
    }

    public boolean deleteUser(int id) {
        User user = userDao.findById(id);
        if (user != null) {
            user.setStatus("INACTIVE");
            userDao.update(user);
            return true;
        }
        return false;
    }

    public boolean restoreUser(int id) {
        User user = userDao.findById(id);
        if (user != null) {
            user.setStatus("ACTIVE");
            userDao.update(user);
            return true;
        }
        return false;
    }

    public List<User> getCustomerByName(String name){
        return userDao.findByName(name);
    }

    public User getUserByEmail(String email) {
        List<User> users = userDao.findByAttribute("email", email);
        return users.isEmpty() ? null : users.get(0);
    }

    public List<User> getUserByPhone(String phone){
        List<User> users = userDao.findByAttribute("phone", phone);
        return users;
    }
    public boolean changePassword(User user, String newPassword, String confirmPassword) {
        if(confirmPassword.equals(newPassword)) {
            newPassword = Utils.hashPassword(confirmPassword);
            user.setPasswordHash(newPassword);
            if(updateUser(user)){
                return true;
            }
        }
        return false;
    }
    public User getUserByToken(String hashToken) {
        List<User> users = userDao.findByAttribute("rememberToken", hashToken);
        return users.isEmpty() ? null : users.get(0);
    }
}