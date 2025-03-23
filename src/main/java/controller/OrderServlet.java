package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.OrderDetail;
import service.OrderService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }

        switch (action){
            case "listOrder":
                listOrder(request, response);
                break;
            case "detail":
                listOrderDetail(request, response);
                break;
            case "topOrders":
                listTopOrders(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }

        switch (action){
            case "edit":
                break;
        }
    }
    private void listTopOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int limit = 20; // Lấy top 10 đơn hàng
        List<Object[]> topOrders = orderService.getTopOrderedProducts(limit);

        request.setAttribute("topOrders", topOrders);
        request.getRequestDispatcher("/order/TopOrders.jsp").forward(request, response);
    }


    private void listOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
        if (pageSizeParam != null) {
            pageSize = Integer.parseInt(pageSizeParam);
        }

        List<Map<String, Object>> orders = orderService.listWithOffset(page, pageSize);
        boolean hasNext = orderService.hasNextPage(page, pageSize);

        request.setAttribute("orders", orders);
        request.setAttribute("hasNext", hasNext);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("/order/OrderList.jsp").forward(request, response);
    }
    private void listOrderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        List<Map<String, Object>> orderDetails = orderService.getOrderDetails(orderId);

        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("/order/OrderDetail.jsp").forward(request, response);
    }
    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
}