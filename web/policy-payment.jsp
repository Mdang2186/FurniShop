<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/header.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path}/assets/css/luxe-policy.css"/>

<main class="container" style="margin-top:5rem;margin-bottom:5rem;max-width:1080px">
  <div class="luxe-breadcrumb">
    <a href="${path}/home">Trang chủ</a> / <a href="${path}/policy/payment">Chính sách</a> / Thanh toán & Trả góp
  </div>

  <section class="luxe-hero">
    <span class="kicker"><i class="fa-solid fa-credit-card"></i>&nbsp; AN TOÀN – LINH HOẠT</span>
    <h1 class="display-6">${pageTitle}</h1>
    <p>${pageDesc}</p>
  </section>

  <div class="grid-2" style="margin-top:18px">
    <section class="luxe-section">
      <h5>Phương thức thanh toán</h5>
      <ul class="luxe-list">
        <li>Tiền mặt khi nhận (COD).</li>
        <li>Thẻ Visa/Master/JCB.</li>
        <li>Ví MoMo, VNPay QR.</li>
        <li>Chuyển khoản ngân hàng (VCB/TCB/BIDV...).</li>
      </ul>
      <div class="hr-soft"></div>
      <span class="luxe-chip"><span class="dot"></span> Mã hóa & chống gian lận</span>
    </section>

    <section class="luxe-section">
      <h5>Trả góp 0% (đối tác)</h5>
      <ul class="luxe-list">
        <li>Kỳ hạn: 3–12 tháng, tùy thời điểm.</li>
        <li>Yêu cầu: CCCD + thẻ tín dụng còn hiệu lực.</li>
        <li>Duyệt online nhanh, sao kê điện tử.</li>
      </ul>
    </section>
  </div>

  <section class="luxe-section">
    <h5>Hóa đơn & Thuế</h5>
    <p>Xuất hóa đơn VAT theo yêu cầu trong 7 ngày kể từ ngày giao hàng. Vui lòng cung cấp thông tin mã số thuế & địa chỉ công ty chính xác.</p>
  </section>

  <section class="luxe-section luxe-acc">
    <details>
      <summary>FAQ: Đơn trả góp có được đổi trả?</summary>
      <div class="acc-body">Áp dụng theo chính sách đổi trả chung; khoản tín dụng sẽ được tất toán theo quy định của đối tác.</div>
    </details>
    <details>
      <summary>FAQ: Tạo hóa đơn sau 7 ngày?</summary>
      <div class="acc-body">Rất tiếc không hỗ trợ xuất hóa đơn muộn hơn 7 ngày theo quy định hiện hành.</div>
    </details>
  </section>
</main>

<jsp:include page="includes/footer.jsp" />
