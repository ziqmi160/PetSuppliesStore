package com.petsupplies.dao;

import com.petsupplies.model.Product;
import java.sql.SQLException;
import java.util.List;

public interface ProductDAO {
    Product create(Product product) throws SQLException;
    Product findById(int productId) throws SQLException;
    List<Product> findAll() throws SQLException;
    List<Product> findByCategoryId(int categoryId) throws SQLException;
    Product update(Product product) throws SQLException;
    boolean delete(int productId) throws SQLException;
}