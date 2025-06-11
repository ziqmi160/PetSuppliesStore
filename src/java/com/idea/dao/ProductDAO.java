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
  String sql = "SELECT p.ProductID, p.Name, p.Price, p.Description, " +
             "i.ImageID, i.ImagePath, " +
             "c.CategoryName " +
             "FROM Products p " +
             "LEFT JOIN Images i ON p.ProductID = i.ProductID " +
             "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID " +
             "ORDER BY p.ProductID";
;

    try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        Map<Integer, Product> productMap = new LinkedHashMap<>();

        while (rs.next()) {
            int productId = rs.getInt("ProductID");
            Product product = productMap.get(productId);

            if (product == null) {
//                  int categoryId = rs.getInt("CategoryID");
            String categoryName = rs.getString("CategoryName");
                product = new Product(
                    productId,
                    rs.getString("Name"),
                                                    rs.getString("Description"),
                    new ArrayList<>(),
                    rs.getDouble("Price"),
                    categoryName

                        
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
    public Product getProductById(int id) {
    Product product = null;
 String sql = "SELECT p.ProductID, p.Name, p.Price, p.CategoryID, p.Description, " +
             "c.CategoryName, i.ImageID, i.ImagePath " +
             "FROM Products p " +
             "LEFT JOIN Images i ON p.ProductID = i.ProductID " +
             "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID " +
             "WHERE p.ProductID = ?";


    try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            if (product == null) {
                int categoryId = rs.getInt("CategoryID");
            String categoryName = rs.getString("CategoryName");
            
product = new Product(
                    rs.getInt("ProductID"),
                    rs.getString("Name"),
                            rs.getString("Description"),

                    new ArrayList<>(),
                    rs.getDouble("Price"),
                    categoryName
                );
            }

            int imageId = rs.getInt("ImageID");
            String imagePath = rs.getString("ImagePath");
            
            if (imagePath != null) {
                product.getImages().add(new ProductImage(imageId, imagePath));
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return product;
}

}
