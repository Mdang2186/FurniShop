<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="luxe-title m-0">Đơn hàng</h4>
  <form class="d-flex gap-2">
    <select name="status" class="form-select form-dark">
      <option value="">Tất cả</option>
      <c:forEach var="s" items="${['Pending','Processing','Shipped','Delivered','Cancelled']}">
        <option value="${s}" <c:if test="${status==s}">selected</c:if>>${s}</option>
      </c:forEach>
    </select>
    <button class="btn btn-dark">Lọc</button>
  </form>
</div>

<table class="table table-luxe">
  <thead><tr><th>#</th><th>Ngày</th><th>Khách</th><th>Tổng</th><th>Trạng thái</th><th class="text-end">Chi tiết</th></tr></thead>
  <tbody>
    <c:forEach items="${orders}" var="o">
      <tr>
        <td>${o.orderID}</td>
        <td><fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
        <td>${o.userID}</td>
        <td><fmt:formatNumber value="${o.totalAmount}" type="currency" currencyCode="VND"/></td>
        <td>
          <span class="${o.status=='Pending'?'badge-warn':(o.status=='Cancelled'?'badge-bad':'badge-ok')}">${o.status}</span>
        </td>
        <td class="text-end"><a class="btn btn-dark btn-sm" href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${o.orderID}">
          <i class="fa-solid fa-eye"></i></a></td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<c:if test="${totalPages>1}">
  <nav><ul class="pagination">
    <c:forEach begin="1" end="${totalPages}" var="i">
      <li class="page-item ${i==currentPage?'active':''}">
        <a class="page-link" href="?page=${i}&status=${status}">${i}</a>
      </li>
    </c:forEach>
  </ul></nav>
</c:if>

<jsp:include page="includes/admin-footer.jsp"/>
