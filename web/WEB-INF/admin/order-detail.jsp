<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<h4 class="luxe-title mb-3">Đơn #${order.orderID}</h4>
<div class="row g-3">
  <div class="col-lg-5"><div class="p-3 luxe-card">
    <h6 class="mb-2">Thông tin</h6>
    <div class="small text-muted">Ngày: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></div>
    <div class="small text-muted">Khách: ${order.userID}</div>
    <div class="small text-muted">Thanh toán: ${order.paymentMethod}</div>
    <div class="small text-muted">Địa chỉ: ${order.shippingAddress}</div>
    <div class="small text-muted">Ghi chú: ${order.note}</div>
    <hr class="text-secondary"/>
    <form method="post" action="${pageContext.request.contextPath}/admin/orders" class="d-flex gap-2">
      <input type="hidden" name="action" value="status"/>
      <input type="hidden" name="id" value="${order.orderID}"/>
      <select name="status" class="form-select form-dark">
        <c:forEach var="s" items="${['Pending','Processing','Shipped','Delivered','Cancelled']}">
          <option value="${s}" <c:if test="${order.status==s}">selected</c:if>>${s}</option>
        </c:forEach>
      </select>
      <button class="btn btn-gold">Cập nhật</button>
    </form>
  </div></div>

  <div class="col-lg-7"><div class="p-3 luxe-card">
    <h6 class="mb-2">Sản phẩm</h6>
    <table class="table table-luxe">
      <thead><tr><th>Ảnh</th><th>Tên</th><th>SL</th><th>Đơn giá</th><th>Tổng</th></tr></thead>
      <tbody>
        <c:forEach items="${order.items}" var="it">
          <tr>
            <td style="width:60px"><img src="${it.product.imageURL}" class="rounded" style="height:48px;width:48px;object-fit:cover" onerror="this.src='${pageContext.request.contextPath}/assets/images/noimg.png'"/></td>
            <td>${it.product.productName}</td>
            <td>${it.quantity}</td>
            <td><fmt:formatNumber value="${it.unitPrice}" type="currency" currencyCode="VND"/></td>
            <td><fmt:formatNumber value="${it.quantity*it.unitPrice}" type="currency" currencyCode="VND"/></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <div class="text-end fw-bold">Tổng: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND"/></div>
  </div></div>
</div>

<jsp:include page="includes/admin-footer.jsp"/>
