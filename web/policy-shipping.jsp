<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/header.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${path}/assets/css/luxe-policy.css"/>

<main class="container" style="margin-top:5rem;margin-bottom:5rem;max-width:1080px">
  <div class="luxe-breadcrumb">
    <a href="${path}/home">Trang chủ</a> / <a href="${path}/policy/shipping">Chính sách</a> / Giao hàng & Lắp đặt
  </div>

  <section class="luxe-hero">
    <span class="kicker"><i class="fa-solid fa-truck-fast"></i>&nbsp; GIAO NHANH – CHUẨN HẸN</span>
    <h1 class="display-6">${pageTitle}</h1>
    <p>${pageDesc}</p>
  </section>

  <div class="grid-2" style="margin-top:18px">
    <section class="luxe-section">
      <h5>Phạm vi & Thời gian</h5>
      <div class="timeline">
        <div class="tl-item"><b class="gold">Nội thành HN/HCM:</b> 1–3 ngày làm việc.</div>
        <div class="tl-item"><b class="gold">Ngoại thành & tỉnh:</b> 3–7 ngày làm việc.</div>
        <div class="tl-item"><b class="gold">Hỏa tốc:</b> hỗ trợ trong ngày (liên hệ hotline).</div>
      </div>
      <div class="hr-soft"></div>
      <span class="luxe-chip"><span class="dot"></span> Theo dõi đơn qua email/SMS</span>
    </section>

    <section class="luxe-section">
      <h5>Chi phí vận chuyển</h5>
      <table class="luxe-table">
        <tbody>
        <tr class="luxe-row">
          <td style="width:45%">Đơn từ <b>5.000.000đ</b> (nội thành)</td>
          <td><span class="luxe-tag">Miễn phí</span></td>
        </tr>
        <tr class="luxe-row">
          <td>Đơn cồng kềnh / khoảng cách xa</td>
          <td>Phát sinh theo báo giá nhà vận chuyển</td>
        </tr>
        </tbody>
      </table>
    </section>
  </div>

  <section class="luxe-section">
    <h5>Lắp đặt tại nhà</h5>
    <ul class="luxe-list">
      <li>Miễn phí lắp cơ bản: sofa, giường, tủ, kệ.</li>
      <li>Phụ phí nếu có khoan tường đặc biệt, đi dây ẩn, bắn nở…</li>
      <li>Kỹ thuật viên mang đủ dụng cụ, vệ sinh gọn gàng sau lắp.</li>
    </ul>
  </section>

  <section class="luxe-section">
    <h5>Kiểm hàng & Bàn giao</h5>
    <p>Kiểm tra ngoại quan, độ chắc chắn, phụ kiện kèm theo. Ký biên bản bàn giao & kích hoạt bảo hành điện tử.</p>
  </section>

  <section class="luxe-section luxe-acc">
    <details>
      <summary>FAQ: Tôi đổi lịch giao thì sao?</summary>
      <div class="acc-body">Bạn có thể liên hệ CSKH trước 20:00 ngày hôm trước để sắp xếp lại lịch miễn phí.</div>
    </details>
    <details>
      <summary>FAQ: Giao lên tầng cao không thang máy?</summary>
      <div class="acc-body">Sẽ có phụ phí theo số tầng & khối lượng. Nhân viên sẽ báo rõ trước khi thực hiện.</div>
    </details>
  </section>
</main>

<jsp:include page="includes/footer.jsp" />
