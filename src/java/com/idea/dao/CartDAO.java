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
import utils.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public int createCart(int userId) throws SQLException {
        String sql = "INSERT INTO Cart (UserID) VALUES (?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userId);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // return CartID
            }
        }
        return -1; // Should ideally throw an exception or handle better if creation fails
    }

    public void addCartItem(int cartId, CartItem item) throws SQLException {
        String sql = "INSERT INTO CartItems (CartID, ProductID, Quantity) VALUES (?, ?, ?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartId);
            stmt.setInt(2, item.getProductId());
            stmt.setInt(3, item.getQuantity());
            stmt.executeUpdate();
        }
    }

    public void removeCartItem(int cartId, int productId) throws SQLException {
        String sql = "DELETE FROM CartItems WHERE CartID = ? AND ProductID = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }

    public void updateCartItem(int cartId, int productId, int quantity) throws SQLException {
        String sql = "UPDATE CartItems SET Quantity = ? WHERE CartID = ? AND ProductID = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, cartId);
            stmt.setInt(3, productId);
            stmt.executeUpdate();
        }
    }

    /**
     * Retrieves a single CartItem from the database based on CartID and ProductID.
     * This is used to check if a product already exists in the cart.
     *
     * @param cartId The ID of the cart.
     * @param productId The ID of the product.
     * @return A CartItem object if found, otherwise null.
     * @throws SQLException If a database access error occurs.
     */
    public CartItem getCartItem(int cartId, int productId) throws SQLException {
        CartItem item = null;
        // The query needs to join with products to get details like name, price, and image.
        String sql = "SELECT ci.ProductID, p.Name, p.Price, ci.Quantity, " +
                     "(SELECT imagepath FROM images WHERE productid = p.productid ORDER BY imageid FETCH FIRST ROW ONLY) AS imagepath " +
                     "FROM CartItems ci " +
                     "JOIN Products p ON ci.ProductID = p.ProductID " +
                     "WHERE ci.CartID = ? AND ci.ProductID = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    item = new CartItem(
                            rs.getInt("ProductID"),
                            rs.getString("Name"),
                            rs.getDouble("Price"),
                            rs.getInt("Quantity"),
                            rs.getString("imagepath")
                    );
                }
            }
        }
        return item;
    }

    public int getCartIdByUserId(int userId) throws SQLException {
        String sql = "SELECT cartid FROM cart WHERE userid = ?";

        try (Connection conn = Database.getConnection(); // Ensure connection is properly closed
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cartid");
                }
            }
        } // The outer try-with-resources handles closing conn and stmt
        // Removed the catch here, let the calling method handle SQLException

        return -1; // No cart found
    }

    public int getOrCreateCartId(int userId) throws SQLException {
        int cartId = getCartIdByUserId(userId);
        if (cartId != -1) {
            return cartId;
        }
        System.out.println("No existing cart for user " + userId + ". Creating a new one.");

        // If no cart exists, create one
        String insertSql = "INSERT INTO cart (userid) VALUES (?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userId);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating cart failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating cart failed, no ID obtained.");
                }
            }
        }
    }

    public List<CartItem> getCartItems(int cartId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        // Make sure your SQL query correctly handles cases where there might be no image
        String sql = "SELECT ci.productid, p.name, p.price, ci.quantity," +
                     "(SELECT imagepath FROM images WHERE productid = p.productid ORDER BY imageid FETCH FIRST ROW ONLY) AS imagepath " +
                     "FROM cartitems ci " +
                     "JOIN products p ON ci.productid = p.productid " +
                     "WHERE ci.cartid = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem(
                        rs.getInt("productid"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("imagepath") // This can be null if no image is found
                );
                items.add(item);
            }
        }
        return items;
    }
}
