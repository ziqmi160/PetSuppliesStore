package com.idea.controller;

import com.idea.dao.ProductDAO;
import com.idea.model.CartItem;
import com.idea.model.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if (action != null) {
            switch (action) {
                case "add":
                    addToCart(request, cart);
                    break;
                case "remove":
                    removeFromCart(request, cart);
                    break;
                case "update":
                    updateCart(request, cart);
                    break;
            }
        }

        // Calculate totals
        double subtotal = calculateSubtotal(cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", subtotal); // Add shipping/tax calculations if needed

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    private void addToCart(HttpServletRequest request, List<CartItem> cart) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Check if product already in cart
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    return;
                }
            }

            // If not in cart, add new item
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(productId);
            
            if (product != null) {
                CartItem newItem = new CartItem(
                    product.getProductId(),
                    product.getName(),
                    product.getPrice(),
                    quantity,
                    product.getImages().get(0).getPath()
                );
                cart.add(newItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void removeFromCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        cart.removeIf(item -> item.getProductId() == productId);
    }

    private void updateCart(HttpServletRequest request, List<CartItem> cart) {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(quantity);
                break;
            }
        }
    }

    private double calculateSubtotal(List<CartItem> cart) {
        return cart.stream()
                  .mapToDouble(CartItem::getTotal)
                  .sum();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 