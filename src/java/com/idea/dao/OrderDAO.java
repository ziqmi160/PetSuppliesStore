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
import utils.Database; // Assuming this provides your database connection
import java.sql.*;
import java.util.List;
import java.util.ArrayList; // For Java 5 compatibility

public class OrderDAO {

    /**
     * Places a new order, including adding order items, updating product stock,
     * and clearing purchased items from the user's cart, all within a single transaction.
     *
     * @param order The Order object containing user, total amount, status, and billing details.
     * @param userId The ID of the user placing the order.
     * @param cartId The ID of the user's cart (to clear purchased items from).
     * @param purchasedProductIds A list of product IDs that were successfully purchased.
     * @return The generated OrderID for the new order.
     * @throws SQLException If a database error occurs, the transaction will be rolled back.
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
            // Important: We retrieve current stock to ensure atomicity and prevent over-selling
            for (int i = 0; i < order.getOrderItems().size(); i++) { // Changed: Traditional loop
                CartItem item = (CartItem) order.getOrderItems().get(i); // Explicit cast for Java 5
                
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
                    throw new IllegalArgumentException("Insufficient stock for product: " + item.getName() + ". Available: " + currentStock + ", Requested: " + item.getQuantity());
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
                StringBuilder deleteCartItemsSql = new StringBuilder("DELETE FROM CartItems WHERE CartID = ? AND ProductID IN (");
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

        } catch (SQLException | IllegalArgumentException e) { // Catch both SQLException and custom IllegalArgumentException
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
}

