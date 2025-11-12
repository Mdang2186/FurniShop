<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-luxe.css">
<div class="admin-header">
  <div class="header-left">
    <button id="btn-toggle-sidebar" class="btn btn-ghost">?</button>
    <div style="font-weight:700; font-size:1.05rem;">Admin Dashboard</div>
    <div class="badge">LUXE</div>
  </div>
  <div class="header-actions">
    <div style="color:var(--muted); margin-right:1rem;">Xin chào, <strong><c:out value="${sessionScope.adminName}" default="Admin"/></strong></div>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost">??ng xu?t</a>
  </div>
</div>

<script>
  document.addEventListener('click', function(e){
    if(e.target && e.target.id === 'btn-toggle-sidebar') {
      var sb = document.querySelector('.admin-sidebar');
      if(sb) sb.classList.toggle('open');
    }
  });
</script>
