<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <h1 class="mb-4">Giỏ hàng của bạn</h1>
    <c:choose>
        <c:when test="${empty sessionScope.cart || sessionScope.cartSize == 0}">
            <div class="text-center py-5">
                <i class="fas fa-shopping-bag fa-4x text-muted mb-3"></i>
                <h3 class="mb-3">Giỏ hàng của bạn đang trống</h3>
                <a href="shop" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-lg-8">
                    <c:forEach items="${sessionScope.cart}" var="item">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div class="d-flex flex-row align-items-center">
                                        <div><img src="${item.product.imageURL}" class="img-fluid rounded-3" style="width: 65px;"></div>
                                        <div class="ms-3">
                                            <h5><a href="product-detail?pid=${item.product.productID}" class="text-dark text-decoration-none">${item.product.productName}</a></h5>
                                            <p class="small mb-0 text-muted">${item.product.brand}</p>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center">
                                        <div style="width: 120px;">
                                            <form action="cart" method="post" class="d-flex">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="pid" value="${item.product.productID}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control form-control-sm text-center" onchange="this.form.submit()">
                                            </form>
                                        </div>
                                        <div style="width: 120px;" class="text-end"><h5 class="mb-0"><fmt:formatNumber value="${item.totalPrice}" type="currency" currencyCode="VND"/></h5></div>
                                        <a href="cart?action=remove&pid=${item.product.productID}" class="ms-3 text-danger"><i class="fas fa-trash-alt"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="col-lg-4">
                    <div class="card bg-primary text-white rounded-3">
                        <div class="card-body">
                            <h5 class="mb-4">Tổng kết đơn hàng</h5>
                            <hr class="my-4">
                            <div class="d-flex justify-content-between">
                                <p class="mb-2">Tạm tính</p>
                                <p class="mb-2"><fmt:formatNumber value="${sessionScope.totalAmount}" type="currency" currencyCode="VND"/></p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p class="mb-2">Phí vận chuyển</p>
                                <p class="mb-2 text-warning">Miễn phí</p>
                            </div>
                            <hr class="my-4">
                            <div class="d-flex justify-content-between mb-4">
                                <p class="mb-2">Tổng cộng</p>
                                <p class="mb-2 fw-bold"><fmt:formatNumber value="${sessionScope.totalAmount}" type="currency" currencyCode="VND"/></p>
                            </div>
                            <a href="checkout" class="btn btn-info btn-block btn-lg w-100">
                                <span>Tiến hành đặt hàng <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="includes/footer.jsp" />