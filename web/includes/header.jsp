<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LuxeHome - Nội thất sang trọng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container">
    <a class="navbar-brand fw-bold" href="home"><i class="fas fa-couch"></i> LUXEHOME</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="home">Trang Chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="shop">Cửa Hàng</a></li>
      </ul>
      <div class="d-flex align-items-center">
        <a href="cart" class="btn btn-outline-dark me-2 position-relative">
            <i class="fas fa-shopping-bag"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
              ${sessionScope.cartSize}
            </span>
        </a>
        <c:if test="${sessionScope.account != null}">
          <div class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
              Chào, ${sessionScope.account.fullName}
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="orders">Đơn hàng của tôi</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="logout">Đăng xuất</a></li>
            </ul>
          </div>
        </c:if>
        <c:if test="${sessionScope.account == null}">
          <a href="login" class="btn btn-primary">Đăng nhập</a>
        </c:if>
      </div>
    </div>
  </div>
</nav>