<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/includes/header.jsp" />

<main class="container my-5">
  <div class="row g-4">
    <!-- Sidebar -->
    <aside class="col-lg-3">
      <div class="list-group shadow-sm rounded-3">
        <a href="<c:url value='/account'/>"
           class="list-group-item list-group-item-action ${empty param.tab || param.tab=='profile' || tab=='profile' ? 'active' : ''}">
          <i class="fas fa-user-gear me-2"></i> Thông tin tài khoản
        </a>
        <a href="<c:url value='/account?tab=password'/>"
           class="list-group-item list-group-item-action ${param.tab=='password' || tab=='password' ? 'active' : ''}">
          <i class="fas fa-key me-2"></i> Đổi mật khẩu
        </a>
        <a href="<c:url value='/orders'/>" class="list-group-item list-group-item-action">
          <i class="fas fa-clipboard-list me-2"></i> Lịch sử đơn hàng
        </a>
        <a href="<c:url value='/logout'/>" class="list-group-item list-group-item-action text-danger">
          <i class="fas fa-right-from-bracket me-2"></i> Đăng xuất
        </a>
      </div>
    </aside>

    <!-- Content -->
    <section class="col-lg-9">
      <!-- Alerts -->
      <c:if test="${not empty success}">
        <div class="alert alert-success rounded-3 shadow-sm">${success}</div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="alert alert-danger rounded-3 shadow-sm">${error}</div>
      </c:if>

      <!-- PROFILE TAB -->
      <div class="${empty tab || tab=='profile' ? '' : 'd-none'}">
        <div class="card border-0 shadow-sm rounded-4">
          <div class="card-body p-4">
            <h3 class="font-playfair mb-1">Thông tin tài khoản</h3>
            <p class="text-muted mb-4">Cập nhật thông tin cá nhân để thuận tiện khi thanh toán và giao hàng.</p>

            <form action="<c:url value='/account'/>" method="post" class="row g-3">
              <input type="hidden" name="_csrf" value="${csrf}"/>
              <input type="hidden" name="action" value="update-profile"/>

              <div class="col-12">
                <label class="form-label fw-semibold">Email (không thay đổi)</label>
                <input type="email" class="form-control rounded-pill" value="${sessionScope.account.email}" disabled readonly>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Họ và tên</label>
                <input name="fullName" class="form-control rounded-pill" required
                       value="${sessionScope.account.fullName}" placeholder="Nguyễn Văn A">
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Số điện thoại</label>
                <input name="phone" class="form-control rounded-pill" placeholder="0xxxxxxxxx"
                       value="${sessionScope.account.phone}"
                       pattern="^(0|\\+?84)\\d{8,10}$"
                       title="Số điện thoại Việt Nam hợp lệ">
              </div>

              <div class="col-12">
                <label class="form-label fw-semibold">Địa chỉ giao hàng</label>
                <textarea name="address" rows="3" class="form-control" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành"
                          required>${sessionScope.account.address}</textarea>
              </div>

              <div class="col-12">
                <button class="btn btn-warning text-dark fw-semibold rounded-pill px-4">
                  <i class="fas fa-save me-2"></i>Lưu thay đổi
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- PASSWORD TAB -->
      <div class="${tab=='password' ? '' : 'd-none'}">
        <div class="card border-0 shadow-sm rounded-4">
          <div class="card-body p-4">
            <h3 class="font-playfair mb-1">Đổi mật khẩu</h3>
            <p class="text-muted mb-4">Tối thiểu 6 ký tự. Hãy dùng mật khẩu mạnh để bảo vệ tài khoản.</p>

            <form action="<c:url value='/account'/>" method="post" class="row g-3">
              <input type="hidden" name="_csrf" value="${csrf}"/>
              <input type="hidden" name="action" value="change-password"/>

              <div class="col-12">
                <label class="form-label fw-semibold">Mật khẩu hiện tại</label>
                <input type="password" name="oldPassword" class="form-control rounded-pill" required>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Mật khẩu mới</label>
                <input type="password" name="newPassword" id="newPwd" class="form-control rounded-pill" minlength="6" required>
              </div>

              <div class="col-md-6">
                <label class="form-label fw-semibold">Nhập lại mật khẩu mới</label>
                <input type="password" name="re_newPassword" id="rePwd" class="form-control rounded-pill" minlength="6" required>
              </div>

              <div class="col-12">
                <button class="btn btn-warning text-dark fw-semibold rounded-pill px-4">
                  <i class="fas fa-key me-2"></i>Đổi mật khẩu
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  </div>
</main>

<jsp:include page="/includes/footer.jsp" />

<script>
  // Nhắc khớp mật khẩu mới (client-side bổ trợ)
  (function () {
    const newPwd = document.getElementById('newPwd');
    const rePwd  = document.getElementById('rePwd');
    if (newPwd && rePwd) {
      const check = () => {
        if (rePwd.value && newPwd.value !== rePwd.value) {
          rePwd.setCustomValidity('Mật khẩu xác nhận không khớp');
        } else {
          rePwd.setCustomValidity('');
        }
      };
      newPwd.addEventListener('input', check);
      rePwd.addEventListener('input', check);
    }
  })();
</script>
