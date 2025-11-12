<%@ page pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%
  String ctrl = (String) request.getAttribute("adminActive");
  if (ctrl == null) ctrl = "";
%>
<aside class="col-12 col-md-3 col-lg-2 p-3 admin-sidebar" style="border-right:1px solid rgba(212,175,55,.18); min-height: calc(100vh - 56px)">
  <div class="list-group list-group-dark">
    <a href="${path}/admin" class="list-group-item list-group-item-action list-group-item-dark nav-link <%=(ctrl.equals("dashboard")?"active text-luxury-gold":"")%>">
      <i class="fa-solid fa-chart-line me-2"></i> Dashboard
    </a>
    <a href="${path}/admin/products" class="list-group-item list-group-item-action list-group-item-dark nav-link <%=(ctrl.equals("products")?"active text-luxury-gold":"")%>">
      <i class="fa-solid fa-couch me-2"></i> Sản phẩm
    </a>
    <a href="${path}/admin/categories" class="list-group-item list-group-item-action list-group-item-dark nav-link <%=(ctrl.equals("categories")?"active text-luxury-gold":"")%>">
      <i class="fa-solid fa-layer-group me-2"></i> Danh mục
    </a>
    <a href="${path}/admin/orders" class="list-group-item list-group-item-action list-group-item-dark nav-link <%=(ctrl.equals("orders")?"active text-luxury-gold":"")%>">
      <i class="fa-solid fa-receipt me-2"></i> Đơn hàng
    </a>
    <a href="${path}/admin/users" class="list-group-item list-group-item-action list-group-item-dark nav-link <%=(ctrl.equals("users")?"active text-luxury-gold":"")%>">
      <i class="fa-solid fa-users me-2"></i> Người dùng
    </a>
  </div>
</aside>
<main class="col-12 col-md-9 col-lg-10 p-4">