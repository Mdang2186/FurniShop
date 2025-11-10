<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/header.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path}/assets/css/luxe-policy.css"/>

<main class="container" style="margin-top:5rem;margin-bottom:5rem;max-width:1080px">
  <div class="luxe-breadcrumb">
    <a href="${path}/home">Trang chủ</a> / <a href="${path}/policy/terms">Chính sách</a> / Điều khoản
  </div>

  <section class="luxe-hero">
    <span class="kicker"><i class="fa-solid fa-scale-balanced"></i>&nbsp; FAIR USE</span>
    <h1 class="display-6">${pageTitle}</h1>
    <p>${pageDesc}</p>
  </section>

  <section class="luxe-section">
    <h5>Điều khoản chung</h5>
    <ul class="luxe-list">
      <li>Không sử dụng website vào mục đích trái pháp luật.</li>
      <li>Giá có thể thay đổi theo thời điểm; hình ảnh mang tính minh họa.</li>
      <li>Chúng tôi có quyền từ chối/huỷ đơn trong trường hợp bất thường về giá/stock.</li>
    </ul>
  </section>

  <section class="luxe-section">
    <h5>Trách nhiệm & Tranh chấp</h5>
    <p>Tranh chấp được ưu tiên thương lượng/hoà giải; nếu không đạt, tuân theo pháp luật Việt Nam.</p>
  </section>

  <section class="luxe-section luxe-acc">
    <details>
      <summary>FAQ: Tôi dùng nội dung website như thế nào?</summary>
      <div class="acc-body">Không sao chép thương mại khi chưa có chấp thuận bằng văn bản.</div>
    </details>
    <details>
      <summary>FAQ: Lỗi niêm yết giá hiếm gặp?</summary>
      <div class="acc-body">Đơn sẽ được thông báo điều chỉnh/huỷ; bạn được chọn tiếp tục hoặc hoàn tiền toàn bộ.</div>
    </details>
  </section>
</main>

<jsp:include page="includes/footer.jsp" />
