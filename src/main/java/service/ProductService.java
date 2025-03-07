package service;

import dao.GenericDAO;
import model.Product;

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

    public boolean deleteProduct(int id) {
        return productDAO.delete(id);
    }
}
