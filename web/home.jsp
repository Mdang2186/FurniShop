<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main>
    <section class="hero-section d-flex align-items-center text-white text-center">
        <div class="container">
            <h1 class="display-3 fw-bold">Tinh Hoa Nội Thất Đương Đại</h1>
            <p class="lead col-lg-8 mx-auto">Nơi nghệ thuật và tiện nghi giao thoa, mang đến vẻ đẹp vượt thời gian cho không gian sống của bạn.</p>
            <a href="shop" class="btn btn-primary btn-lg mt-3">Khám phá Bộ Sưu Tập</a>
        </div>
    </section>

    <div class="album py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold display-5">Sản Phẩm Nổi Bật</h2>
                <p class="text-muted">Những thiết kế được yêu thích nhất, dẫn đầu xu hướng.</p>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
                <c:forEach items="${requestScope.products}" var="p" end="7">
                    <div class="col">
                        <div class="card card-product h-100">
                            <div class="product-card-img-wrapper">
                                <a href="product-detail?pid=${p.productID}">
                                    <img src="${p.imageURL}" class="product-card-img" alt="${p.productName}">
                                </a>
                            </div>
                            <div class="card-body d-flex flex-column text-center">
                                <h5 class="card-title">${p.productName}</h5>
                                <div class="mt-auto">
                                    <p class="card-price text-primary mb-2">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND"/>
                                    </p>
                                    <a href="cart?action=add&pid=${p.productID}" class="btn btn-outline-secondary btn-sm">Thêm vào giỏ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<jsp:include page="includes/footer.jsp" />