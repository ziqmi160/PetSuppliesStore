package com.idea.model;

import java.util.List;
import java.util.List;
import java.util.ArrayList;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author haziq
 */

public class Product {
    private int id;
    private String name;
    private String description;
    private List<ProductImage> images; // Your existing field
    private double price;
    private int categoryId;       // New: For foreign key to Categories table
    private String categoryName;  // New: To store category name for display
    private int stockQuantity;    // New: For stock management

    // Constructor to match your existing fields plus new ones from the database
    public Product(int id, String name, String description, List<ProductImage> images, double price, int categoryId, String categoryName, int stockQuantity) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.images = images;
        this.price = price;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.stockQuantity = stockQuantity;
    }
    
    // Constructor for cases where images or categoryName might not be immediately available
    // Used by ProductDAO's getProductById and getAllProducts before images are fetched separately
    public Product(int id, String name, String description, double price, int categoryId, String categoryName, int stockQuantity) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.categoryName = categoryName;  // New: To store category name for display
        this.stockQuantity = stockQuantity;
        this.images = new ArrayList<>(); // Initialize to empty list for Java 5
        this.categoryName = null; // Will be set later if needed
    }


    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
    
    public String getDescription() {
        return description;
    }

    public List<ProductImage> getImages() {
        return images;
    }

    public double getPrice() {
        return price;
    }
    
    public int getCategoryId() { // Getter for CategoryID
        return categoryId;
    }

    public String getCategoryName() { // Getter for Category Name
        return categoryName;
    }

    public int getStockQuantity() { // Getter for StockQuantity
        return stockQuantity;
    }

    // Setters (if you need to modify these fields after creation)
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImages(List<ProductImage> images) {
        this.images = images;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setCategoryId(int categoryId) { // Setter for CategoryID
        this.categoryId = categoryId;
    }

    public void setCategoryName(String categoryName) { // Setter for Category Name
        this.categoryName = categoryName;
    }

    public void setStockQuantity(int stockQuantity) { // Setter for StockQuantity
        this.stockQuantity = stockQuantity;
    }
}
