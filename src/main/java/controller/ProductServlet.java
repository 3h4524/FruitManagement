    package controller;

    import jakarta.servlet.*;
    import jakarta.servlet.http.*;
    import jakarta.servlet.annotation.*;
    import model.*;
    import service.*;

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
                    List<Category> categories = productService.getAllCategories();
                    request.setAttribute("categories", categories);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("product/CreateProduct.jsp");
                    dispatcher.forward(request, response);
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
                case "manageDiscounts":
                    showDiscountManagement(request, response);
                    break;
                case "showDiscountedProducts":
                    showDiscountedProducts(request, response);
                    break;
                case "removeDiscount":
                    removeDiscount(request, response);
                    break;
                case "productBestSeller":
                    getProductBestSeller(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        }

        private void getProductBestSeller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            List<Map<String, Object>> products = productService.getMostOrderedProducts(20);
            request.setAttribute("products", products);
            request.getRequestDispatcher("product/ProductBestSeller.jsp").forward(request, response);
        }


        private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int page = 1;
            int pageSize = 10;
            String pageStr = request.getParameter("page");
            String pageSizeStr = request.getParameter("pageSize");

            if (pageStr != null){
                page = Integer.parseInt(pageStr);
            }

            if (pageSizeStr != null){
                pageSize = Integer.parseInt(pageSizeStr);
            }


            List<Product> products = productService.getAllProduct(page, pageSize);
            request.setAttribute("products", products);
            request.getRequestDispatcher("product/ProductList.jsp").forward(request, response);
        }

        private void showDiscountManagement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Load categories for the dropdown
            List<Category> categories = productService.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/DiscountManagement.jsp").forward(request, response);
        }

        private void removeDiscount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                String name = request.getParameter("name");
                String categoryId = request.getParameter("categoryId");

                productService.removeDiscount(name, categoryId);

                // Set success message
                request.setAttribute("successMessage", "Discounts have been successfully removed!");

                // Redirect back to discount management page
                showDiscountManagement(request, response);
            } catch (Exception e) {
                // Set error message
                request.setAttribute("errorMessage", "Failed to remove discounts: " + e.getMessage());
                showDiscountManagement(request, response);
            }
        }

        private void showDiscountedProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int page = 1;
            int recordsPerPage = 8;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Get discounted products with pagination
            List<Product> discountedProducts = productService.getDiscountedProducts((page - 1) * recordsPerPage, recordsPerPage);
            int noOfRecords = productService.getNumberOfDiscountedProducts();
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

            request.setAttribute("discountedProducts", discountedProducts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", noOfPages);

            request.getRequestDispatcher("/product/DiscountedProducts.jsp").forward(request, response);
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
            int page = 1;
            int pageSize = 8; // Changed to match the grid layout

            String pageStr = request.getParameter("page");
            String pageSizeStr = request.getParameter("pageSize");

            if(pageStr != null){
                page = Integer.parseInt(pageStr);
            }

            if(pageSizeStr != null){
                pageSize = Integer.parseInt(pageSizeStr);
            }
            String categoryID = request.getParameter("categoryId");
            String sort = request.getParameter("sort");
            String searchName = request.getParameter("searchName");

            // Gọi service để lấy sản phẩm với giá của size "Small"
            List<Product> products = productService.searchAndFilterProducts(searchName, categoryID, sort, page, pageSize);

            // Calculate total number of products to determine total pages
            int totalProducts = productService.countFilteredProducts(searchName, categoryID);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            List<Category> categories = productService.getAllCategories();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("selectedCategory", categoryID);
            request.setAttribute("selectedSort", sort);
            request.setAttribute("searchName", searchName);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/product/ProductListCart.jsp").forward(request, response);
        }

        private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                int id = Integer.parseInt(request.getParameter("productId"));
                productService.deleteProduct(id);

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
                System.out.println(productDetails);
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
                case "applyDiscount":
                    applyDiscount(request, response);
                    break;
                case "removeDiscount":
                    removeDiscount(request, response);
                    break;

            }
        }

        private void applyDiscount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            try {
                String name = request.getParameter("name");
                String categoryId = request.getParameter("categoryId");
                int discountPercent = Integer.parseInt(request.getParameter("discountPercent"));
                String expireDateStr = request.getParameter("expireDate");

                LocalDate expireDate = LocalDate.parse(expireDateStr);

                productService.applyDiscount(name, categoryId, discountPercent, expireDate);

                // Set success message
                request.setAttribute("successMessage", "Discounts have been successfully applied!");

                // Redirect back to discount management page
                    showDiscountManagement(request, response);
            } catch (Exception e) {
                // Set error message
                request.setAttribute("errorMessage", "Failed to apply discounts: " + e.getMessage());
                showDiscountManagement(request, response);
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
                Integer categoryId = Integer.parseInt(request.getParameter("categoryId"));

                String importDateStr = request.getParameter("importDate");

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                LocalDateTime importDate = LocalDateTime.parse(importDateStr, formatter);

                Instant importDateUTC = importDate.atZone(ZoneId.systemDefault()).toInstant();

                Category category = new CategoryService().findCategory(categoryId);
                System.out.println(category);
                if (category == null) {
                    throw new IllegalArgumentException("Category not found");
                }

                Product newProduct = new Product();
                newProduct.setName(name);
                newProduct.setDescription(description);
                newProduct.setImageURL(imageURL);
                newProduct.setImportDate(importDateUTC);
                productService.addProduct(newProduct);

                ProductsCategory productCategory = new ProductsCategory();
                productCategory.setProductID(newProduct);
                productCategory.setCategoryID(category);
                new ProductCategoryService().insert(productCategory); // Lưu vào bảng trung gian



                ProductVariant newProductVariant = new ProductVariant();
                newProductVariant.setProduct(newProduct);
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

                productService.updateProductDetails(productId, name, description, imageURL, sizes, prices, quantities);
                response.sendRedirect(request.getContextPath() + "/products");
            } catch (NumberFormatException e) {
                request.setAttribute("error", e.getMessage());
                request.getRequestDispatcher("/product/CreateProduct.jsp").forward(request, response);
            }
        }
    }
