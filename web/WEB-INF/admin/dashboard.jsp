<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/admin/admin-header.jsp" %>
<%@ include file="/WEB-INF/admin/admin-sidebar.jsp" %>

<div class="admin-app">
  <div class="admin-main">
    <div class="admin-content">
      <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1rem;">
        <h1 style="margin:0;">Bảng điều khiển</h1>
        <div class="muted">Cập nhật: <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm" /></div>
      </div>

      <div class="kpi">
        <div class="k card">
          <div class="muted">Tổng doanh thu</div>
          <div style="font-size:1.5rem; font-weight:800;"><fmt:formatNumber value="${totalRevenue}" type="currency" currencyCode="VND"/></div>
        </div>
        <div class="k card">
          <div class="muted">Đơn hàng</div>
          <div style="font-size:1.5rem; font-weight:800;">${orderCount}</div>
        </div>
        <div class="k card">
          <div class="muted">Sản phẩm</div>
          <div style="font-size:1.5rem; font-weight:800;">${productCount}</div>
        </div>
        <div class="k card">
          <div class="muted">Người dùng</div>
          <div style="font-size:1.5rem; font-weight:800;">${userCount}</div>
        </div>
      </div>

      <div style="margin-top:1.25rem;">
        <div class="card">
          <h3 class="muted">Đơn hàng mới</h3>
          <table class="table">
            <thead><tr><th>Mã</th><th>Khách</th><th>Tổng tiền</th><th>Trạng thái</th><th>Ngày</th><th></th></tr></thead>
            <tbody>
              <c:forEach var="o" items="${recentOrders}">
                <tr>
                  <td>#${o.orderID}</td>
                  <td>${o.fullName}</td>
                  <td><fmt:formatNumber value="${o.totalAmount}" type="currency" currencyCode="VND"/></td>
                  <td>${o.status}</td>
                  <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy"/></td>
                  <td><a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/orders/view?oid=${o.orderID}">Xem</a></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>

    </div>
  </div>
</div>
