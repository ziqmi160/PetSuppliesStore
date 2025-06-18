/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.idea.model;

/**
 *
 * @author haziq
 */

public class Category {
    private int categoryId;
    private String categoryName;

    /**
     * Constructor for creating a new Category object.
     * @param categoryId The unique ID of the category.
     * @param categoryName The name of the category.
     */
    public Category(int categoryId, String categoryName) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    // --- Getters ---
    public int getCategoryId() {
        return categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    // --- Setters (optional) ---
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}

