package com.petsupplies.dao;

import com.petsupplies.model.CartItem;
import com.petsupplies.model.Product;
import com.petsupplies.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAOImpl implements CartItemDAO {

    private ProductDAO productDAO = new ProductDAOImpl();
    
    @Override
    public CartItem create(CartItem cartItem) throws SQLException {
        String sql = "INSERT INTO CartItems (cart_id, product_id, quantity, added_at) VALUES (?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setInt(1, cartItem.getCartId());
            statement.setInt(2, cartItem.getProductId());
            statement.setInt(3, cartItem.getQuantity());
            statement.setTimestamp(4, cartItem.getAddedAt());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating cart item failed, no rows affected.");
            }
            
            generatedKeys = statement.getGeneratedKeys();
            
            if (generatedKeys.next()) {
                cartItem.setCartItemId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Creating cart item failed, no ID obtained.");
            }
            
            return cartItem;
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
    public CartItem findById(int cartItemId) throws SQLException {
        String sql = "SELECT * FROM CartItems WHERE cart_item_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cartItemId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                CartItem cartItem = extractCartItemFromResultSet(resultSet);
                // Load product information
                Product product = productDAO.findById(cartItem.getProductId());
                cartItem.setProduct(product);
                return cartItem;
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
    public List<CartItem> findByCartId(int cartId) throws SQLException {
        String sql = "SELECT * FROM CartItems WHERE cart_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cartId);
            
            resultSet = statement.executeQuery();
            
            List<CartItem> cartItems = new ArrayList<>();
            
            while (resultSet.next()) {
                CartItem cartItem = extractCartItemFromResultSet(resultSet);
                // Load product information
                Product product = productDAO.findById(cartItem.getProductId());
                cartItem.setProduct(product);
                cartItems.add(cartItem);
            }
            
            return cartItems;
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
    public CartItem findByCartIdAndProductId(int cartId, int productId) throws SQLException {
        String sql = "SELECT * FROM CartItems WHERE cart_id = ? AND product_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, cartId);
            statement.setInt(2, productId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                CartItem cartItem = extractCartItemFromResultSet(resultSet);
                // Load product information
                Product product = productDAO.findById(cartItem.getProductId());
                cartItem.setProduct(product);
                return cartItem;
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
    public CartItem update(CartItem cartItem) throws SQLException {
        String sql = "UPDATE CartItems SET quantity = ? WHERE cart_item_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, cartItem.getQuantity());
            statement.setInt(2, cartItem.getCartItemId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Updating cart item failed, no rows affected.");
            }
            
            return cartItem;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean delete(int cartItemId) throws SQLException {
        String sql = "DELETE FROM CartItems WHERE cart_item_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, cartItemId);
            
            int affectedRows = statement.executeUpdate();
            
            return affectedRows > 0;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }
    
    private CartItem extractCartItemFromResultSet(ResultSet resultSet) throws SQLException {
        CartItem cartItem = new CartItem();
        cartItem.setCartItemId(resultSet.getInt("cart_item_id"));
        cartItem.setCartId(resultSet.getInt("cart_id"));
        cartItem.setProductId(resultSet.getInt("product_id"));
        cartItem.setQuantity(resultSet.getInt("quantity"));
        cartItem.setAddedAt(resultSet.getTimestamp("added_at"));
        return cartItem;
    }
}