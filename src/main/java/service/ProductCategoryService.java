package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.Category;
import model.ProductsCategory;

public class ProductCategoryService {
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    private GenericDAO<ProductsCategory> productsCategoryDAO = new GenericDAO<ProductsCategory>(ProductsCategory.class);

    public void insert(ProductsCategory productsCategory) {
        productsCategoryDAO.insert(productsCategory);
    }
}
