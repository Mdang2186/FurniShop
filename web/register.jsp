<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<main class="container" style="max-width: 600px; margin-top: 5rem; margin-bottom: 5rem;">
    <div class="card">
        <div class="card-body p-5">
            <h2 class="text-center mb-4">Đăng Ký Tài Khoản Mới</h2>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <c:if test="${not empty requestScope.error}">
                <div class="alert alert-danger" role="alert">
                    ${requestScope.error}
                </div>
            </c:if>

            <form action="register" method="post">
                <input type="hidden" name="action" value="register">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Họ và Tên</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Địa chỉ Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="re_password" class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" class="form-control" id="re_password" name="re_password" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 mt-3">Đăng Ký</button>
            </form>
            <div class="text-center mt-3">
                <p>Bạn đã có tài khoản? <a href="login">Đăng nhập tại đây</a></p>
            </div>
        </div>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />