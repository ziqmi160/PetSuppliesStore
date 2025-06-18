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

public class Admin {
    private int adminId;
    private String name;
    private String email;
    private String password; // Storing password for retrieval for comparison during login

    /**
     * Constructor for creating a new Admin object.
     * @param adminId The unique ID of the admin.
     * @param name The name of the admin.
     * @param email The email address of the admin.
     * @param password The password (hashed/salted in a real application, but raw here for simplicity based on DB).
     */
    public Admin(int adminId, String name, String email, String password) {
        this.adminId = adminId;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // --- Getters ---
    public int getAdminId() {
        return adminId;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    // --- Setters (optional, but good for flexibility) ---
    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

