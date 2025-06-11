package com.idea.model;

import java.util.List;

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
    private List<ProductImage> images;
    private double price;
    private String category;

    public Product(int id, String name, String description, List<ProductImage> images, double price, String category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.images = images;
        this.price = price;
        this.category = category;
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
    
    public String getCategory() {
        return category;
    }
}
