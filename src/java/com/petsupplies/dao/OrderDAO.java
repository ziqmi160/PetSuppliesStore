package com.petsupplies.dao;

import com.petsupplies.model.Order;
import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {
    Order create(Order order) throws SQLException;
    Order findById(int orderId) throws SQLException;
    List<Order> findAll() throws SQLException;
    List<Order> findByUserId(int userId) throws SQLException;
    List<Order> findRecentOrders(int limit) throws SQLException;
    Order update(Order order) throws SQLException;
    boolean delete(int orderId) throws SQLException;
}