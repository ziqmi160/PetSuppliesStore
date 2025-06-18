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
                    rs.getString("CategoryName")
                ));
            }
            LOGGER.log(Level.INFO, "Retrieved {0} categories.", categories.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getAllCategories: {0}", e.getMessage());
            throw e;
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet in getAllCategories: {0}", e.getMessage()); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getAllCategories: {0}", e.getMessage()); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection in getAllCategories: {0}", e.getMessage()); }
        }
        return categories;
    }
}

