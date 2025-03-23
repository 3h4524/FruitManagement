package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import model.Order;
import model.OrderDetail;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class OrderService {
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    private GenericDAO<Order> orderDao = new GenericDAO<Order>(Order.class);
    private GenericDAO<OrderDetail> orderDetailDao = new GenericDAO<OrderDetail>(OrderDetail.class);
    public List<Order> getAllOrders() {
        return orderDao.getAll();
    }
    public Order getOrderById(int id) {
        return orderDao.findById(id);
    }
    public boolean updateOrder(Order order) {
        return orderDao.update(order);
    }
    public boolean deleteOrder(int id) {
        return orderDao.delete(id);
    }
    public void createOrder(Order order) {
        orderDao.insert(order);
    }
    public void addOrderDetails(List<OrderDetail> orderDetails) {
        for(OrderDetail orderDetail : orderDetails) {
            orderDetailDao.insert(orderDetail);
        }
    }
    public List<Map<String, Object>> getOrderDetails(int orderId) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT od.id, p.name, pv.size, pv.price, od.quantity FROM OrderDetail od " +
                    "JOIN od.orderID o " +
                    "JOIN od.productVariantID pv " +
                    "JOIN pv.productID p " +
                    "WHERE o.id = :orderId";


            return em.createQuery(jpql, Object[].class)
                    .setParameter("orderId", orderId)
                    .getResultStream()
                    .map(row -> Map.of(
                            "orderDetailId", row[0],
                            "productName", row[1],
                            "size", row[2],
                            "price", row[3],
                            "quantity", row[4]
                    ))
                    .collect(Collectors.toList());
        } finally {
            em.close();
        }
    }


    public List<Map<String, Object>> listWithOffset(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT o.id, u.name, u.address, u.phone, o.orderDate, o.status, o.totalAmount " +
                    "FROM Order o " +
                    "JOIN User u ON o.userID = u " +
                    "ORDER BY o.id";

            return em.createQuery(jpql, Object[].class)
                    .setFirstResult((page - 1) * pageSize)
                    .setMaxResults(pageSize)
                    .getResultStream()
                    .map(row -> Map.of(
                            "orderId", row[0],
                            "userName", row[1],
                            "userAddress", row[2],
                            "userPhone", row[3],
                            "orderDate", row[4],
                            "status", row[5],
                            "totalAmount", row[6]
                    )).collect(Collectors.toList());
        } finally {
            em.close();
        }
    }

    public boolean hasNextPage(int page, int pageSize){
        return orderDao.hasNextPage(page, pageSize);
    }

    public List<OrderDetail> getOrderDetailsByUserId(int userId) {
        EntityManager em = GenericDAO.emf.createEntityManager();
        TypedQuery<OrderDetail> query = em.createQuery(
                "SELECT od FROM OrderDetail od JOIN od.orderID o WHERE o.userID.id = :userId", OrderDetail.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
    public List<Object[]> getTopOrderedProducts(int limit) {
        EntityManager em = GenericDAO.emf.createEntityManager();
        TypedQuery<Object[]> query = em.createNamedQuery("OrderDetails.findTopOrderedProducts", Object[].class);
        query.setMaxResults(limit);
        return query.getResultList();
    }
}
