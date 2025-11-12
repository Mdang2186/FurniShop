<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/admin/admin-header.jsp" %>
<%@ include file="/WEB-INF/admin/admin-sidebar.jsp" %>

<div class="admin-app">
  <div class="admin-main">
    <div class="admin-content">
      <h1>${product != null ? 'Chỉnh sửa sản phẩm' : 'Tạo sản phẩm mới'}</h1>

      <div class="card" style="margin-top:1rem;">
        <form action="${pageContext.request.contextPath}/admin/products/save" method="post" enctype="multipart/form-data">
          <input type="hidden" name="productID" value="${product.productID}" />
          <div class="form-row">
            <div style="flex:1">
              <label class="muted">Tên sản phẩm</label>
              <input class="input" type="text" name="productName" value="${product.productName}" required>
            </div>
            <div style="width:200px;">
              <label class="muted">Giá (VND)</label>
              <input class="input" type="number" name="price" value="${product.price}" required>
            </div>
          </div>

          <div class="form-row">
            <div style="flex:1">
              <label class="muted">Danh mục</label>
              <select name="categoryID" class="input">
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="c" items="${categories}">
                  <option value="${c.categoryID}" ${product!=null && product.categoryID==c.categoryID ? 'selected' : ''}>${c.categoryName}</option>
                </c:forEach>
              </select>
            </div>
            <div style="width:200px;">
              <label class="muted">Stock</label>
              <input class="input" type="number" name="stock" value="${product.stock}" min="0">
            </div>
          </div>

          <div class="form-row">
            <div style="flex:1">
              <label class="muted">Mô tả</label>
              <textarea class="input" name="description" rows="6">${product.description}</textarea>
            </div>
            <div style="width:260px;">
              <label class="muted">Hình đại diện</label>
              <input type="file" name="imageFile" class="input">
              <c:if test="${product!=null && not empty product.imageURL}">
                <img src="${product.imageURL}" style="width:100%; margin-top:.5rem; border-radius:8px;">
              </c:if>
            </div>
          </div>

          <div style="display:flex; gap:.75rem; margin-top:1rem;">
            <button class="btn btn-primary" type="submit">Lưu</button>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-ghost">Hủy</a>
          </div>
        </form>
      </div>

    </div>
  </div>
</div>
