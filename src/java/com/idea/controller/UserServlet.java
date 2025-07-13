/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.OrderDAO;
import com.idea.dao.UserDAO;
import com.idea.model.Order;
import com.idea.model.OrderItem;
import com.idea.model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author haziq
 */

public class UserServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO(); // Or inject it via constructor or context
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        User user =(User) session.getAttribute("user");
        String userName = user.getUsername();
        System.out.println("username: " + user.getUsername());
        List<Order> orders = null;
        try {
            orders = (List<Order>) orderDAO.getOrdersByUserId(user.getId());
            
            for (Order order : orders) {
                List<OrderItem> items = orderDAO.getOrderItemsByOrderId(order.getOrderId());
                order.setOrderItems(items);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("orders", orders);
        request.setAttribute("userName", userName);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");

    if ("edit".equals(action)) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Please+login+first");
            return;
        }

        // Get updated form values
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        boolean passwordChanged = false;

        // Validate and update password if fields are filled
        if (currentPassword != null && !currentPassword.trim().isEmpty()) {
            if (!currentPassword.equals(user.getPassword())) {
    response.sendRedirect("edit-profile.jsp?error=Current+password+is+incorrect");
    return;
} else if (newPassword == null || newPassword.trim().isEmpty()) {
                response.sendRedirect("edit-profile.jsp?error=New+password+cannot+be+empty");
                return;
            } else 
if (!newPassword.equals(confirmPassword)) {
    response.sendRedirect("edit-profile.jsp?error=New+passwords+do+not+match");
    return;
}
 else {
                user.setPassword(newPassword);
                passwordChanged = true;
            }
        }

        // Update other fields regardless
        user.setUsername(username);
        user.setEmail(email);
        user.setAddress(address);

        if (request.getAttribute("error") == null) {
            try {
                new UserDAO().updateUser(user);
                session.setAttribute("user", user);
                request.setAttribute("success", passwordChanged ? "Profile and password updated successfully." : "Profile updated successfully.");
            } catch (SQLException e) {
                request.setAttribute("error", "Failed to update profile: " + e.getMessage());
                e.printStackTrace();
            }
        }

        try {
            List<Order> orders = new OrderDAO().getOrdersByUserId(user.getId());
            request.setAttribute("orders", orders);
        } catch (SQLException e) {
            request.setAttribute("error", "Could not load orders.");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}


}



