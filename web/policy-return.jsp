<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/header.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path}/assets/css/luxe-policy.css"/>

<main class="container" style="margin-top:5rem;margin-bottom:5rem;max-width:1080px">
  <div class="luxe-breadcrumb">
    <a href="${path}/home">Trang chủ</a> / <a href="${path}/policy/return">Chính sách</a> / Đổi trả & Bảo hành
  </div>

  <section class="luxe-hero">
    <span class="kicker"><i class="fa-solid fa-shield-heart"></i>&nbsp; BẢO VỆ QUYỀN LỢI</span>
    <h1 class="display-6">${pageTitle}</h1>
    <p>${pageDesc}</p>
  </section>

  <div class="grid-2" style="margin-top:18px">
    <section class="luxe-section">
      <h5>Điều kiện đổi trả (7 ngày)</h5>
      <ul class="luxe-list">
        <li>Còn tem/phiếu bảo hành, không trầy xước, không bẩn.</li>
        <li>Đổi màu/kích thước: hỗ trợ 1 lần (phí phát sinh nếu có).</li>
        <li>Hàng dọn kho/clearance: không áp dụng đổi do sở thích.</li>
      </ul>
    </section>
    <section class="luxe-section">
      <h5>Thời hạn bảo hành</h5>
      <table class="luxe-table">
        <tbody>
        <tr class="luxe-row"><td style="width:45%">Khung gỗ/kim loại</td><td><span class="luxe-tag">24 tháng</span></td></tr>
        <tr class="luxe-row"><td>Nệm mút, bọc vải/da (lỗi kỹ thuật)</td><td><span class="luxe-tag">12 tháng</span></td></tr>
        <tr class="luxe-row"><td>Hao mòn tự nhiên / vệ sinh sai</td><td>Không bảo hành</td></tr>
        </tbody>
      </table>
    </section>
  </div>

  <section class="luxe-section">
    <h5>Quy trình xử lý</h5>
    <ol class="luxe-list">
      <li>Gửi hình ảnh/video + mã đơn để xác minh tình trạng.</li>
      <li>Lên lịch kỹ thuật khảo sát hoặc đổi mới.</li>
      <li>Hoàn tiền nếu đủ điều kiện: 3–7 ngày theo phương thức thanh toán.</li>
    </ol>
  </section>

  <section class="luxe-section luxe-acc">
    <details>
      <summary>FAQ: Tôi đổi do không hợp màu?</summary>
      <div class="acc-body">Được hỗ trợ 1 lần trong 7 ngày (phát sinh phí vận chuyển/lắp đặt nếu có).</div>
    </details>
    <details>
      <summary>FAQ: Sản phẩm bị lỗi nhẹ khi nhận?</summary>
      <div class="acc-body">Nhân viên sẽ xử lý tại chỗ nếu khả thi; nếu không sẽ đổi mới theo kho.</div>
    </details>
  </section>
</main>

<jsp:include page="includes/footer.jsp" />
