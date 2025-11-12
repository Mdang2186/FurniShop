<%-- Thay thế toàn bộ file: includes/header.jsp (Đã thay logo) --%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <c:set var="pageTitle" value="${empty pageTitle ? 'LUXE INTERIORS - Tinh hoa Nội thất' : pageTitle}" scope="request"/>
        <title>${pageTitle}</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Cormorant+Garamond:wght@300;400;600&family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet"/>
        <link href="${path}/assets/css/luxe-style.css" rel="stylesheet">
        
        <%-- CSS ĐỒNG BỘ HEADER VỚI FOOTER.LUXE --%>
      <style>
            /* 1. Biến màu từ footer.jsp */
            :root {
                --ink: #1d1a16; --bg: #0e0d0c; --muted: #9c9aa0;
                --gold1: #f7e7a1; --gold2: #f1c40f; --gold3: #d4af37; --gold4: #b68d16;
                --ring: rgba(212,175,55,.22);
            }
            
            /* 2. Nền (background) của footer cho header */
            .header-luxe {
                color: #e9e7a4;
                background: radial-gradient(1200px 800px at 15% -10%, rgba(212,175,55,.10), transparent 55%), #0b0a09;
                border-bottom: 1px solid rgba(255, 255, 255, .06);
            }

            /* 3. Link (navbar-dark overrides) */
            .navbar-dark .navbar-brand,
            .navbar-dark .nav-link {
                color: #e9e7a4;
                transition: color 0.2s ease;
            }
            .navbar-dark .navbar-brand:hover,
            .navbar-dark .nav-link:hover,
            .navbar-dark .nav-link:focus {
                color: var(--gold1);
            }
            .navbar-dark .navbar-toggler {
                border-color: rgba(255,255,255,.12);
            }

            /* 4. Ô tìm kiếm (style của .cta-input) */
            .form-control-luxe {
                background: #111;
                color: #eee;
                border: 1px solid rgba(255, 255, 255, .08);
                outline: none;
                transition: all 0.2s ease;
            }
            .form-control-luxe::placeholder {
                color: var(--muted);
            }
            .form-control-luxe:focus {
                background: #111;
                color: #eee;
                border-color: var(--gold3);
                box-shadow: 0 0 0 3px var(--ring);
            }
            
            /* 5. Nút viền sáng (style của .socials a) */
            .btn-outline-luxe {
                background: rgba(255, 255, 255, .06);
                border: 1px solid rgba(255, 255, 255, .12);
                color: #e9e7a4;
                transition: all 0.2s ease;
                border-radius: 999px;
            }
            
            .btn-outline-luxe:hover,
            .btn-outline-luxe:focus {
                background: linear-gradient(135deg, var(--gold2), var(--gold3));
                color: #1b1304;
                transform: translateY(-1px);
            }
            
  /* 5. CSS (TRUST BADGES) */
  .trust-badge-section { background-color: #f8f9fa; }
  .trust-badge { text-align: center; }
  .trust-badge .badge-icon {
      width: 70px; height: 70px;
      margin: 0 auto 1rem auto;
      border-radius: 50%;
      background: #fff;
      display: grid;
      place-items: center;
      box-shadow: 0 4px 15px rgba(0,0,0,0.05);
      font-size: 1.75rem;
      color: var(--gold3, #d4af37);
  }
  .trust-badge h6 {
      font-weight: 700; color: var(--ink, #1d1a16);
  }
  .trust-badge p { font-size: 0.9rem; color: #6c757d; }
  
            /* =================================================
              CSS MỚI: TÙY CHỈNH LOGO SVG
              =================================================
            */
            .navbar-brand-logo-svg {
                height: 38px; /* Tăng kích thước logo */
                width: auto;
            }
            .navbar-brand {
                padding-top: 0.5rem; /* Căn chỉnh lại padding cho cân đối */
                padding-bottom: 0.5rem;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">

        <header class="sticky-top header-luxe shadow-sm">
            <nav class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <%-- 
                      =================================================
                      THAY ĐỔI: Thay icon 'fa-couch' bằng logo 'image_e7725f.png'
                      =================================================
                    --%>
                    <a class="navbar-brand" href="${path}/home">
                        <%-- 
                          LƯU Ý: Hãy thay đổi đường dẫn này 
                          cho đúng với vị trí file name.svg của bạn 
                        --%>
                        <img src="${path}/assets/images/logo/name.svg" alt="LUXE INTERIORS" class="navbar-brand-logo-svg">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav mx-auto">
    
                            <li class="nav-item"><a class="nav-link" href="${path}/home">Trang Chủ</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path}/shop">Sản Phẩm</a></li>
                            <li class="nav-item"><a class="nav-link" href="${path}/contact">Liên Hệ</a></li>
                        </ul>
                        
                       
                         <form class="d-flex me-3" action="${path}/shop" method="get" role="search">
                            <input class="form-control form-control-luxe me-2 rounded-pill" type="search" name="keyword" value="${keywordValue}" placeholder="Tìm sản phẩm..." aria-label="Search">
                            <button class="btn btn-outline-luxe rounded-pill" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                         </form>
                        
                        <div class="d-flex align-items-center gap-3">
             
                            <a href="${path}/cart" class="btn btn-outline-luxe position-relative">
                                <i class="fas fa-shopping-bag"></i>
                                <c:if test="${not empty sessionScope.cartSize && sessionScope.cartSize > 0}">
                                    <span data-cart-badge class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                         ${sessionScope.cartSize}
                                    </span>
                                </c:if>
                                <c:if test="${empty sessionScope.cartSize || sessionScope.cartSize == 0}">
                                    <span data-cart-badge class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger d-none">0</span>
                                </c:if>
                             </a>

                            <c:if test="${not empty sessionScope.account}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-luxe dropdown-toggle" type="button" data-bs-toggle="dropdown"><i class="fas fa-user"></i></button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><span class="dropdown-item-text">${sessionScope.account.fullName}</span></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${path}/account">Tài khoản</a></li>
                                        <li><a class="dropdown-item" href="${path}/orders">Đơn hàng</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="${path}/logout">Đăng xuất</a></li>
                                    </ul>
                                </div>
                            </c:if>
                            
                            
                            <c:if test="${empty sessionScope.account}">
                                <a href="${path}/register" class="btn btn-outline-luxe btn-sm" style="padding: 0.5rem 1rem;">Đăng kí</a>
                                <a href="${path}/login" class="btn-luxury ripple btn-sm" style="padding: 0.5rem 1rem;">Đăng nhập</a>
                            </c:if>
                         </div>
                    </div>
                </div>
            </nav>
        </header>