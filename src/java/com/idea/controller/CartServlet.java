package com.idea.controller;

import com.idea.dao.CartDAO;
import com.idea.dao.ProductDAO;
import com.idea.model.CartItem;
import com.idea.model.Product;
import com.idea.model.User;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList; // Already present, but good to note
import java.util.List;

public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        System.out.println("User: " + user.getId());

        int cartId;
        List<CartItem> cartItems;
        try {
            // Get or create cart ID for the user
            cartId = cartDAO.getOrCreateCartId(user.getId());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to a generic error page
            return;
        }

        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    // Handles adding a single item to the cart (usually from a product detail page)
                    addToCart(request, cartId);
                    break;
                case "remove":
                    // Handles removing a single item from the cart
                    removeFromCart(request, cartId);
                    break;
                // The "update" case is removed from doGet as bulk updates are handled by doPost
            }
        }

        // Always reload updated cart from DB to ensure current state is displayed
        try {
            cartItems = cartDAO.getCartItems(cartId);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        // Calculate subtotal and total for display
        double subtotal = calculateSubtotal(cartItems);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", subtotal); // Assuming total is same as subtotal for now

        // Forward to the cart JSP for rendering
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int cartId;
        try {
            cartId = cartDAO.getOrCreateCartId(user.getId());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("updateAll".equals(action)) {
            // Handle bulk update of cart items
            updateAllCartItems(request, cartId);
        } else {
            // Fallback for other POST requests, or if an action isn't specified
            // For example, if adding to cart is also a POST from somewhere else
            doGet(request, response); // Redirect to doGet to display the cart
            return; // Important: return to prevent further execution after redirect
        }

        // After any POST operation, redirect to GET to refresh the cart display
        response.sendRedirect("CartServlet");
    }

    // Helper method to add item to cart
    private void addToCart(HttpServletRequest request, int cartId) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Check if product already exists in cart, then update quantity
            CartItem existingItem = cartDAO.getCartItem(cartId, productId); // Assuming this method exists in CartDAO
            if (existingItem != null) {
                int newQuantity = existingItem.getQuantity() + quantity;
                cartDAO.updateCartItem(cartId, productId, newQuantity);
            } else {
                // If product not in cart, add new item
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    String imagePath = product.getImages().isEmpty() ? "" : product.getImages().get(0).getPath();
                    CartItem newItem = new CartItem(
                            product.getId(),
                            product.getName(),
                            product.getPrice(),
                            quantity,
                            imagePath
                    );
                    cartDAO.addCartItem(cartId, newItem); // Assuming this method exists in CartDAO
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Log the error but don't redirect here, let doGet handle the display
        }
    }

    // Helper method to remove item from cart
    private void removeFromCart(HttpServletRequest request, int cartId) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cartDAO.removeCartItem(cartId, productId);
        } catch (Exception e) {
            e.printStackTrace();
            // Log the error
        }
    }

    // New method to handle bulk cart updates
    private void updateAllCartItems(HttpServletRequest request, int cartId) {
        // Retrieve arrays of product IDs and quantities
        String[] productIdsStr = request.getParameterValues("productId");
        String[] quantitiesStr = request.getParameterValues("quantity");
        System.out.println(quantitiesStr[0]);

        
        if (productIdsStr != null && quantitiesStr != null && productIdsStr.length == quantitiesStr.length) {
            try {
                for (int i = 0; i < productIdsStr.length; i++) {
                    int productId = Integer.parseInt(productIdsStr[i]);
                    int quantity = Integer.parseInt(quantitiesStr[i]);

                    if (quantity > 0) {
                        // Update existing item's quantity
                        cartDAO.updateCartItem(cartId, productId, quantity);
                    } else {
                        // If quantity is 0 or less, remove the item from the cart
                        cartDAO.removeCartItem(cartId, productId);
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                // Log invalid number format, but continue processing others if possible
                request.getSession().setAttribute("error", "Invalid quantity or product ID format provided.");
            } catch (SQLException e) {
                e.printStackTrace();
                // Log database error
                request.getSession().setAttribute("error", "Database error during cart update: " + e.getMessage());
            }
        } else {
            // Handle cases where no items are submitted or data is malformed
            request.getSession().setAttribute("error", "No cart items to update or data mismatch.");
        }
    }

    // Helper method to calculate subtotal
    private double calculateSubtotal(List<CartItem> cart) {
        return cart.stream().mapToDouble(CartItem::getTotal).sum();
    }
}
