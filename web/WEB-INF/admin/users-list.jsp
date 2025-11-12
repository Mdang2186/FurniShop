<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="luxe-title m-0">Người dùng</h4>
  <div class="d-flex gap-2">
    <%-- THAY ĐỔI: Thêm action và method cho form --%>
    <form class="d-flex gap-2" action="<c:url value='/admin/users'/>" method="get">
      <input class="form-control form-dark" name="q" value="${q}" placeholder="Tìm tên hoặc email"/>
      <button class="btn btn-dark" type="submit">Tìm</button>
    </form>
    <a href="<c:url value='/home'/>" target="_blank" class="btn btn-outline-light d-flex align-items-center gap-2">
      <i class="fa-solid fa-store"></i>
      <span class="d-none d-md-inline">Xem trang chủ</span>
    </a>
  </div>
</div>

<table class="table table-luxe">
  <thead><tr><th>ID</th><th>Họ tên</th><th>Email</th><th>Điện thoại</th><th>Vai trò</th><th class="text-end">Thao tác</th></tr></thead>
  <tbody>
    <c:forEach items="${users}" var="u">
      <tr>
        <td>${u.userID}</td>
        <td>${u.fullName}</td>
        <td>${u.email}</td>
        <td>${u.phone}</td>
        <td><span class="${u.role=='Admin'?'badge-ok':'badge-warn'}">${u.role}</span></td>
        <td class="text-end">
          <%-- THAY ĐỔI: Thêm input ẩn cho page và q --%>
          <form method="post" action="${pageContext.request.contextPath}/admin/users" class="d-inline">
            <input type="hidden" name="action" value="role"/>
            <input type="hidden" name="id" value="${u.userID}"/>
            <input type="hidden" name="role" value="${u.role=='Admin'?'Customer':'Admin'}"/>
            <input type="hidden" name="page" value="${currentPage}"/>
            <input type="hidden" name="q" value="${q}"/>
            <button class="btn btn-dark btn-sm"><i class="fa-solid fa-user-gear me-1"></i> Set ${u.role=='Admin'?'Customer':'Admin'}</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<%-- 
  =================================================
  THAY ĐỔI: Thêm Phân trang (Pagination)
  =================================================
--%>
<c:if test="${totalPages > 1}">
  <nav aria-label="Pagination" class="mt-4">
    <ul class="pagination justify-content-center gap-1">
      <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
        <a class="page-link" href="<c:url value='/admin/users?page=1&q=${q}'/>">&laquo;</a>
      </li>
      <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
        <a class="page-link" href="<c:url value='/admin/users?page=${currentPage-1}&q=${q}'/>">Trước</a>
      </li>
      <%-- Hiển thị tối đa 5 số trang --%>
      <c:forEach begin="${Math.max(1, currentPage - 2)}" end="${Math.min(totalPages, currentPage + 2)}" var="i">
        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
          <a class="page-link" href="<c:url value='/admin/users?page=${i}&q=${q}'/>">${i}</a>
        </li>
      </c:forEach>
      <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
        <a class="page-link" href="<c:url value='/admin/users?page=${currentPage+1}&q=${q}'/>">Sau</a>
      </li>
      <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
        <a class="page-link" href="<c:url value='/admin/users?page=${totalPages}&q=${q}'/>">&raquo;</a>
      </li>
    </ul>
  </nav>
</c:if>

<jsp:include page="includes/admin-footer.jsp"/>