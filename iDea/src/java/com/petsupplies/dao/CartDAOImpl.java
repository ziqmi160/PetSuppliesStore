package com.petsupplies.dao;

import com.petsupplies.model.Cart;
import com.petsupplies.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CartDAOImpl implements CartDAO {

    @Override
    public Cart create(Cart cart) throws SQLException {
        String sql = "INSERT INTO Cart (user_id, created_at) VALUES (?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setInt(1, cart.getUserId());
            statement.setTimestamp(2, cart.getCreatedAt());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating cart failed, no rows affected.");
            }
            
            generatedKeys = statement.getGeneratedKeys();
            
            if (generatedKeys.next()) {
                cart.setCartId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Creating cart failed, no ID obtained.");
            }
            
            return cart;
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
    public Cart findById(int cartId) throws SQLException {
        String sql = "SELECT * FROM Cart WHERE cart_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cartId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return extractCartFromResultSet(resultSet);
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
    public Cart findByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM Cart WHERE user_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return extractCartFromResultSet(resultSet);
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
    public Cart update(Cart cart) throws SQLException {
        String sql = "UPDATE Cart SET user_id = ? WHERE cart_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, cart.getUserId());
            statement.setInt(2, cart.getCartId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Updating cart failed, no rows affected.");
            }
            
            return cart;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean delete(int cartId) throws SQLException {
        String sql = "DELETE FROM Cart WHERE cart_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, cartId);
            
            int affectedRows = statement.executeUpdate();
            
            return affectedRows > 0;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }
    
    private Cart extractCartFromResultSet(ResultSet resultSet) throws SQLException {
        Cart cart = new Cart();
        cart.setCartId(resultSet.getInt("cart_id"));
        cart.setUserId(resultSet.getInt("user_id"));
        cart.setCreatedAt(resultSet.getTimestamp("created_at"));
        return cart;
    }
}