<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<c:set var="pageTitle" value="Cửa hàng - LUXE INTERIORS" scope="request" />
<jsp:include page="/includes/header.jsp" />

<main class="container my-5">
  <!-- các biến phân trang -->
  <c:set var="pageSize"   value="${pageSize   != null ? pageSize   : 12}" />
  <c:set var="page"       value="${currentPage!= null ? currentPage : 1}" />
  <c:set var="totalPages" value="${totalPages != null ? totalPages : 1}" />
  <c:set var="totalCount" value="${totalCount != null ? totalCount : 0}" />
  <c:set var="startIndex" value="${(page-1) * pageSize + (products != null && products.size() > 0 ? 1 : 0)}" />
  <c:set var="endIndex"   value="${startIndex + (products != null ? products.size() : 0) - 1}" />

  <div class="row g-4">
    <!-- BỘ LỌC -->
    <div class="col-lg-3">
      <div class="card-luxury p-3 sticky-top" style="top:84px;">
        <div class="card-header bg-transparent border-0">
          <h5 class="font-playfair m-0"><i class="fas fa-filter me-2" style="color:var(--gold4)"></i> Bộ lọc</h5>
        </div>
        <div class="card-body">
          <form id="filterForm" action="<c:url value='/shop'/>" method="get">
            <input type="hidden" name="page" id="pageInput" value="${page}" />

            <div class="mb-4">
              <label for="keyword" class="form-label fw-semibold">Tìm kiếm</label>
              <input type="text" name="keyword" id="keyword" class="form-control rounded-pill"
                     value="${keywordValue}" placeholder="Tên sản phẩm...">
            </div>

            <div class="mb-4">
              <label for="cid" class="form-label fw-semibold">Danh mục</label>
              <select name="cid" id="cid" class="form-select rounded-pill">
                <option value="all" <c:if test="${empty selectedCid || selectedCid eq 'all'}">selected</c:if>>Tất cả danh mục</option>
                <c:forEach items="${categories}" var="c">
                  <option value="${c.categoryID}"
                          <c:if test="${selectedCidInt == c.categoryID}">selected</c:if>>
                    ${c.categoryName}
                  </option>
                </c:forEach>
              </select>
            </div>

            <div class="mb-4">
              <label class="form-label fw-semibold">Khoảng giá (₫)</label>
              <div class="d-flex gap-2">
                <input type="number" min="0" name="min" class="form-control rounded-pill" placeholder="Từ"
                       value="${minValue > 0 ? minValue : ''}">
                <input type="number" min="0" name="max" class="form-control rounded-pill" placeholder="Đến"
                       value="${maxValue > 0 ? maxValue : ''}">
              </div>
            </div>

            <div class="mb-4">
              <label for="sort" class="form-label fw-semibold">Sắp xếp</label>
              <select name="sort" id="sort" class="form-select rounded-pill">
                <option value="newest"     <c:if test="${sortByValue eq 'newest'}">selected</c:if>>Mới nhất</option>
                <option value="price-asc"  <c:if test="${sortByValue eq 'price-asc'}">selected</c:if>>Giá: Thấp → Cao</option>
                <option value="price-desc" <c:if test="${sortByValue eq 'price-desc'}">selected</c:if>>Giá: Cao → Thấp</option>
              </select>
            </div>

            <div class="d-grid gap-2">
              <button type="submit" class="btn-luxury ripple w-100">ÁP DỤNG</button>
              <button type="button" id="btnReset" class="btn btn-outline-secondary rounded-pill w-100">Xoá bộ lọc</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- KHU VỰC SẢN PHẨM -->
    <div class="col-lg-9">
      <!-- SỬA 1 DÒNG NÀY: thêm h-auto để không bị “cao vô cực” -->
      <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 p-3 card-luxury h-auto">
        <div class="small text-muted">
          Hiển thị <strong>${startIndex}-${endIndex}</strong> trong <strong>${totalCount}</strong> sản phẩm
          <c:if test="${not empty keywordValue}">
            <span class="ms-2">• Từ khoá: “${keywordValue}”</span>
          </c:if>
        </div>
        <div>
          <a href="<c:url value='/home'/>" class="btn btn-sm btn-outline-secondary rounded-pill">Trang chủ</a>
        </div>
      </div>

      <c:choose>
        <c:when test="${not empty products}">
          <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
            <c:forEach items="${products}" var="p">
              <div class="col">
                <div class="card-luxury g-hover g-gold p-3 h-100">
                  <div class="product-image-wrap shine mb-3">
                    <a href="<c:url value='/product-detail?pid=${p.productID}'/>" class="d-block rounded-4 overflow-hidden">
                      <img src="${p.imageURL}" alt="${fn:escapeXml(p.productName)}"
                           onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                           class="product-image">
                    </a>
                   <div class="quick-actions">
  <a href="<c:url value='/product-detail?pid=${p.productID}'/>" class="qa-btn" title="Xem nhanh">
    <i class="fas fa-eye"></i>
  </a>
  <a href="<c:url value='/cart?action=add&pid=${p.productID}'/>" class="qa-btn" title="Thêm vào giỏ">
    <i class="fas fa-cart-plus"></i>
  </a>
