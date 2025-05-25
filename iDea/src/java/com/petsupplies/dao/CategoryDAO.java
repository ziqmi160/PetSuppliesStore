package com.petsupplies.dao;

import com.petsupplies.model.Category;
import java.sql.SQLException;
import java.util.List;

public interface CategoryDAO {
    Category create(Category category) throws SQLException;
    Category findById(int categoryId) throws SQLException;
    List<Category> findAll() throws SQLException;
    Category update(Category category) throws SQLException;
    boolean delete(int categoryId) throws SQLException;
}