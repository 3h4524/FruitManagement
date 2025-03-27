package service;

import dao.GenericDAO;
import jakarta.persistence.*;
import model.Category;
import model.Product;
import model.ProductStock;
import model.ProductVariant;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

public class ProductService {
    private final GenericDAO<Product> productDAO = new GenericDAO<>(Product.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");

    public List<Product> getAllProducts() {
        return productDAO.getAll();
    }
    public boolean hasNextPage(int page, int pageSize){
        return productDAO.hasNextPage(page, pageSize);
    }

    public Product getProductById(int id) {
        return productDAO.findById(id);
    }

    public void addProduct(Product product) {
        if (!product.getIsDeleted()) {
            product.setIsDeleted(false);
        }
        productDAO.insert(product);
    }

    public boolean updateProduct(Product product) {
        return productDAO.update(product);
    }

    public void deleteProduct(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Product product = productDAO.findById(id);
            if (product != null) {
                product.setIsDeleted(!product.getIsDeleted());
                em.merge(product);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    // Pagination
    public List<Product> listWithOffset(int page, int pageSize) {
        return productDAO.listWithOffset(page, pageSize).stream()
                .filter(p -> !p.getIsDeleted())
                .collect(Collectors.toList());
    }

    // Get price for Small size
    public BigDecimal getSmallSizePrice(Integer productId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<BigDecimal> query = em.createQuery(
                    "SELECT pv.price FROM ProductVariant pv WHERE pv.product.id = :productId AND pv.size = 'Small' AND pv.isDeleted = false",
                    BigDecimal.class);
            query.setParameter("productId", productId);
            return query.getResultStream().findFirst().orElse(BigDecimal.ZERO);
        } finally {
            em.close();
        }
    }

    // Category handling
    public List<Category> getAllCategories() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
        } finally {
            em.close();
        }
    }

    // Search and filter products
    public List<Product> searchAndFilterProducts(String name, String categoryID, String sortType, int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            StringBuilder queryStr = new StringBuilder(
                    "SELECT p, " +
                            "COALESCE(MIN(CASE WHEN v.discountPrice IS NOT NULL AND v.discountExpiry >= CURRENT_TIMESTAMP THEN v.discountPrice END), NULL) AS minDiscountPrice, " +
                            "MIN(v.price) AS minOriginalPrice, " +
                            "COALESCE(MIN(v.size), NULL) AS displaySize " +
                            "FROM Product p " +
                            "LEFT JOIN p.variants v ON v.isDeleted = false " +
                            "LEFT JOIN p.categories c " +
                            "WHERE p.isDeleted = false "
            );

            boolean hasCategoryFilter = categoryID != null && !categoryID.trim().isEmpty();
            boolean hasNameFilter = name != null && !name.trim().isEmpty();

            if (hasCategoryFilter) {
                queryStr.append(" AND c.id = :categoryId");
            }
            if (hasNameFilter) {
                queryStr.append(" AND LOWER(p.name) LIKE :name");
            }

            queryStr.append(" GROUP BY p");

            // Xử lý sắp xếp
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

            TypedQuery<Object[]> query = em.createQuery(queryStr.toString(), Object[].class);

            if (hasCategoryFilter) {
                query.setParameter("categoryId", Integer.parseInt(categoryID));
            }
            if (hasNameFilter) {
                query.setParameter("name", "%" + name.trim().toLowerCase() + "%");
            }

            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);

            List<Object[]> results = query.getResultList();
            List<Product> products = new ArrayList<>();

            for (Object[] row : results) {
                Product product = (Product) row[0];
                BigDecimal minDiscountPrice = (BigDecimal) row[1];
                BigDecimal minOriginalPrice = (BigDecimal) row[2];
                String displaySize = (String) row[3];

                product.setOriginalPrice(minOriginalPrice);
                product.setDiscountPrice(minDiscountPrice);
                product.setDisplaySize(displaySize);

                if (minDiscountPrice != null) {
                    BigDecimal discount = minOriginalPrice.subtract(minDiscountPrice);
                    BigDecimal percentage = discount.multiply(BigDecimal.valueOf(100))
                            .divide(minOriginalPrice, 0, RoundingMode.HALF_UP);
                    product.setDiscountPercent(percentage.intValue());
                } else {
                    product.setDiscountPercent(0);
                }

                products.add(product);
            }

            // Sắp xếp theo giá nếu cần
            if (sortType != null) {
                switch (sortType) {
                    case "price_asc":
                        products.sort(Comparator.comparing(p -> p.getDiscountPrice() != null ? p.getDiscountPrice() : p.getOriginalPrice()));
                        break;
                    case "price_desc":
                        products.sort((p1, p2) -> {
                            BigDecimal price1 = p1.getDiscountPrice() != null ? p1.getDiscountPrice() : p1.getOriginalPrice();
                            BigDecimal price2 = p2.getDiscountPrice() != null ? p2.getDiscountPrice() : p2.getOriginalPrice();
                            return price2.compareTo(price1);
                        });
                        break;
                }
            }

