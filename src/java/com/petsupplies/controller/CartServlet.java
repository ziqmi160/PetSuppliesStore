package com.petsupplies.controller;

import com.petsupplies.dao.CartDAO;
import com.petsupplies.dao.CartDAOImpl;
import com.petsupplies.dao.CartItemDAO;
import com.petsupplies.dao.CartItemDAOImpl;
import com.petsupplies.dao.ProductDAO;
import com.petsupplies.dao.ProductDAOImpl;
import com.petsupplies.model.Cart;
import com.petsupplies.model.CartItem;
import com.petsupplies.model.Product;
import com.petsupplies.model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            Cart cart = getOrCreateCart(user.getUserId());
            List<CartItem> cartItems = cartItemDAO.findByCartId(cart.getCartId());
            
            // Calculate total
            double total = 0;
            for (CartItem item : cartItems) {
                Product product = productDAO.findById(item.getProductId());
                item.setProduct(product);
                total += product.getPrice().doubleValue() * item.getQuantity();
            }
            
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            switch (action) {
                case "add":
                    addToCart(request, response, user.getUserId());
                    break;
                case "update":
                    updateCart(request, response);
                    break;
                case "remove":
                    removeFromCart(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/cart");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private Cart getOrCreateCart(int userId) throws SQLException {
        Cart cart = cartDAO.findByUserId(userId);
        
        if (cart == null) {
            cart = new Cart();
            cart.setUserId(userId);
            cart.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            cart = cartDAO.create(cart);
        }
        
        return cart;
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, int userId)
            throws SQLException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        Cart cart = getOrCreateCart(userId);
        
        // Check if product already exists in cart
        CartItem existingItem = cartItemDAO.findByCartIdAndProductId(cart.getCartId(), productId);
        
        if (existingItem != null) {
            // Update quantity
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            cartItemDAO.update(existingItem);
        } else {
            // Add new item
            CartItem newItem = new CartItem();
            newItem.setCartId(cart.getCartId());
            newItem.setProductId(productId);
            newItem.setQuantity(quantity);
            newItem.setAddedAt(new Timestamp(System.currentTimeMillis()));
            cartItemDAO.create(newItem);
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        CartItem cartItem = cartItemDAO.findById(cartItemId);
        
        if (cartItem != null) {
            if (quantity > 0) {
                cartItem.setQuantity(quantity);
                cartItemDAO.update(cartItem);
            } else {
                cartItemDAO.delete(cartItemId);
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        cartItemDAO.delete(cartItemId);
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}