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

@WebServlet(name = "ProductServlet", urlPatterns = {"/products"})
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "detail":
                    showProductDetail(request, response);
                    break;
                case "category":
                    listProductsByCategory(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Product> products = productDAO.findAll();
        List<Category> categories = categoryDAO.findAll();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
    
    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.findById(productId);
        
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }
        
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
    }
    
    private void listProductsByCategory(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        List<Product> products = productDAO.findByCategoryId(categoryId);
        List<Category> categories = categoryDAO.findAll();
        Category currentCategory = categoryDAO.findById(categoryId);
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentCategory", currentCategory);
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}