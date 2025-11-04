<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <div class="row g-4">
        <div class="col-lg-3">
            <div class="card sticky-top" style="top: 80px;">
                <div class="card-header fw-bold">
                    <i class="fas fa-filter me-2"></i>Bộ lọc
                </div>
                <div class="card-body">
                    <form action="shop" method="get">
                        <div class="mb-4">
                            <label for="keyword" class="form-label fw-bold">Tìm kiếm</label>
                            <input type="text" name="keyword" id="keyword" class="form-control" value="${keywordValue}" placeholder="Tên sản phẩm...">
                        </div>
                        
                
                        <div class="mb-4">
                            <label for="cid" class="form-label fw-bold">Danh mục</label>
                            <select name="cid" id="cid" class="form-select">
                                <option value="all" ${empty selectedCid || selectedCid eq 'all' ? 'selected' : ''}>Tất cả danh mục</option>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryID}" ${selectedCid eq c.categoryID ? 'selected' : ''}>${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
              
                        
                        <div class="mb-4">
                            <label for="sort" class="form-label fw-bold">Sắp xếp theo</label>
                            <select name="sort" id="sort" class="form-select">
                                <option value="newest" ${sortByValue eq 'newest' ? 'selected' : ''}>Mới nhất</option>
                                <option value="price-asc" ${sortByValue eq 'price-asc' ? 'selected' : ''}>Giá: Thấp đến cao</option>
                                <option value="price-desc" ${sortByValue eq 'price-desc' ? 'selected' : ''}>Giá: Cao đến thấp</option>
                            </select>
                        </div>
                        
                   
                        <button type="submit" class="btn btn-primary w-100">Áp dụng</button>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-3 p-3 bg-white rounded border">
                <span class="fw-bold">Hiển thị ${products.size()} sản phẩm</span>
            </div>
            
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
                        <c:forEach items="${products}" var="p">
                            <div class="col">
                                <div class="card card-product h-100 overflow-hidden">
                                    <a href="product-detail?pid=${p.productID}" class="overflow-hidden">
                                        <img src="${p.imageURL}" class="card-img-top product-card-img" alt="${p.productName}">
                                    </a>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title fw-normal fs-6">${p.productName}</h5>
                                        <p class="card-text text-danger fs-5 fw-bold mt-auto">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/>
                                        </p>
                                    </div>
                                    <div class="card-footer bg-white border-0 p-3 pt-0">
                                        <a href="product-detail?pid=${p.productID}" class="btn btn-outline-primary w-100">Xem chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                        <h3 class="mb-3">Không tìm thấy sản phẩm nào</h3>
                        <p class="text-muted">Vui lòng thử lại với từ khóa hoặc bộ lọc khác.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <%-- =================================== --%>
            <%-- BẮT ĐẦU KHỐI MÃ PHÂN TRANG MỚI --%>
            <%-- =================================== --%>
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" class="mt-5">
                    <ul class="pagination justify-content-center">
                        
                        <%-- Nút Lùi (Previous) --%>
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <li class="page-item">
                                    <%-- Quan trọng: Giữ lại các tham số lọc khi chuyển trang --%>
                                    <a class="page-link" href="shop?page=${currentPage - 1}&keyword=${keywordValue}&cid=${selectedCid}&sort=${sortByValue}">Trước</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item disabled">
                                    <a class="page-link" href="#">Trước</a>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <%-- Các nút số trang --%>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="shop?page=${i}&keyword=${keywordValue}&cid=${selectedCid}&sort=${sortByValue}">${i}</a>
                            </li>
                        </c:forEach>

                        <%-- Nút Tới (Next) --%>
                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="shop?page=${currentPage + 1}&keyword=${keywordValue}&cid=${selectedCid}&sort=${sortByValue}">Tiếp</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item disabled">
                                    <a class="page-link" href="#">Tiếp</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        
                    </ul>
                </nav>
            </c:if>
            <%-- =================================== --%>
            <%-- KẾT THÚC KHỐI MÃ PHÂN TRANG --%>
            <%-- =================================== --%>

        </div>
    </div>
</main>
<jsp:include page="includes/footer.jsp" />