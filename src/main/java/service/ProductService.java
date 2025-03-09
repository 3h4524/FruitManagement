package service;

import dao.GenericDAO;
import model.Category;
import model.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
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
        public List<Product> searchAndFilterProducts(String name, String categoryID, String sortType) {
            EntityManager em = GenericDAO.emf.createEntityManager();
            try {
                StringBuilder queryStr = new StringBuilder("SELECT DISTINCT p FROM Product p");

                boolean hasCategoryFilter = categoryID != null && !categoryID.isEmpty();
                boolean hasNameFilter = name != null && !name.isEmpty();

                // Nếu lọc theo danh mục, JOIN bảng categories
                if (hasCategoryFilter) {
                    queryStr.append(" JOIN p.categories c WHERE c.id = :categoryId");
                }

                // Nếu lọc theo tên sản phẩm
                if (hasNameFilter) {
                    queryStr.append(hasCategoryFilter ? " AND" : " WHERE");
                    queryStr.append(" LOWER(p.name) LIKE :name");
                }

                // Thêm điều kiện sắp xếp nếu có
                if (sortType != null && !sortType.isEmpty()) {
                    switch (sortType) {
                        case "price_asc":
                            queryStr.append(" ORDER BY p.price ASC");
                            break;
                        case "price_desc":
                            queryStr.append(" ORDER BY p.price DESC");
                            break;
                        case "name_asc":
                            queryStr.append(" ORDER BY p.name ASC");
                            break;
                        case "name_desc":
                            queryStr.append(" ORDER BY p.name DESC");
                            break;
                    }
                }

                TypedQuery<Product> query = em.createQuery(queryStr.toString(), Product.class);

                // Set tham số nếu có
                if (hasCategoryFilter) {
                    query.setParameter("categoryId", Integer.parseInt(categoryID));
                }
                if (hasNameFilter) {
                    query.setParameter("name", "%" + name.toLowerCase() + "%");
                }

                List<Product> products = query.getResultList();

                // Kiểm tra nếu không có sản phẩm nào
                if (products.isEmpty()) {
                    System.out.println("Không có sản phẩm nào phù hợp!");
                }

                return products;
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
