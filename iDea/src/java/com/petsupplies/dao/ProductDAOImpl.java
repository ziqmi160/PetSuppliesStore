package com.petsupplies.dao;

import com.petsupplies.model.Category;
import com.petsupplies.model.Product;
import com.petsupplies.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    private CategoryDAO categoryDAO = new CategoryDAOImpl();
    
    @Override
    public Product create(Product product) throws SQLException {
        String sql = "INSERT INTO Products (name, description, price, stock_quantity, image_url, category_id, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            Timestamp now = new Timestamp(System.currentTimeMillis());
            
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setBigDecimal(3, product.getPrice());
            statement.setInt(4, product.getStockQuantity());
            statement.setString(5, product.getImageUrl());
            statement.setInt(6, product.getCategoryId());
            statement.setTimestamp(7, product.getCreatedAt() != null ? product.getCreatedAt() : now);
            statement.setTimestamp(8, product.getUpdatedAt() != null ? product.getUpdatedAt() : now);
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating product failed, no rows affected.");
            }
            
            generatedKeys = statement.getGeneratedKeys();
            
            if (generatedKeys.next()) {
                product.setProductId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Creating product failed, no ID obtained.");
            }
            
            return product;
        } finally {
            if (generatedKeys != null) {
                generatedKeys.close();
            }
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public Product findById(int productId) throws SQLException {
        String sql = "SELECT p.*, c.name as category_name, c.description as category_description "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "WHERE p.product_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return extractProductFromResultSet(resultSet);
            }
            
            return null;
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public List<Product> findAll() throws SQLException {
        String sql = "SELECT p.*, c.name as category_name, c.description as category_description "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            resultSet = statement.executeQuery();
            
            List<Product> products = new ArrayList<>();
            
            while (resultSet.next()) {
                products.add(extractProductFromResultSet(resultSet));
            }
            
            return products;
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public List<Product> findByCategoryId(int categoryId) throws SQLException {
        String sql = "SELECT p.*, c.name as category_name, c.description as category_description "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.category_id "
                + "WHERE p.category_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, categoryId);
            
            resultSet = statement.executeQuery();
            
            List<Product> products = new ArrayList<>();
            
            while (resultSet.next()) {
                products.add(extractProductFromResultSet(resultSet));
            }
            
            return products;
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public Product update(Product product) throws SQLException {
        String sql = "UPDATE Products SET name = ?, description = ?, price = ?, stock_quantity = ?, "
                + "image_url = ?, category_id = ?, updated_at = ? WHERE product_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setBigDecimal(3, product.getPrice());
            statement.setInt(4, product.getStockQuantity());
            statement.setString(5, product.getImageUrl());
            statement.setInt(6, product.getCategoryId());
            statement.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            statement.setInt(8, product.getProductId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Updating product failed, no rows affected.");
            }
            
            return product;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean delete(int productId) throws SQLException {
        String sql = "DELETE FROM Products WHERE product_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, productId);
            
            int affectedRows = statement.executeUpdate();
            
            return affectedRows > 0;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }
    
    private Product extractProductFromResultSet(ResultSet resultSet) throws SQLException {
        Product product = new Product();
        product.setProductId(resultSet.getInt("product_id"));
        product.setName(resultSet.getString("name"));
        product.setDescription(resultSet.getString("description"));
        product.setPrice(resultSet.getBigDecimal("price"));
        product.setStockQuantity(resultSet.getInt("stock_quantity"));
        product.setImageUrl(resultSet.getString("image_url"));
        product.setCategoryId(resultSet.getInt("category_id"));
        product.setCreatedAt(resultSet.getTimestamp("created_at"));
        product.setUpdatedAt(resultSet.getTimestamp("updated_at"));
        
        // Add category information if available
        if (resultSet.getString("category_name") != null) {
            Category category = new Category();
            category.setCategoryId(resultSet.getInt("category_id"));
            category.setName(resultSet.getString("category_name"));
            category.setDescription(resultSet.getString("category_description"));
            product.setCategory(category);
        }
        
        return product;
    }
}