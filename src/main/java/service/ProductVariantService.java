package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import model.ProductVariant;

import java.util.List;

public class ProductVariantService {
    private final GenericDAO<ProductVariant> productVariantDao = new GenericDAO<>(ProductVariant.class);
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");

    public ProductVariant getProductVariantById(int id) {
        return productVariantDao.findById(id);
    }
    public List<ProductVariant> getAllProductVariants(int productID) {
        return productVariantDao.findByAttribute("productID", productID);
    }

    public void addProductVariant(ProductVariant productVariant) {
        productVariantDao.insert(productVariant);
    }

    public ProductVariant getVariantByProductAndSize(int productId, String size) {
        EntityManager em = emf.createEntityManager();
        ProductVariant result = null;

        try {
            TypedQuery<ProductVariant> query = em.createQuery(
                    "SELECT pv FROM ProductVariant pv JOIN FETCH pv.product WHERE pv.product.id = :productId AND pv.size = :size",
                    ProductVariant.class);
            query.setParameter("productId", productId);
            query.setParameter("size", size);

            List<ProductVariant> variants = query.getResultList();
            if (!variants.isEmpty()) {
                result = variants.get(0);
            }
        } finally {
            em.close();
        }
        return result;
    }

    public void updateVariant(ProductVariant variant) {
        productVariantDao.update(variant);
    }

    public void deleteProductVariant(Integer variantId) {
        EntityManager em = emf.createEntityManager();
        try{
            em.getTransaction().begin();
            ProductVariant productVariant = productVariantDao.findById(variantId);
            if(productVariant != null) {
                productVariant.setIsDeleted(!productVariant.getIsDeleted());
                em.merge(productVariant);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
