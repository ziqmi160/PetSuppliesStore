package com.petsupplies.dao;

import com.petsupplies.model.OrderItem;
import com.petsupplies.model.Product;
import com.petsupplies.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAOImpl implements OrderItemDAO {

    private ProductDAO productDAO = new ProductDAOImpl();
    
    @Override
    public OrderItem create(OrderItem orderItem) throws SQLException {
        String sql = "INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setInt(1, orderItem.getOrderId());
            statement.setInt(2, orderItem.getProductId());
            statement.setInt(3, orderItem.getQuantity());
            statement.setBigDecimal(4, orderItem.getPrice());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating order item failed, no rows affected.");
            }
            
            generatedKeys = statement.getGeneratedKeys();
            
            if (generatedKeys.next()) {
                orderItem.setItemId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Creating order item failed, no ID obtained.");
            }
            
            return orderItem;
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
    public OrderItem findById(int itemId) throws SQLException {
        String sql = "SELECT * FROM OrderItems WHERE item_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, itemId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                OrderItem orderItem = extractOrderItemFromResultSet(resultSet);
                // Load product information
                Product product = productDAO.findById(orderItem.getProductId());
                orderItem.setProduct(product);
                return orderItem;
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
    public List<OrderItem> findByOrderId(int orderId) throws SQLException {
        String sql = "SELECT oi.*, p.name as product_name FROM OrderItems oi "
                + "JOIN Products p ON oi.product_id = p.product_id "
                + "WHERE oi.order_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);
            
            resultSet = statement.executeQuery();
            
            List<OrderItem> orderItems = new ArrayList<>();
            
            while (resultSet.next()) {
                OrderItem orderItem = extractOrderItemFromResultSet(resultSet);
                
                // Create a basic product with minimal information
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setName(resultSet.getString("product_name"));
                
                orderItem.setProduct(product);
                
                // If you need full product details
                product = productDAO.findById(orderItem.getProductId());
                orderItem.setProduct(product);
                
                orderItems.add(orderItem);
            }
            
            return orderItems;
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
    public OrderItem update(OrderItem orderItem) throws SQLException {
        String sql = "UPDATE OrderItems SET quantity = ?, price = ? WHERE item_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, orderItem.getQuantity());
            statement.setBigDecimal(2, orderItem.getPrice());
            statement.setInt(3, orderItem.getItemId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Updating order item failed, no rows affected.");
            }
            
            return orderItem;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean delete(int itemId) throws SQLException {
        String sql = "DELETE FROM OrderItems WHERE item_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setInt(1, itemId);
            
            int affectedRows = statement.executeUpdate();
            
            return affectedRows > 0;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }
    
    private OrderItem extractOrderItemFromResultSet(ResultSet resultSet) throws SQLException {
        OrderItem orderItem = new OrderItem();
        orderItem.setItemId(resultSet.getInt("item_id"));
        orderItem.setOrderId(resultSet.getInt("order_id"));
        orderItem.setProductId(resultSet.getInt("product_id"));
        orderItem.setQuantity(resultSet.getInt("quantity"));
        orderItem.setPrice(resultSet.getBigDecimal("price"));
        return orderItem;
    }
}