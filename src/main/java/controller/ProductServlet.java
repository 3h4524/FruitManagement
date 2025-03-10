package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import service.InventoryService;
import service.ProductService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    ProductService productService;
    public void init(){
        productService = new ProductService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch(action){
            case "create":
                request.getRequestDispatcher("/product/CreateProduct.jsp").forward(request, response);
                break;
            case "update":
                sendToUpdateProduct(request, response);
                break;
            case "find":
                searchProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "productDetail":
                detailProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productService.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("product/ProductList.jsp").forward(request, response);
    }

    private void sendToUpdateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            int id = Integer.parseInt(request.getParameter("productId"));
            Product product = productService.getProductById(id);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/product/UpdateProduct.jsp").forward(request, response);
        } catch (NumberFormatException e){
            throw new NumberFormatException("id must be an integer");
        }
    }

    // Thang bo sung phan search product
    private void searchProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            int id = Integer.parseInt(request.getParameter("id"));
            productService.deleteProduct(id);
            response.sendRedirect("/products");
        } catch (NumberFormatException e){
            throw new NumberFormatException("id must be an integer");
        }
    }

    private void detailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productService.getProductById(id);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/product/ProductDetail.jsp").forward(request, response);
        } catch (NumberFormatException e){
            throw new NumberFormatException("id must be an integer");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch(action){
            case "create":
                createProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
        }
    }

    public void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        String message = "";
        try {
            Product newProduct = (Product) request.getSession().getAttribute("product");
            if(newProduct == null){
                throw new RuntimeException("Invalid product.");
            }
            productService.addProduct(newProduct);
            message = "Add new product successfully";
            request.setAttribute("message", message);
        } catch (Exception e) {
            message = e.getMessage();
            request.setAttribute("error", message);
        }
        request.getRequestDispatcher("/product/CreateProduct.jsp").forward(request, response);
    }

    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String message = "";
        try{
            int id = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String description = request.getParameter("description");
            String imageURL = request.getParameter("imageURL");

            Product product = productService.getProductById(id);
            if(product != null){
                product.setName(name);
                product.setDescription(description);
                product.setImageURL(imageURL);
                productService.updateProduct(product);
            }
            message = "Update product successfully";
        } catch (NumberFormatException e){
            message = "Update product fail";
            request.setAttribute("message", message);
            request.getRequestDispatcher("/product/CreateProduct.jsp").forward(request, response);
        }
    }
}
