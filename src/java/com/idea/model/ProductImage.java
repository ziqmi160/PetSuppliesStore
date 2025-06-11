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
public class ProductImage {
    
    private int id;
    private String path;
    
    public ProductImage(int id, String path){
        this.id = id;
        this.path = path;
    }
    
    public String getPath(){
        return path;
    }
    
}
