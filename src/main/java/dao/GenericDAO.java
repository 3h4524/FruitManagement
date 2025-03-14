package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceException;
import jakarta.persistence.Query;
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
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback(); // Rollback nếu có lỗi
            System.out.println("LỖI INSERT: " + e.getMessage()); // In lỗi ra console
            e.printStackTrace(); // In toàn bộ lỗi
            return false;
        } finally {
            em.close();
        }
    }



    @Override
    public boolean update(T t) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(t); // Hibernate sẽ kiểm tra ID, nếu có thì cập nhật, không có thì thêm mới
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace(); // In lỗi ra console để debug
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

    public List<T> listWithOffset(int page, int pageSize) {
        EntityManager em = emf.createEntityManager();
        try{
            return em.createNamedQuery(entityClass.getSimpleName() + "listWithOffset", entityClass).setFirstResult((page -1) * pageSize).setMaxResults(pageSize).getResultList();
        } finally {
            em.close();
        }
    }

    public List<T> findByAttribute(String attributeName, Object value) {
        EntityManager em = emf.createEntityManager();
        List<T> resultList = Collections.emptyList(); // Tránh trả về null
        try {
            // Tạo tên NamedQuery dựa trên entity
            String queryName = entityClass.getSimpleName() + ".findBy" + Utils.capitalizeFirstLetter(attributeName);
            System.out.println("Executing NamedQuery: " + queryName + " with value: " + value);

            // Thực thi NamedQuery
            resultList = em.createNamedQuery(queryName, entityClass)
                    .setParameter(attributeName, value)
                    .getResultList();
        } catch (IllegalArgumentException e) {
            System.err.println("❌ ERROR: NamedQuery '" + attributeName + "' không tồn tại hoặc tham số không hợp lệ: " + e.getMessage());
        } catch (PersistenceException e) {
            System.err.println("❌ Database Error khi thực thi query: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("❌ Unexpected Error trong findByAttribute: " + e.getMessage());
        } finally {
            em.close();
        }
        return resultList;
    }



}

