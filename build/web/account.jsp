<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <div class="row">
        <div class="col-md-3">
            <div class="list-group">
                <a href="account" class="list-group-item list-group-item-action active" aria-current="true">
                    <i class="fas fa-user-edit me-2"></i>Thông tin tài khoản
                </a>
                <a href="orders" class="list-group-item list-group-item-action">
                    <i class="fas fa-clipboard-list me-2"></i>Lịch sử đơn hàng
                </a>

                <%-- THÊM DÒNG NÀY VÀO ĐÂY --%>
                <a href="change-password" class="list-group-item list-group-item-action">
                    <i class="fas fa-key me-2"></i>Đổi mật khẩu
                </a>

                <a href="logout" class="list-group-item list-group-item-action text-danger">
                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                </a>
            </div>
        </div>
        <div class="col-md-9">
            <h2>Thông tin tài khoản</h2>
            <p>Cập nhật thông tin cá nhân của bạn tại đây.</p>
            <hr>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success" role="alert">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            
            <form action="account" method="post" class="mt-4">
                <div class="mb-3">
                    <label for="email" class="form-label">Địa chỉ Email (Không thể thay đổi)</label>
                    <input type="email" id="email" class="form-control" value="${sessionScope.account.email}" disabled readonly>
                </div>
                <div class="mb-3">
                    <label for="fullName" class="form-label">Họ và tên</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" value="${sessionScope.account.fullName}" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" class="form-control" value="${sessionScope.account.phone}" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ giao hàng</label>
                    <textarea id="address" name="address" class="form-control" rows="3" required>${sessionScope.account.address}</textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            </form>
        </div>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />