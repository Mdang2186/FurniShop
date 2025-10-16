<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <c:if test="${not empty product}">
        <div class="row">
            <div class="col-md-6">
                <img src="${product.imageURL}" class="img-fluid rounded shadow-sm detail-img w-100" alt="${product.productName}">
            </div>
            <div class="col-md-6">
                <h1 class="display-5">${product.productName}</h1>
                <p class="text-muted">Thương hiệu: ${product.brand}</p>
                <h2 class="text-danger fw-bold my-3">
                    <fmt:formatNumber value="${product.price}" type="currency" currencyCode="VND"/>
                </h2>
                <p class="lead">${product.description}</p>
                
                <h5 class="mt-4">Thông tin chi tiết</h5>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item"><strong>Chất liệu:</strong> ${product.material}</li>
                    <li class="list-group-item"><strong>Tính năng:</strong> ${product.features}</li>
                    <li class="list-group-item"><strong>Tồn kho:</strong> ${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}</li>
                </ul>
                
                <form action="cart" method="post" class="mt-4">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="pid" value="${product.productID}">
                    <div class="input-group" style="max-width: 200px;">
                        <span class="input-group-text">Số lượng</span>
                        <input type="number" name="quantity" class="form-control" value="1" min="1">
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg mt-3" ${product.stock <= 0 ? 'disabled' : ''}>
                        <i class="fas fa-shopping-bag me-2"></i>Thêm vào giỏ hàng
                    </button>
                </form>
            </div>
        </div>
    </c:if>
    <c:if test="${empty product}">
        <div class="text-center">
            <h2>Không tìm thấy sản phẩm</h2>
            <a href="shop" class="btn btn-primary">Quay lại cửa hàng</a>
        </div>
    </c:if>
</main>

<jsp:include page="includes/footer.jsp" />