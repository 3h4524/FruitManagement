package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Order;
import model.OrderDetail;

import java.util.ArrayList;
import java.util.List;

public class OrderService {
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
    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
        for(OrderDetail orderDetail : orderDetailDao.getAll()){
            if(orderDetail.getOrderID().getId() == orderId){
                orderDetails.add(orderDetail);
            }
        }
        return orderDetails;
    }

    public List<OrderDetail> listWithOffset(int page, int pageSize) {
        return orderDetailDao.listWithOffset(page, pageSize);
    }

    public List<Order> getOrderByUserId(int userId) {
        List<Order> orders = orderDao.findByAttribute("userId", userId);
        return orders;
    }

    public List<OrderDetail> getOrderDetailsByUserId(int userId) {
        EntityManager em = GenericDAO.emf.createEntityManager();
        TypedQuery<OrderDetail> query = em.createQuery(
                "SELECT od FROM OrderDetail od JOIN od.orderID o WHERE o.userID.id = :userId", OrderDetail.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

}
