package junitTest;

import dao.GenericDAO;
import model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * Unit test cho lớp UserService sử dụng JUnit 5 và Mockito.
 */
@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private GenericDAO<User> userDao; // Giả lập lớp DAO để kiểm tra mà không cần kết nối CSDL

    @InjectMocks
    private UserService userService; // Đối tượng UserService cần kiểm tra

    private User user1;
    private User user2;

    /**
     * Thiết lập dữ liệu test trước mỗi lần chạy test.
     */
    @BeforeEach
    void setUp() {
        user1 = new User();
        user1.setId(1);
        user1.setEmail("user1@example.com");
        user1.setName("Alice");
        user1.setStatus("ACTIVE");

        user2 = new User();
        user2.setId(2);
        user2.setEmail("user2@example.com");
        user2.setName("Bob");
        user2.setStatus("INACTIVE");
    }

    /**
     * Kiểm tra phương thức getAllUser() có trả về danh sách đúng không.
     */
    @Test
    void testGetAllUser() {
        when(userDao.getAll()).thenReturn(Arrays.asList(user1, user2));
        List<User> users = userService.getAllUser();
        assertEquals(2, users.size());
        assertEquals("Alice", users.get(0).getName());
        assertEquals("Bob", users.get(1).getName());
    }

    /**
     * Kiểm tra phương thức getUserById() có lấy đúng user theo ID không.
     */
    @Test
    void testGetUserById() {
        when(userDao.findById(1)).thenReturn(user1);
        User foundUser = userService.getUserById(1);
        assertNotNull(foundUser);
        assertEquals(1, foundUser.getId());
        assertEquals("Alice", foundUser.getName());
    }

    /**
     * Kiểm tra phương thức addUser() có thêm user thành công không.
     */
    @Test
    void testAddUser() {
        when(userDao.insert(user1)).thenReturn(true);
        assertTrue(userService.addUser(user1));
    }

    /**
     * Kiểm tra phương thức updateUser() có cập nhật thông tin người dùng thành công không.
     */
    @Test
    void testUpdateUser() {
        when(userDao.update(user1)).thenReturn(true);
        assertTrue(userService.updateUser(user1));
    }

    /**
     * Kiểm tra phương thức deleteUser() có chuyển trạng thái user thành INACTIVE không.
     */
    @Test
    void testDeleteUser() {
        when(userDao.findById(1)).thenReturn(user1);
        when(userDao.update(any(User.class))).thenReturn(true);
        assertTrue(userService.deleteUser(1));
        assertEquals("INACTIVE", user1.getStatus());
    }

    /**
     * Kiểm tra phương thức restoreUser() có chuyển trạng thái user về ACTIVE không.
     */
    @Test
    void testRestoreUser() {
        when(userDao.findById(2)).thenReturn(user2);
        when(userDao.update(any(User.class))).thenReturn(true);
        assertTrue(userService.restoreUser(2));
        assertEquals("ACTIVE", user2.getStatus());
    }

    /**
     * Kiểm tra phương thức getUserByEmail() có tìm đúng user theo email không.
     */
    @Test
    void testGetUserByEmail() {
        when(userDao.findByAttribute("email", "user1@example.com"))
                .thenReturn(Arrays.asList(user1));
        User foundUser = userService.getUserByEmail("user1@example.com");
        assertNotNull(foundUser);
        assertEquals("user1@example.com", foundUser.getEmail());
    }
}
