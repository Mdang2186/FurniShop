
<%-- login.jsp --%>
<jsp:include page="includes/header.jsp" />
<div class="container" style="max-width: 500px; margin-top: 5rem;">
    <div class="card">
        <div class="card-body p-5">
            <h2 class="text-center mb-4">??ng nh?p</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            <form action="login" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">M?t kh?u</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">??ng nh?p</button>
            </form>
        </div>
    </div>
                <%-- Thêm ?o?n này vào file login.jsp --%>
<div class="text-center mt-3">
    <p>B?n ch?a có tài kho?n? <a href="register">??ng ký ngay</a></p>
</div>
</div>
<jsp:include page="includes/footer.jsp" />