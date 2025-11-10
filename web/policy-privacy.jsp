<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/header.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path}/assets/css/luxe-policy.css"/>

<main class="container" style="margin-top:5rem;margin-bottom:5rem;max-width:1080px">
  <div class="luxe-breadcrumb">
    <a href="${path}/home">Trang chủ</a> / <a href="${path}/policy/privacy">Chính sách</a> / Bảo mật
  </div>

  <section class="luxe-hero">
    <span class="kicker"><i class="fa-solid fa-user-shield"></i>&nbsp; PRIVACY FIRST</span>
    <h1 class="display-6">${pageTitle}</h1>
    <p>${pageDesc}</p>
  </section>

  <section class="luxe-section">
    <h5>Thu thập dữ liệu</h5>
    <p>Chỉ thu thập thông tin cần thiết để xử lý đơn hàng: họ tên, số điện thoại, địa chỉ, email, lịch sử mua sắm.</p>
  </section>

  <section class="luxe-section">
    <h5>Lưu trữ & Chia sẻ</h5>
    <ul class="luxe-list">
      <li>Lưu trữ an toàn theo quy định pháp luật.</li>
      <li>Chỉ chia sẻ với đơn vị vận chuyển/đối tác thanh toán để hoàn tất đơn.</li>
      <li>Không bán dữ liệu cho bên thứ ba.</li>
    </ul>
  </section>

  <section class="luxe-section">
    <h5>Quyền của bạn</h5>
    <ul class="luxe-list">
      <li>Yêu cầu xem, sửa hoặc xóa dữ liệu cá nhân.</li>
      <li>Rút lại đồng ý nhận bản tin bất cứ lúc nào.</li>
    </ul>
  </section>

  <section class="luxe-section luxe-acc">
    <details>
      <summary>FAQ: Xóa dữ liệu cá nhân như thế nào?</summary>
      <div class="acc-body">Gửi yêu cầu từ email đã đăng ký; chúng tôi xử lý trong 3–5 ngày làm việc.</div>
    </details>
    <details>
      <summary>FAQ: Dữ liệu thanh toán có được lưu?</summary>
      <div class="acc-body">Thông tin thẻ không lưu trên hệ thống; thanh toán qua cổng đạt chuẩn bảo mật.</div>
    </details>
  </section>
</main>

<jsp:include page="includes/footer.jsp" />
