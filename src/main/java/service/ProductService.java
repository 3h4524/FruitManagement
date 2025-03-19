package service;

import dao.GenericDAO;
import model.Category;
import model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.ProductStock;
import model.ProductVariant;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;


public class ProductService {
    private final GenericDAO<Product> productDAO = new GenericDAO<>(Product.class);

    public List<Product> getAllProducts() {
        return productDAO.getAll();
    }

    public Product getProductById(int id) {
        return productDAO.findById(id);
    }

    public void addProduct(Product product) {
        productDAO.insert(product);
    }

    public boolean updateProduct(Product product) {
        return productDAO.update(product);
    }

    public void deleteProduct(int id) {
        productDAO.delete(id);
    }

    public List<Product> listWithOffset(int page, int pageSize) {
        return productDAO.listWithOffset(page, pageSize);
    }

    // Hàm lấy giá của size "Small"
    public BigDecimal getSmallSizePrice(Integer productId) {
        EntityManager em = GenericDAO.emf.createEntityManager();
        try {
            TypedQuery<BigDecimal> query = em.createQuery(
                    "SELECT pv.price FROM ProductVariant pv WHERE pv.productID.id = :productId AND pv.size = 'Small'", BigDecimal.class);
            query.setParameter("productId", productId);
            return query.getResultStream().findFirst().orElse(BigDecimal.ZERO);
        } finally {
            em.close();
        }
    }

    public List<Category> getAllCategories() {
        EntityManager em = GenericDAO.emf.createEntityManager(); // Mở EntityManager
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            em.close(); // Đóng EntityManager để tránh rò rỉ tài nguyên
        }
    }

    public List<Product> searchAndFilterProducts(String name, String categoryID, String sortType) {
        EntityManager em = GenericDAO.emf.createEntityManager();
        try {
            StringBuilder queryStr = new StringBuilder("SELECT DISTINCT p FROM Product p LEFT JOIN p.categories c");

            boolean hasCategoryFilter = categoryID != null && !categoryID.isEmpty();
            boolean hasNameFilter = name != null && !name.isEmpty();

            if (hasCategoryFilter || hasNameFilter) {
                queryStr.append(" WHERE");
                if (hasCategoryFilter) {
                    queryStr.append(" c.id = :categoryId");
                }
                if (hasNameFilter) {
                    queryStr.append(hasCategoryFilter ? " AND" : "").append(" LOWER(p.name) LIKE :name");
                }
            }

            // Sắp xếp kết quả theo yêu cầu
            if (sortType != null && !sortType.isEmpty()) {
                switch (sortType) {
                    case "name_asc":
                        queryStr.append(" ORDER BY p.name ASC");
                        break;
                    case "name_desc":
                        queryStr.append(" ORDER BY p.name DESC");
                        break;
                }
            }

            TypedQuery<Product> query = em.createQuery(queryStr.toString(), Product.class);

            if (hasCategoryFilter) {
                query.setParameter("categoryId", Integer.parseInt(categoryID));
            }
            if (hasNameFilter) {
                query.setParameter("name", "%" + name.toLowerCase() + "%");
            }

            List<Product> products = query.getResultList();

            // Lấy giá của size "Small" cho từng sản phẩm bằng truy vấn riêng
            for (Product product : products) {
                BigDecimal price = getSmallSizePrice(product.getId());
                product.setPrice(price);
            }

            // Nếu cần sắp xếp theo giá, thực hiện sắp xếp trong Java vì giá được lấy từ truy vấn riêng
            if (sortType != null && (sortType.equals("price_asc") || sortType.equals("price_desc"))) {
                products.sort((p1, p2) -> {
                    BigDecimal price1 = p1.getPrice() != null ? p1.getPrice() : BigDecimal.ZERO;
                    BigDecimal price2 = p2.getPrice() != null ? p2.getPrice() : BigDecimal.ZERO;
                    return sortType.equals("price_asc") ? price1.compareTo(price2) : price2.compareTo(price1);
                });
            }

            return products;
        } finally {
            em.close();
        }
    }


    public List<Map<String, Object>> detailProduct(int id) {
        EntityManager em = productDAO.emf.createEntityManager();
        try {
            String jpql = "SELECT p.id, p.name, p.imageURL, p.description, pv.size, pv.price, ps.amount " +
                    "FROM Product p " +
                    "JOIN ProductVariant pv ON p = pv.productID " +
                    "JOIN ProductStock ps ON pv = ps.productVariantID " +
                    "WHERE p.id = :productId " +
                    "ORDER BY p.id";

            return em.createQuery(jpql, Object[].class)
                    .setParameter("productId", id)
                    .getResultStream().map(row -> Map.of(
                            "productId", row[0],
                            "productName", row[1],
                            "imageURL", row[2],
                            "description", row[3],
                            "size", row[4],
                            "price", row[5],
                            "stock", row[6]
                    )).collect(Collectors.toList());
        } finally {
            em.close();
        }
    }


    public boolean updateProductDetails(int productId, String name, String description, String imageURL,
                                        String[] sizes, String[] prices, String[] quantities) {
        ProductStockService productStockService = new ProductStockService();
        InventoryLogService inventoryLogService = new InventoryLogService();
        ProductService productService = new ProductService();
        ProductVariantService productVariantService = new ProductVariantService();
        Product product = productService.getProductById(productId);

        if (product == null) {
            return false;
        }

        product.setName(name);
        product.setDescription(description);
        product.setImageURL(imageURL);
        productService.updateProduct(product);

        if (sizes != null && prices != null && quantities != null) {
            for (int i = 0; i < sizes.length; i++) {
                try {
                    String size = sizes[i];
                    BigDecimal price = new BigDecimal(product.getId());
                    int quantity = Integer.parseInt(quantities[i]);

                    ProductVariant productVariant = productVariantService.getVariantByProductAndSize(productId, size);

                    if (productVariant != null) {
                        productVariant.setPrice(price);
                        productVariantService.updateVariant(productVariant);
                        ProductStock productStock = productStockService.getProductStock(productVariant.getId());
                        productStock.setAmount(quantity);
                        productStockService.updateProductStock(productStock);
                    } else {
                        productVariant = new ProductVariant();
                        productVariant.setProductID(product);
                        productVariant.setSize(size);
                        productVariant.setPrice(price);
                        productVariantService.addProductVariant(productVariant);

                        productVariant = productVariantService.getVariantByProductAndSize(productId, size);

                        // Tạo stock mới
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
        return true;
    }

}
