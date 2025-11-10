<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="luxe-title m-0">Danh mục</h4>
  <a href="?action=create" class="btn btn-gold"><i class="fa-solid fa-plus"></i> Thêm</a>
</div>

<table class="table table-luxe">
  <thead><tr><th>ID</th><th>Tên</th><th>Mô tả</th><th class="text-end">Thao tác</th></tr></thead>
  <tbody>
    <c:forEach items="${categories}" var="c">
      <tr><td>${c.categoryID}</td><td><b>${c.categoryName}</b></td><td>${c.description}</td>
        <td class="text-end">
          <a class="btn btn-dark btn-sm" href="?action=edit&id=${c.categoryID}"><i class="fa-solid fa-pen"></i></a>
          <form class="d-inline" method="post" action="${pageContext.request.contextPath}/admin/categories" onsubmit="return confirm('Xóa danh mục?')">
            <input type="hidden" name="action" value="delete"/><input type="hidden" name="id" value="${c.categoryID}"/>
            <button class="btn btn-dark btn-sm"><i class="fa-solid fa-trash"></i></button>
          </form>
        </td></tr>
    </c:forEach>
  </tbody>
</table>

<jsp:include page="includes/admin-footer.jsp"/>
