<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <c:if test="${not empty product}">
        <div class="row g-5">
            <div class="col-md-7">
                <img src="${product.imageUrls[0]}" class="img-fluid rounded shadow-sm detail-img-main" id="mainImage" alt="${product.productName}">
                <div class="row mt-3 g-2">
                    <c:forEach items="${product.imageUrls}" var="imgUrl">
                        <div class="col-3">
                            <img src="${imgUrl}" class="detail-img-thumbnail" onclick="changeImage(this)">
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="col-md-5">
                <h1 class="display-5 fw-bold">${product.productName}</h1>
                <p class="text-muted">Thương hiệu: ${product.brand}</p>
                <h2 class="my-3" style="color: var(--secondary-color); font-weight: 700;">
                    <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                </h2>
                
                <div class="accordion" id="productDetailsAccordion">
                    <div class="accordion-item">
                        <h2 class="accordion-header"><button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDesc">Mô tả sản phẩm</button></h2>
                        <div id="collapseDesc" class="accordion-collapse collapse show" data-bs-parent="#productDetailsAccordion">
                            <div class="accordion-body">${product.description}</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSpecs">Thông số kỹ thuật</button></h2>
                        <div id="collapseSpecs" class="accordion-collapse collapse" data-bs-parent="#productDetailsAccordion">
                            <div class="accordion-body">
                                <ul class="list-unstyled">
                                    <li><strong>Chất liệu:</strong> ${product.material}</li>
                                    <li><strong>Kích thước:</strong> ${product.dimensions}</li>
                                    <li><strong>Tính năng:</strong> ${product.features}</li>
                                    <li><strong>Tình trạng:</strong> <span class="badge ${product.stock > 0 ? 'bg-success' : 'bg-danger'}">${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}</span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <form action="cart" method="post" class="mt-4">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="pid" value="${product.productID}">
                    <div class="input-group mb-3" style="max-width: 200px;">
                        <span class="input-group-text">Số lượng</span>
                        <input type="number" name="quantity" class="form-control text-center" value="1" min="1">
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg w-100" ${product.stock <= 0 ? 'disabled' : ''}>
                        <i class="fas fa-shopping-bag me-2"></i>Thêm vào giỏ hàng
                    </button>
                </form>
            </div>
        </div>
    </c:if>
</main>

<script>
    // JavaScript để thay đổi ảnh chính khi click vào ảnh thumbnail
    function changeImage(thumbnail) {
        document.getElementById('mainImage').src = thumbnail.src;
        document.querySelectorAll('.detail-img-thumbnail').forEach(img => img.classList.remove('active'));
        thumbnail.classList.add('active');
    }
    document.addEventListener("DOMContentLoaded", function() {
        const firstThumbnail = document.querySelector('.detail-img-thumbnail');
        if (firstThumbnail) firstThumbnail.classList.add('active');
    });
</script>

<jsp:include page="includes/footer.jsp" />