<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<main class="container" style="max-width: 500px; margin-top: 5rem; margin-bottom: 5rem;">
    <div class="card">
        <div class="card-body p-5">
            <h2 class="text-center mb-4">Đăng nhập</h2>

            <%-- Hiển thị thông báo thành công (nếu có, ví dụ: sau khi reset mật khẩu) --%>
            <c:if test="${not empty requestScope.success}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.success}
                </div>
            </c:if>
            
            <%-- Hiển thị thông báo lỗi (nếu có) --%>
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger" role="alert">
                    ${requestScope.error}
                </div>
            </c:if>

            <form action="login" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                
                <%-- THÊM LINK "QUÊN MẬT KHẨU" TẠI ĐÂY --%>
                <div class="text-end mb-3">
                    <a href="password-reset">Quên mật khẩu?</a>
                </div>
                
                <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
            </form>
            
            <div class="text-center mt-4">
                <p>Bạn chưa có tài khoản? <a href="register">Đăng ký ngay</a></p>
            </div>
        </div>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />