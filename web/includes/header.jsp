<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Furni Shop - Tinh hoa nội thất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${path}/assets/css/style.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">
<header class="sticky-top bg-white shadow-sm">
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="${path}/home"><i class="fas fa-couch" style="color: var(--secondary-color);"></i> Furni Shop</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="${path}/home">Trang Chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="${path}/shop">Sản Phẩm</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <a href="${path}/cart" class="btn btn-light me-2 position-relative">
                        <i class="fas fa-shopping-bag"></i>
                        <c:if test="${not empty sessionScope.cartSize && sessionScope.cartSize > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${sessionScope.cartSize}</span>
                        </c:if>
                    </a>
                    <c:if test="${not empty sessionScope.account}">
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown"><i class="fas fa-user"></i></button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><span class="dropdown-item-text">Chào, ${sessionScope.account.fullName}</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${path}/account">Tài khoản</a></li>
                                <li><a class="dropdown-item" href="${path}/orders">Đơn hàng</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${path}/logout">Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${empty sessionScope.account}">
                        <a href="${path}/login" class="btn btn-primary">Đăng nhập</a>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>
</header>