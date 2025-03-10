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

//    public void setStockInInventory(List<Inventory> inventoryList){
//        EntityManager em = emf.createEntityManager();
//        try {
//            em.getTransaction().begin();
//            for (Inventory inventory : inventoryList) {
//                em.createNamedQuery(Inventory.class.getSimpleName() + ".setStockInInventory")
//                        .setParameter("storeLocation", inventory.getStoreLocation())
//                        .setParameter("productID", inventory.getProduct().getId())
//                        .setParameter("quantity", inventory.getQuantity())
//                        .executeUpdate();
//            }
//            em.getTransaction().commit();
//        } catch (Exception e) {
//            em.getTransaction().rollback(); // Rollback nếu có lỗi
//            e.printStackTrace();
//        } finally {
//            em.close();
//        }
//    }

}
