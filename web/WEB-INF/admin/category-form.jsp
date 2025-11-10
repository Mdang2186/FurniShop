<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<h4 class="luxe-title mb-3">${empty category?'Thêm':'Sửa'} danh mục</h4>
<form method="post" action="${pageContext.request.contextPath}/admin/categories" class="row g-3">
  <input type="hidden" name="action" value="save"/>
  <c:if test="${not empty category}">
    <input type="hidden" name="categoryID" value="${category.categoryID}"/>
  </c:if>
  <div class="col-md-6">
    <label class="form-label">Tên danh mục</label>
    <input class="form-control form-dark" name="categoryName" value="${category.categoryName}" required/>
  </div>
  <div class="col-md-6">
    <label class="form-label">Mô tả</label>
    <input class="form-control form-dark" name="description" value="${category.description}"/>
  </div>
  <div class="col-12 d-flex gap-2">
    <button class="btn btn-gold">Lưu</button>
    <a class="btn btn-dark" href="${pageContext.request.contextPath}/admin/categories">Hủy</a>
  </div>
</form>

<jsp:include page="includes/admin-footer.jsp"/>
