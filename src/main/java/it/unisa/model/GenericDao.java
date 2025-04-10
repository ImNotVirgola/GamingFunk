package it.unisa.model;

import java.util.List;

public interface GenericDao<T, ID> {
    T getById(ID id);
    List<T> getAll();
    boolean add(T entity);
    boolean update(T entity);
    boolean deleteById(ID id);

}
