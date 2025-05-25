package com.petsupplies.model;

import java.io.Serializable;

public class Category implements Serializable {
    private int categoryId;
    private String name;
    private String description;

    // Constructors, getters, and setters
    public Category() {
    }

    public Category(int categoryId, String name, String description) {
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", name=" + name + '}';
    }
}