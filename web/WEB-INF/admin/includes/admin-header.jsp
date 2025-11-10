<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html><html lang="vi"><head>
<meta charset="utf-8"/><meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Admin · Luxe Interiors</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet"/>
<link href="${path}/assets/css/admin-luxe.css" rel="stylesheet"/>
</head><body class="admin">
<nav class="navbar navbar-dark" style="background:#0f0e0d; border-bottom:1px solid rgba(212,175,55,.18)">
  <div class="container-fluid">
    <span class="navbar-brand sidebar-brand"><i class="fa-solid fa-crown me-2"></i>ADMIN</span>
    <div class="d-flex align-items-center gap-3">
      <span class="text-muted small d-none d-md-inline">Xin chào, ${sessionScope.account.fullName}</span>
      <a class="btn btn-dark btn-sm" href="${path}/home"><i class="fa-solid fa-store me-1"></i> Store</a>
      <a class="btn btn-gold btn-sm" href="${path}/logout"><i class="fa-solid fa-right-from-bracket"></i></a>
    </div>
  </div>
</nav>
<div class="container-fluid">
  <div class="row">
