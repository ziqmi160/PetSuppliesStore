<%@ include file="/WEB-INF/jspf/header.jsp" %>

<div class="row">
    <div class="col">
        <h1>Login</h1>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register</a></p>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jsp" %>