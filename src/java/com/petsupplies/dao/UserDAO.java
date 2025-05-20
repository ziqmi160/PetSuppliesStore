package com.petsupplies.dao;

import com.petsupplies.model.User;
import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    User create(User user) throws SQLException;
    User findById(int userId) throws SQLException;
    User findByUsername(String username) throws SQLException;
    User findByEmail(String email) throws SQLException;
    List<User> findAll() throws SQLException;
    User update(User user) throws SQLException;
    boolean delete(int userId) throws SQLException;
    User authenticate(String username, String password) throws SQLException;
}