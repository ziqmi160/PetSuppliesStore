package com.petsupplies.dao;

import com.petsupplies.model.Order;
import com.petsupplies.model.User;
import com.petsupplies.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    private UserDAO userDAO = new UserDAOImpl();
    
    @Override
    public Order create(Order order) throws SQLException {
        String sql = "INSERT INTO Orders (user_id, order_date, total_amount, shipping_address, status, payment_method) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            statement.setInt(1, order.getUserId());
            statement.setTimestamp(2, order.getOrderDate());
            statement.setBigDecimal(3, order.getTotalAmount());
            statement.setString(4, order.getShippingAddress());
            statement.setString(5, order.getStatus());
            statement.setString(6, order.getPaymentMethod());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }
            
            generatedKeys = statement.getGeneratedKeys();
            
            if (generatedKeys.next()) {
                order.setOrderId(generatedKeys.getInt(1));
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }
            
            return order;
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
    public Order findById(int orderId) throws SQLException {
        String sql = "SELECT * FROM Orders WHERE order_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                Order order = extractOrderFromResultSet(resultSet);
                // Load user information
                User user = userDAO.findById(order.getUserId());
                order.setUser(user);
                return order;
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
    public List<Order> findAll() throws SQLException {
        String sql = "SELECT o.*, u.username, u.email, u.full_name FROM Orders o "
                + "JOIN Users u ON o.user_id = u.user_id "
                + "ORDER BY o.order_date DESC";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            resultSet = statement.executeQuery();
            
            List<Order> orders = new ArrayList<>();
            
            while (resultSet.next()) {
                Order order = extractOrderFromResultSet(resultSet);
                
                // Create a basic user with minimal information
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setFullName(resultSet.getString("full_name"));
                
                order.setUser(user);
                orders.add(order);
            }
            
            return orders;
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
    public List<Order> findByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM Orders WHERE user_id = ? ORDER BY order_date DESC";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            
            resultSet = statement.executeQuery();
            
            List<Order> orders = new ArrayList<>();
            
            while (resultSet.next()) {
                orders.add(extractOrderFromResultSet(resultSet));
            }
            
            return orders;
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
    public List<Order> findRecentOrders(int limit) throws SQLException {
        String sql = "SELECT o.*, u.username, u.email, u.full_name FROM Orders o "
                + "JOIN Users u ON o.user_id = u.user_id "
                + "ORDER BY o.order_date DESC "
                + "FETCH FIRST ? ROWS ONLY";
        
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            
            resultSet = statement.executeQuery();
            
            List<Order> orders = new ArrayList<>();
            
            while (resultSet.next()) {
                Order order = extractOrderFromResultSet(resultSet);
                
                // Create a basic user with minimal information
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setFullName(resultSet.getString("full_name"));
                
                order.setUser(user);
                orders.add(order);
            }
            
            return orders;
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
    public Order update(Order order) throws SQLException {
        String sql = "UPDATE Orders SET status = ?, shipping_address = ?, payment_method = ? WHERE order_id = ?";
        
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            
            statement.setString(1, order.getStatus());
            statement.setString(2, order.getShippingAddress());
            statement.setString(3, order.getPaymentMethod());
            statement.setInt(4, order.getOrderId());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Updating order failed, no rows affected.");
            }
            
            return order;
        } finally {
            if (statement != null) {
                statement.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }

    @Override
    public boolean delete(int orderId) throws SQLException {
        // First delete related order items
        String deleteOrderItemsSql = "DELETE FROM OrderItems WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM Orders WHERE order_id = ?";
        
        Connection connection = null;
        PreparedStatement deleteOrderItemsStmt = null;
        PreparedStatement deleteOrderStmt = null;
        
        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false);
            
            // Delete order items first
            deleteOrderItemsStmt = connection.prepareStatement(deleteOrderItemsSql);
            deleteOrderItemsStmt.setInt(1, orderId);
            deleteOrderItemsStmt.executeUpdate();
            
            // Then delete the order
            deleteOrderStmt = connection.prepareStatement(deleteOrderSql);
            deleteOrderStmt.setInt(1, orderId);
            int affectedRows = deleteOrderStmt.executeUpdate();
            
            connection.commit();
            
            return affectedRows > 0;
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    throw new SQLException("Error rolling back transaction", ex);
                }
            }
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
            if (deleteOrderItemsStmt != null) {
                deleteOrderItemsStmt.close();
            }
            if (deleteOrderStmt != null) {
                deleteOrderStmt.close();
            }
            DatabaseConnection.closeConnection(connection);
        }
    }
    
    private Order extractOrderFromResultSet(ResultSet resultSet) throws SQLException {
        Order order = new Order();
        order.setOrderId(resultSet.getInt("order_id"));
        order.setUserId(resultSet.getInt("user_id"));
        order.setOrderDate(resultSet.getTimestamp("order_date"));
        order.setTotalAmount(resultSet.getBigDecimal("total_amount"));
        order.setShippingAddress(resultSet.getString("shipping_address"));
        order.setStatus(resultSet.getString("status"));
        order.setPaymentMethod(resultSet.getString("payment_method"));
        return order;
    }
}