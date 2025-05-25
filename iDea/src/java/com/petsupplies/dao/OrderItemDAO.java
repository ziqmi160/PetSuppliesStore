package com.petsupplies.dao;

import com.petsupplies.model.OrderItem;
import java.sql.SQLException;
import java.util.List;

public interface OrderItemDAO {
    OrderItem create(OrderItem orderItem) throws SQLException;
    OrderItem findById(int itemId) throws SQLException;
    List<OrderItem> findByOrderId(int orderId) throws SQLException;
    OrderItem update(OrderItem orderItem) throws SQLException;
    boolean delete(int itemId) throws SQLException;
}