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
        return -1;
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
}
