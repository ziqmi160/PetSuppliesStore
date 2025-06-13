package com.idea.controller;

import com.idea.dao.CartDAO;
import com.idea.dao.ProductDAO;
import com.idea.model.CartItem;
import com.idea.model.Product;
import com.idea.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Initialize cart in session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Initialize or retrieve cart ID from DB
        Integer cartId = (Integer) session.getAttribute("cartId");
        if (cartId == null) {
            try {
                cartId = cartDAO.createCart(user.getId());
                session.setAttribute("cartId", cartId);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
                return;
            }
        }

        // Handle cart actions
        String action = request.getParameter("action");
        if (action != null && cartId != null) {
            switch (action) {
                case "add":
                    addToCart(request, cart, cartId);
                    break;
                case "remove":
                    removeFromCart(request, cart, cartId);
                    break;
                case "update":
                    updateCart(request, cart, cartId);
                    break;
            }
        }

        double subtotal = calculateSubtotal(cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", subtotal); // Add tax/shipping if needed

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void addToCart(HttpServletRequest request, List<CartItem> cart, int cartId) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    cartDAO.updateCartItem(cartId, productId, item.getQuantity());
                    return;
                }
            }

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
                cart.add(newItem);
                cartDAO.addCartItem(cartId, newItem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void removeFromCart(HttpServletRequest request, List<CartItem> cart, int cartId) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(item -> item.getProductId() == productId);
            cartDAO.removeCartItem(cartId, productId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateCart(HttpServletRequest request, List<CartItem> cart, int cartId) {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(quantity);
                    cartDAO.updateCartItem(cartId, productId, quantity);
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private double calculateSubtotal(List<CartItem> cart) {
        return cart.stream().mapToDouble(CartItem::getTotal).sum();
    }
}
