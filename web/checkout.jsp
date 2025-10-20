<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <h1 class="text-center mb-5">Thanh Toán Đơn Hàng</h1>
    <div class="row g-5">
        <div class="col-md-7 col-lg-8">
            <h4 class="mb-3">Thông tin giao hàng</h4>
            <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
            <form action="checkout" method="post" class="needs-validation">
                <div class="row g-3">
                    <div class="col-12"><label class="form-label">Họ và tên</label><input type="text" name="fullName" class="form-control" value="${sessionScope.account.fullName}" required></div>
                    <div class="col-12"><label class="form-label">Số điện thoại</label><input type="tel" name="phone" class="form-control" value="${sessionScope.account.phone}" required></div>
                    <div class="col-12"><label class="form-label">Địa chỉ giao hàng</label><textarea name="address" class="form-control" rows="3" required>${sessionScope.account.address}</textarea></div>
                    <div class="col-12"><label class="form-label">Phương thức thanh toán</label><select name="paymentMethod" class="form-select"><option value="COD" selected>Thanh toán khi nhận hàng (COD)</option><option value="BankTransfer">Chuyển khoản ngân hàng</option></select></div>
                    <div class="col-12"><label class="form-label">Ghi chú (tùy chọn)</label><textarea name="note" class="form-control" rows="2"></textarea></div>
                </div>
                <hr class="my-4">
                <button type="submit" class="w-100 btn btn-primary btn-lg">Xác nhận đặt hàng</button>
            </form>
        </div>
        <div class="col-md-5 col-lg-4 order-md-last">
            <h4 class="d-flex justify-content-between align-items-center mb-3"><span class="text-primary">Đơn hàng của bạn</span><span class="badge bg-primary rounded-pill">${sessionScope.cartSize}</span></h4>
            <ul class="list-group mb-3">
                <c:forEach items="${sessionScope.cart}" var="item">
                    <li class="list-group-item d-flex justify-content-between lh-sm">
                        <div><h6 class="my-0">${item.product.productName}</h6><small class="text-muted">Số lượng: ${item.quantity}</small></div>
                        <span class="text-muted"><fmt:formatNumber value="${item.totalPrice}" type="currency" currencyCode="VND"/></span>
                    </li>
                </c:forEach>
                <li class="list-group-item d-flex justify-content-between"><span>Tổng cộng (VND)</span><strong><fmt:formatNumber value="${sessionScope.totalAmount}" type="currency" currencyCode="VND"/></strong></li>
            </ul>
        </div>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />