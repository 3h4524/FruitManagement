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
    public List<Product> listWithOffset(int page, int pageSize) {
            return productDAO.listWithOffset(page, pageSize);
    }

    }
