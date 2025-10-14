<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="includes/header.jsp" />

<main class="container my-5">
    <h1 class="mb-4">Lịch sử đơn hàng</h1>
    
    <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>

    <c:choose>
        <c:when test="${empty orderList}">
            <div class="text-center py-5"><i class="fas fa-clipboard-list fa-4x text-muted mb-3"></i><h3 class="mb-3">Bạn chưa có đơn hàng nào</h3><a href="shop" class="btn btn-primary">Bắt đầu mua sắm</a></div>
        </c:when>
        <c:otherwise>
            <div class="accordion" id="ordersAccordion">
                <c:forEach items="${orderList}" var="order" varStatus="loop">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="heading${loop.index}">
                            <button class="accordion-button ${loop.index > 0 ? 'collapsed' : ''}" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${loop.index}">
                                <div class="w-100 d-flex justify-content-between pe-3 flex-wrap">
                                    <span class="fw-bold me-3">Đơn hàng #${order.orderID}</span>
                                    <span class="me-3"><i class="fas fa-calendar-alt me-1"></i> <fmt:formatDate value="${order.orderDate}" pattern="HH:mm dd/MM/yyyy"/></span>
                                    <span class="badge bg-info">${order.status}</span>
                                </div>
                            </button>
                        </h2>
                        <div id="collapse${loop.index}" class="accordion-collapse collapse ${loop.index == 0 ? 'show' : ''}" data-bs-parent="#ordersAccordion">
                            <div class="accordion-body">
                                <p><strong>Tổng tiền:</strong> <span class="text-danger fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND"/></span></p>
                                <p><strong>Địa chỉ giao hàng:</strong> ${order.shippingAddress}</p>
                                <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                <c:if test="${not empty order.note}"><p><strong>Ghi chú:</strong> ${order.note}</p></c:if>
                                <h6 class="mt-4">Chi tiết sản phẩm:</h6>
                                <ul class="list-group">
                                    <c:forEach items="${order.items}" var="item">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <div class="d-flex align-items-center">
                                                <img src="${item.product.imageURL}" style="width: 50px;" class="me-3 rounded"/>
                                                <span>${item.product.productName} (x${item.quantity})</span>
                                            </div>
                                            <span><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" currencyCode="VND"/></span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="includes/footer.jsp" />