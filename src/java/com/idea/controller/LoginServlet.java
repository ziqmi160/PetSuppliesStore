/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.CartDAO;
import com.idea.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.Database;

/**
 *
 * @author haziq
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName()); // Initialize Logger
    private CartDAO cartDAO; // New: Declare CartDAO

    @Override
    public void init() throws ServletException {
        super.init();
        cartDAO = new CartDAO(); // New: Initialize CartDAO
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = Database.getConnection(); // Get DB connection

            // First check if email exists and get all user details, including password for comparison
            String checkEmailSql = "SELECT UserID, Name, Email, Password, Address FROM Users WHERE Email = ?";
            stmt = conn.prepareStatement(checkEmailSql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (!rs.next()) {
                // Email not found
                LOGGER.warning("Login failed: Email '" + email + "' not found.");
                response.sendRedirect("login.jsp?error=Email+not+found");
                return;
            }

            String storedPassword = rs.getString("Password");
            if (!password.equals(storedPassword)) {
                // Wrong password
                LOGGER.warning("Login failed: Incorrect password for email '" + email + "'.");
                response.sendRedirect("login.jsp?error=Incorrect+password");
                return;
            }

            // Login successful. Retrieve all necessary user details.
            int userId = rs.getInt("UserID");
            String username = rs.getString("Name");
            String userEmail = rs.getString("Email");
            String userAddress = rs.getString("Address");
            
            // Get or create cart ID for the user
            int cartId = cartDAO.getOrCreateCartId(userId);
            LOGGER.info("User '" + username + "' logged in. Retrieved/Created Cart ID: " + cartId);

            // Instantiate User object with all relevant details, including the retrieved cartId
            User user = new User(userId, username, userEmail, storedPassword, userAddress, cartId);
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Store the fully populated User object in session
            
            LOGGER.info("Login successful for User ID: " + userId + ". Redirecting to index.jsp.");
            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            LOGGER.severe("An error occurred during login for email '" + email + "': " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=An+error+occurred+during+login");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {LOGGER.severe("Error closing ResultSet: " + e.getMessage());}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {LOGGER.severe("Error closing PreparedStatement: " + e.getMessage());}
            try { if (conn != null) conn.close(); } catch (Exception e) {LOGGER.severe("Error closing Connection: " + e.getMessage());}
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet handles user authentication.";
    }
}
