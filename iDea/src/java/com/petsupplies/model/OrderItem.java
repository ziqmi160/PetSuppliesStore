package com.petsupplies.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderItem implements Serializable {
    private int itemId;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal price;
    private Product product; // For joining with product

    // Constructors, getters, and setters
    public OrderItem() {
    }

    public OrderItem(int itemId, int orderId, int productId, int quantity, BigDecimal price) {
        this.itemId = itemId;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and setters
    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "OrderItem{" + "itemId=" + itemId + ", productId=" + productId + ", quantity=" + quantity + ", price=" + price + '}';
    }
}