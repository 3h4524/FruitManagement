package service;

import dao.GenericDAO;
import model.Category;
import model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.math.BigDecimal;
import java.util.List;


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

    public boolean updateProduct(Product product){
        return productDAO.update(product);
    }

    public void deleteProduct(int id) {
        productDAO.delete(id);
    }
    public List<Product> listWithOffset(int page, int pageSize) {
            return productDAO.listWithOffset(page, pageSize);
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
    }
