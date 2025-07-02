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

import com.idea.model.Category;
import utils.Database;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CategoryDAO {
    private static final Logger LOGGER = Logger.getLogger(CategoryDAO.class.getName());

    /**
     * Retrieves all categories from the database.
     * 
     * @return A list of Category objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Attempting to retrieve all categories.");

        try {
            conn = Database.getConnection();
            String sql = "SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                categories.add(new Category(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName")));
            }
            LOGGER.log(Level.INFO, "Retrieved {0} categories.", categories.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getAllCategories: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in getAllCategories: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getAllCategories: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in getAllCategories: {0}", e.getMessage());
            }
        }
        return categories;
    }

    /**
     * Retrieves a category by its ID.
     * 
     * @param categoryId The ID of the category to retrieve.
     * @return The Category object, or null if not found.
     * @throws SQLException If a database access error occurs.
     */
    public Category getCategoryById(int categoryId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Attempting to retrieve category with ID: " + categoryId);

        try {
            conn = Database.getConnection();
            String sql = "SELECT CategoryID, CategoryName FROM Categories WHERE CategoryID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Category category = new Category(
                        rs.getInt("CategoryID"),
                        rs.getString("CategoryName"));
                LOGGER.log(Level.INFO, "Retrieved category: {0}", category.getCategoryName());
                return category;
            } else {
                LOGGER.log(Level.WARNING, "Category with ID {0} not found.", categoryId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getCategoryById: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in getCategoryById: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getCategoryById: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in getCategoryById: {0}", e.getMessage());
            }
        }
    }

    /**
     * Adds a new category to the database.
     * 
     * @param category The Category object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addCategory(Category category) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to add new category: " + category.getCategoryName());

        try {
            conn = Database.getConnection();
            String sql = "INSERT INTO Categories (CategoryName) VALUES (?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, category.getCategoryName());
            stmt.executeUpdate();

            LOGGER.log(Level.INFO, "Successfully added category: {0}", category.getCategoryName());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in addCategory: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in addCategory: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in addCategory: {0}", e.getMessage());
            }
        }
    }

    /**
     * Updates an existing category in the database.
     * 
     * @param category The Category object with updated information.
     * @throws SQLException If a database access error occurs.
     */
    public void updateCategory(Category category) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to update category with ID: " + category.getCategoryId());

        try {
            conn = Database.getConnection();
            String sql = "UPDATE Categories SET CategoryName = ? WHERE CategoryID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getCategoryId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully updated category: {0}", category.getCategoryName());
            } else {
                LOGGER.log(Level.WARNING, "No category found with ID {0} to update.", category.getCategoryId());
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in updateCategory: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in updateCategory: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in updateCategory: {0}", e.getMessage());
            }
        }
    }

    /**
     * Deletes a category from the database.
     * 
     * @param categoryId The ID of the category to delete.
     * @throws SQLException If a database access error occurs.
     */
    public void deleteCategory(int categoryId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to delete category with ID: " + categoryId);

        try {
            conn = Database.getConnection();
            String sql = "DELETE FROM Categories WHERE CategoryID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully deleted category with ID: {0}", categoryId);
            } else {
                LOGGER.log(Level.WARNING, "No category found with ID {0} to delete.", categoryId);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in deleteCategory: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in deleteCategory: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in deleteCategory: {0}", e.getMessage());
            }
        }
    }

    /**
     * Checks if a category name already exists in the database.
     * 
     * @param categoryName      The category name to check.
     * @param excludeCategoryId The category ID to exclude from the check (for
     *                          updates). Use -1 for new categories.
     * @return true if the category name exists, false otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public boolean categoryNameExists(String categoryName, int excludeCategoryId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Checking if category name exists: " + categoryName + " (excluding ID: " + excludeCategoryId + ")");

        try {
            conn = Database.getConnection();
            String sql;
            if (excludeCategoryId > 0) {
                // For updates: check if name exists excluding the current category
                sql = "SELECT COUNT(*) FROM Categories WHERE CategoryName = ? AND CategoryID != ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, categoryName.trim());
                stmt.setInt(2, excludeCategoryId);
            } else {
                // For new categories: check if name exists anywhere
                sql = "SELECT COUNT(*) FROM Categories WHERE CategoryName = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, categoryName.trim());
            }

            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                boolean exists = count > 0;
                LOGGER.log(Level.INFO, "Category name '{0}' exists: {1}", new Object[] { categoryName, exists });
                return exists;
            }

            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in categoryNameExists: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in categoryNameExists: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in categoryNameExists: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in categoryNameExists: {0}", e.getMessage());
            }
        }
    }
}
