package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import model.ProductStock;
import model.ProductVariant;

import java.util.List;

public class ProductStockService {
    private static final GenericDAO<ProductStock> productStockDAO = new GenericDAO<>(ProductStock.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");

    public ProductStock getProductStock(Integer productVariantId) {
        return productStockDAO.findByAttribute("productVariantID", productVariantId).get(0);
    }

    public void updateProductStock(ProductStock productStock) {
        productStockDAO.update(productStock);
    }

    public void addProductStock(ProductStock productStock) {
        productStockDAO.insert(productStock);
    }

    public void deleteByVariantId(Integer productVariantId) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.createQuery("DELETE FROM ProductStock ps WHERE ps.productVariantID.id = :variantId")
                    .setParameter("variantId", productVariantId)
                    .executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
