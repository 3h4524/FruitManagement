package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import service.Utils;

import java.util.Collections;
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
            System.out.println("added");
            return true; // Chèn thành công
        } catch (Exception e) {
            System.out.println(e.getMessage());
            em.getTransaction().rollback(); // Rollback nếu có lỗi
            e.printStackTrace(); // In lỗi ra console (hoặc log)
            return false; // Chèn thất bại
        } finally {
            em.close();
        }
    }


    @Override
    public boolean update(T t) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            if (!em.contains(t)) {
                t = em.merge(t);
            }

            em.flush();  // Đảm bảo dữ liệu cập nhật ngay lập tức
            em.refresh(t); // Load lại entity sau khi trigger chạy

            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }


    @Override
    public boolean delete(int id) {
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

    public List<T> listWithOffset(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createNamedQuery(entityClass.getSimpleName() + "listWithOffset", entityClass).setFirstResult((page - 1) * pageSize).setMaxResults(pageSize).getResultList();
        } finally {
            em.close();
        }
    }

    public List<T> findByAttribute(String attributeName, Object value) {
        EntityManager em = emf.createEntityManager();
        try {
            String queryName = entityClass.getSimpleName() + ".findBy" + Utils.capitalizeFirstLetter(attributeName);
            return em.createNamedQuery(queryName, entityClass)
                    .setParameter(attributeName, value)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

}

