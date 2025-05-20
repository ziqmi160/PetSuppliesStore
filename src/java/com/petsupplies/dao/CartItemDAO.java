package com.petsupplies.dao;

import com.petsupplies.model.CartItem;
import java.sql.SQLException;
import java.util.List;

public interface CartItemDAO {
    CartItem create(CartItem cartItem) throws SQLException;
    CartItem findById(int cartItemId) throws SQLException;
    List<CartItem> findByCartId(int cartId) throws SQLException;
    CartItem findByCartIdAndProductId(int cartId, int productId) throws SQLException;
    CartItem update(CartItem cartItem) throws SQLException;
    boolean delete(int cartItemId) throws SQLException;
}