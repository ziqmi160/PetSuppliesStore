<%@ include file="/WEB-INF/jspf/header.jsp" %>

<div class="row">
    <div class="col" style="flex: 0 0 25%;">
        <h2>Categories</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/products">All Products</a></li>
            <c:forEach items="${categories}" var="category">
                <li><a href="${pageContext.request.contextPath}/products?action=category&id=${category.categoryId}">${category.name}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="col" style="flex: 0 0 75%;">
        <h1>
            <c:choose>
                <c:when test="${not empty currentCategory}">
                    ${currentCategory.name}
                </c:when>
                <c:otherwise>
                    All Products
                </c:otherwise>
            </c:choose>
        </h1>
        <div class="product-grid">
            <c:forEach items="${products}" var="product">
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
            <c:if test="${empty products}">
                <p>No products found.</p>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jsp" %>