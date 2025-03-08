package service;

import dao.GenericDAO;
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
    public boolean createOrder(Order order) {
        return orderDao.insert(order);
    }
    public void addOrderDetails(List<OrderDetail> orderDetails) {
        for(OrderDetail orderDetail : orderDetails) {
            orderDetailDao.insert(orderDetail);
        }
    }
//    public List<OrderDetail> getOrderDetails(int orderId) {
//        List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
//        for(OrderDetail orderDetail : orderDetailDao.getAll()){
//            if(orderDetail.getOrderID() == orderId){
//                orderDetails.add(orderDetail);
//            }
//        }
//        return orderDetails;
//    }
}
