<%-- Thay thế toàn bộ file: checkout.jsp (Đồng bộ phong cách BoConcept) --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<c:set var="pageTitle" value="Thanh toán - LUXE INTERIORS" scope="request"/>
<jsp:include page="/includes/header.jsp"/>

<main class="container my-5">
  <div class="row g-4">
    <div class="col-lg-7">
      <%-- THAY ĐỔI: Bỏ 'card-luxury g-gold' --%>
      <div class="p-4">
        <h3 class="font-playfair mb-3">Thông tin giao hàng</h3>

        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="<c:url value='/checkout'/>" method="post" id="checkoutForm">
          <input type="hidden" name="sel" value="${sel}"/>

          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label fw-semibold">Họ và tên</label>
               <input name="fullName" class="form-control rounded-pill" required value="${fullName}"/>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-semibold">Số điện thoại</label>
              <input name="phone" class="form-control rounded-pill" required value="${phone}" pattern="^.{9,}$"/>
            </div>
            <div class="col-12">
              <label class="form-label fw-semibold">Địa chỉ nhận hàng</label>
              <input name="address" class="form-control rounded-pill" required value="${address}"/>
            </div>

            <div class="col-12">
              <label class="form-label fw-semibold d-block mb-2">Phương thức thanh toán</label>
              <div class="d-flex flex-wrap gap-2">
                <label class="btn btn-outline-secondary rounded-pill">
                  <input type="radio" name="paymentMethod" class="me-2" value="COD"
                         <c:if test="${empty paymentMethod || paymentMethod=='COD'}">checked</c:if>/> COD (khi nhận hàng)
                </label>
                <label class="btn btn-outline-secondary rounded-pill">
                  <input type="radio" name="paymentMethod" class="me-2" value="BANK"
                         <c:if test="${paymentMethod=='BANK'}">checked</c:if>/> Chuyển khoản ngân hàng
                 </label>
                <label class="btn btn-outline-secondary rounded-pill">
                  <input type="radio" name="paymentMethod" class="me-2" value="MOMO"
                         <c:if test="${paymentMethod=='MOMO'}">checked</c:if>/> Momo
                </label>
                 <label class="btn btn-outline-secondary rounded-pill">
                  <input type="radio" name="paymentMethod" class="me-2" value="VNPAY"
                         <c:if test="${paymentMethod=='VNPAY'}">checked</c:if>/> VNPay
                </label>
              </div>
            </div>

            <div class="col-12">
              <label class="form-label fw-semibold">Ghi chú (tuỳ chọn)</label>
              <textarea name="note" rows="3" class="form-control"
                        placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi đến...">${note}</textarea>
            </div>

            <div class="col-12">
              <button class="btn-luxury ripple w-100" type="submit" id="btnPlace">XÁC NHẬN ĐẶT HÀNG</button>
            </div>
          </div>
        </form>
      </div>
    </div>

    <div class="col-lg-5">
      <%-- THAY ĐỔI: Bỏ 'card-luxury' --%>
      <div class="p-4" style="background: #fdfcf9; border-radius: 12px;">
        <h4 class="font-playfair mb-3">Đơn của bạn</h4>

        <div class="vstack gap-3">
          <c:forEach items="${items}" var="it">
            <div class="d-flex align-items-center gap-3">
              <img src="${it.product.imageURL}" alt="${it.product.productName}"
                   class="rounded-3" style="width:64px;height:64px;object-fit:cover"
                   onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'">
              <div class="flex-grow-1">
                <div class="fw-semibold">${it.product.productName}</div>
                <div class="text-muted small">x${it.quantity}</div>
              </div>
              <div class="fw-bold">
                <fmt:formatNumber value="${it.totalPrice}" type="currency" currencyCode="VND"/>
              </div>
            </div>
          </c:forEach>

          <hr/>
          <div class="d-flex justify-content-between">
            <span class="text-muted">Tạm tính</span>
            <span class="fw-semibold">
              <fmt:formatNumber value="${subTotal}" type="currency" currencyCode="VND"/>
            </span>
          </div>
          <div class="d-flex justify-content-between">
            <span class="text-muted">Phí vận chuyển</span>
            <span class="badge bg-success">Miễn phí</span>
          </div>
          <div class="d-flex justify-content-between fs-5">
            <span class="fw-bold">Tổng cộng</span>
            <span class="fw-bold text-luxury-gold">
              <fmt:formatNumber value="${grandTotal}" type="currency" currencyCode="VND"/>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<jsp:include page="/includes/footer.jsp"/>

<script>
document.getElementById('checkoutForm')?.addEventListener('submit', function () {
  const btn = document.getElementById('btnPlace');
  if (btn){ btn.disabled = true; btn.textContent = 'Đang xử lý...'; }
});
</script>