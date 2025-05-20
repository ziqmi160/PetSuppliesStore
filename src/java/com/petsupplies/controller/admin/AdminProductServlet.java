package com.petsupplies.controller.admin;

import com.petsupplies.dao.CategoryDAO;
import com.petsupplies.dao.CategoryDAOImpl;
import com.petsupplies.dao.ProductDAO;
import com.petsupplies.dao.ProductDAOImpl;
import com.petsupplies.model.Category;
import com.petsupplies.model.Product;
import com.petsupplies.model.User;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 30 // 30 MB
)
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (SQLException e) {
            log("Database error: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            log("Error: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "create":
                    createProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/products");
                    break;
            }
        } catch (SQLException e) {
            log("Database error: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            log("Error: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Product> products = productDAO.findAll();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        
        Product product = productDAO.findById(productId);
        
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        
        List<Category> categories = categoryDAO.findAll();
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
    }
    
    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = null;
        int stockQuantity = 0;
        int categoryId = 0;
        
        try {
            price = new BigDecimal(request.getParameter("price"));
            stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format in form data");
            showNewForm(request, response);
            return;
        }
        
        // Validate inputs
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Product name is required");
            showNewForm(request, response);
            return;
        }
        
        // Handle file upload for image
        String imageUrl = "";
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                
                if (fileName != null && !fileName.isEmpty()) {
                    // Ensure upload directory exists
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Create a unique file name to prevent overwriting
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String filePath = uploadPath + File.separator + uniqueFileName;
                    
                    // Write the file
                    filePart.write(filePath);
                    
                    // Store the relative URL
                    imageUrl = "images" + File.separator + uniqueFileName;
                }
            }
        } catch (Exception e) {
            log("Error uploading file: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Error uploading image: " + e.getMessage());
            showNewForm(request, response);
            return;
        }
        
        // Create product object
        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);
        product.setImageUrl(imageUrl);
        product.setCategoryId(categoryId);
        product.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        product.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        
        // Save to database
        try {
            productDAO.create(product);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (SQLException e) {
            log("Error creating product: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Error creating product: " + e.getMessage());
            showNewForm(request, response);
        }
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Get form data and parse numeric values
        int productId = 0;
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = null;
        int stockQuantity = 0;
        int categoryId = 0;
        
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
            price = new BigDecimal(request.getParameter("price"));
            stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format in form data");
            response.sendRedirect(request.getContextPath() + "/admin/products?action=edit&id=" + productId);
            return;
        }
        
        // Fetch existing product
        Product product = productDAO.findById(productId);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        
        // Handle file upload for image
        String imageUrl = product.getImageUrl(); // Keep existing image by default
        try {
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getSubmittedFileName(filePart);
                
                if (fileName != null && !fileName.isEmpty()) {
                    // Ensure upload directory exists
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    // Delete old image if it exists
                    if (imageUrl != null && !imageUrl.isEmpty()) {
                        File oldFile = new File(uploadPath + File.separator + 
                                      imageUrl.substring(imageUrl.lastIndexOf(File.separator) + 1));
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }
                    
                    // Create a unique file name to prevent overwriting
                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String filePath = uploadPath + File.separator + uniqueFileName;
                    
                    // Write the file
                    filePart.write(filePath);
                    
                    // Update the image URL
                    imageUrl = "images" + File.separator + uniqueFileName;
                }
            }
        } catch (Exception e) {
            log("Error uploading file: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Error uploading image: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/products?action=edit&id=" + productId);
            return;
        }
        
        // Update product object
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);
        product.setImageUrl(imageUrl);
        product.setCategoryId(categoryId);
        product.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
        
        // Save to database
        try {
            productDAO.update(product);
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (SQLException e) {
            log("Error updating product: " + e.getMessage(), e);
            request.setAttribute("errorMessage", "Error updating product: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/products?action=edit&id=" + productId);
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }
        
        // Get the product to find the image path
        Product product = productDAO.findById(productId);
        
        if (product != null) {
            // Delete the product from the database
            productDAO.delete(productId);
            
            // Delete the associated image file if it exists
            String imageUrl = product.getImageUrl();
            if (imageUrl != null && !imageUrl.isEmpty()) {
                String imagePath = getServletContext().getRealPath("") + File.separator + imageUrl;
                File imageFile = new File(imagePath);
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
    
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        
        return null;
    }
}