package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.Category;

public class CategoryService {
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    private GenericDAO<Category> categoryDAO = new GenericDAO<Category>(Category.class);

    public Category findCategory(int id) {
        return categoryDAO.findById(id);
    }
}
