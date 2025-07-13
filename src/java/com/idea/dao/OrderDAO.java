/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.dao;

/**
 *
 * @author haziq
 */
import com.idea.model.CartItem;
import com.idea.model.Order;
import com.idea.model.OrderItem;
import utils.Database; // Assuming this provides your database connection
import java.sql.*;
import java.util.List;
import java.util.ArrayList; // For Java 5 compatibility
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO {
    private static final Logger LOGGER = Logger.getLogger(OrderDAO.class.getName());

    /**
     * Places a new order, including adding order items, updating product stock,
     * and clearing purchased items from the user's cart, all within a single
     * transaction.
     *
     * @param order               The Order object containing user, total amount,
     *                            status, and billing details.
     * @param userId              The ID of the user placing the order.
     * @param cartId              The ID of the user's cart (to clear purchased
     *                            items from).
     * @param purchasedProductIds A list of product IDs that were successfully
     *                            purchased.
     * @return The generated OrderID for the new order.
     * @throws SQLException             If a database error occurs, the transaction
     *                                  will be rolled back.
     * @throws IllegalArgumentException If an item's stock is insufficient.
     */
    public int placeOrder(Order order, int userId, int cartId, List<Integer> purchasedProductIds) throws SQLException {
        Connection conn = null;
        int orderId = -1;

        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Create the Order record
            String insertOrderSql = "INSERT INTO Orders (UserID, TotalAmount, Status) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.setDouble(2, order.getTotalAmount());
                stmt.setString(3, order.getStatus());
                stmt.executeUpdate();

                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                    order.setOrderId(orderId); // Set the generated ID back to the Order object
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }

            // 2. Add OrderItems and update Product Stock
            // Important: We retrieve current stock to ensure atomicity and prevent
            // over-selling
            for (int i = 0; i < order.getOrderItems().size(); i++) { // Changed: Traditional loop
                OrderItem item = (OrderItem) order.getOrderItems().get(i); // Explicit cast for Java 5

                // Get current product stock
                int currentStock = 0;
                String getStockSql = "SELECT StockQuantity FROM Products WHERE ProductID = ?";
                try (PreparedStatement stockStmt = conn.prepareStatement(getStockSql)) {
                    stockStmt.setInt(1, item.getProductId());
                    ResultSet stockRs = stockStmt.executeQuery();
                    if (stockRs.next()) {
                        currentStock = stockRs.getInt("StockQuantity");
                    } else {
                        throw new SQLException("Product with ID " + item.getProductId() + " not found.");
                    }
                }

                if (currentStock < item.getQuantity()) {
                    throw new IllegalArgumentException("Insufficient stock for product: " + item.getProductName()
                            + ". Available: " + currentStock + ", Requested: " + item.getQuantity());
                }

                // Insert into OrderItems
                String insertOrderItemSql = "INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";
                try (PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemSql)) {
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, item.getProductId());
                    itemStmt.setInt(3, item.getQuantity());
                    itemStmt.setDouble(4, item.getPrice()); // Price at the time of order
                    itemStmt.executeUpdate();
                }

                // Update Product Stock (decrement)
                String updateStockSql = "UPDATE Products SET StockQuantity = StockQuantity - ? WHERE ProductID = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateStockSql)) {
                    updateStmt.setInt(1, item.getQuantity());
                    updateStmt.setInt(2, item.getProductId());
                    updateStmt.executeUpdate();
                }
            }

            // 3. Clear purchased items from the user's CartItems table
            if (purchasedProductIds != null && !purchasedProductIds.isEmpty()) {
                // Build a dynamic SQL query to delete multiple items
                StringBuilder deleteCartItemsSql = new StringBuilder(
                        "DELETE FROM CartItems WHERE CartID = ? AND ProductID IN (");
                for (int i = 0; i < purchasedProductIds.size(); i++) {
                    deleteCartItemsSql.append("?");
                    if (i < purchasedProductIds.size() - 1) {
                        deleteCartItemsSql.append(",");
                    }
                }
                deleteCartItemsSql.append(")");

                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteCartItemsSql.toString())) {
                    deleteStmt.setInt(1, cartId);
                    for (int i = 0; i < purchasedProductIds.size(); i++) {
                        deleteStmt.setInt(i + 2, purchasedProductIds.get(i)); // +2 because 1st param is cartId
                    }
                    deleteStmt.executeUpdate();
                }
            }

            conn.commit(); // Commit the transaction if all operations succeed
            return orderId;

        } catch (SQLException | IllegalArgumentException e) { // Catch both SQLException and custom
                                                              // IllegalArgumentException
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException rollbackEx) {
                    // Log rollback exception

                }
            }
            throw e; // Re-throw the original exception
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Reset auto-commit mode
                    conn.close();
                } catch (SQLException closeEx) {
                    // Log close exception

                }
            }
        }
    }

    /**
     * Retrieves all orders from the database.
     * 
     * @return A list of Order objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Attempting to retrieve all orders.");

        try {
            conn = Database.getConnection();
            String sql = "SELECT OrderID, UserID, OrderDate, TotalAmount, Status FROM Orders ORDER BY OrderDate DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                // Use the constructor for retrieving existing orders from DB
                String status = rs.getString("Status");
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getTimestamp("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        (status != null) ? status : "Pending",
                        "", "", "", "", "", "", "", "" // Default empty values for billing fields including notes
                );
                orders.add(order);
            }
            LOGGER.log(Level.INFO, "Retrieved {0} orders.", orders.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getAllOrders: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in getAllOrders: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getAllOrders: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in getAllOrders: {0}", e.getMessage());
            }
        }
        return orders;
    }

    /**
     * Retrieves an order by its ID.
     * 
     * @param orderId The ID of the order to retrieve.
     * @return The Order object, or null if not found.
     * @throws SQLException If a database access error occurs.
     */
    public Order getOrderById(int orderId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Attempting to retrieve order with ID: " + orderId);

        try {
            conn = Database.getConnection();
            String sql = "SELECT OrderID, UserID, OrderDate, TotalAmount, Status FROM Orders WHERE OrderID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Use the constructor for retrieving existing orders from DB
                String status = rs.getString("Status");
                Order order = new Order(
                        rs.getInt("OrderID"),
                        rs.getInt("UserID"),
                        rs.getTimestamp("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        (status != null) ? status : "Pending",
                        "", "", "", "", "", "", "", "" // Default empty values for billing fields including notes
                );
                LOGGER.log(Level.INFO, "Retrieved order: {0}", orderId);
                return order;
            } else {
                LOGGER.log(Level.WARNING, "Order with ID {0} not found.", orderId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getOrderById: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in getOrderById: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getOrderById: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in getOrderById: {0}", e.getMessage());
            }
        }
    }
    
    /**
 * Retrieves all orders placed by a specific user.
 *
 * @param userId The ID of the user.
 * @return A list of Order objects.
 * @throws SQLException If a database access error occurs.
 */
public List<Order> getOrdersByUserId(int userId) throws SQLException {
    List<Order> orders = new ArrayList<>();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    LOGGER.info("Retrieving orders for user ID: " + userId);

    try {
        conn = Database.getConnection();
        String sql = "SELECT OrderID, UserID, OrderDate, TotalAmount, Status FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();

        while (rs.next()) {
            String status = rs.getString("Status");
            Order order = new Order(
                rs.getInt("OrderID"),
                rs.getInt("UserID"),
                rs.getTimestamp("OrderDate"),
                rs.getDouble("TotalAmount"),
                (status != null) ? status : "Pending",
                "", "", "", "", "", "", "", "" // Default empty values
            );
            orders.add(order);
        }

        LOGGER.log(Level.INFO, "Retrieved {0} orders for user ID {1}.", new Object[]{orders.size(), userId});
    } catch (SQLException e) {
        LOGGER.log(Level.SEVERE, "SQL Exception in getOrdersByUserId: {0}", e.getMessage());
        throw e;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Closing ResultSet failed", e); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Closing PreparedStatement failed", e); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Closing Connection failed", e); }
    }

    return orders;
}


    /**
     * Updates an existing order's status in the database.
     * 
     * @param orderId The ID of the order to update.
     * @param status  The new status for the order.
     * @throws SQLException If a database access error occurs.
     */
    public void updateOrderStatus(int orderId, String status) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to update order status for ID: " + orderId + " to: " + status);

        try {
            conn = Database.getConnection();
            String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully updated order status: {0} (ID: {1})",
                        new Object[] { status, orderId });
            } else {
                LOGGER.log(Level.WARNING, "No order found with ID {0} to update.", orderId);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in updateOrderStatus: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in updateOrderStatus: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in updateOrderStatus: {0}", e.getMessage());
            }
        }
    }

    /**
     * Checks if an order has related records that would prevent deletion.
     * 
     * @param orderId The ID of the order to check.
     * @return true if the order has related records, false otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public boolean hasRelatedRecords(int orderId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = Database.getConnection();

            // Check for OrderItems records
            String sql = "SELECT COUNT(*) FROM OrderItems WHERE OrderID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }

            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in hasRelatedRecords: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in hasRelatedRecords: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in hasRelatedRecords: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in hasRelatedRecords: {0}", e.getMessage());
            }
        }
    }

    /**
     * Deletes an order from the database.
     * This method handles foreign key constraints by deleting related OrderItems
     * first.
     * 
     * @param orderId The ID of the order to delete.
     * @throws SQLException If a database access error occurs.
     */
    public void deleteOrder(int orderId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to delete order with ID: " + orderId);

        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // First, delete related OrderItems records
            String deleteOrderItemsSql = "DELETE FROM OrderItems WHERE OrderID = ?";
            stmt = conn.prepareStatement(deleteOrderItemsSql);
            stmt.setInt(1, orderId);
            int orderItemsDeleted = stmt.executeUpdate();
            LOGGER.log(Level.INFO, "Deleted {0} order items for order ID: {1}",
                    new Object[] { orderItemsDeleted, orderId });

            // Then delete the order itself
            String deleteOrderSql = "DELETE FROM Orders WHERE OrderID = ?";
            stmt = conn.prepareStatement(deleteOrderSql);
            stmt.setInt(1, orderId);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                conn.commit(); // Commit the transaction
                LOGGER.log(Level.INFO, "Successfully deleted order with ID: {0} and {1} related order items",
                        new Object[] { orderId, orderItemsDeleted });
            } else {
                conn.rollback(); // Rollback if no order was found
                LOGGER.log(Level.WARNING, "No order found with ID {0} to delete.", orderId);
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error
                } catch (SQLException rollbackEx) {
                    LOGGER.log(Level.SEVERE, "Error rolling back transaction: {0}", rollbackEx.getMessage());
                }
            }
            LOGGER.log(Level.SEVERE, "SQL Exception in deleteOrder: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto-commit mode
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error resetting auto-commit: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in deleteOrder: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in deleteOrder: {0}", e.getMessage());
            }
        }
    }
    
    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
    List<OrderItem> items = new ArrayList<>();
    String sql = "SELECT oi.*, p.Name AS ProductName FROM OrderItems oi " +
                 "JOIN Products p ON oi.ProductID = p.ProductID WHERE oi.OrderID = ?";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, orderId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            OrderItem item = new OrderItem();
            item.setOrderItemId(rs.getInt("OrderItemID"));
            item.setOrderId(rs.getInt("OrderID"));
            item.setProductId(rs.getInt("ProductID"));
            item.setQuantity(rs.getInt("Quantity"));
            item.setPrice(rs.getDouble("Price"));
            item.setProductName(rs.getString("ProductName"));
            items.add(item);
        }
    }

    return items;
}

}
