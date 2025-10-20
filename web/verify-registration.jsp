<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<main class="container" style="max-width: 600px; margin-top: 5rem; margin-bottom: 5rem;">
    <div class="card">
        <div class="card-body p-5">
            <h2 class="text-center mb-4">Xác thực tài khoản</h2>
            <p class="text-center">Chúng tôi đã gửi một mã xác thực đến email của bạn. Vui lòng kiểm tra và nhập mã vào ô bên dưới.</p>
            
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger" role="alert">
                    ${requestScope.error}
                </div>
            </c:if>

            <form action="register" method="post">
                <input type="hidden" name="action" value="verify">
                <div class="mb-3">
                    <label for="code" class="form-label">Mã xác thực</label>
                    <input type="text" class="form-control" id="code" name="code" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Xác thực</button>
            </form>
        </div>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />