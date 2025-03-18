package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.*;
import org.hibernate.annotations.ColumnDefault;
import service.InventoryService;
import service.ProductService;
import service.ProductStockService;
import service.ProductVariantService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    ProductService productService;
    ProductVariantService productVariantService;
    ProductStockService productStockService;

    public void init() {
        productService = new ProductService();
        productVariantService = new ProductVariantService();
        productStockService = new ProductStockService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
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
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            List<ProductVariant> productVariants = productVariantService.getAllProductVariants(productId);
            HashMap<ProductVariant, Integer> productVariantQuantity = new HashMap<>();
            ProductStockService productStockService = new ProductStockService();
            for (ProductVariant productVariant : productVariants) {
                Integer amount = productStockService.getProductStock(productVariant.getId()).getAmount();
                productVariantQuantity.put(productVariant, amount);
            }
            Product product = productService.getProductById(productId);
            request.setAttribute("productVariants", productVariantQuantity);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/product/UpdateProduct.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            throw new NumberFormatException("ID must be an integer");
        }
    }

    // Thang bo sung phan search product
    private void searchProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryID = request.getParameter("categoryId");
        String sort = request.getParameter("sort");
        String searchName = request.getParameter("searchName");

        // Gọi service để lấy sản phẩm với giá của size "Small"
        List<Product> products = productService.searchAndFilterProducts(searchName, categoryID, sort);
        List<Category> categories = productService.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", categoryID);
        request.setAttribute("selectedSort", sort);
        request.setAttribute("searchName", searchName);
        request.getRequestDispatcher("/product/ProductListCart.jsp").forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("productId"));
            Product product = productService.getProductById(id);
            productService.deleteProduct(id);

            List<ProductVariant> productVariants = productVariantService.getAllProductVariants(id);
            for (ProductVariant productVariant : productVariants) {
                productVariantService.deleteProductVariant(productVariant.getId());
            }
            response.sendRedirect(request.getContextPath() + "/products");
        } catch (NumberFormatException e) {
            throw new NumberFormatException("id must be an integer");
        }
    }

    private void detailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("productId"));
            List<Map<String, Object>> productDetails = productService.detailProduct(id);

            if (productDetails.isEmpty()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }

            request.setAttribute("productDetails", productDetails);

            request.getRequestDispatcher("/product/ProductDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID must be an integer");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "create":
                createProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
        }
    }

    public void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "";
        try {
            String name = request.getParameter("name");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String size = request.getParameter("size");
            String description = request.getParameter("description");
            Integer stock = Integer.parseInt(request.getParameter("stock"));
            String imageURL = request.getParameter("imageURL");

            String importDateStr = request.getParameter("importDate");

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime importDate = LocalDateTime.parse(importDateStr, formatter);

            Instant importDateUTC = importDate.atZone(ZoneId.systemDefault()).toInstant();

            Product newProduct = new Product();
            newProduct.setName(name);
            newProduct.setDescription(description);
            newProduct.setImageURL(imageURL);
            newProduct.setImportDate(importDateUTC);
            productService.addProduct(newProduct);


            ProductVariant newProductVariant = new ProductVariant();
            newProductVariant.setProductID(newProduct);
            newProductVariant.setSize(size);
            newProductVariant.setPrice(price);
            productVariantService.addProductVariant(newProductVariant);


            ProductStock productStock = new ProductStock();
            productStock.setProductVariantID(newProductVariant);
            productStock.setAmount(stock);
            productStock.setInventoryID(new InventoryService().findById(1));
            new ProductStockService().addProductStock(productStock);

            message = "add product successfully";
            request.setAttribute("message", message);
        } catch (Exception e) {
            message = "add product fail";
            request.setAttribute("error", message);
        }
        request.getRequestDispatcher("/product/CreateProduct.jsp").forward(request, response);
    }

    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String imageURL = request.getParameter("imageURL");
            String[] sizes = request.getParameterValues("sizes");
            String[] prices = request.getParameterValues("prices");
            String[] quantities = request.getParameterValues("quantities");


            Product product = productService.getProductById(productId);
            if (product != null) {
                product.setName(name);
                product.setDescription(description);
                product.setImageURL(imageURL);
                productService.updateProduct(product);
            }

            List<ProductVariant> existingVariants = productVariantService.getAllProductVariants(productId);
            Set<String> newSizeSet = null;
            if (sizes != null) {
                newSizeSet = new HashSet<>(Arrays.asList(sizes));
            }

            for (ProductVariant variant : existingVariants) {
                if (!newSizeSet.contains(variant.getSize())) {
                    productVariantService.deleteProductVariant(variant.getId());
                }
            }


            if (sizes != null && prices != null && quantities != null) {
                for (int i = 0; i < sizes.length; i++) {
                    try {
                        String size = sizes[i];
                        BigDecimal price = new BigDecimal(prices[i]);
                        Integer quantity = Integer.parseInt(quantities[i]);

                        // Kiểm tra xem ProductVariant có tồn tại không
                        ProductVariant productVariant = productVariantService.getVariantByProductAndSize(productId, size);

                        if (productVariant != null) {
                            // ✅ Nếu size đã tồn tại → Cập nhật giá và số lượng
                            productVariant.setPrice(price);
                            productVariantService.updateVariant(productVariant);

                            ProductStock productStock = productStockService.getProductStock(productVariant.getId());
                            productStock.setAmount(quantity);
                            productStockService.updateProductStock(productStock);
                        } else {
                            // 🔥 Nếu size chưa tồn tại → Thêm mới vào database
                            productVariant = new ProductVariant();
                            productVariant.setProductID(product);
                            productVariant.setSize(size);
                            productVariant.setPrice(price);
                            productVariantService.addProductVariant(productVariant);

                            // Lấy lại productVariant vừa thêm để có ID chính xác
                            productVariant = productVariantService.getVariantByProductAndSize(productId, size);

                            // Tạo stock mới cho size mới
                            ProductStock newStock = new ProductStock();
                            newStock.setProductVariantID(productVariant);
                            newStock.setAmount(quantity);
                            newStock.setInventoryID(new InventoryService().findById(1));
                            productStockService.addProductStock(newStock);
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            }

            response.sendRedirect(request.getContextPath() + "/products");
        } catch (NumberFormatException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/product/CreateProduct.jsp").forward(request, response);
        }
    }
}