<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<c:set var="pageTitle" value="Lịch sử đơn hàng - LUXE INTERIORS" scope="request"/>
<jsp:include page="/includes/header.jsp" />

<main class="container my-5">
  <h1 class="font-playfair display-6 mb-4 text-luxury-gold">Lịch sử đơn hàng</h1>

  <c:if test="${not empty message}">
    <div class="alert alert-success card-luxury p-3">${message}</div>
  </c:if>

  <c:choose>
    <c:when test="${empty orderList}">
      <div class="card-luxury p-5 text-center">
        <div class="mb-3" style="font-size:60px;">📦</div>
        <h3 class="mb-2">Bạn chưa có đơn hàng nào</h3>
        <p class="text-muted mb-4">Mua vài món décor cho không gian sang xịn nào.</p>
        <a class="btn-luxury ripple px-5" href="<c:url value='/shop'/>">Bắt đầu mua sắm</a>
      </div>
    </c:when>

    <c:otherwise>
      <div class="accordion" id="ordersAccordion">
        <c:forEach items="${orderList}" var="order" varStatus="st">
          <c:set var="panelId" value="order_${order.orderID}" />
          <c:set var="isFirst" value="${st.index == 0}" />

          <!-- map trạng thái -> màu badge -->
          <c:set var="statusClass" value="bg-secondary"/>
          <c:choose>
            <c:when test="${order.status eq 'Pending'}">    <c:set var="statusClass" value="bg-warning text-dark"/></c:when>
            <c:when test="${order.status eq 'Processing'}"> <c:set var="statusClass" value="bg-info"/></c:when>
            <c:when test="${order.status eq 'Shipped'}">    <c:set var="statusClass" value="bg-primary"/></c:when>
            <c:when test="${order.status eq 'Completed'}">  <c:set var="statusClass" value="bg-success"/></c:when>
            <c:when test="${order.status eq 'Cancelled'}">  <c:set var="statusClass" value="bg-danger"/></c:when>
          </c:choose>

          <div class="accordion-item card-luxury mb-3">
            <h2 class="accordion-header" id="h_${panelId}">
              <button class="accordion-button ${!isFirst ? 'collapsed' : ''}" type="button"
                      data-bs-toggle="collapse" data-bs-target="#c_${panelId}" aria-expanded="${isFirst}" aria-controls="c_${panelId}">
                <div class="w-100 d-flex flex-wrap gap-3 align-items-center">
                  <span class="fw-bold">Đơn hàng #${order.orderID}</span>
                  <span class="text-muted"><i class="fa-regular fa-clock me-1"></i>
                    <fmt:formatDate value="${order.orderDate}" pattern="HH:mm dd/MM/yyyy"/>
                  </span>
                  <span class="badge ${statusClass} ms-auto">${order.status}</span>
                </div>
              </button>
            </h2>

            <div id="c_${panelId}" class="accordion-collapse collapse ${isFirst ? 'show' : ''}" aria-labelledby="h_${panelId}" data-bs-parent="#ordersAccordion">
              <div class="accordion-body">
                <div class="row g-4">
                  <div class="col-lg-6">
                    <div class="vstack gap-2">
                      <div><span class="text-muted">Tổng tiền:</span>
                        <span class="fw-bold text-danger">
                          <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND"/>
                        </span>
                      </div>
                      <div><span class="text-muted">Địa chỉ giao hàng:</span>
                        <span class="fw-semibold">${order.shippingAddress}</span>
                      </div>
                      <div><span class="text-muted">Thanh toán:</span>
                        <span class="fw-semibold">${order.paymentMethod}</span>
                      </div>
                      <c:if test="${not empty order.note}">
                        <div><span class="text-muted">Ghi chú:</span> ${order.note}</div>
                      </c:if>
                    </div>
                  </div>

                  <div class="col-lg-6">
                    <h6 class="fw-semibold mb-3">Chi tiết sản phẩm</h6>
                    <ul class="list-group">
                      <c:forEach items="${order.items}" var="it">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                          <div class="d-flex align-items-center">
                            <img src="${it.product.imageURL}" class="rounded me-3"
                                 style="width:56px;height:56px;object-fit:cover"
                                 onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'" />
                            <div>
                              <div class="fw-semibold">${it.product.productName}</div>
                              <div class="text-muted small">x${it.quantity}</div>
                            </div>
                          </div>
                          <div class="fw-semibold">
                            <fmt:formatNumber value="${it.unitPrice * it.quantity}" type="currency" currencyCode="VND"/>
                          </div>
                        </li>
                      </c:forEach>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<jsp:include page="/includes/footer.jsp" />