</div>

                  </div>
                  <h3 class="h5 font-playfair mb-1 text-truncate" title="${p.productName}">${p.productName}</h3>
                  <div class="d-flex align-items-center justify-content-between mt-auto">
                    <div class="price-tag"><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></div>
                  </div>
                  <a class="btn-luxury ripple mt-3 w-100" href="<c:url value='/product-detail?pid=${p.productID}'/>">Xem chi tiết</a>
                </div>
              </div>
            </c:forEach>
          </div>

          <c:if test="${totalPages > 1}">
            <nav aria-label="Pagination" class="mt-4">
              <ul class="pagination justify-content-center gap-1">
                <li class="page-item <c:if test='${page == 1}'>disabled</c:if>">
                  <a class="page-link" href="#" data-page="1">&laquo;</a>
                </li>
                <li class="page-item <c:if test='${page == 1}'>disabled</c:if>">
                  <a class="page-link" href="#" data-page="${page-1}">Trước</a>
                </li>
                <c:forEach begin="${page-2 > 1 ? page-2 : 1}" end="${page+2 < totalPages ? page+2 : totalPages}" var="i">
                  <li class="page-item <c:if test='${i == page}'>active</c:if>">
                    <a class="page-link" href="#" data-page="${i}">${i}</a>
                  </li>
                </c:forEach>
                <li class="page-item <c:if test='${page == totalPages}'>disabled</c:if>">
                  <a class="page-link" href="#" data-page="${page+1}">Sau</a>
                </li>
                <li class="page-item <c:if test='${page == totalPages}'>disabled</c:if>">
                  <a class="page-link" href="#" data-page="${totalPages}">&raquo;</a>
                </li>
              </ul>
            </nav>
          </c:if>
        </c:when>
        <c:otherwise>
          <div class="text-center py-5 card-luxury">
            <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
            <h3 class="mb-2">Không tìm thấy sản phẩm nào</h3>
            <p class="text-muted">Thử từ khoá khác hoặc xoá bớt điều kiện lọc.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</main>

<jsp:include page="/includes/footer.jsp" />

<!-- JS nhỏ để phân trang & reset -->
<script>
  document.querySelectorAll('.pagination .page-link').forEach(a=>{
    a.addEventListener('click',e=>{
      e.preventDefault();
      const p=a.dataset.page; if(!p) return;
      document.getElementById('pageInput').value=p;
      document.getElementById('filterForm').submit();
    });
  });
  const btnReset=document.getElementById('btnReset');
  if(btnReset){
    btnReset.addEventListener('click',()=>{ window.location.href='<c:url value="/shop"/>'; });
  }
</script>
