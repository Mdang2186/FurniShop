<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="includes/admin-header.jsp"/>
<jsp:include page="includes/admin-sidebar.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="luxe-title m-0">Người dùng</h4>
  <form class="d-flex gap-2">
    <input class="form-control form-dark" name="q" value="${q}" placeholder="Tìm tên hoặc email"/>
    <button class="btn btn-dark">Tìm</button>
  </form>
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
          <form method="post" action="${pageContext.request.contextPath}/admin/users" class="d-inline">
            <input type="hidden" name="action" value="role"/>
            <input type="hidden" name="id" value="${u.userID}"/>
            <input type="hidden" name="role" value="${u.role=='Admin'?'Customer':'Admin'}"/>
            <button class="btn btn-dark btn-sm"><i class="fa-solid fa-user-gear me-1"></i> Set ${u.role=='Admin'?'Customer':'Admin'}</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<jsp:include page="includes/admin-footer.jsp"/>
