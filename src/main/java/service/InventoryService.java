package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.Inventory;

import java.util.List;

public class InventoryService {
    private GenericDAO<Inventory> inventoryDAO = new GenericDAO<>(Inventory.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    public List<Inventory> getAllInventory() {
        return inventoryDAO.getAll();
    }
    public Inventory getInventoryById(int id) {
        return inventoryDAO.findById(id);
    }

    public void setStockInInventory(String storeLocation ,int productID, int quantity){
        EntityManager em = emf.createEntityManager();
        try{
            em.getTransaction();
            em.getTransaction().begin();
            em.createNamedQuery(Inventory.class.getSimpleName() + ".setStockInInventory", Inventory.class).setParameter("storeLocation", storeLocation).setParameter("productID", productID).setParameter("quantity", quantity).executeUpdate();
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

}
