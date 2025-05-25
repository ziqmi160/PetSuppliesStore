package com.petsupplies.dao;

import com.petsupplies.model.Cart;
import java.sql.SQLException;

public interface CartDAO {
    Cart create(Cart cart) throws SQLException;
    Cart findById(int cartId) throws SQLException;
    Cart findByUserId(int userId) throws SQLException;
    Cart update(Cart cart) throws SQLException;
    boolean delete(int cartId) throws SQLException;
}