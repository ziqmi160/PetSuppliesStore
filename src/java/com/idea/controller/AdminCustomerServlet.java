/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.UserDAO;
import com.idea.model.User;
import com.idea.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author haziq
 */
public class AdminCustomerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(AdminCustomerServlet.class.getName());
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminCustomerServlet (GET). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminCustomerServlet (GET).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("list".equals(action)) {
                listCustomers(request, response);
            } else if ("showAddForm".equals(action)) {
                showAddCustomerForm(request, response);
            } else if ("showEditForm".equals(action)) {
                showEditCustomerForm(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminCustomerServlet (GET): {0}", action);
                listCustomers(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminCustomerServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/customers.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminCustomerServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/customers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminCustomerServlet (POST). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminCustomerServlet (POST).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("add".equals(action)) {
                addCustomer(request, response);
            } else if ("update".equals(action)) {
                updateCustomer(request, response);
            } else if ("delete".equals(action)) {
                deleteCustomer(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminCustomerServlet (POST): {0}", action);
                listCustomers(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminCustomerServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/customers.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminCustomerServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/customers.jsp").forward(request, response);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<User> customers = userDAO.getAllUsers();
        request.setAttribute("customers", customers);
        LOGGER.info("Forwarding to admin/customers.jsp with " + customers.size() + " customers.");
        request.getRequestDispatcher("admin/customers.jsp").forward(request, response);
    }

    private void showAddCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        LOGGER.info("Forwarding to admin/customer-form.jsp for adding new customer.");
        request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
    }

    private void showEditCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("id"));
        User customer = userDAO.getUserById(customerId);
        if (customer != null) {
            request.setAttribute("customer", customer);
            LOGGER.info("Forwarding to admin/customer-form.jsp for editing customer ID: " + customerId);
            request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
        } else {
            LOGGER.log(Level.WARNING, "Customer with ID {0} not found for editing.", customerId);
            request.setAttribute("error", "Customer not found for editing.");
            listCustomers(request, response);
        }
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Basic validation
        if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username, email, and password cannot be empty.");
            showAddCustomerForm(request, response);
            return;
        }

        // Check for duplicate username
        if (userDAO.usernameExists(username.trim(), -1)) {
            request.setAttribute("error", "A user with the username '" + username.trim()
                    + "' already exists. Please choose a different username.");
            showAddCustomerForm(request, response);
            return;
        }

        // Check for duplicate email
        if (userDAO.emailExists(email.trim(), -1)) {
            request.setAttribute("error", "A user with the email '" + email.trim()
                    + "' already exists. Please use a different email address.");
            showAddCustomerForm(request, response);
            return;
        }

        // Password validation
        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            showAddCustomerForm(request, response);
            return;
        }

        // Confirm password validation
        if (confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Password and confirm password do not match.");
            showAddCustomerForm(request, response);
            return;
        }

        User newCustomer = new User(-1, username.trim(), email.trim(), password.trim(),
                address != null ? address.trim() : "", phone != null ? phone.trim() : "", 0);
        userDAO.addUser(newCustomer);
        LOGGER.log(Level.INFO, "New customer added: {0}", username);
        response.sendRedirect("AdminCustomerServlet?message=Customer+added+successfully!");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Basic validation for required fields
        if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Username and email cannot be empty.");
            User customer = new User(customerId, username, email, password, address, phone, 0);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
            return;
        }

        // Check for duplicate username (excluding current user)
        if (userDAO.usernameExists(username.trim(), customerId)) {
            request.setAttribute("error", "A user with the username '" + username.trim()
                    + "' already exists. Please choose a different username.");
            User customer = new User(customerId, username.trim(), email.trim(), password != null ? password.trim() : "",
                    address != null ? address.trim() : "",  phone != null ? phone.trim() : "", 0);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
            return;
        }

        // Check for duplicate email (excluding current user)
        if (userDAO.emailExists(email.trim(), customerId)) {
            request.setAttribute("error", "A user with the email '" + email.trim()
                    + "' already exists. Please use a different email address.");
            User customer = new User(customerId, username.trim(), email.trim(), password != null ? password.trim() : "",
                    address != null ? address.trim() : "", phone != null ? phone.trim() : "", 0);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
            return;
        }

        // Get current user to preserve password if not changed
        User currentUser = userDAO.getUserById(customerId);
        String finalPassword = currentUser.getPassword(); // Keep current password by default

        // If password is provided, validate it
        if (password != null && !password.trim().isEmpty()) {
            // Password validation
            if (password.length() < 8) {
                request.setAttribute("error", "Password must be at least 8 characters long.");
                User customer = new User(customerId, username.trim(), email.trim(), password.trim(),
                        address != null ? address.trim() : "", phone != null ? phone.trim() : "", 0);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
                return;
            }

            // Confirm password validation
            if (confirmPassword == null || !password.equals(confirmPassword)) {
                request.setAttribute("error", "Password and confirm password do not match.");
                User customer = new User(customerId, username.trim(), email.trim(), password.trim(),
                        address != null ? address.trim() : "", phone != null ? phone.trim() : "", 0);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("admin/customer-form.jsp").forward(request, response);
                return;
            }

            finalPassword = password.trim(); // Use new password
        }

        User updatedCustomer = new User(customerId, username.trim(), email.trim(), finalPassword,
                address != null ? address.trim() : "", phone != null ? phone.trim() : "", 0);
        userDAO.updateUser(updatedCustomer);
        LOGGER.log(Level.INFO, "Customer updated: {0} (ID: {1})", new Object[] { username, customerId });
        response.sendRedirect("AdminCustomerServlet?message=Customer+updated+successfully!");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        // Get customer name for logging before deletion
        User customer = userDAO.getUserById(customerId);
        String customerName = customer != null ? customer.getUsername() : "Unknown";

        userDAO.deleteUser(customerId);
        LOGGER.log(Level.INFO, "Customer deleted: {0} (ID: {1})", new Object[] { customerName, customerId });
        response.sendRedirect("AdminCustomerServlet?message=Customer+deleted+successfully!");
    }
}