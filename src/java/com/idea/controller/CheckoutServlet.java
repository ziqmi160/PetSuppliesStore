/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.OrderDAO;
import com.idea.model.CartItem;
import com.idea.model.Order;
import com.idea.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList; // For Java 5 compatibility
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author haziq
 */

public class CheckoutServlet extends HttpServlet {
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
    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class.getName());
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This doGet can be used to simply forward to checkout.jsp if accessed directly,
        // but typically the flow comes from CartServlet POST -> redirect to checkout.jsp.
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Ensure selectedCartItemsForCheckout and totalSelectedForCheckout are in session
        // If not, it means direct access or session timeout, so redirect back to cart
        List<CartItem> selectedCartItems = (List<CartItem>) session.getAttribute("selectedCartItemsForCheckout");
        Double totalSelected = (Double) session.getAttribute("totalSelectedForCheckout");

        if (selectedCartItems == null || selectedCartItems.isEmpty() || totalSelected == null) {
            LOGGER.warning("Attempted direct access to checkout.jsp or session expired. Redirecting to CartServlet.");
            response.sendRedirect("CartServlet"); // Redirect back to cart if no selected items
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("-------------------- New POST Request to CheckoutServlet --------------------");
        // Log all parameters received for debugging
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            for (String paramValue : paramValues) {
                LOGGER.log(Level.INFO, "Parameter: {0} = ''{1}''", new Object[]{paramName, paramValue});
            }
        }
        LOGGER.info("----------------------------------------------------------------------");

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("Unauthorized access to CheckoutServlet (POST): User not logged in. Redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> selectedCartItems = (List<CartItem>) session.getAttribute("selectedCartItemsForCheckout");
        Double totalSelected = (Double) session.getAttribute("totalSelectedForCheckout");

        if (selectedCartItems == null || selectedCartItems.isEmpty() || totalSelected == null) {
            LOGGER.severe("Checkout failed: selectedCartItemsForCheckout or totalSelectedForCheckout missing from session.");
            session.setAttribute("error", "Your checkout session expired or no items were selected. Please try again from the cart.");
            response.sendRedirect("CartServlet"); // Redirect back to cart if session data is missing
            return;
        }

        // Retrieve billing details from request parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String postalCode = request.getParameter("postalCode");
        String phone = request.getParameter("phone");
        String notes = request.getParameter("notes");

        // Basic validation (add more comprehensive validation as needed)
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            address == null || address.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            postalCode == null || postalCode.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            
            LOGGER.warning("Checkout failed: Missing required billing details.");
            session.setAttribute("error", "Please fill in all required billing details.");
            response.sendRedirect("checkout.jsp"); // Go back to checkout page to show errors
            return;
        }

        // Create the Order object
        // Initial status can be "Pending", "Processing", etc.
        Order newOrder = new Order(user.getId(), totalSelected, "Pending",
                                   firstName, lastName, email, address, city, postalCode, phone, notes,
                                   selectedCartItems);

        List<Integer> purchasedProductIds = new ArrayList<>(); // To store IDs of items to clear from cart
        for (int i = 0; i < selectedCartItems.size(); i++) { // Changed to traditional for loop
            CartItem item = (CartItem) selectedCartItems.get(i); // Explicit cast for Java 5
            purchasedProductIds.add(item.getProductId()); // Use Integer constructor for Java 5
        }


        try {
            int orderId = orderDAO.placeOrder(newOrder, user.getId(), user.getCartId(), purchasedProductIds); // Assuming User object has getCartId()
            LOGGER.log(Level.INFO, "Order placed successfully! Order ID: {0}", orderId);

            // Clear selected items from session after successful order
            session.removeAttribute("selectedCartItemsForCheckout");
            session.removeAttribute("totalSelectedForCheckout");

            // Store order ID in session to display on confirmation page
            session.setAttribute("lastOrderId", orderId); // Use Integer constructor for Java 5
            session.setAttribute("message", "Your order has been placed successfully! Order ID: " + orderId);
            
            response.sendRedirect("order-confirmation.jsp");

        }catch (IllegalArgumentException e) { // For insufficient stock
            LOGGER.log(Level.WARNING, "Checkout failed due to insufficient stock: {0}", e.getMessage());
            session.setAttribute("error", "Checkout failed: " + e.getMessage());
            response.sendRedirect("checkout.jsp"); // Go back to checkout page
        }
        // Go back to checkout page
         catch (IOException | SQLException e) {
            LOGGER.log(Level.SEVERE, "Unexpected exception during order placement: {0}", e.getMessage());
            session.setAttribute("error", "An unexpected error occurred. Please try again.");
            response.sendRedirect("checkout.jsp"); // Go back to checkout page
        }
    }
}
