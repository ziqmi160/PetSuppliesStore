/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.AdminDAO;
import com.idea.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author haziq
 */
public class AdminLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(AdminLoginServlet.class.getName());
    private AdminDAO adminDAO; // Declare AdminDAO

    @Override
    public void init() throws ServletException {
        super.init();
        adminDAO = new AdminDAO(); // Initialize AdminDAO
    }

    /**
     * Handles HTTP GET requests.
     * Typically, a GET request to this servlet should just forward to the admin login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("GET request received for AdminLoginServlet. Forwarding to admin-login.jsp.");
        // Forward to the admin login JSP page
        request.getRequestDispatcher("admin-login.jsp").forward(request, response);
    }

    /**
     * Handles HTTP POST requests.
     * Processes login form submission from admin-login.jsp.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("POST request received for AdminLoginServlet.");

        // Retrieve email and password from the form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation for empty fields
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            LOGGER.warning("Admin login attempt with empty email or password.");
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }

        Admin admin = null;
        try {
            // Attempt to retrieve admin by email
            admin = adminDAO.getAdminByEmail(email);

            if (admin == null) {
                // Admin not found with this email
                LOGGER.log(Level.WARNING, "Admin login failed: Email ''{0}'' not found.", email);
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
                return;
            }

            // Check if the provided password matches the stored password
            // In a real application, you'd use a secure hashing algorithm (e.g., bcrypt) for password comparison.
            // For now, we are doing a direct string comparison based on your current DB schema.
            if (!password.equals(admin.getPassword())) {
                // Password mismatch
                LOGGER.log(Level.WARNING, "Admin login failed: Incorrect password for email ''{0}''.", email);
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
                return;
            }

            // Authentication successful!
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin); // Store the Admin object in session
            LOGGER.log(Level.INFO, "Admin ''{0}'' (ID: {1}) logged in successfully. Redirecting to admin-dashboard.jsp.", new Object[]{admin.getName(), admin.getAdminId()});
            
            // Redirect to the admin dashboard
            response.sendRedirect("admin-dashboard.jsp"); // You might later change this to AdminDashboardServlet

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during admin login for email ''{0}'': {1}", new Object[]{email, e.getMessage()});
            request.setAttribute("error", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            LOGGER.log(Level.SEVERE, "An unexpected error occurred during admin login for email ''{0}'': {1}", new Object[]{email, e.getMessage()});
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}
