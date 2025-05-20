package com.petsupplies.controller;

import com.petsupplies.dao.CategoryDAO;
import com.petsupplies.dao.CategoryDAOImpl;
import com.petsupplies.dao.ProductDAO;
import com.petsupplies.dao.ProductDAOImpl;
import com.petsupplies.model.Category;
import com.petsupplies.model.Product;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/"})
public class HomeServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get featured products (first 6 products)
            List<Product> allProducts = productDAO.findAll();
            List<Product> featuredProducts = allProducts.size() > 6 ? 
                allProducts.subList(0, 6) : allProducts;
            
            // Get all categories
            List<Category> categories = categoryDAO.findAll();
            
            request.setAttribute("featuredProducts", featuredProducts);
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}