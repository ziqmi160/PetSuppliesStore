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

public class User {
    private int id;
    private String username;
    private String email;
    private String password; // Adding password field as it's in your Users table schema
    private String address; // Adding address field as it's in your Users table schema
    private int cartId;     // New: Adding cartId to the User model

    // Existing constructor (adjusting to include password and address if needed)
    // This constructor matches what you currently use in LoginServlet for basic instantiation.
    public User(int id, String username, String email) {
        this.id = id;
        this.username = username;
        this.email = email;
        // password and address would be null/default if not set here
    }

    // New constructor to fully populate user data, including password, address, and cartId
    public User(int id, String username, String email, String password, String address, int cartId) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password; // Set password
        this.address = address;   // Set address
        this.cartId = cartId;     // Set cartId
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() { // Getter for password
        return password;
    }

    public String getAddress() { // Getter for address
        return address;
    }

    public int getCartId() { // New: Getter for cartId
        return cartId;
    }

    // Setters (if you need to modify these fields after creation)
    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) { // Setter for password
        this.password = password;
    }

    public void setAddress(String address) { // Setter for address
        this.address = address;
    }

    public void setCartId(int cartId) { // New: Setter for cartId
        this.cartId = cartId;
    }
}
