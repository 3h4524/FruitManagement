import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.TypedQuery;
import model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import service.UserService;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@ExtendWith(MockitoExtension.class)
public class UserServiceTest {

    @Mock
    private GenericDAO<User> userDao;

    @Mock
    private EntityManagerFactory emf;

    @Mock
    private EntityManager em;

    @InjectMocks
    private UserService userService;

    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setId(1);
        testUser.setName("John Doe");
        testUser.setEmail("john@example.com");
        testUser.setPasswordHash("hashedpassword");
        testUser.setStatus("ACTIVE");
    }

    @Test
    void testGetAllUsers() {
        List<User> users = Arrays.asList(testUser);
        when(userDao.getAll()).thenReturn(users);

        List<User> result = userService.getAllUser();
        assertEquals(1, result.size());
        assertEquals("John Doe", result.get(0).getName());
    }

    @Test
    void testGetUserById() {
        when(userDao.findById(1)).thenReturn(testUser);

        User result = userService.getUserById(1);
        assertNotNull(result);
        assertEquals("John Doe", result.getName());
    }

    @Test
    void testAddUser() {
        when(userDao.insert(testUser)).thenReturn(true);
        assertTrue(userService.addUser(testUser));
    }

    @Test
    void testUpdateUser() {
        when(userDao.update(testUser)).thenReturn(true);
        assertTrue(userService.updateUser(testUser));
    }

    @Test
    void testDeleteUser() {
        when(userDao.findById(1)).thenReturn(testUser);
        when(userDao.update(any(User.class))).thenReturn(true);

        assertTrue(userService.deleteUser(1));
        assertEquals("INACTIVE", testUser.getStatus());
    }

    @Test
    void testRestoreUser() {
        testUser.setStatus("INACTIVE");
        when(userDao.findById(1)).thenReturn(testUser);
        when(userDao.update(any(User.class))).thenReturn(true);

        assertTrue(userService.restoreUser(1));
        assertEquals("ACTIVE", testUser.getStatus());
    }

    @Test
    void testGetUserByEmail() {
        when(userDao.findByAttribute("email", "john@example.com")).thenReturn(Arrays.asList(testUser));
        User result = userService.getUserByEmail("john@example.com");
        assertNotNull(result);
        assertEquals("John Doe", result.getName());
    }
}
