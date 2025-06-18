/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.OrderDAO;
import com.idea.model.Order;
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
public class AdminOrderServlet extends HttpServlet {

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
    private static final Logger LOGGER = Logger.getLogger(AdminOrderServlet.class.getName());
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminOrderServlet (GET). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminOrderServlet (GET).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("list".equals(action)) {
                listOrders(request, response);
            } else if ("showEditForm".equals(action)) {
                showEditOrderForm(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminOrderServlet (GET): {0}", action);
                listOrders(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminOrderServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/orders.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminOrderServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/orders.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminOrderServlet (POST). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminOrderServlet (POST).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("update".equals(action)) {
                updateOrder(request, response);
            } else if ("delete".equals(action)) {
                deleteOrder(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminOrderServlet (POST): {0}", action);
                listOrders(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminOrderServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/orders.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminOrderServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/orders.jsp").forward(request, response);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        LOGGER.info("Forwarding to admin/orders.jsp with " + orders.size() + " orders.");
        request.getRequestDispatcher("admin/orders.jsp").forward(request, response);
    }

    private void showEditOrderForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);
        if (order != null) {
            request.setAttribute("order", order);
            LOGGER.info("Forwarding to admin/order-form.jsp for editing order ID: " + orderId);
            request.getRequestDispatcher("admin/order-form.jsp").forward(request, response);
        } else {
            LOGGER.log(Level.WARNING, "Order with ID {0} not found for editing.", orderId);
            request.setAttribute("error", "Order not found for editing.");
            listOrders(request, response);
        }
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        // Basic validation
        if (status == null || status.trim().isEmpty()) {
            request.setAttribute("error", "Order status cannot be empty.");
            Order order = orderDAO.getOrderById(orderId);
            if (order != null) {
                request.setAttribute("order", order);
            }
            request.getRequestDispatcher("admin/order-form.jsp").forward(request, response);
            return;
        }

        orderDAO.updateOrderStatus(orderId, status.trim());
        LOGGER.log(Level.INFO, "Order status updated: {0} (ID: {1})", new Object[] { status, orderId });
        response.sendRedirect("AdminOrderServlet?message=Order+status+updated+successfully!");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        orderDAO.deleteOrder(orderId);
        LOGGER.log(Level.INFO, "Order deleted: {0}", orderId);
        response.sendRedirect("AdminOrderServlet?message=Order+deleted+successfully!");
    }
}