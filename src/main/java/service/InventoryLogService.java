package service;    

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import model.Inventory;
import model.InventoryLog;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class InventoryLogService {
    private GenericDAO<InventoryLog> inventoryLogDAO = new GenericDAO<>(InventoryLog.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    public List<InventoryLog> getAllInventory() {
        return inventoryLogDAO.getAll();
    }
    public InventoryLog getInventoryById(int id) {
        return inventoryLogDAO.findById(id);
    }

    public List<Map<String, Object>> listWithOffset(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT p.name, pv.size, i.quantityChanged, i.actionType, i.actionDate, i.storeLocation " +
                    "FROM InventoryLog i " +
                    "JOIN ProductVariant pv ON i.productVariantID = pv " +
                    "JOIN Product p ON pv.productID = p " +
                    "ORDER BY i.id";

            return em.createQuery(jpql, Object[].class)
                    .setFirstResult((page - 1) * pageSize)
                    .setMaxResults(pageSize)
                    .getResultStream()
                    .map(row -> Map.of(
                            "productName", row[0],
                            "size", row[1],
                            "quantityChanged", row[2],
                            "actionType", row[3],
                            "actionDate", row[4],
                            "storeLocation", row[5]
                    ))
                    .collect(Collectors.toList());
        } finally {
            em.close();
        }
    }


    public boolean hasNextPage(int page, int pageSize){
        return inventoryLogDAO.hasNextPage(page, pageSize);
    }
}
