package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Order;
import model.OrderDetail;
import service.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", value = "/orders")
public class OrderServlet extends HttpServlet {
    private OrderService orderService;
    public void init(){
        orderService = new OrderService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch(action){
            case "getOrderDetailList":
                getOrderList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
    public void getOrderList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        switch (type){
            case "userId":
                getOrderDetailByUserId(request, response);
                break;
        }
    }
    public void getOrderDetailByUserId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        List<OrderDetail> orderDetails = orderService.getOrderDetailsByUserId(id);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("/user/UserAccount.jsp?page=user/UserOrder.jsp").forward(request, response);
    }
}