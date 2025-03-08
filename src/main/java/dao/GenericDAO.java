package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import model.Customer;
import model.Product;

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
            return em.createNamedQuery(entityClass.getSimpleName() + ".findAll", entityClass)
                    .getResultList();
        } finally {
            em.close();
        }
    }


    @Override
    public boolean insert(T t) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(t);
            em.getTransaction().commit();
            return true; // Chèn thành công
        } catch (Exception e) {
            em.getTransaction().rollback(); // Rollback nếu có lỗi
            e.printStackTrace(); // In lỗi ra console (hoặc log)
            return false; // Chèn thất bại
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
    public List<T> findByName(String name) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createNamedQuery(entityClass.getSimpleName() + ".findByName", entityClass)
                    .setParameter("name", "%" + name + "%") // Tìm kiếm chuỗi chứa 'name'
                    .getResultList();
        } finally {
            em.close();
        }
    }
    public T findByUserName(String name) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createNamedQuery(entityClass.getSimpleName() + ".findByName", entityClass)
                    .setParameter("name", name) // Không dùng dấu % nữa
                    .getSingleResult(); // Lấy một kết quả duy nhất
        } catch (NoResultException e) {
            return null; // Nếu không tìm thấy, trả về null
        } finally {
            em.close();
        }
    }

}

