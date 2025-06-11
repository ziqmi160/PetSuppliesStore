/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.dao;

/**
 *
 * @author haziq
 */
import java.sql.*;
import java.util.*;
import com.idea.model.Product;
import com.idea.model.ProductImage;

public class ProductDAO {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/iDea";
    private static final String JDBC_USER = "app";
    private static final String JDBC_PASS = "app";

    public List<Product> getAllProducts() {
    List<Product> products = new ArrayList<>();
    String sql = "SELECT p.ProductID, p.Name, p.Price, i.ImageID, i.ImagePath " +
                 "FROM Products p LEFT JOIN Images i ON p.ProductID = i.ProductID " +
                 "ORDER BY p.ProductID";

    try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        Map<Integer, Product> productMap = new LinkedHashMap<>();

        while (rs.next()) {
            int productId = rs.getInt("ProductID");
            Product product = productMap.get(productId);

            if (product == null) {
                product = new Product(
                    productId,
                    rs.getString("Name"),
                    new ArrayList<>(),
                    rs.getDouble("Price")
                );
                productMap.put(productId, product);
            }

            int imageId = rs.getInt("ImageID");
            String imageUrl = rs.getString("ImagePath");

            if (imageUrl != null) {
                product.getImages().add(new ProductImage(imageId, imageUrl));
            }
        }

        products.addAll(productMap.values());

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return products;
}

}
