
import dao.GenericDAO;
import model.Order;
import model.OrderDetail;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import service.OrderService;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    private GenericDAO<Order> orderDao;

    @Mock
    private GenericDAO<OrderDetail> orderDetailDao;

    @InjectMocks
    private OrderService orderService;

    private Order sampleOrder;

    @BeforeEach
    void setUp() {
        sampleOrder = new Order();
        sampleOrder.setId(1);
        sampleOrder.setOrderDate(Instant.now());
        sampleOrder.setTotalAmount(new BigDecimal("1000.00"));
        sampleOrder.setStatus("Pending");
    }

    @Test
    void testGetAllOrders() {
        when(orderDao.getAll()).thenReturn(Collections.singletonList(sampleOrder));

        List<Order> orders = orderService.getAllOrders();

        assertNotNull(orders);
        assertEquals(1, orders.size());
        verify(orderDao, times(1)).getAll();
    }

    @Test
    void testGetOrderById() {
        when(orderDao.findById(1)).thenReturn(sampleOrder);

        Order order = orderService.getOrderById(1);

        assertNotNull(order);
        assertEquals(1, order.getId());
        verify(orderDao, times(1)).findById(1);
    }

    @Test
    void testUpdateOrder() {
        when(orderDao.update(sampleOrder)).thenReturn(true);

        boolean result = orderService.updateOrder(sampleOrder);

        assertTrue(result);
        verify(orderDao, times(1)).update(sampleOrder);
    }

    @Test
    void testDeleteOrder() {
        when(orderDao.delete(1)).thenReturn(true);

        boolean result = orderService.deleteOrder(1);

        assertTrue(result);
        verify(orderDao, times(1)).delete(1);
    }

    @Test
    void testCreateOrder() {
        doNothing().when(orderDao).insert(sampleOrder);

        orderService.createOrder(sampleOrder);

        verify(orderDao, times(1)).insert(sampleOrder);
    }

    @Test
    void testAddOrderDetails() {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setId(1);
        orderDetail.setOrderID(sampleOrder);
        orderDetail.setQuantity(2);
        orderDetail.setPrice(new BigDecimal("500.00"));

        List<OrderDetail> orderDetails = Collections.singletonList(orderDetail);

        doNothing().when(orderDetailDao).insert(any(OrderDetail.class));

        orderService.addOrderDetails(orderDetails);

        verify(orderDetailDao, times(1)).insert(orderDetail);
    }

    @Test
    void testHasNextPage() {
        when(orderDao.hasNextPage(1, 10)).thenReturn(true);

        boolean result = orderService.hasNextPage(1, 10);

        assertTrue(result);
        verify(orderDao, times(1)).hasNextPage(1, 10);
    }
}
