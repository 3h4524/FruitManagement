package service;

import dao.GenericDAO;
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

    public List<User> getCustomerByName(String name){
        return userDao.findByName(name);
    }

    public boolean checkEmailExisted(String email) {
        return userDao.findByAttribute("email", email) != null;
    }
    public User getUserByEmail(String email) {
        List<User> users = userDao.findByAttribute("email", email);
        return users.get(0);
    }
}
