package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Product;
import model.ProductStock;
import model.ProductVariant;
import service.ProductService;
import service.ProductStockService;
import service.ProductVariantService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    ProductService productService;
    ProductVariantService productVariantService;

    public void init() {
        productService = new ProductService();
        productVariantService = new ProductVariantService();
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
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("productId"));
            productService.deleteProduct(id);
            response.sendRedirect(request.getContextPath()+ "/products");
        } catch (NumberFormatException e) {
            throw new NumberFormatException("id must be an integer");
        }
    }

    private void detailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productService.getProductById(id);
            request.setAttribute("product", product);
            request.getRequestDispatcher("/product/ProductDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            throw new NumberFormatException("id must be an integer");
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
            // Lấy dữ liệu từ request
            String name = request.getParameter("name");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            String size = request.getParameter("size");
            String description = request.getParameter("description");
            Integer stock = Integer.parseInt(request.getParameter("stock"));
            String imageURL = request.getParameter("imageURL");

            String dateStr = request.getParameter("importDate");
            LocalDate localDate = LocalDate.parse(dateStr, DateTimeFormatter.ISO_DATE);
            Instant importDate = localDate.atStartOfDay(ZoneId.systemDefault()).toInstant();

            // Tạo Product
            Product newProduct = new Product();
            newProduct.setName(name);
            newProduct.setDescription(description);
            newProduct.setImageURL(imageURL);
            newProduct.setImportDate(importDate);

            // Lưu sản phẩm trước
            productService.addProduct(newProduct);

            // Tạo ProductVariant
            ProductVariant productVariant = new ProductVariant();
            productVariant.setProductID(newProduct);
            productVariant.setSize(size);
            productVariant.setPrice(price);

            // Lưu productVariant trước khi sử dụng nó
            productVariantService.addProductVariant(productVariant);

            // Tạo ProductStock
            ProductStock productStock = new ProductStock();
            productStock.setProductVariantID(productVariant);
            productStock.setAmount(stock);

            // Lưu ProductStock vào database
            new ProductStockService().addProductStock(productStock);

            message = "Thêm sản phẩm thành công";
            request.setAttribute("message", message);
        } catch (Exception e) {
            e.printStackTrace(); // Debug lỗi dễ hơn
            message = "Thêm sản phẩm thất bại";
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

            ProductStockService productStockService = new ProductStockService();

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
                    productStockService.deleteByVariantId(variant.getId());
                    productVariantService.deleteProductVariant(variant.getId());
                }
            }


            if (sizes != null && prices != null && quantities != null) {
                for (int i = 0; i < sizes.length; i++) {
                    try {
                        String size = sizes[i];
                        BigDecimal price = new BigDecimal(prices[i]);
                        Integer quantity = Integer.parseInt(quantities[i]);

                        ProductVariant productVariant = productVariantService.getVariantByProductAndSize(productId, size);
                        if (productVariant != null) {
                            // Nếu size đã có thì cập nhật giá
                            productVariant.setPrice(price);
                            productVariantService.updateVariant(productVariant);
                        } else {
                            // Nếu size chưa có, tạo mới
                            productVariant = new ProductVariant();
                            productVariant.setProductID(product); // Sửa lỗi ở đây
                            productVariant.setSize(size);
                            productVariant.setPrice(price);
                            productVariantService.updateVariant(productVariant); // Thêm mới variant vào DB
                        }


                        // Cập nhật hoặc thêm mới ProductStock
                        ProductStock productStock = productStockService.getProductStock(productVariant.getId());
                        if (productStock != null) {
                            productStock.setAmount(quantity);
                            productStockService.updateProductStock(productStock);
                        } else {
                            ProductStock newStock = new ProductStock();
                            newStock.setAmount(quantity);
                            newStock.setProductVariantID(productVariant);
                            productStockService.updateProductStock(newStock);
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
