package com.petsupplies.controller.admin;

import com.petsupplies.dao.OrderDAO;
import com.petsupplies.dao.OrderDAOImpl;
import com.petsupplies.dao.ProductDAO;
import com.petsupplies.dao.ProductDAOImpl;
import com.petsupplies.dao.UserDAO;
import com.petsupplies.dao.UserDAOImpl;
import com.petsupplies.model.Order;
import com.petsupplies.model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get counts for dashboard
            int userCount = userDAO.findAll().size();
            int productCount = productDAO.findAll().size();
            
            List<Order> recentOrders = orderDAO.findRecentOrders(5);
            
            request.setAttribute("userCount", userCount);
            request.setAttribute("productCount", productCount);
            request.setAttribute("recentOrders", recentOrders);
            
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}