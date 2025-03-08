package dao;

import jakarta.persistence.EntityManager;

import java.util.List;

public class GenericDAO<T> extends BaseDAO<T> {

    private final Class<T> entityClass;

    public GenericDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    @Override
    public List<T> getAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT e FROM " + entityClass.getSimpleName() + " e", entityClass).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(T t){
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(t);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean update(T t){
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            // Kiểm tra entity có tồn tại không
            if (em.find(entityClass, em.getEntityManagerFactory().getPersistenceUnitUtil().getIdentifier(t)) == null) {
                return false; // Không tìm thấy => không cập nhật
            }

            em.merge(t);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean delete(int id)  {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            T entity = em.find(entityClass, id);
            if (entity != null) {
                em.remove(entity);
                em.getTransaction().commit();
                return true; // Xóa thành công
            }
            em.getTransaction().rollback();
            return false; // Không tìm thấy entity để xóa
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e; // Nếu có lỗi, ném exception để xử lý
        } finally {
            em.close();
        }
    }

    @Override
    public T findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(entityClass, id);
        } finally {
            em.close();
        }
    }
}

