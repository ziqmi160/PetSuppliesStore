/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.controller;

import com.idea.dao.ProductDAO;
import com.idea.dao.CategoryDAO; // Import CategoryDAO
import com.idea.model.Product;
import com.idea.model.Admin;
import com.idea.model.Category; // Import Category model

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author haziq
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class AdminProductServlet extends HttpServlet {

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
    private static final Logger LOGGER = Logger.getLogger(AdminProductServlet.class.getName());
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO; // Declare CategoryDAO

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO(); // Initialize CategoryDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminProductServlet (GET). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminProductServlet (GET).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("list".equals(action)) {
                listProducts(request, response);
            } else if ("showAddForm".equals(action)) {
                showAddProductForm(request, response);
            } else if ("showEditForm".equals(action)) {
                showEditProductForm(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminProductServlet (GET): {0}", action);
                listProducts(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminProductServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/products.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminProductServlet (GET) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/products.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            LOGGER.warning("Unauthorized access attempt to AdminProductServlet (POST). Redirecting to admin login.");
            response.sendRedirect("admin-login.jsp");
            return;
        }
        LOGGER.info("Admin '" + admin.getName() + "' accessing AdminProductServlet (POST).");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            if ("add".equals(action)) {
                addProduct(request, response);
            } else if ("update".equals(action)) {
                updateProduct(request, response);
            } else if ("delete".equals(action)) {
                deleteProduct(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Unknown action in AdminProductServlet (POST): {0}", action);
                listProducts(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in AdminProductServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/products.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in AdminProductServlet (POST) for action {0}: {1}",
                    new Object[] { action, e.getMessage() });
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("admin/products.jsp").forward(request, response);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        LOGGER.info("Forwarding to admin/products.jsp with " + products.size() + " products.");
        request.getRequestDispatcher("admin/products.jsp").forward(request, response);
    }

    private void showAddProductForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories(); // Fetch categories
        request.setAttribute("categories", categories);
        LOGGER.info("Forwarding to admin/product-form.jsp for adding new product.");
        request.getRequestDispatcher("admin/product-form.jsp").forward(request, response);
    }

    private void showEditProductForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        if (product != null) {
            request.setAttribute("product", product);
            List<Category> categories = categoryDAO.getAllCategories(); // Fetch categories for edit form
            request.setAttribute("categories", categories);
            LOGGER.info("Forwarding to admin/product-form.jsp for editing product ID: " + productId);
            request.getRequestDispatcher("admin/product-form.jsp").forward(request, response);
        } else {
            LOGGER.log(Level.WARNING, "Product with ID {0} not found for editing.", productId);
            request.setAttribute("error", "Product not found for editing.");
            listProducts(request, response);
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

        // Basic validation (add more comprehensive validation as needed)
        if (name == null || name.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Product name and description cannot be empty.");
            showAddProductForm(request, response); // Go back to form with error
            return;
        }
        if (price <= 0) {
            request.setAttribute("error", "Price must be a positive value.");
            showAddProductForm(request, response);
            return;
        }
        if (stockQuantity < 0) {
            request.setAttribute("error", "Stock quantity cannot be negative.");
            showAddProductForm(request, response);
            return;
        }

        // Get category name from CategoryDAO
        Category category = categoryDAO.getCategoryById(categoryId);
        String categoryName = (category != null) ? category.getCategoryName() : "Unknown Category";

        Product newProduct = new Product(-1, name, description, price, categoryId, categoryName, stockQuantity);
        int productId = productDAO.addProduct(newProduct);

        // Handle image uploads - always save to deployed webapp's /images/products/
        try {
            List<Part> fileParts = (List<Part>) request.getParts();
            for (Part filePart : fileParts) {
                if ("imageFiles".equals(filePart.getName()) && filePart.getSize() > 0) {
                    String fileName = getSubmittedFileName(filePart);
                    if (fileName != null && !fileName.isEmpty()) {
                        // Generate unique filename
                        String fileExtension = fileName.lastIndexOf(".") >= 0
                                ? fileName.substring(fileName.lastIndexOf("."))
                                : "";
                        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                        // Always save to deployed webapp's /images/products/ directory
                        String uploadPath = getServletContext().getRealPath("/images/products/");
                        Path uploadDir = Paths.get(uploadPath);
                        if (!Files.exists(uploadDir)) {
                            Files.createDirectories(uploadDir);
                        }
                        Path filePath = uploadDir.resolve(uniqueFileName);
                        try (InputStream input = filePart.getInputStream()) {
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                        }
                        // Store the path in DB as images/products/xxx.jpg (no leading slash)
                        String relativePath = "images/products/" + uniqueFileName;
                        productDAO.addImage(productId, relativePath);
                        LOGGER.log(Level.INFO, "Image uploaded: {0} for product ID {1}",
                                new Object[] { fileName, productId });
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error uploading images for product ID {0}: {1}",
                    new Object[] { productId, e.getMessage() });
            // Continue with product creation even if image upload fails
        }

        LOGGER.log(Level.INFO, "New product added: {0} (ID: {1})", new Object[] { name, productId });
        response.sendRedirect("AdminProductServlet?message=Product+added+successfully!");
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));

        // Basic validation for update (similar to add)
        if (name == null || name.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "Product name and description cannot be empty.");
            showEditProductForm(request, response); // Go back to form with error
            return;
        }
        if (price <= 0) {
            request.setAttribute("error", "Price must be a positive value.");
            showEditProductForm(request, response);
            return;
        }
        if (stockQuantity < 0) {
            request.setAttribute("error", "Stock quantity cannot be negative.");
            showEditProductForm(request, response);
            return;
        }

        // Get category name from CategoryDAO
        Category category = categoryDAO.getCategoryById(categoryId);
        String categoryName = (category != null) ? category.getCategoryName() : "Unknown Category";

        Product updatedProduct = new Product(productId, name, description, price, categoryId, categoryName,
                stockQuantity);
        productDAO.updateProduct(updatedProduct);

        // Handle image deletions
        String[] deleteImageIds = request.getParameterValues("deleteImageIds");
        if (deleteImageIds != null) {
            System.out.println("To delete: " + java.util.Arrays.toString(deleteImageIds)); // Debug log
            for (String imageIdStr : deleteImageIds) {
                try {
                    int imageId = Integer.parseInt(imageIdStr);
                    productDAO.deleteImage(imageId);
                    LOGGER.log(Level.INFO, "Image deleted: ID {0} for product ID {1}",
                            new Object[] { imageId, productId });
                } catch (NumberFormatException e) {
                    LOGGER.log(Level.WARNING, "Invalid image ID for deletion: {0}", imageIdStr);
                }
            }
        }

        // Handle new image uploads - always save to deployed webapp's /images/products/
        try {
            List<Part> fileParts = (List<Part>) request.getParts();
            for (Part filePart : fileParts) {
                if ("imageFiles".equals(filePart.getName()) && filePart.getSize() > 0) {
                    String fileName = getSubmittedFileName(filePart);
                    if (fileName != null && !fileName.isEmpty()) {
                        // Generate unique filename
                        String fileExtension = fileName.lastIndexOf(".") >= 0
                                ? fileName.substring(fileName.lastIndexOf("."))
                                : "";
                        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

                        // Always save to deployed webapp's /images/products/ directory
                        String uploadPath = getServletContext().getRealPath("/images/products/");
                        Path uploadDir = Paths.get(uploadPath);
                        if (!Files.exists(uploadDir)) {
                            Files.createDirectories(uploadDir);
                        }
                        Path filePath = uploadDir.resolve(uniqueFileName);
                        try (InputStream input = filePart.getInputStream()) {
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                        }
                        // Store the path in DB as images/products/xxx.jpg (no leading slash)
                        String relativePath = "images/products/" + uniqueFileName;
                        productDAO.addImage(productId, relativePath);
                        LOGGER.log(Level.INFO, "Image uploaded: {0} for product ID {1}",
                                new Object[] { fileName, productId });
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error uploading images for product ID {0}: {1}",
                    new Object[] { productId, e.getMessage() });
            // Continue with product update even if image upload fails
        }

        LOGGER.log(Level.INFO, "Product updated: {0} (ID: {1})", new Object[] { name, updatedProduct.getId() });
        response.sendRedirect("AdminProductServlet?message=Product+updated+successfully!");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        productDAO.deleteProduct(productId);
        LOGGER.log(Level.INFO, "Product deleted: ID {0}", productId);
        response.sendRedirect("AdminProductServlet?message=Product+deleted+successfully!");
    }
}
