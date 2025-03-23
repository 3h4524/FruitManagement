package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import org.json.JSONObject;

import java.time.Instant;
import java.util.List;

public class UserService {
    private GenericDAO<User> userDao = new GenericDAO<>(User.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");

    // Existing methods
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

    public List<User> getCustomerByName(String name) {
        return userDao.findByName(name);
    }

    public User getUserByEmail(String email) {
        List<User> users = userDao.findByAttribute("email", email);
        return users.isEmpty() ? null : users.get(0);
    }

    public boolean changePassword(User user, String newPassword, String confirmPassword) {
        if (confirmPassword.equals(newPassword)) {
            newPassword = Utils.hashPassword(confirmPassword);
            user.setPasswordHash(newPassword);
            if (updateUser(user)) {
                return true;
            }
        }
        return false;
    }

    public void saveRememberToken(int userId, String token) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            User user = em.find(User.class, userId);
            if (user != null) {
                user.setRememberToken(token);
                em.merge(user);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public boolean isValidToken(int userId, String token) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.id = :userId AND u.rememberToken = :token";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("userId", userId);
            query.setParameter("token", token);
            return !query.getResultList().isEmpty();
        } finally {
            em.close();
        }
    }

    // New Google OAuth methods

    /**
     * Process Google user information and create or update user account
     */
    public User processGoogleUserInfo(String userInfoJson) {
        try {
            System.out.println("Google User Info JSON: " + userInfoJson); // Debug

            JSONObject userInfo = new JSONObject(userInfoJson);

            // Kiểm tra xem có email và name hay không
            if (!userInfo.has("email") || !userInfo.has("name")) {
                System.out.println("Google user info missing email or name!");
                return null;
            }

            String email = userInfo.getString("email");
            String name = userInfo.getString("name");

            System.out.println("Extracted Email: " + email);
            System.out.println("Extracted Name: " + name);

            EntityManager em = emf.createEntityManager();
            User user = null;

            try {
                em.getTransaction().begin();

                // Kiểm tra user có tồn tại chưa
                TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
                query.setParameter("email", email);
                List<User> users = query.getResultList();

                if (users.isEmpty()) {
                    // Nếu user chưa tồn tại, tạo user mới
                    user = new User();
                    user.setEmail(email);
                    user.setName(name);
                    user.setStatus("ACTIVE");
                    user.setRole("Customer");
                    user.setRegistrationDate(Instant.now());

                    // Đặt mật khẩu random
                    String randomPassword = Utils.generateToken().substring(0, 12);
                    user.setPasswordHash(Utils.hashPassword(randomPassword));

                    em.persist(user);
                } else {
                    // Nếu user đã tồn tại, cập nhật tên
                    user = users.get(0);
                    user.setName(name);
                    em.merge(user);
                }

                // Cập nhật remember token
                String rememberToken = Utils.generateToken();
                user.setRememberToken(rememberToken);
                em.merge(user);

                em.getTransaction().commit();
                return user;

            } catch (Exception e) {
                if (em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }
                e.printStackTrace();
                return null;
            } finally {
                em.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * Setup session and cookie for authenticated Google user
     */
    public void setupGoogleUserSession(HttpServletRequest request, HttpServletResponse response,
                                       User user, String pictureUrl) {
        try {
            // Store user info in session
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userPicture", pictureUrl);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("loggedIn", true);
            session.setAttribute("UserLogin", user); // Add this line to store the User object
            System.out.println("User saved in session: " + session.getAttribute("UserLogin"));


            // Store remember token in cookie for persistent login
            Cookie rememberCookie = new Cookie("remember_token", user.getRememberToken());
            rememberCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
            rememberCookie.setPath("/");
            rememberCookie.setHttpOnly(true); // For security

            // If using HTTPS
            // rememberCookie.setSecure(true);

            response.addCookie(rememberCookie);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Check if user has valid remember token cookie and log them in automatically
     */
    public User checkRememberToken(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) {
            return null;
        }

        String rememberToken = null;
        for (Cookie cookie : cookies) {
            if ("remember_token".equals(cookie.getName())) {
                rememberToken = cookie.getValue();
                break;
            }
        }

        if (rememberToken == null || rememberToken.isEmpty()) {
            return null;
        }

        EntityManager em = emf.createEntityManager();
        try {
            // Find user with this remember token
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.rememberToken = :token AND u.status = 'ACTIVE'",
                    User.class
            );
            query.setParameter("token", rememberToken);
            List<User> results = query.getResultList();

            return !results.isEmpty() ? results.get(0) : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public void clearRememberToken(int userId){
        EntityManager em  = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            User user = em.find(User.class, userId);
            if(user != null){
                user.setRememberToken(null);
                em.merge(user);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if(em.getTransaction().isActive()){
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}