            return products;
        } finally {
            em.close();
        }
    }
    // Get product details
    public List<Map<String, Object>> detailProduct(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT p.id, p.name, p.imageURL, p.description, pv.size, pv.price, pv.discountPrice, ps.amount " +
                    "FROM Product p " +
                    "JOIN ProductVariant pv ON p = pv.product " +
                    "JOIN ProductStock ps ON pv = ps.productVariantID " +
                    "WHERE p.id = :productId AND p.isDeleted = false AND pv.isDeleted = false ";

            return em.createQuery(jpql, Object[].class)
                    .setParameter("productId", id)
                    .getResultStream()
                    .map(row -> {
                        Map<String, Object> result = new HashMap<>();
                        result.put("productId", row[0]);
                        result.put("productName", row[1]);
                        result.put("imageURL", row[2]);
                        result.put("description", row[3]);
                        result.put("size", row[4]);
                        result.put("originalPrice", row[5]);
                        result.put("discountPrice", row[6]);
                        result.put("stock", row[7]);
                        return result;
                    })
                    .collect(Collectors.toList());
        } finally {
            em.close();
        }
    }

    // Update product details
    public void updateProductDetails(int productId, String name, String description, String imageURL,
                                     String[] sizes, String[] prices, String[] quantities) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // Update product details
            Product product = em.find(Product.class, productId);
            if (product == null || product.getIsDeleted()) {
                throw new IllegalArgumentException("Product not found or deleted");
            }

            product.setName(name);
            product.setDescription(description);
            product.setImageURL(imageURL);
            em.merge(product);

            // Get existing variants
            List<ProductVariant> existingVariants = em.createQuery(
                            "SELECT pv FROM ProductVariant pv WHERE pv.product.id = :productId AND pv.isDeleted = false",
                            ProductVariant.class)
                    .setParameter("productId", productId)
                    .getResultList();

            // Track which sizes are updated
            Set<String> updatedSizes = new HashSet<>();

            // Update or add variants
            if (sizes != null && prices != null && quantities != null) {
                for (int i = 0; i < sizes.length; i++) {
                    String size = sizes[i];
                    BigDecimal price = new BigDecimal(prices[i]);
                    int quantity = Integer.parseInt(quantities[i]);

                    updatedSizes.add(size);

                    // Find existing variant
                    ProductVariant variant = existingVariants.stream()
                            .filter(v -> v.getSize().equals(size))
                            .findFirst()
                            .orElse(null);

                    if (variant != null) {
                        // Update existing variant
                        variant.setPrice(price);
                        em.merge(variant);

                        // Update stock
                        ProductStock stock = em.createQuery(
                                        "SELECT ps FROM ProductStock ps WHERE ps.productVariantID = :variantId",
                                        ProductStock.class)
                                .setParameter("variantId", variant)
                                .getSingleResult();

                        stock.setAmount(quantity);
                        em.merge(stock);
                    } else {
                        // Create new variant
                        ProductVariant newVariant = new ProductVariant();
                        newVariant.setProduct(product);
                        newVariant.setSize(size);
                        newVariant.setPrice(price);
                        newVariant.setIsDeleted(false);
                        em.persist(newVariant);

                        // Create new stock
                        ProductStock newStock = new ProductStock();
                        newStock.setProductVariantID(newVariant);
                        newStock.setAmount(quantity);
                        newStock.setInventoryID(em.find(model.Inventory.class, 1));
                        em.persist(newStock);
                    }
                }
            }

            // Mark variants not in the update as deleted
            for (ProductVariant variant : existingVariants) {
                if (!updatedSizes.contains(variant.getSize())) {
                    variant.setIsDeleted(true);
                    em.merge(variant);
                }
            }

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    // Apply discount to products
    public void applyDiscount(String name, String categoryId, int discountPercent, LocalDate expireDate) {
        // Validate inputs
        if (discountPercent < 0 || discountPercent > 100) {
            throw new IllegalArgumentException("Discount percentage must be between 0 and 100");
        }
        if (expireDate == null) {
            throw new IllegalArgumentException("Expiration date must be provided");
        }

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // Build query for products
            StringBuilder queryStr = new StringBuilder("SELECT DISTINCT p FROM Product p LEFT JOIN p.categories c WHERE p.isDeleted = false");

            // Safely handle category filter
            Integer parsedCategoryId = null;
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                try {
                    parsedCategoryId = Integer.parseInt(categoryId.trim());
                    queryStr.append(" AND c.id = :categoryId");
                } catch (NumberFormatException e) {
                    // Log the error or handle invalid category ID
                    System.err.println("Invalid category ID: " + categoryId);
                }
            }

            // Handle name filter
            if (name != null && !name.trim().isEmpty()) {
                queryStr.append(" AND LOWER(p.name) LIKE :name");
            }

            TypedQuery<Product> query = em.createQuery(queryStr.toString(), Product.class);

            // Set parameters safely
            if (parsedCategoryId != null) {
                query.setParameter("categoryId", parsedCategoryId);
            }
            if (name != null && !name.trim().isEmpty()) {
                query.setParameter("name", "%" + name.toLowerCase().trim() + "%");
            }

            List<Product> products = query.getResultList();

            // Validate products found
            if (products.isEmpty()) {
                System.out.println("No products found matching the criteria");
                tx.rollback();
                return;
            }

            // Convert LocalDate to Instant
            Instant expireDateInstant = expireDate.atStartOfDay(ZoneId.systemDefault()).toInstant();

            // Apply discount to variants
            int discountCount = 0;
            for (Product product : products) {
                List<ProductVariant> variants = em.createQuery(
                                "SELECT pv FROM ProductVariant pv WHERE pv.product = :product AND pv.isDeleted = false",
                                ProductVariant.class)
                        .setParameter("product", product)
                        .getResultList();

                for (ProductVariant variant : variants) {
                    BigDecimal originalPrice = variant.getPrice();
                    BigDecimal discountAmount = originalPrice.multiply(new BigDecimal(discountPercent))
                            .divide(new BigDecimal(100), 2, RoundingMode.HALF_UP);
                    BigDecimal discountPrice = originalPrice.subtract(discountAmount);

                    variant.setDiscountPrice(discountPrice);
                    variant.setDiscountExpiry(expireDateInstant);

                    em.merge(variant);
                    discountCount++;
                }
            }

            tx.commit();
            System.out.println("Applied discount to " + discountCount + " product variants");
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            // Log the full exception for debugging
            e.printStackTrace();
            throw new RuntimeException("Failed to apply discount", e);
        } finally {
            em.close();
        }
    }

    // Remove discount from products
    public void removeDiscount(String name, String categoryId) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            // Build query for products
            StringBuilder queryStr = new StringBuilder("SELECT DISTINCT p FROM Product p LEFT JOIN p.categories c WHERE p.isDeleted = false");

            boolean hasCategoryFilter = categoryId != null && !categoryId.isEmpty();
            boolean hasNameFilter = name != null && !name.isEmpty();

            if (hasCategoryFilter) {
                queryStr.append(" AND c.id = :categoryId");
            }
            if (hasNameFilter) {
                queryStr.append(" AND LOWER(p.name) LIKE :name");
            }

            TypedQuery<Product> query = em.createQuery(queryStr.toString(), Product.class);

            if (hasCategoryFilter) {
                query.setParameter("categoryId", Integer.parseInt(categoryId));
            }
            if (hasNameFilter) {
                query.setParameter("name", "%" + name.toLowerCase() + "%");
            }

            List<Product> products = query.getResultList();

            // Remove discount from variants
            for (Product product : products) {
                List<ProductVariant> variants = em.createQuery(
                                "SELECT pv FROM ProductVariant pv WHERE pv.product = :product AND pv.isDeleted = false",
                                ProductVariant.class)
                        .setParameter("product", product)
                        .getResultList();

                for (ProductVariant variant : variants) {
                    variant.setDiscountPrice(null);
                    variant.setDiscountExpiry(null);

                    em.merge(variant);
                }
            }

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    // Get discounted products
    public List<Product> getDiscountedProducts(int offset, int limit) {
        EntityManager em = emf.createEntityManager();
        try {
            System.out.println("Fetching discounted products...");

            // Get distinct products that have any variant with a discount
            String jpql = "SELECT DISTINCT p FROM Product p JOIN ProductVariant pv " +
                    "ON p = pv.product " +
                    "WHERE p.isDeleted = false AND pv.isDeleted = false " +
                    "AND pv.discountPrice IS NOT NULL " +
                    "AND pv.discountExpiry >= CURRENT_TIMESTAMP " +
                    "ORDER BY p.id";

            List<Product> products = em.createQuery(jpql, Product.class)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .getResultList();

            System.out.println("Found " + products.size() + " products with discounts");

            // For each product, find the primary variant to display
            for (Product product : products) {
                // First try to find the 'Small' size with discount
                ProductVariant displayVariant = findDiscountedVariant(em, product, "Small");

                // If no 'Small' variant with discount, get any discounted variant
                if (displayVariant == null) {
                    displayVariant = em.createQuery(
                                    "SELECT v FROM ProductVariant v " +
                                            "WHERE v.product = :product " +
                                            "AND v.isDeleted = false " +
                                            "AND v.discountPrice IS NOT NULL " +
                                            "AND v.discountExpiry >= CURRENT_TIMESTAMP " +
                                            "ORDER BY v.size",
                                    ProductVariant.class)
                            .setParameter("product", product)
                            .setMaxResults(1)
                            .getResultStream()
                            .findFirst()
                            .orElse(null);
                }

                if (displayVariant != null) {
                    // Set display prices from the chosen variant
                    product.setOriginalPrice(displayVariant.getPrice());
                    product.setDiscountPrice(displayVariant.getDiscountPrice());

                    // Calculate and set discount percentage
                    BigDecimal discount = displayVariant.getPrice().subtract(displayVariant.getDiscountPrice());
                    BigDecimal percentage = discount.multiply(new BigDecimal(100))
                            .divide(displayVariant.getPrice(), 0, BigDecimal.ROUND_HALF_UP);
                    product.setDiscountPercent(percentage.intValue());

                    // Optionally store the size information for display
                    product.setDisplaySize(displayVariant.getSize());
                }
            }

            return products;
        } finally {
            em.close();
        }
    }

    private ProductVariant findDiscountedVariant(EntityManager em, Product product, String size) {
        return em.createQuery(
                        "SELECT v FROM ProductVariant v " +
                                "WHERE v.product = :product AND v.size = :size " +
                                "AND v.isDeleted = false " +
                                "AND v.discountPrice IS NOT NULL " +
                                "AND v.discountExpiry >= CURRENT_TIMESTAMP",
                        ProductVariant.class)
                .setParameter("product", product)
                .setParameter("size", size)
                .getResultStream()
                .findFirst()
                .orElse(null);
    }

    // Count total discounted products for pagination
    public int getNumberOfDiscountedProducts() {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(DISTINCT p) FROM Product p JOIN ProductVariant pv " +
                    "ON p = pv.product " +
                    "WHERE p.isDeleted = false AND pv.isDeleted = false " +
                    "AND pv.discountPrice IS NOT NULL " +
                    "AND pv.discountExpiry >= CURRENT_TIMESTAMP";

            return em.createQuery(jpql, Long.class)
                    .getSingleResult()
                    .intValue();
        } finally {
            em.close();
        }
    }

    public List<Map<String, Object>> getMostOrderedProducts(Integer limit) {
        EntityManager em = productDAO.emf.createEntityManager();
        try {
            String jpql = "SELECT p.id, p.name, p.description, p.imageURL, " +
                    "COALESCE(SUM(od.quantity), 0) AS totalOrdered, " +
                    "COALESCE(MIN(pv.price), 0) AS productPrice " +  // Lấy giá nhỏ nhất
                    "FROM Product p " +
                    "LEFT JOIN ProductVariant pv ON p = pv.product " +
                    "LEFT JOIN OrderDetail od ON pv = od.productVariantID " +
                    "GROUP BY p.id, p.name, p.description, p.imageURL " +
                    "ORDER BY totalOrdered DESC";

            TypedQuery<Object[]> query = em.createQuery(jpql, Object[].class);

            // Nếu limit > 0 thì giới hạn số lượng, nếu không thì lấy tất cả
            if (limit != null && limit > 0) {
                query.setMaxResults(limit);
            }

            return query.getResultStream().map(row -> Map.of(
                    "productId", row[0],
                    "productName", row[1],
                    "description", row[2],
                    "imageURL", row[3],
                    "totalOrdered", row[4],
                    "productPrice", row[5]  // Thêm giá nhỏ nhất vào Map
            )).collect(Collectors.toList());
        } finally {
            em.close();
        }
    }

    public int countFilteredProducts(String name, String categoryID) {
        EntityManager em = emf.createEntityManager();
        try {
            StringBuilder queryStr = new StringBuilder(
                    "SELECT COUNT(DISTINCT p) " +
                            "FROM Product p " +
                            "LEFT JOIN p.variants v " +
                            "LEFT JOIN p.categories c " +
                            "WHERE p.isDeleted = false AND v.isDeleted = false"
            );

            boolean hasCategoryFilter = categoryID != null && !categoryID.isEmpty();
            boolean hasNameFilter = name != null && !name.isEmpty();

            if (hasCategoryFilter) {
                queryStr.append(" AND c.id = :categoryId");
            }
            if (hasNameFilter) {
                queryStr.append(" AND LOWER(p.name) LIKE :name");
            }

            TypedQuery<Long> query = em.createQuery(queryStr.toString(), Long.class);

            if (hasCategoryFilter) {
                query.setParameter("categoryId", Integer.parseInt(categoryID));
            }
            if (hasNameFilter) {
                query.setParameter("name", "%" + name.toLowerCase() + "%");
            }

            return query.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}