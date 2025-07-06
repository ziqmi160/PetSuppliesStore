/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.listener;

import com.idea.dao.CategoryDAO;
import com.idea.model.Category;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author haziq
 */

/**
 * ServletContextListener to load categories into application scope on startup.
 */
@WebListener
public class CategoryLoaderListener implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(CategoryLoaderListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("CategoryLoaderListener: Web application context initialized. Loading categories...");
        ServletContext servletContext = sce.getServletContext();
        CategoryDAO categoryDAO = new CategoryDAO();

        try {
            List<Category> categories = categoryDAO.getAllCategories();
            servletContext.setAttribute("categories", categories);
            LOGGER.log(Level.INFO, "CategoryLoaderListener: Successfully loaded {0} categories into application scope.", categories.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "CategoryLoaderListener: Failed to load categories from database on startup: {0}", e.getMessage());
            // Depending on severity, you might want to throw a RuntimeException here
            // to prevent the application from starting if categories are critical.
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "CategoryLoaderListener: An unexpected error occurred while loading categories: {0}", e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("CategoryLoaderListener: Web application context destroyed. Cleaning up...");
        // No specific cleanup needed for categories in application scope, as they are read-only.
    }
}

