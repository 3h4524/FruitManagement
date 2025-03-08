package dao;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public abstract class BaseDAO<T> {
    static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("FruitManagementPU");
    public abstract List<T> getAll();
    public abstract T findById(int id);
    public abstract boolean insert(T t) ;
    public abstract boolean update(T t) ;
    public abstract boolean delete(int id) ;

}
