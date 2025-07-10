/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.dao;

import com.idea.model.User;
import utils.Database;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());

    /**
     * Retrieves all users/customers from the database.
     * 
     * @return A list of User objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Attempting to retrieve all users.");

        try {
            conn = Database.getConnection();
            String sql = "SELECT UserID, Name, Email, Password, Address FROM Users ORDER BY Name";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Address"),
                        rs.getString("Phone"),
                        0 // cartId will be set separately if needed
                ));
            }
            LOGGER.log(Level.INFO, "Retrieved {0} users.", users.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getAllUsers: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in getAllUsers: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getAllUsers: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in getAllUsers: {0}", e.getMessage());
            }
        }
        return users;
    }

    /**
     * Retrieves a user by their ID.
     * 
     * @param userId The ID of the user to retrieve.
     * @return The User object, or null if not found.
     * @throws SQLException If a database access error occurs.
     */
    public User getUserById(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Attempting to retrieve user with ID: " + userId);

        try {
            conn = Database.getConnection();
            String sql = "SELECT UserID, Name, Email, Password, Address FROM Users WHERE UserID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        0 // cartId will be set separately if needed
                );
                LOGGER.log(Level.INFO, "Retrieved user: {0}", user.getUsername());
                return user;
            } else {
                LOGGER.log(Level.WARNING, "User with ID {0} not found.", userId);
                return null;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in getUserById: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in getUserById: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in getUserById: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in getUserById: {0}", e.getMessage());
            }
        }
    }

    /**
     * Adds a new user to the database.
     * 
     * @param user The User object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addUser(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to add new user: " + user.getUsername());

        try {
            conn = Database.getConnection();
            String sql = "INSERT INTO Users (Name, Email, Password, Address, Phone) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getPhone());
            stmt.executeUpdate();

            LOGGER.log(Level.INFO, "Successfully added user: {0}", user.getUsername());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in addUser: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in addUser: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in addUser: {0}", e.getMessage());
            }
        }
    }

    /**
     * Updates an existing user in the database.
     * 
     * @param user The User object with updated information.
     * @throws SQLException If a database access error occurs.
     */
    public void updateUser(User user) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to update user with ID: " + user.getId());

        try {
            conn = Database.getConnection();
            String sql = "UPDATE Users SET Name = ?, Email = ?, Password = ?, Address = ?, Phone = ? WHERE UserID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getPhone());
            stmt.setInt(6, user.getId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully updated user: {0}", user.getUsername());
            } else {
                LOGGER.log(Level.WARNING, "No user found with ID {0} to update.", user.getId());
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in updateUser: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in updateUser: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in updateUser: {0}", e.getMessage());
            }
        }
    }

    /**
     * Deletes a user from the database.
     * 
     * @param userId The ID of the user to delete.
     * @throws SQLException If a database access error occurs.
     */
    public void deleteUser(int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        LOGGER.info("Attempting to delete user with ID: " + userId);

        try {
            conn = Database.getConnection();
            String sql = "DELETE FROM Users WHERE UserID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                LOGGER.log(Level.INFO, "Successfully deleted user with ID: {0}", userId);
            } else {
                LOGGER.log(Level.WARNING, "No user found with ID {0} to delete.", userId);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in deleteUser: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in deleteUser: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in deleteUser: {0}", e.getMessage());
            }
        }
    }

    /**
     * Checks if a username already exists in the database.
     * 
     * @param username      The username to check.
     * @param excludeUserId The user ID to exclude from the check (for updates). Use
     *                      -1 for new users.
     * @return true if the username exists, false otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public boolean usernameExists(String username, int excludeUserId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Checking if username exists: " + username + " (excluding ID: " + excludeUserId + ")");

        try {
            conn = Database.getConnection();
            String sql;
            if (excludeUserId > 0) {
                // For updates: check if username exists excluding the current user
                sql = "SELECT COUNT(*) FROM Users WHERE Name = ? AND UserID != ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username.trim());
                stmt.setInt(2, excludeUserId);
            } else {
                // For new users: check if username exists anywhere
                sql = "SELECT COUNT(*) FROM Users WHERE Name = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username.trim());
            }

            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                boolean exists = count > 0;
                LOGGER.log(Level.INFO, "Username '{0}' exists: {1}", new Object[] { username, exists });
                return exists;
            }

            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in usernameExists: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in usernameExists: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in usernameExists: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in usernameExists: {0}", e.getMessage());
            }
        }
    }

    /**
     * Checks if an email already exists in the database.
     * 
     * @param email         The email to check.
     * @param excludeUserId The user ID to exclude from the check (for updates). Use
     *                      -1 for new users.
     * @return true if the email exists, false otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public boolean emailExists(String email, int excludeUserId) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        LOGGER.info("Checking if email exists: " + email + " (excluding ID: " + excludeUserId + ")");

        try {
            conn = Database.getConnection();
            String sql;
            if (excludeUserId > 0) {
                // For updates: check if email exists excluding the current user
                sql = "SELECT COUNT(*) FROM Users WHERE Email = ? AND UserID != ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, email.trim());
                stmt.setInt(2, excludeUserId);
            } else {
                // For new users: check if email exists anywhere
                sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, email.trim());
            }

            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                boolean exists = count > 0;
                LOGGER.log(Level.INFO, "Email '{0}' exists: {1}", new Object[] { email, exists });
                return exists;
            }

            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception in emailExists: {0}", e.getMessage());
            throw e;
        } finally {
            try {
                if (rs != null)
                    rs.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing ResultSet in emailExists: {0}", e.getMessage());
            }
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing PreparedStatement in emailExists: {0}", e.getMessage());
            }
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing Connection in emailExists: {0}", e.getMessage());
            }
        }
    }
}