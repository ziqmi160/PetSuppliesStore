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
    
    public User(int id, String username, String email){
        this.id = id;
        this.username = username;
        this.email = email;
    }
    
    public int getId(){
        return id;
    }
    
    public String getUsername(){
        return username;
    }
    
    public String getEmail(){
        return email;
    }
}
