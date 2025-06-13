/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import utils.Database;

/**
 *
 * @author haziq
 */
public class RegisterUserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check password length
        if (password.length() < 8) {
            response.sendRedirect("register.jsp?error=Password+must+be+at+least+8+characters+long");
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords+do+not+match");
            return;
        }

        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            // Connect to database
            conn = Database.getConnection();
            
            // Check if email exists in Users table
            String checkEmailSql = "SELECT COUNT(*) FROM USERS WHERE email = ?";
            checkStmt = conn.prepareStatement(checkEmailSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();
            rs.next();
            int userCount = rs.getInt(1);
            
            // Check if email exists in Admins table
            checkEmailSql = "SELECT COUNT(*) FROM ADMINS WHERE email = ?";
            checkStmt = conn.prepareStatement(checkEmailSql);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();
            rs.next();
            int adminCount = rs.getInt(1);
            
            if (userCount > 0 || adminCount > 0) {
                response.sendRedirect("register.jsp?error=Email+already+exists");
                return;
            }

            // Insert new user
            String sql = "INSERT INTO USERS (name, email, password, address) VALUES (?, ?, ?, ?)";
            insertStmt = conn.prepareStatement(sql);
            insertStmt.setString(1, username);
            insertStmt.setString(2, email);
            insertStmt.setString(3, password);  // Ideally hash this!
            insertStmt.setString(4, "");  // Empty address for now

            insertStmt.executeUpdate();

            // Redirect to login page with success message
            response.sendRedirect("login.jsp?success=Registration+successful.+Please+login.");

        } catch (Exception e) {
            e.printStackTrace();
            // Get the root cause of the error
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
            }
            String errorMessage = cause.getMessage();
            if (errorMessage == null) {
                errorMessage = e.getMessage();
            }
            if (errorMessage == null) {
                errorMessage = "An error occurred during registration";
            }
            // URL encode the error message
            errorMessage = errorMessage.replace(" ", "+");
            response.sendRedirect("register.jsp?error=" + errorMessage);
        } finally {
            // Close all resources
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (checkStmt != null) checkStmt.close(); } catch (Exception e) {}
            try { if (insertStmt != null) insertStmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
