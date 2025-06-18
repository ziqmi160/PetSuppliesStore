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
import com.idea.model.Admin;
import utils.Database; // Assuming this provides your database connection
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object (DAO) for Admin operations.
 * Handles database interactions related to the Admins table.
 */
public class AdminDAO {
    private static final Logger LOGGER = Logger.getLogger(AdminDAO.class.getName());

    /**
     * Retrieves an Admin from the database based on their email.
     * This method is primarily used during the login process to fetch an admin's details,
     * including their stored password for comparison.
     *
     * @param email The email address of the admin.
     * @return An Admin object if found, otherwise null.
     * @throws SQLException If a database access error occurs.
     */
    public Admin getAdminByEmail(String email) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Admin admin = null;

        LOGGER.log(Level.INFO, "Attempting to retrieve admin by email: {0}", email);

        try {
            conn = Database.getConnection(); // Get a database connection
            String sql = "SELECT AdminID, Name, Email, Password FROM Admins WHERE Email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email); // Set the email parameter

            rs = stmt.executeQuery(); // Execute the query

            if (rs.next()) {
                // If a record is found, create an Admin object
                admin = new Admin(
                    rs.getInt("AdminID"),
                    rs.getString("Name"),
                    rs.getString("Email"),
                    rs.getString("Password") // Retrieve the stored password
                );
                LOGGER.log(Level.INFO, "Admin found: {0} (ID: {1})", new Object[]{admin.getName(), admin.getAdminId()});
            } else {
                LOGGER.log(Level.INFO, "No admin found with email: {0}", email);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getAdminByEmail: {0}", e.getMessage());
            throw e; // Re-throw the exception for servlet to handle
        } finally {
            // Close resources in finally block to ensure they are closed even if an exception occurs
            if (rs != null) {
                try { rs.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing ResultSet: {0}", e.getMessage()); }
            }
            if (stmt != null) {
                try { stmt.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing PreparedStatement: {0}", e.getMessage()); }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { LOGGER.log(Level.SEVERE, "Error closing Connection: {0}", e.getMessage()); }
            }
        }
        return admin;
    }
}

