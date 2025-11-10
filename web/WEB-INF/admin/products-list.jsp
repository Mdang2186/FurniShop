<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="luxe-title m-0">Quản lý sản phẩm</h4>
  <a href="?action=create" class="btn btn-gold"><i class="fa-solid fa-plus"></i> Thêm</a>
</div>

<form class="row g-2 mb-3" method="get">
  <div class="col-md-5"><input name="q" value="${q}" class="form-control form-dark" placeholder="Tìm theo tên..."></div>
  <div class="col-md-4">
    <select name="cid" class="form-select form-dark">
      <option value="">-- Tất cả danh mục --</option>
      <c:forEach items="${categories}" var="c">
        <option value="${c.categoryID}" <c:if test="${cid==c.categoryID}">selected</c:if>>${c.categoryName}</option>
      </c:forEach>
    </select>
  </div>
  <div class="col-md-3">
    <button class="btn btn-dark w-100"><i class="fa-solid fa-filter"></i> Lọc</button>
  </div>
</form>

<table class="table table-luxe align-middle">
  <thead><tr><th>Ảnh</th><th>Tên</th><th>Danh mục</th><th>Giá</th><th>Kho</th><th class="text-end">Thao tác</th></tr></thead>
  <tbody>
    <c:forEach items="${products}" var="p">
      <tr>
        <td style="width:72px"><img src="${p.imageURL}" onerror="this.src='${path}/assets/images/noimg.png'" class="rounded" style="height:56px;width:56px;object-fit:cover"/></td>
        <td><b>${p.productName}</b><div class="small text-muted">${p.brand}</div></td>
        <td>${p.categoryID}</td>
        <td><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></td>
        <td><span class="${p.stock>0?'badge-ok':'badge-bad'}">${p.stock}</span></td>
        <td class="text-end">
          <a class="btn btn-dark btn-sm" href="?action=edit&id=${p.productID}"><i class="fa-solid fa-pen"></i></a>
          <form method="post" action="${path}/admin/products" class="d-inline" onsubmit="return confirm('Xóa sản phẩm?')">
            <input type="hidden" name="action" value="delete"/><input type="hidden" name="id" value="${p.productID}"/>
            <button class="btn btn-dark btn-sm"><i class="fa-solid fa-trash"></i></button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<c:if test="${totalPages>1}">
  <nav><ul class="pagination">
    <c:forEach begin="1" end="${totalPages}" var="i">
      <li class="page-item ${i==currentPage?'active':''}"><a class="page-link" href="?page=${i}&q=${q}&cid=${cid}">${i}</a></li>
    </c:forEach>
  </ul></nav>
</c:if>

<jsp:include page="includes/admin-footer.jsp"/>
