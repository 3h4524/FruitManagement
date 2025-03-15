package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.InventoryLogService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "InventoryServlet", value = "/inventory")
public class InventoryServlet extends HttpServlet {

    private InventoryLogService inventoryLogService;

    public void init(ServletConfig config) throws ServletException {
        inventoryLogService = new InventoryLogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "pagination":
                listWithOffset(request, response);
                break;
            default:
                listWithOffset(request, response);
                break;
        }
    }

    private void listWithOffset(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;

        // Lấy tham số từ request nếu có
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }
        if (pageSizeParam != null) {
            pageSize = Integer.parseInt(pageSizeParam);
        }

        // Gọi service để lấy danh sách logs
        List<Map<String, Object>> logs = inventoryLogService.listWithOffset(page, pageSize);
        boolean hasNext = inventoryLogService.hasNextPage(page, pageSize);

        // Đặt dữ liệu vào request
        request.setAttribute("logs", logs);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("hasNextPage", hasNext);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("/Inventory/InventoryLog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}