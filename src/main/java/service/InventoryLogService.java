package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.Inventory;
import model.InventoryLog;

import java.util.List;

public class InventoryLogService {
    private GenericDAO<InventoryLog> inventoryLogDAO = new GenericDAO<>(InventoryLog.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    public List<InventoryLog> getAllInventory() {
        return inventoryLogDAO.getAll();
    }
    public InventoryLog getInventoryById(int id) {
        return inventoryLogDAO.findById(id);
    }

    public List<InventoryLog> listWithOffset(int page, int pageSize){
         return inventoryLogDAO.listWithOffset(page, pageSize);
    }
}
