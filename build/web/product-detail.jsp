<%@ include file="/WEB-INF/jspf/header.jsp" %>

<div class="row">
    <div class="col" style="flex: 0 0 40%;">
        <c:if test="${not empty product.imageUrl}">
            <img src="${pageContext.request.contextPath}/${product.imageUrl}" class="product-image" alt="${product.name}">
        </c:if>
    </div>
    <div class="col" style="flex: 0 0 60%;">
        <h1>${product.name}</h1>
        <p>${product.description}</p>
        <p class="product-price">${product.price} USD</p>
        <p>In Stock: ${product.stockQuantity > 0 ? 'Yes' : 'No'}</p>
        
        <c:if test="${product.stockQuantity > 0}">
            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${product.productId}">
                <div class="form-group">
                    <label for="quantity">Quantity</label>
                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.stockQuantity}" class="form-control" style="width: 100px;">
                </div>
                <button type="submit" class="btn">Add to Cart</button>
            </form>
        </c:if>
        
        <c:if test="${product.stockQuantity <= 0}">
            <p>This product is currently out of stock.</p>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jsp" %>