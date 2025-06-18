/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.CategoryDAO;
import com.idea.model.Category;
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
public class AdminCategoryServlet extends HttpServlet {

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
    private static final Logger LOGGER = Logger.getLogger(AdminCategoryServlet.class.getName());
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminCategoryServlet (GET). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminCategoryServlet (GET).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("list".equals(action)) {
                listCategories(request, response);
            } else if ("showAddForm".equals(action)) {
                showAddCategoryForm(request, response);
            } else if ("showEditForm".equals(action)) {
                showEditCategoryForm(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminCategoryServlet (GET): {0}", action);
                listCategories(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminCategoryServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/categories.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminCategoryServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/categories.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminCategoryServlet (POST). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminCategoryServlet (POST).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("add".equals(action)) {
                addCategory(request, response);
            } else if ("update".equals(action)) {
                updateCategory(request, response);
            } else if ("delete".equals(action)) {
                deleteCategory(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminCategoryServlet (POST): {0}", action);
                listCategories(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminCategoryServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/categories.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminCategoryServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/categories.jsp").forward(request, response);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        LOGGER.info("Forwarding to admin/categories.jsp with " + categories.size() + " categories.");
        request.getRequestDispatcher("admin/categories.jsp").forward(request, response);
    }

    private void showAddCategoryForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        LOGGER.info("Forwarding to admin/category-form.jsp for adding new category.");
        request.getRequestDispatcher("admin/category-form.jsp").forward(request, response);
    }

    private void showEditCategoryForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getCategoryById(categoryId);
        if (category != null) {
            request.setAttribute("category", category);
            LOGGER.info("Forwarding to admin/category-form.jsp for editing category ID: " + categoryId);
            request.getRequestDispatcher("admin/category-form.jsp").forward(request, response);
        } else {
            LOGGER.log(Level.WARNING, "Category with ID {0} not found for editing.", categoryId);
            request.setAttribute("error", "Category not found for editing.");
            listCategories(request, response);
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String categoryName = request.getParameter("categoryName");

        // Basic validation
        if (categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("error", "Category name cannot be empty.");
            showAddCategoryForm(request, response);
            return;
        }

        Category newCategory = new Category(-1, categoryName.trim());
        categoryDAO.addCategory(newCategory);
        LOGGER.log(Level.INFO, "New category added: {0}", categoryName);
        response.sendRedirect("AdminCategoryServlet?message=Category+added+successfully!");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String categoryName = request.getParameter("categoryName");

        // Basic validation
        if (categoryName == null || categoryName.trim().isEmpty()) {
            request.setAttribute("error", "Category name cannot be empty.");
            Category category = new Category(categoryId, categoryName);
            request.setAttribute("category", category);
            request.getRequestDispatcher("admin/category-form.jsp").forward(request, response);
            return;
        }

        Category updatedCategory = new Category(categoryId, categoryName.trim());
        categoryDAO.updateCategory(updatedCategory);
        LOGGER.log(Level.INFO, "Category updated: {0} (ID: {1})", new Object[] { categoryName, categoryId });
        response.sendRedirect("AdminCategoryServlet?message=Category+updated+successfully!");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        // Get category name for logging before deletion
        Category category = categoryDAO.getCategoryById(categoryId);
        String categoryName = category != null ? category.getCategoryName() : "Unknown";

        categoryDAO.deleteCategory(categoryId);
        LOGGER.log(Level.INFO, "Category deleted: {0} (ID: {1})", new Object[] { categoryName, categoryId });
        response.sendRedirect("AdminCategoryServlet?message=Category+deleted+successfully!");
    }
}