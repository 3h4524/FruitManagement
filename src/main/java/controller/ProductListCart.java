package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Category;
import model.Product;
import service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductListCart", value = "/ProductListCart")
public class ProductListCart extends HttpServlet {
    private ProductService productService = new ProductService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số từ request
        String categoryID = request.getParameter("categoryId");
        String sort = request.getParameter("sort");
        String searchName = request.getParameter("searchName");


        // Gọi phương thức đã tối ưu hóa để tìm kiếm, lọc và sắp xếp
        List<Product> products = productService.searchAndFilterProducts(searchName, categoryID, sort);

        // Lấy danh sách categories để hiển thị trong bộ lọc
        List<Category> categories = productService.getAllCategories();

        // Set attributes để hiển thị trên giao diện
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", categoryID);
        request.setAttribute("selectedSort", sort);
        request.setAttribute("searchName", searchName); // Giữ lại từ khóa tìm kiếm trên UI

        // Chuyển hướng đến trang JSP hiển thị danh sách sản phẩm
        request.getRequestDispatcher("ProductListCart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}