<%-- Thay thế toàn bộ file: home.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<%-- Đặt tiêu đề động cho trang --%>
<c:set var="pageTitle" value="Trang chủ - LUXE INTERIORS" scope="request" />

<%-- Gọi file Header (đã chứa CSS Luxe, Fonts, Menu...) --%>
<jsp:include page="includes/header.jsp" />

<%-- BẮT ĐẦU NỘI DUNG CHÍNH CỦA TRANG (THEME LUXE SÁNG) --%>
<main>

    <section class="position-relative d-flex align-items-center" style="min-height:92vh;">
        <img src="https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=2000&q=80"
             alt="Luxury Interior" class="position-absolute w-100 h-100" style="object-fit:cover;">
        <div class="hero-overlay position-absolute w-100 h-100"></div>

        <div class="container position-relative text-center text-white scroll-reveal">
            <p class="opacity-75 mb-3 font-inter" style="letter-spacing:.3em">LUXURY • ELEGANCE • SOPHISTICATION</p>
            <h1 class="hero-title font-playfair mb-4">
                LUXE <span class="d-block text-luxury-gold fw-medium">COLLECTION</span>
                <span class="d-block fs-3 font-cormorant text-warning mt-3">2025</span>
            </h1>
            <p class="fs-5 font-cormorant mx-auto mb-4" style="max-width:740px">
                Khám phá bộ sưu tập nội thất cao cấp được tuyển chọn, mang đến không gian sống đẳng cấp với chất lượng hoàn hảo.
            </p>
            <div class="d-flex flex-column flex-sm-row gap-3 justify-content-center">
                <a href="<c:url value='/shop'/>" class="btn-luxury ripple">Khám phá bộ sưu tập</a>
                <a href="<c:url value='/shop'/>" class="btn btn-outline-light rounded-pill px-4 py-3">Xem catalog 2025</a>
            </div>
        </div>
    </section>

    <section class="py-5" style="background: #fdfcf9;">
        <div class="container">
            <div class="row g-4">
                <div class="col-6 col-md-3 scroll-reveal"><div class="stats-card"><div class="h2 text-luxury-gold mb-2 font-playfair">15+</div><div class="text-muted text-uppercase small fw-semibold">Năm kinh nghiệm</div></div></div>
                <div class="col-6 col-md-3 scroll-reveal" style="transition-delay: 0.1s;"><div class="stats-card"><div class="h2 text-luxury-gold mb-2 font-playfair">2,500+</div><div class="text-muted text-uppercase small fw-semibold">Dự án hoàn thành</div></div></div>
                <div class="col-6 col-md-3 scroll-reveal" style="transition-delay: 0.2s;"><div class="stats-card"><div class="h2 text-luxury-gold mb-2 font-playfair">150+</div><div class="text-muted text-uppercase small fw-semibold">Thương hiệu đối tác</div></div></div>
                <div class="col-6 col-md-3 scroll-reveal" style="transition-delay: 0.3s;"><div class="stats-card"><div class="h2 text-luxury-gold mb-2 font-playfair">99%</div><div class="text-muted text-uppercase small fw-semibold">Khách hàng hài lòng</div></div></div>
            </div>
        </div>
    </section>

    <c:if test="${not empty bestSellersEx}">
        <section class="py-5" style="background: #fdfcf9;">
            <div class="container">
                <div class="text-center mb-4 scroll-reveal">
                    <p class="text-muted small text-uppercase mb-2">Sản phẩm bán chạy</p>
                    <h2 class="h1 font-playfair">Bộ sưu tập <span class="text-luxury-gold">Bán chạy nhất</span></h2>
                </div>

                <div class="row row-cols-2 row-cols-lg-4 g-3">
                    <c:forEach var="it" items="${bestSellersEx}" varStatus="loop">
                        <c:set var="p" value="${it.product}"/>
                        <div class="col scroll-reveal" style="transition-delay: ${loop.index * 0.1}s;">
                            <div class="card-luxury g-hover g-gold p-3 h-100">
                                <div class="product-image-wrap shine mb-2">
                                    <span class="ribbon">Bán chạy</span>
                                    <a href="<c:url value='/product-detail?pid=${p.productID}'/>" class="d-block ratio ratio-1x1">
                                        <img src="${p.imageURL}" alt="${p.productName}"
                                             onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                                             class="product-image"/>
                                    </a>
                                    <div class="quick-actions">
                                        <a href="<c:url value='/product-detail?pid=${p.productID}'/>" class="qa-btn" title="Xem nhanh"><i class="fas fa-eye"></i></a>
                                        <a href="<c:url value='/cart?action=add&pid=${p.productID}'/>" class="qa-btn" title="Thêm vào giỏ"><i class="fas fa-cart-plus"></i></a>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center gap-2 mb-1">
                                    <span class="badge bg-warning text-dark">Đã bán ${it.sold}</span>
                                </div>
                                <h6 class="fw-semibold text-truncate mb-1" title="${p.productName}">${p.productName}</h6>
                                <div class="d-flex align-items-center justify-content-between mt-2">
                                    <div class="price-tag"><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></div>
                                </div>
                                <a href="<c:url value='/cart?action=add&pid=${p.productID}'/>" class="btn-luxury ripple mt-2 w-100">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <c:if test="${not empty specialProduct}">
        <section class="py-5 bg-white">
            <div class="container">
                <div class="text-center mb-4 scroll-reveal">
                    <p class="text-muted small text-uppercase mb-2">Sản phẩm đặc biệt</p>
                    <h2 class="h1 font-playfair">Tác phẩm <span class="text-luxury-gold">nghệ thuật</span></h2>
                </div>
                <div class="row g-4 align-items-center">
                    <div class="col-lg-6 scroll-reveal">
                        <div class="position-relative">
                            <img src="${specialProduct.imageURL}"
                                 onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                                 alt="${fn:escapeXml(specialProduct.productName)}"
                                 class="w-100 rounded-4 shadow" style="height:500px;object-fit:cover">
                            <span class="special-badge position-absolute top-0 start-0 m-3">Limited Edition</span>
                        </div>
                    </div>
                    <div class="col-lg-6 scroll-reveal" style="transition-delay: 0.2s;">
                        <p class="text-uppercase small text-muted mb-2">Độc quyền • Phiên bản giới hạn</p>
                        <h3 class="h2 font-playfair mb-3">${specialProduct.productName}</h3>
                        <p class="text-secondary mb-4">${specialProduct.description}</p>
                        
                        <div class="d-flex align-items-center justify-content-between border-top pt-3">
                            <div class="price-tag"><fmt:formatNumber value="${specialProduct.price}" type="currency" currencyCode="VND"/></div>
                        </div>
                        <div class="d-flex gap-3 mt-3">
                            <a class="btn-luxury ripple flex-grow-1" href="<c:url value='/product-detail?pid=${specialProduct.productID}'/>">Xem chi tiết</a>
                            <form action="<c:url value='/cart'/>" method="post" class="flex-grow-1">
                                <input type="hidden" name="action" value="add"/>
                                <input type="hidden" name="pid" value="${specialProduct.productID}"/>
                                <input type="hidden" name="quantity" value="1"/>
                                <button type="submit" class="btn btn-outline-secondary rounded-pill w-100 py-3">Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </c:if>

    <section class="py-5" style="background: #fdfcf9;">
        <div class="container">
            <div class="text-center mb-4 scroll-reveal">
                <p class="text-muted small text-uppercase mb-2">Sản phẩm nổi bật</p>
                <h2 class="h1 font-playfair">Bộ sưu tập <span class="text-luxury-gold">mới về</span></h2>
            </div>
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="row g-4" id="productsGrid">
                        <c:forEach items="${products}" var="p" varStatus="st" begin="0" end="5">
                            <div class="col-12 col-md-6 col-lg-4 scroll-reveal" style="transition-delay: ${st.index * 0.1}s;">
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
                                    <p class="text-secondary small mb-3" style="min-height: 48px; max-height:48px; overflow:hidden">${p.description}</p>
                                    <div class="d-flex align-items-center justify-content-between mt-auto">
                                        <div class="price-tag"><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/></div>
                                    </div>
                                    <a class="btn-luxury ripple mt-3 w-100" href="<c:url value='/product-detail?pid=${p.productID}'/>">Xem chi tiết</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-center mt-4 scroll-reveal">
                        <a href="<c:url value='/shop'/>" class="btn btn-outline-secondary rounded-pill px-4 py-3">Xem tất cả sản phẩm</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 scroll-reveal">
                        <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                        <p class="mb-0 text-muted">Chưa có sản phẩm để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <section class="py-5 bg-white">
        <div class="container">
            <div class="text-center mb-4 scroll-reveal">
                <p class="text-muted small text-uppercase mb-2">Khách hàng nói gì</p>
                <h2 class="h1 font-playfair">Đánh giá <span class="text-luxury-gold">5 sao</span></h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4 scroll-reveal">
                    <div class="testimonial-card">
                        <div class="text-warning mb-2">★★★★★</div>
                        <p class="text-secondary fst-italic">"Chất lượng vượt mong đợi. Đội ngũ lắp đặt cực kỳ chuyên nghiệp."</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" class="rounded-circle me-3" width="48" height="48" />
                            <div><div class="fw-semibold">Anh Minh Tuấn</div><div class="small text-muted">CEO, ABC</div></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 scroll-reveal" style="transition-delay: 0.1s;">
                    <div class="testimonial-card">
                        <div class="text-warning mb-2">★★★★★</div>
                        <p class="text-secondary fst-italic">"Thiết kế đẹp, phù hợp không gian gia đình. Dịch vụ tuyệt vời."</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://randomuser.me/api/portraits/women/44.jpg" class="rounded-circle me-3" width="48" height="48" />
                            <div><div class="fw-semibold">Chị Lan Anh</div><div class="small text-muted">Kiến trúc sư</div></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 scroll-reveal" style="transition-delay: 0.2s;">
                    <div class="testimonial-card">
                        <div class="text-warning mb-2">★★★★★</div>
                        <p class="text-secondary fst-italic">"Luxe Interiors biến ước mơ về ngôi nhà lý tưởng thành hiện thực."</p>
                        <div class="d-flex align-items-center mt-3">
                            <img src="https://randomuser.me/api/portraits/men/75.jpg" class="rounded-circle me-3" width="48" height="48" />
                            <div><div class="fw-semibold">Anh Hoàng Nam</div><div class="small text-muted">Doanh nhân</div></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="contact" class="py-5" style="background: #fdfcf9;">
        <div class="container">
            <div class="text-center mb-4 scroll-reveal">
                <p class="text-muted small text-uppercase mb-2">Liên hệ tư vấn</p>
                <h2 class="h1 font-playfair">Bắt đầu <span class="text-luxury-gold">hành trình</span></h2>
            </div>
            <div class="card-luxury g-gold p-4 p-md-5 col-lg-8 mx-auto scroll-reveal">
                <%-- Form này sẽ POST đến ContactController --%>
                <form action="<c:url value='/contact'/>" method="post" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold">Họ và tên *</label>
                        <input name="fullName" required class="form-control form-control-lg rounded-4"/>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold">Số điện thoại *</label>
                        <input name="phone" required class="form-control form-control-lg rounded-4"/>
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Email *</label>
                        <input name="email" type="email" required class="form-control form-control-lg rounded-4"/>
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Chủ đề *</label>
                        <input name="subject" type="text" required class="form-control form-control-lg rounded-4"/>
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Nhu cầu tư vấn *</Mlabel>
                        <textarea name="message" rows="4" required class="form-control rounded-4"></textarea>
                    </div>
                    <div class="col-12">
                        <button class="btn-luxury ripple w-100 py-3" type="submit">Gửi yêu cầu tư vấn</button>
                    </div>
                </form>
            </div>
        </div>
    </section>

</main>
<%-- KẾT THÚC NỘI DUNG CHÍNH --%>

<%-- Gọi file Footer (sẽ chứa JS và nội dung footer) --%>
<jsp:include page="includes/footer.jsp"/>