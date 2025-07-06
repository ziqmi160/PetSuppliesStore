/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import com.idea.dao.ProductDAO;
import com.idea.dao.CategoryDAO; 
import com.idea.model.Product;
import com.idea.model.Category; 
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author haziq
 */

public class ShopServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ShopServlet.class.getName());
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * This method now always fetches all products and all categories,
     * delegating filtering to the client-side JavaScript.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LOGGER.info("Starting product and category retrieval for shop page (client-side filtering)...");

            List<Product> productList = productDAO.getAllProducts(); // Always get all products
            List<Category> categoryList = categoryDAO.getAllCategories(); // Always get all categories

            LOGGER.log(Level.INFO, "Retrieved {0} products and {1} categories for client-side filtering.", new Object[]{productList.size(), categoryList.size()});

            request.setAttribute("products", productList);
            request.setAttribute("categories", categoryList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("shop.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while retrieving products/categories for shop page: {0}", e.getMessage());
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error while retrieving products/categories for shop page: {0}", e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        return "Shop Servlet for displaying all products and categories for client-side filtering";
    }
}
