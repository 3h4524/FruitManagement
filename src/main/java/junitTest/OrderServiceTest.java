package junitTest;

import dao.GenericDAO;
import model.Order;
import model.OrderDetail;
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
 * Unit test cho lớp OrderService sử dụng JUnit 5 và Mockito.
 */
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    private GenericDAO<Order> orderDao; // Giả lập DAO cho Order

    @Mock
    private GenericDAO<OrderDetail> orderDetailDao; // Giả lập DAO cho OrderDetail

    @InjectMocks
    private OrderService orderService; // Đối tượng OrderService cần kiểm tra

    private Order order1;
    private Order order2;

    /**
     * Thiết lập dữ liệu test trước mỗi lần chạy test.
     */
    @BeforeEach
    void setUp() {
        order1 = new Order();
        order1.setId(1);
        order1.setStatus("PENDING");

        order2 = new Order();
        order2.setId(2);
        order2.setStatus("COMPLETED");
    }

    /**
     * Kiểm tra phương thức getAllOrders() có trả về danh sách đơn hàng đúng không.
     */
    @Test
    void testGetAllOrders() {
        when(orderDao.getAll()).thenReturn(Arrays.asList(order1, order2));
        List<Order> orders = orderService.getAllOrders();
        assertEquals(2, orders.size());
        assertEquals("PENDING", orders.get(0).getStatus());
        assertEquals("COMPLETED", orders.get(1).getStatus());
    }

    /**
     * Kiểm tra phương thức getOrderById() có lấy đúng đơn hàng theo ID không.
     */
    @Test
    void testGetOrderById() {
        when(orderDao.findById(1)).thenReturn(order1);
        Order foundOrder = orderService.getOrderById(1);
        assertNotNull(foundOrder);
        assertEquals(1, foundOrder.getId());
    }

    /**
     * Kiểm tra phương thức updateOrder() có cập nhật đơn hàng thành công không.
     */
    @Test
    void testUpdateOrder() {
        when(orderDao.update(order1)).thenReturn(true);
        assertTrue(orderService.updateOrder(order1));
    }

    /**
     * Kiểm tra phương thức deleteOrder() có xóa đơn hàng thành công không.
     */
    @Test
    void testDeleteOrder() {
        when(orderDao.delete(1)).thenReturn(true);
        assertTrue(orderService.deleteOrder(1));
    }

    /**
     * Kiểm tra phương thức createOrder() có thêm đơn hàng thành công không.
     */
    @Test
    void testCreateOrder() {
        doNothing().when(orderDao).insert(order1);
        orderService.createOrder(order1);
        verify(orderDao, times(1)).insert(order1);
    }
}
