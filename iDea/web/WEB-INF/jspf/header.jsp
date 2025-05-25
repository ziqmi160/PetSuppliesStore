<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Supplies Store</title>
    <style>
        /* Reset and base styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        header {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
            text-decoration: none;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            flex-wrap: wrap;
        }

        .nav-item {
            margin: 0 5px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
            border: 1px solid transparent;
        }

        .nav-link:hover {
            background-color: rgba(255,255,255,0.2);
            border-color: rgba(255,255,255,0.3);
        }

        /* Main content */
        main.container {
            flex: 1;
            padding-top: 30px;
        }

        /* Typography */
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
            text-align: center;
            font-size: 2.5rem;
        }

        h2 {
            color: #34495e;
            margin: 30px 0 20px 0;
            font-size: 2rem;
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }

        /* Layout */
        .row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px;
        }

        .col {
            flex: 1;
            padding: 0 15px;
        }

        /* Cards */
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid #e0e0e0;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .card-img-top {
            width: 100%;
            height: 220px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 25px;
        }

        .card-title {
            font-size: 1.4rem;
            margin-bottom: 15px;
            color: #2c3e50;
            font-weight: 600;
        }

        .card-text {
            margin-bottom: 20px;
            color: #666;
            font-size: 1.1rem;
        }

        .price {
            font-size: 1.3rem;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 15px;
        }

        /* Buttons */
        .btn {
            display: inline-block;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(76, 175, 80, 0.3);
        }

        .btn:hover {
            background: linear-gradient(135deg, #45a049, #3d8b40);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
            color: white;
            text-decoration: none;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            box-shadow: 0 2px 8px rgba(108, 117, 125, 0.3);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268, #495057);
        }

        /* Product grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 25px;
        }

        /* Welcome section */
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 50px 20px;
            margin-bottom: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .welcome-section h1 {
            color: white;
            margin-bottom: 15px;
            font-size: 3rem;
        }

        .welcome-section p {
            font-size: 1.3rem;
            opacity: 0.9;
        }

        /* Footer */
        footer {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 40px 0 20px 0;
            margin-top: auto;
        }

        footer h3 {
            margin-bottom: 15px;
            color: #ecf0f1;
            font-size: 1.3rem;
        }

        footer p {
            margin-bottom: 8px;
            color: #bdc3c7;
        }

        footer .row:last-child {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            text-align: center;
        }

        /* Alerts */
        .alert {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 8px;
            border: 1px solid transparent;
            font-weight: 500;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                text-align: center;
            }
            
            .navbar-nav {
                margin-top: 15px;
                justify-content: center;
            }
            
            .welcome-section h1 {
                font-size: 2.2rem;
            }
            
            .welcome-section p {
                font-size: 1.1rem;
            }
            
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
            }
            
            .container {
                width: 95%;
                padding: 15px;
            }

            h1 {
                font-size: 2rem;
            }

            h2 {
                font-size: 1.6rem;
            }
        }

        @media (max-width: 480px) {
            .product-grid {
                grid-template-columns: 1fr;
            }
            
            .nav-item {
                margin: 5px 0;
            }
            
            .navbar-nav {
                flex-direction: column;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/home" class="navbar-brand">🐾 Pet Supplies Store</a>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/home" class="nav-link">🏠 Home</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/products" class="nav-link">🛍️ Products</a>
                    </li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/cart" class="nav-link">🛒 Cart</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/account" class="nav-link">👤 My Account</a>
                            </li>
                            <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                                <li class="nav-item">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">⚙️ Admin</a>
                                </li>
                            </c:if>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/logout" class="nav-link">🚪 Logout</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/login" class="nav-link">🔐 Login</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/register" class="nav-link">📝 Register</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </div>
    </header>
    <main class="container">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">❌ ${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">✅ ${successMessage}</div>
        </c:if>