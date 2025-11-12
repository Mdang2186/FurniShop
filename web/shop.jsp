<%-- Thay thế toàn bộ file: shop.jsp (Đã sửa lỗi "Vùng bị trống") --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<c:set var="pageTitle" value="Cửa hàng - LUXE INTERIORS" scope="request" />
<jsp:include page="/includes/header.jsp" />

<style>
  /* 1. CSS đồng bộ Phân trang */
  .pagination .page-link {
    color: var(--ink, #1d1a16); border: none; background: #f0f0f0;
    border-radius: 8px; margin: 0 3px; font-weight: 500; transition: all 0.2s ease;
  }
  .pagination .page-link:hover { background-color: #e9ecef; }
  .pagination .page-item.active .page-link {
    background-color: var(--gold3, #d4af37); border-color: var(--gold3, #d4af37);
    color: #fff; box-shadow: 0 4px 12px rgba(212, 175, 55, 0.3);
  }
  .pagination .page-item.disabled .page-link { color: #adb5bd; background-color: #f8f9fa; }

  /* 2. CSS cho mô tả ngắn */
  .product-description-clamp {
      display: -webkit-box; -webkit-box-orient: vertical;
      -webkit-line-clamp: 2; overflow: hidden; text-overflow: ellipsis; min-height: 40px; 
  }
  /* 3. CSS Tên thương hiệu */
  .product-brand {
    font-size: 0.8rem; font-weight: 600; color: #999;
    text-transform: uppercase; letter-spacing: 0.05em;
  }
  
  /* 4. CSS (THANH CHỨC NĂNG GỘP) */
  .brand-scroller-wrapper {
      display: flex;
      align-items: center;
      overflow: hidden; /* Ẩn phần cuộn */
  }
  .brand-scroller-top {
    display: flex;
    overflow-x: auto; /* Cho phép cuộn bằng JS */
    white-space: nowrap;
    gap: 15px;
    scroll-behavior: smooth; /* Cuộn mượt */
    scrollbar-width: none; /* Firefox */
  }
  .brand-scroller-top::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Edge */
  }
  
  .brand-item-link {
    display: inline-block;
    text-align: center;
    text-decoration: none;
    width: 80px;
    flex-shrink: 0;
  }
  .brand-item-link .logo-box {
    width: 60px; height: 60px; border-radius: 50%;
    background: #fff;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    display: grid;
    place-items: center;
    margin: 0 auto 5px auto;
    border: 2px solid transparent;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  .brand-item-link .logo-box img {
    width: 40px; height: 40px; object-fit: contain;
  }
  .brand-item-link .logo-box i {
      font-size: 1.5rem; color: #555;
  }
  .brand-item-link span {
    font-size: 0.75rem; color: #555;
    font-weight: 500;
  }
  .brand-item-link.active .logo-box {
    border-color: var(--gold3, #d4af37);
    box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
  }
  .brand-item-link.active span {
      color: var(--ink, #1d1a16);
      font-weight: 700;
  }
  
  /* Nút mũi tên cuộn */
  .scroll-btn {
      background: #fff;
      border: 1px solid #eee;
      border-radius: 50%;
      width: 36px;
      height: 36px;
      line-height: 1;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      flex-shrink: 0;
  }
  .scroll-btn:hover {
      background: #f8f9fa;
      border-color: #ddd;
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
  
</style>

<main>
  <div class="py-5" style="background: #fdfcf9;">
  <div class="container">
  
    <c:set var="pageSize"   value="${pageSize   != null ? pageSize   : 12}" />
    <c:set var="page"       value="${currentPage!= null ? currentPage : 1}" />
    <c:set var="totalPages" value="${totalPages != null ? totalPages : 1}" />
    <c:set var="totalCount" value="${totalCount != null ? totalCount : 0}" />
    <c:set var="startIndex" value="${(page-1) * pageSize + (products != null && products.size() > 0 ? 1 : 0)}" />
    <c:set var="endIndex"   value="${startIndex + (products != null ? products.size() : 0) - 1}" />

    <div class="brand-scroller-wrapper mb-4">
        <button class="btn scroll-btn me-2" id="scrollLeftBtn"><i class="fas fa-chevron-left"></i></button>
        
        <div class="brand-scroller-top" id="brandScroller">
            <a href="<c:url value='/shop?cid=${selectedCidInt}&sort=${sortByValue}&min=${minValue}&max=${maxValue}'/>" 
               class="brand-item-link <c:if test='${empty selectedBrand || selectedBrand eq "all"}'>active</c:if>">
                <div class="logo-box"><i class="fas fa-store"></i></div>
                <span>Tất cả</span>
            </a>
            <c:forEach items="${brands}" var="brand">
                <a href="<c:url value='/shop?brandName=${brand}&cid=${selectedCidInt}&sort=${sortByValue}&min=${minValue}&max=${maxValue}'/>" 
                   class="brand-item-link <c:if test='${selectedBrand eq brand}'>active</c:if>">
                    <div class="logo-box">
                        <c:set var="brandInitial" value="${fn:substring(brand, 0, 2)}"/>
                        <span class="fw-bold fs-5">${fn:toUpperCase(brandInitial)}</span>
                    </div>
                    <span>${brand}</span>
                </a>
            </c:forEach>
        </div>
        
        <button class="btn scroll-btn ms-2" id="scrollRightBtn"><i class="fas fa-chevron-right"></i></button>
    </div>

    <div class="bg-white rounded-3 shadow-sm p-3 p-md-4 mb-4">
        <form id="filterForm" action="<c:url value='/shop'/>" method="get">
            <input type="hidden" name="page" id="pageInput" value="1" />
            <input type="hidden" name="brandName" value="${selectedBrand}" />

            <div class="row g-3 align-items-center">
                
                <div class="col-lg-3 col-md-6">
                    <select name="cid" id="cid" class="form-select rounded-pill" aria-label="Lọc theo danh mục">
                      <option value="all" <c:if test="${empty selectedCid || selectedCid eq 'all'}">selected</c:if>>Tất cả danh mục</option>
                      <c:forEach items="${categories}" var="c">
                        <option value="${c.categoryID}"
                                <c:if test="${selectedCidInt == c.categoryID}">selected</c:if>>
                          ${c.categoryName}
                        </option>
                      </c:forEach>
                    </select>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <select name="sort" id="sort" class="form-select rounded-pill" aria-label="Sắp xếp theo">
                      <option value="newest"     <c:if test="${sortByValue eq 'newest' || empty sortByValue}">checked</c:if>>Sắp xếp: Mới nhất</option>
                      <option value="price-asc"  <c:if test="${sortByValue eq 'price-asc'}">checked</c:if>>Sắp xếp: Giá Thấp → Cao</option>
                      <option value="price-desc" <c:if test="${sortByValue eq 'price-desc'}">checked</c:if>>Sắp xếp: Giá Cao → Thấp</option>
                    </select>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="d-flex gap-2">
                      <input type="number" min="0" name="min" class="form-control rounded-pill" placeholder="Giá từ"
                             value="${minValue > 0 ? minValue : ''}">
                      <input type="number" min="0" name="max" class="form-control rounded-pill" placeholder="Giá đến"
                             value="${maxValue > 0 ? maxValue : ''}">
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 d-flex gap-2 justify-content-end">
                     <button type="button" id="btnReset" class="btn btn-outline-secondary rounded-pill">Xoá lọc</button>
                     <button type="submit" class="btn-luxury ripple">Áp dụng</button>
                </div>
            </div>
            
            <div class="mt-3 border-top pt-3">
                 <div class="small text-muted">
                    Hiển thị <strong>${startIndex}-${endIndex}</strong> trong <strong>${totalCount}</strong> sản phẩm
                    <c:if test="${not empty keywordValue}">
                      <span class="ms-2">• Từ khoá: “${keywordValue}”</span>
                    </c:if>
                  </div>
            </div>
        </form>
    </div>


    <div>
      <c:choose>
        <c:when test="${not empty products}">
          
          <div class="row g-4"> 
            <c:forEach items="${products}" var="p" varStatus="loop">
              
              <%-- BỐ CỤC 1 LỚN (index 0, 5, 10...) --%>
              <c:if test="${loop.index % 5 == 0}">
                  <div class="col-12 col-md-6 col-lg-6">
                      <div class="bg-transparent h-100 d-flex flex-column">
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
                          
                          <p class="product-brand mb-1">${p.brand}</p>
                          <h3 class="fw-bold mb-2" title="${p.productName}">${p.productName}</h3>
                          <p class="text-muted small mb-3 product-description-clamp">${p.description}</p>
                          
                          <%-- SỬA LỖI: Bỏ 'mt-auto' để giá nằm ngay dưới text --%>
                          <h3 class="fw-bold" style="color: var(--gold3, #d4af37);">
                              <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/>
                          </h3>
                      </div>
                  </div>
              </c:if>
              
              <%-- Mở cột chứa 4 SẢN PHẨM NHỎ (index 1) --%>
              <c:if test="${loop.index % 5 == 1}">
                  <div class="col-12 col-md-6 col-lg-6">
                      <div class="row g-4">
              </c:if>

              <%-- BỐ CỤC 4 NHỎ (index 1, 2, 3, 4) --%>
              <c:if test="${loop.index % 5 > 0}">
                  <div class="col-12 col-md-6"> 
                      <div class="bg-transparent h-100 d-flex flex-column">
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
                          
                          <p class="product-brand mb-1">${p.brand}</p>
                          <h5 class="fw-bold text-truncate mb-2" title="${p.productName}">${p.productName}</h5>
                          
                          <%-- SỬA LỖI: Bỏ <div> mt-auto --%>
                          <h5 class="fw-bold" style="color: var(--gold3, #d4af37);">
                              <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/>
                          </h5>
                      </div>
                  </div>
              </c:if>
              
              <%-- Đóng cột chứa 4 SẢN PHẨM NHỎ (index 4 hoặc cuối danh sách) --%>
              <c:if test="${loop.index % 5 == 4 || loop.last}">
                      </div> 
                  </div> 
              </c:if>
              
            </c:forEach>
          </div>

          <%-- (Phân trang) --%>
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
    
  </div> <%-- Hết .container --%>
  </div> <%-- Hết nền .py-5 --%>
  
  
  <section class="py-5 trust-badge-section">
      <div class="container">
          <div class="row g-4">
              <div class="col-md-3 col-6">
                  <div class="trust-badge">
                      <div class="badge-icon">
                          <i class="fas fa-shield-alt"></i>
                      </div>
                      <h6>Thương hiệu đảm bảo</h6>
                      <p>Nhập khẩu, bảo hành chính hãng</p>
                  </div>
              </div>
              <div class="col-md-3 col-6">
                  <div class="trust-badge">
                      <div class="badge-icon">
                          <i class="fas fa-exchange-alt"></i>
                      </div>
                      <h6>Đổi trả dễ dàng</h6>
                      <p>Theo chính sách đổi trả ưu việt</p>
                  </div>
              </div>
              <div class="col-md-3 col-6">
                  <div class="trust-badge">
                      <div class="badge-icon">
                          <i class="fas fa-truck"></i>
                      </div>
                      <h6>Giao hàng tận nơi</h6>
                      <p>Lắp đặt chuyên nghiệp toàn quốc</p>
                  </div>
              </div>
              <div class="col-md-3 col-6">
                  <div class="trust-badge">
                      <div class="badge-icon">
                           <i class="fas fa-gem"></i>
                      </div>
                      <h6>Sản phẩm chất lượng</h6>
                      <p>Đảm bảo tương thích và độ bền cao</p>
                  </div>
              </div>
          </div>
      </div>
  </section>

</main>
<%-- KẾT THÚC NỘI DUNG CHÍNH --%>

<jsp:include page="/includes/footer.jsp" />

<script>
  // Script cho Phân trang (Pagination)
  document.querySelectorAll('.pagination .page-link').forEach(a=>{
    a.addEventListener('click',e=>{
      e.preventDefault();
      const p=a.dataset.page; if(!p) return;
      document.getElementById('pageInput').value = p; // Set giá trị trang cho form
      document.getElementById('filterForm').submit();
    });
  });
  
  // Script cho nút Xóa bộ lọc (Reset)
  const btnReset=document.getElementById('btnReset');
  if(btnReset){
    // THAY ĐỔI: Khi reset, chỉ reset các trường filter, giữ lại brandName
    btnReset.addEventListener('click',()=>{
        const params = new URLSearchParams(window.location.search);
        const brand = params.get('brandName') || 'all'; // Giữ lại brand đang chọn
        window.location.href=`<c:url value="/shop"/>?brandName=${brand}`;
    });
  }
  
  /* --- SCRIPT CHO THANH CUỘN THƯƠNG HIỆU --- */
  document.addEventListener('DOMContentLoaded', function() {
      const scroller = document.getElementById('brandScroller');
      const scrollLeftBtn = document.getElementById('scrollLeftBtn');
      const scrollRightBtn = document.getElementById('scrollRightBtn');
      
      if(scroller && scrollLeftBtn && scrollRightBtn) {
          const scrollAmount = 200; // Cuộn 200px mỗi lần bấm
          
          scrollLeftBtn.addEventListener('click', () => {
              scroller.scrollLeft -= scrollAmount;
          });
          
          scrollRightBtn.addEventListener('click', () => {
              scroller.scrollLeft += scrollAmount;
          });
      }
  });
</script>