package com.petsupplies.controller;

import com.petsupplies.dao.CartDAO;
import com.petsupplies.dao.CartDAOImpl;
import com.petsupplies.dao.CartItemDAO;
import com.petsupplies.dao.CartItemDAOImpl;
import com.petsupplies.dao.OrderDAO;
import com.petsupplies.dao.OrderDAOImpl;
import com.petsupplies.dao.OrderItemDAO;
import com.petsupplies.dao.OrderItemDAOImpl;
import com.petsupplies.dao.ProductDAO;
import com.petsupplies.dao.ProductDAOImpl;
import com.petsupplies.model.Cart;
import com.petsupplies.model.CartItem;
import com.petsupplies.model.Order;
import com.petsupplies.model.OrderItem;
import com.petsupplies.model.Product;
import com.petsupplies.model.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
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
            Cart cart = cartDAO.findByUserId(user.getUserId());
            
            if (cart == null || cartItemDAO.findByCartId(cart.getCartId()).isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
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
            request.setAttribute("user", user);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        
        try {
            Cart cart = cartDAO.findByUserId(user.getUserId());
            
            if (cart == null) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            List<CartItem> cartItems = cartItemDAO.findByCartId(cart.getCartId());
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : cartItems) {
                Product product = productDAO.findById(item.getProductId());
                total = total.add(product.getPrice().multiply(new BigDecimal(item.getQuantity())));
            }
            
            // Create order
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setOrderDate(new Timestamp(System.currentTimeMillis()));
            order.setTotalAmount(total);
            order.setShippingAddress(shippingAddress);
            order.setStatus("PENDING");
            order.setPaymentMethod(paymentMethod);
            
            order = orderDAO.create(order);
            
            // Create order items
            for (CartItem cartItem : cartItems) {
                Product product = productDAO.findById(cartItem.getProductId());
                
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(order.getOrderId());
                orderItem.setProductId(cartItem.getProductId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setPrice(product.getPrice());
                
                orderItemDAO.create(orderItem);
                
                // Update product stock
                product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
                productDAO.update(product);
            }
            
            // Clear cart
            for (CartItem cartItem : cartItems) {
                cartItemDAO.delete(cartItem.getCartItemId());
            }
            
            // Set order confirmation attribute
            request.setAttribute("order", order);
            request.getRequestDispatcher("/order-confirmation.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}