<%@ include file="/WEB-INF/jspf/header.jsp" %>

<div class="row">
    <div class="col">
        <h1>Welcome to Pet Supplies Store</h1>
        <p>Find everything your pet needs for a happy and healthy life!</p>
    </div>
</div>

<div class="row">
    <div class="col">
        <h2>Featured Products</h2>
        <div class="product-grid">
            <c:forEach items="${featuredProducts}" var="product">
                <div class="card">
                    <c:if test="${not empty product.imageUrl}">
                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" class="card-img-top" alt="${product.name}">
                    </c:if>
                    <div class="card-body">
                        <h3 class="card-title">${product.name}</h3>
                        <p class="card-text">${product.price} USD</p>
                        <a href="${pageContext.request.contextPath}/products?action=detail&id=${product.productId}" class="btn">View Details</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<div class="row">
    <div class="col">
        <h2>Shop by Category</h2>
        <div class="product-grid">
            <c:forEach items="${categories}" var="category">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title">${category.name}</h3>
                        <p class="card-text">${category.description}</p>
                        <a href="${pageContext.request.contextPath}/products?action=category&id=${category.categoryId}" class="btn">Browse Products</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jsp" %>