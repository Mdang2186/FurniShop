<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/admin/admin-header.jsp" %>
<%@ include file="/WEB-INF/admin/admin-sidebar.jsp" %>

<div class="admin-app">
  <div class="admin-main">
    <div class="admin-content">
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <h1>Sản phẩm</h1>
        <a href="${pageContext.request.contextPath}/admin/products/new" class="btn btn-primary">+ Thêm sản phẩm</a>
      </div>

      <div class="card" style="margin-top:1rem;">
        <table class="table">
          <thead><tr><th>ID</th><th>Tên</th><th>Giá</th><th>Danh mục</th><th>Hình</th><th>Stock</th><th></th></tr></thead>
          <tbody>
            <c:forEach var="p" items="${products}">
              <tr>
                <td>${p.productID}</td>
                <td>${p.productName}</td>
                <td><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></td>
                <td>${p.categoryName}</td>
                <td><img class="thumb" src="${p.imageURL}" alt="${p.productName}"></td>
                <td>${p.stock}</td>
                <td>
                  <a class="btn btn-ghost" href="${pageContext.request.contextPath}/admin/products/edit?pid=${p.productID}">Sửa</a>
                  <form action="${pageContext.request.contextPath}/admin/products/delete" method="post" style="display:inline;">
                    <input type="hidden" name="pid" value="${p.productID}" />
                    <button class="btn btn-ghost" onclick="return confirm('Xác nhận xóa?')">Xóa</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</div>
