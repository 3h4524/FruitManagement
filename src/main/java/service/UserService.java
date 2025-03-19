package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import model.User;
import org.hibernate.internal.SessionFactoryImpl;

import java.sql.PreparedStatement;
import java.util.List;

public class UserService {
    private GenericDAO<User> userDao = new GenericDAO<>(User.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");

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

    public void saveRememberToken(int userId, String token) {
        EntityManager em = emf.createEntityManager();
        User user = em.find(User.class, userId);
        if (user != null) {
            user.setRememberToken(token);
            em.merge(user);
        }
    }

    public boolean isValidToken(int userId, String token) {
        EntityManager em = emf.createEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.id = :userId AND u.rememberToken = :token";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setParameter("userId", userId);
        query.setParameter("token", token);
        return !query.getResultList().isEmpty();
    }




}
