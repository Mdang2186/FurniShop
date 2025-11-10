<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<c:set var="pageTitle" value="${product != null ? product.productName : 'Chi tiết sản phẩm'} - LUXE INTERIORS" scope="request"/>
<jsp:include page="/includes/header.jsp" />

<main class="container my-5">
  <c:if test="${not empty product}">
    <nav class="mb-3 small text-muted">
      <a href="<c:url value='/home'/>" class="text-decoration-none">Trang chủ</a>
      <span class="mx-2">/</span>
      <a href="<c:url value='/shop'/>" class="text-decoration-none">Sản phẩm</a>
      <span class="mx-2">/</span>
      <span class="text-dark">${product.productName}</span>
    </nav>

    <div class="row g-4">
      <!-- LEFT: Gallery -->
      <div class="col-lg-6">
        <div class="card-luxury g-gold p-3">
          <div class="product-image-wrap shine mb-3" id="pd-main">
            <img id="mainImg"
                 src="<c:out value='${empty gallery ? product.imageURL : gallery[0]}'/>"
                 onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                 alt="${fn:escapeXml(product.productName)}"
                 style="width:100%;height:520px;object-fit:cover;border-radius:18px;">
            <div class="quick-actions">
              <a href="<c:url value='/cart?action=add&pid=${product.productID}'/>" class="qa-btn" title="Thêm vào giỏ"><i class="fas fa-cart-plus"></i></a>
            </div>
          </div>

          <div class="d-flex gap-2 flex-wrap">
            <c:forEach items="${gallery}" var="img" varStatus="st">
              <img src="${img}"
                   onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                   class="border rounded"
                   style="width:92px;height:92px;object-fit:cover;cursor:pointer"
                   data-big="${img}">
            </c:forEach>
          </div>
        </div>
      </div>

      <!-- RIGHT: Info -->
      <div class="col-lg-6">
        <div class="card-luxury g-gold p-4 h-100">
          <h1 class="h3 font-playfair mb-2">${product.productName}</h1>

          <div class="d-flex align-items-center gap-3 mb-3">
            <div class="price-tag fs-5"><fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/></div>
            <c:choose>
              <c:when test="${product.stock > 0}">
                <span class="badge text-bg-success rounded-pill">Còn hàng: ${product.stock}</span>
              </c:when>
              <c:otherwise>
                <span class="badge text-bg-secondary rounded-pill">Hết hàng</span>
              </c:otherwise>
            </c:choose>
          </div>

          <ul class="list-unstyled small text-muted mb-3">
            <c:if test="${not empty product.brand}"><li><strong>Thương hiệu:</strong> ${product.brand}</li></c:if>
            <c:if test="${not empty product.material}"><li><strong>Chất liệu:</strong> ${product.material}</li></c:if>
            <c:if test="${not empty product.dimensions}"><li><strong>Kích thước:</strong> ${product.dimensions}</li></c:if>
          </ul>

          <p class="text-secondary">${product.description}</p>

          <c:if test="${not empty product.features}">
            <div class="mb-3">
              <div class="fw-semibold mb-2">Nổi bật</div>
              <ul class="small text-secondary ps-3">
                <c:forEach items="${fn:split(product.features, ',')}" var="f">
                  <li>${fn:trim(f)}</li>
                </c:forEach>
              </ul>
            </div>
          </c:if>

          <form action="<c:url value='/cart'/>" method="post" class="mt-auto">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="pid" value="${product.productID}">
            <div class="d-flex align-items-center gap-3 mb-3">
              <label class="small text-muted">Số lượng</label>
              <input type="number" name="quantity" min="1" value="1"
                     class="form-control rounded-pill" style="width:120px"
                     <c:if test="${product.stock <= 0}">disabled</c:if>>
            </div>

            <div class="d-flex gap-3">
              <button type="submit" class="btn-luxury ripple flex-grow-1"
                      <c:if test="${product.stock <= 0}">disabled</c:if>>
                Thêm vào giỏ
              </button>
              <a href="<c:url value='/cart?action=add&pid=${product.productID}&quantity=1'/>"
                 class="btn btn-outline-secondary rounded-pill px-4 py-3">
                Mua ngay
              </a>
            </div>
          </form>

          <div class="mt-3 small text-muted">
            <i class="fa-solid fa-shield-heart me-1"></i> Bảo hành 24 tháng
            • <i class="fa-solid fa-rotate me-1"></i> Đổi trả 7 ngày
            • <i class="fa-solid fa-truck-fast me-1"></i> Giao nhanh 48h
          </div>
        </div>
      </div>
    </div>

    <!-- Related -->
    <c:if test="${not empty related}">
      <section class="mt-5">
        <h3 class="h4 font-playfair mb-3">Sản phẩm liên quan</h3>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
          <c:forEach items="${related}" var="p">
            <div class="col">
              <div class="card-luxury g-hover g-gold p-3 h-100">
                <div class="product-image-wrap shine mb-2">
                  <a href="<c:url value='/product-detail?pid=${p.productID}'/>" class="d-block rounded-4 overflow-hidden">
                    <img src="${p.imageURL}"
                         onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                         alt="${fn:escapeXml(p.productName)}" class="product-image">
                  </a>
                  <div class="quick-actions">
                    <a href="<c:url value='/product-detail?pid=${p.productID}'/>" class="qa-btn" title="Xem"><i class="fas fa-eye"></i></a>
                    <a href="<c:url value='/cart?action=add&pid=${p.productID}'/>" class="qa-btn" title="Giỏ"><i class="fas fa-cart-plus"></i></a>
                  </div>
                </div>
                <div class="fw-semibold text-truncate mb-1" title="${p.productName}">${p.productName}</div>
                <div class="d-flex align-items-center justify-content-between">
                  <div class="price-tag"><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>
      </section>
    </c:if>
  </c:if>
</main>

<jsp:include page="/includes/footer.jsp" />

<script>
  // đổi ảnh khi click thumbnail
  document.querySelectorAll('[data-big]').forEach(img=>{
    img.addEventListener('click', ()=>{
      const big = img.getAttribute('data-big');
      const main = document.getElementById('mainImg');
      main.src = big;
    });
  });
</script>
