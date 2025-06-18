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

import com.idea.model.Product;
import com.idea.model.ProductImage;
import utils.Database;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement; // For RETURN_GENERATED_KEYS
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level; // For logging levels

public class ProductDAO {
    private static final Logger LOGGER = Logger.getLogger(ProductDAO.class.getName());

    public Product getProductById(int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Product product = null;

        try {
            conn = Database.getConnection();
            String sql = "SELECT p.ProductID, p.Name, p.Description, p.Price, p.CategoryID, p.StockQuantity, c.CategoryName " +
                         "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.ProductID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                    rs.getInt("ProductID"),
                    rs.getString("Name"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getInt("StockQuantity")
                );
                product.setImages(getImagesForProduct(conn, productId));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getProductById for ProductID {0}: {1}", new Object[]{productId, e.getMessage()});
            throw e;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet in getProductById: {0}", e.getMessage()); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getProductById: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in getProductById: {0}", e.getMessage()); }
        }
        return product;
    }

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = Database.getConnection();
            String sql = "SELECT p.ProductID, p.Name, p.Description, p.Price, p.CategoryID, p.StockQuantity, c.CategoryName " +
                         "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID ORDER BY p.ProductID"; // Added ORDER BY
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                    rs.getInt("ProductID"),
                    rs.getString("Name"),
                    rs.getString("Description"),
                    rs.getDouble("Price"),
                    rs.getInt("CategoryID"),
                    rs.getString("CategoryName"),
                    rs.getInt("StockQuantity")
                );
                product.setImages(getImagesForProduct(conn, product.getId()));
                products.add(product);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getAllProducts: {0}", e.getMessage());
            throw e;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet in getAllProducts: {0}", e.getMessage()); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getAllProducts: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in getAllProducts: {0}", e.getMessage()); }
        }
        return products;
    }

    private List<ProductImage> getImagesForProduct(Connection conn, int productId) throws SQLException {
        List<ProductImage> images = new ArrayList<ProductImage>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT ImageID, ImagePath FROM Images WHERE ProductID = ?";
        
        try {
            // Re-use the existing connection from the calling method
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                images.add(new ProductImage(
                    rs.getInt("ImageID"),
                    rs.getString("ImagePath")
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getImagesForProduct for ProductID {0}: {1}", new Object[]{productId, e.getMessage()});
            throw e;
        } finally {
            // Do NOT close connection here as it's passed from calling method
            try { if (rs != null) rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet in getImagesForProduct: {0}", e.getMessage()); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getImagesForProduct: {0}", e.getMessage()); }
        }
        return images;
    }

    public int getProductStock(int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int stock = 0;
        try {
            conn = Database.getConnection();
            String sql = "SELECT StockQuantity FROM Products WHERE ProductID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                stock = rs.getInt("StockQuantity");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getProductStock for ProductID {0}: {1}", new Object[]{productId, e.getMessage()});
            throw e;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet in getProductStock: {0}", e.getMessage()); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getProductStock: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in getProductStock: {0}", e.getMessage()); }
        }
        return stock;
    }

    /**
     * Adds a new product to the database.
     * @param product The Product object to add.
     * @return The generated ProductID.
     * @throws SQLException If a database error occurs.
     */
    public int addProduct(Product product) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int productId = -1;

        try {
            conn = Database.getConnection();
            String sql = "INSERT INTO Products (Name, Description, Price, CategoryID, StockQuantity) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getCategoryId()); // Use CategoryID
            stmt.setInt(5, product.getStockQuantity());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating product failed, no rows affected.");
            }

            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                productId = rs.getInt(1);
                product.setId(productId); // Set the ID back to the product object
                // Add images if any
                if (product.getImages() != null && !product.getImages().isEmpty()) {
                    for (int i = 0; i < product.getImages().size(); i++) { // For Java 5
                        ProductImage image = (ProductImage)product.getImages().get(i); // Explicit cast
                        // Assuming IsPrimary is not used in your ProductImage model now
                        addImage(productId, image.getPath()); // Use the simplified addImage method
                    }
                }
            } else {
                throw new SQLException("Creating product failed, no ID obtained.");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in addProduct for product {0}: {1}", new Object[]{product.getName(), e.getMessage()});
            throw e;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet in addProduct: {0}", e.getMessage()); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in addProduct: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in addProduct: {0}", e.getMessage()); }
        }
        return productId;
    }

    /**
     * Updates an existing product in the database.
     * @param product The Product object with updated details.
     * @throws SQLException If a database error occurs.
     */
    public void updateProduct(Product product) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Database.getConnection();
            String sql = "UPDATE Products SET Name = ?, Description = ?, Price = ?, CategoryID = ?, StockQuantity = ? WHERE ProductID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getCategoryId());
            stmt.setInt(5, product.getStockQuantity());
            stmt.setInt(6, product.getId());
            
            stmt.executeUpdate();
            LOGGER.log(Level.INFO, "Product with ID {0} updated successfully.", product.getId());
            
            // For images, typically you would:
            // 1. Delete all existing images for this product (or just those marked for deletion)
            // 2. Add new images
            // This example simplifies by just adding/deleting images if provided in product object.
            // A more robust implementation would compare existing images with new ones.
            // For now, let's assume we handle images separately or clear and re-add.
            // This method focuses on product details. Image management can be a separate process.

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in updateProduct for ProductID {0}: {1}", new Object[]{product.getId(), e.getMessage()});
            throw e;
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in updateProduct: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in updateProduct: {0}", e.getMessage()); }
        }
    }

    /**
     * Deletes a product and its associated images from the database.
     * @param productId The ID of the product to delete.
     * @throws SQLException If a database error occurs.
     */
    public void deleteProduct(int productId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Delete associated images first (due to foreign key constraint)
            String deleteImagesSql = "DELETE FROM Images WHERE ProductID = ?";
            stmt = conn.prepareStatement(deleteImagesSql);
            stmt.setInt(1, productId);
            stmt.executeUpdate();
            LOGGER.log(Level.INFO, "Deleted images for Product ID {0}.", productId);
            
            // 2. Delete the product itself
            String deleteProductSql = "DELETE FROM Products WHERE ProductID = ?";
            stmt = conn.prepareStatement(deleteProductSql);
            stmt.setInt(1, productId);
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                LOGGER.log(Level.WARNING, "Attempted to delete Product ID {0} but no rows were affected. Product may not exist.", productId);
                // Optionally throw an exception if product was expected to exist
            } else {
                LOGGER.log(Level.INFO, "Product with ID {0} deleted successfully.", productId);
            }
            conn.commit(); // Commit transaction

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in deleteProduct for ProductID {0}: {1}", new Object[]{productId, e.getMessage()});
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException rollbackEx) { LOGGER.log(Level.SEVERE, "Error rolling back transaction during deleteProduct: {0}", rollbackEx.getMessage()); }
            }
            throw e;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error resetting auto-commit in deleteProduct: {0}", e.getMessage()); }
                try { conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in deleteProduct: {0}", e.getMessage()); }
            }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in deleteProduct: {0}", e.getMessage()); }
        }
    }

    /**
     * Adds an image path for a given product.
     * @param productId The ID of the product.
     * @param imagePath The path to the image.
     * @throws SQLException If a database error occurs.
     */
    public void addImage(int productId, String imagePath) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = Database.getConnection();
            // Assuming IsPrimary is not used, or defaults to FALSE
            String sql = "INSERT INTO Images (ProductID, ImagePath, IsPrimary) VALUES (?, ?, FALSE)"; // Set IsPrimary to FALSE by default
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            stmt.setString(2, imagePath);
            stmt.executeUpdate();
            LOGGER.log(Level.INFO, "Image '{0}' added for Product ID {1}.", new Object[]{imagePath, productId});
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in addImage for Product ID {0}, Path {1}: {2}", new Object[]{productId, imagePath, e.getMessage()});
            throw e;
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in addImage: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in addImage: {0}", e.getMessage()); }
        }
    }
    
    /**
     * Deletes a specific image by its ImageID.
     * @param imageId The ID of the image to delete.
     * @throws SQLException If a database error occurs.
     */
    public void deleteImage(int imageId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = Database.getConnection();
            String sql = "DELETE FROM Images WHERE ImageID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, imageId);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                LOGGER.log(Level.INFO, "Image with ID {0} deleted successfully.", imageId);
            } else {
                LOGGER.log(Level.WARNING, "Attempted to delete image with ID {0} but no rows affected. Image may not exist.", imageId);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in deleteImage for ImageID {0}: {1}", new Object[]{imageId, e.getMessage()});
            throw e;
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in deleteImage: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in deleteImage: {0}", e.getMessage()); }
        }
    }
}
