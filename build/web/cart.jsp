<%@ include file="/WEB-INF/jspf/header.jsp" %>

<div class="row">
    <div class="col">
        <h1>Shopping Cart</h1>
        
        <c:if test="${empty cartItems}">
            <p>Your cart is empty.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn">Continue Shopping</a>
        </c:if>
        
        <c:if test="${not empty cartItems}">
            <table class="table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartItems}" var="item">
                        <tr>
                            <td>
                                <a href="${pageContext.request.contextPath}/products?action=detail&id=${item.product.productId}">
                                    ${item.product.name}
                                </a>
                            </td>
                            <td>${item.product.price} USD</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stockQuantity}" style="width: 60px;" onchange="this.form.submit()">
                                </form>
                            </td>
                            <td>${item.product.price * item.quantity} USD</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <button type="submit" class="btn btn-danger">Remove</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="3" style="text-align: right;"><strong>Total:</strong></td>
                        <td><strong>${total} USD</strong></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            
            <div style="display: flex; justify-content: space-between;">
                <a href="${pageContext.request.contextPath}/products" class="btn">Continue Shopping</a>
                <a href="${pageContext.request.contextPath}/checkout" class="btn">Proceed to Checkout</a>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jsp" %>
```# Pet Supplies E-commerce Store Development Guide
## Using NetBeans 8.2, Servlets, GlassFish and JavaDB

## Table of Contents
1. [Environment Setup](#environment-setup)
2. [Project Creation](#project-creation)
3. [Database Design](#database-design)
4. [Model Creation](#model-creation)
5. [Database Connection](#database-connection)
6. [Frontend Development](#frontend-development)
7. [Servlet Implementation](#servlet-implementation)
8. [User Authentication](#user-authentication)
9. [Shopping Cart Implementation](#shopping-cart-implementation)
10. [Admin Dashboard](#admin-dashboard)
11. [Deployment](#deployment)
12. [Testing](#testing)

## Environment Setup

1. **Install NetBeans 8.2**
   - Download NetBeans 8.2 with Java EE bundle from the official website
   - Run the installer and follow the on-screen instructions
   - Ensure GlassFish and Java DB are included in the installation

2. **Configure GlassFish Server**
   - Launch NetBeans
   - Go to Tools ? Servers
   - If GlassFish is not already set up, click "Add Server"
   - Select GlassFish Server and follow the wizard

3. **Start Java DB**
   - In NetBeans, go to Services tab
   - Right-click on Java DB and select "Start Server"

## Project Creation

1. **Create a New Project**
   - File ? New Project
   - Choose Java Web ? Web Application
   - Name it "PetSuppliesStore"
   - Select GlassFish Server as the target server
   - Select Java EE 7 Web as the Java EE version

2. **Setup Project Structure**
   - Create the following directory structure in the project:
     ```
     /src
       /java
         /com.petsupplies.model
         /com.petsupplies.controller
         /com.petsupplies.dao
         /com.petsupplies.util
       /resources
     /web
       /WEB-INF
       /css
       /js
       /images
       /admin
     ```

## Database Design

1. **Create Database**
   - Go to Services ? Databases
   - Right-click on Java DB and select "Create Database"
   - Name: PetSuppliesDB
   - Username: pet
   - Password: pet123

2. **Create Tables**
   - Right-click on PetSuppliesDB connection and select "Execute Command"
   - Execute the following SQL commands:

```sql
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20),
    role VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200)
);

CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER NOT NULL,
    image_url VARCHAR(200),
    category_id INTEGER REFERENCES Categories(category_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id INTEGER REFERENCES Users(user_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address VARCHAR(200) NOT NULL,
    status VARCHAR(20) NOT NULL,
    payment_method VARCHAR(50)
);

CREATE TABLE OrderItems (
    item_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    order_id INTEGER REFERENCES Orders(order_id),
    product_id INTEGER REFERENCES Products(product_id),
    quantity INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Cart (
    cart_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id INTEGER REFERENCES Users(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE CartItems (
    cart_item_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    cart_id INTEGER REFERENCES Cart(cart_id),
    product_id INTEGER REFERENCES Products(product_id),
    quantity INTEGER NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert admin user
INSERT INTO Users (username, password, email, full_name, role) 
VALUES ('admin', 'admin123', 'admin@petsupplies.com', 'System Administrator', 'ADMIN');

-- Insert sample categories
INSERT INTO Categories (name, description) 
VALUES ('Dog Food', 'Nutritious food for dogs'),
       ('Cat Food', 'Delicious meals for cats'),
       ('Toys', 'Fun toys for pets'),
       ('Accessories', 'Essential pet accessories');

-- Insert sample products
INSERT INTO Products (name, description, price, stock_quantity, image_url, category_id) 
VALUES ('Premium Dog Kibble', 'High-quality dog food for all breeds', 29.99, 100, 'dog_kibble.jpg', 1),
       ('Gourmet Cat Food', 'Tasty wet food for cats', 19.99, 150, 'cat_food.jpg', 2),
       ('Squeaky Bone', 'Durable dog toy', 9.99, 200, 'dog_toy.jpg', 3),
       ('Cat Scratching Post', 'Keep your cat entertained', 49.99, 50, 'scratch_post.jpg', 4);