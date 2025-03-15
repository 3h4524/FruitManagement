package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "PageServlet", value = "/page")
public class PageServlet extends HttpServlet {
    private static final Map<String, String> pageTitles = new HashMap<>();

    @Override
    public void init() throws ServletException {
        pageTitles.put("user/Login.jsp", "Đăng nhập");
        pageTitles.put("user/Register.jsp", "Đăng ký");
        pageTitles.put("home", "Trang chủ");
        pageTitles.put("product/ProductListCart.jsp", "Danh sách sản phẩm");
        pageTitles.put("product/ProductDetail.jsp", "Chi tiết sản phẩm");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("view");
        if (page == null || page.isEmpty()) {
            page = "home.jsp"; // Trang mặc định
        }

        // Lấy title từ Map, nếu không có thì để mặc định
        String title = pageTitles.getOrDefault(page, "Trang web của tôi");

        request.setAttribute("title", title);
        request.setAttribute("content", page);

        request.getRequestDispatcher("layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}