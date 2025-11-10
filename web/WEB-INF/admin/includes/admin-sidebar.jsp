<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%
  String ctrl = (String) request.getAttribute("adminActive");
  if (ctrl == null) ctrl = "";
%>
<aside class="col-12 col-md-3 col-lg-2 p-3" style="border-right:1px solid rgba(212,175,55,.18); min-height: calc(100vh - 56px)">
  <div class="list-group">
    <a href="${path}/admin" class="list-group-item list-group-item-action nav-link <%=(ctrl.equals("dashboard")?"active":"")%>">
      <i class="fa-solid fa-chart-line me-2"></i> Dashboard
    </a>
    <a href="${path}/admin/products" class="list-group-item list-group-item-action nav-link <%=(ctrl.equals("products")?"active":"")%>">
      <i class="fa-solid fa-couch me-2"></i> S?n ph?m
    </a>
    <a href="${path}/admin/categories" class="list-group-item list-group-item-action nav-link <%=(ctrl.equals("categories")?"active":"")%>">
      <i class="fa-solid fa-layer-group me-2"></i> Danh m?c
    </a>
    <a href="${path}/admin/orders" class="list-group-item list-group-item-action nav-link <%=(ctrl.equals("orders")?"active":"")%>">
      <i class="fa-solid fa-receipt me-2"></i> ??n hàng
    </a>
    <a href="${path}/admin/users" class="list-group-item list-group-item-action nav-link <%=(ctrl.equals("users")?"active":"")%>">
      <i class="fa-solid fa-users me-2"></i> Ng??i dùng
    </a>
  </div>
</aside>
<main class="col-12 col-md-9 col-lg-10 p-4">
