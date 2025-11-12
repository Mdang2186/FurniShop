<%-- Thay thế toàn bộ file: cart.jsp (Đồng bộ phong cách BoConcept) --%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<jsp:include page="/includes/header.jsp">
  <jsp:param name="pageTitle" value="Giỏ hàng - LUXE INTERIORS"/>
</jsp:include>

<style>
/* Cart page specific */
.container-cart { max-width:1100px; margin:2.5rem auto; display:flex; gap:2rem; align-items:flex-start; }
.cart-list-wrap { flex:1; }
.cart-summary { width:360px; position:sticky; top:100px; height:fit-content; }

/* scroll nội bộ cho list */
#cartItems {
  background:transparent;
  /* THAY ĐỔI: Bỏ shadow */
  /* box-shadow:0 6px 30px rgba(0,0,0,.06); */
  max-height: calc(75vh - 80px); /* fallback, JS sẽ điều chỉnh */
  overflow:auto;
}

/* mỗi dòng product */
.cart-item {
  display:flex; gap:1rem; align-items:center; 
  /* THAY ĐỔI: Bỏ nền, viền, shadow */
  background:transparent; 
  padding:18px 0;
  border:none;
  border-bottom:1px solid rgba(0,0,0,.08); /* Dùng gạch ngang thay thế */
  margin-bottom:0;
}
.cart-item .thumb { width:120px; height:90px; flex:0 0 120px; }
.cart-item img { width:100%; height:100%; object-fit:cover; border-radius:8px; }

/* info */
.cart-item .info { flex:1; }
.cart-item .info h5 { margin:0 0 .3rem 0; font-size:1rem; }
.cart-item .meta { color:#6b6b6b; font-size:.9rem; }

/* price block */
.cart-item .price-block { text-align:right; width:180px; flex:0 0 180px; }
.price-block .price { font-weight:700; font-size:1rem; color:#111; }
.price-block .line-total { font-size:.85rem; color:#888; margin-top:6px; }

/* quantity controls */
.qty-controls { display:flex; gap:.5rem; align-items:center; }
.qty-controls button { width:36px; height:36px; border-radius:8px; border:1px solid rgba(0,0,0,.08); background:#fff; cursor:pointer; }
.qty-controls input[type=number]{ width:58px; text-align:center; border-radius:8px; border:1px solid rgba(0,0,0,.06); padding:.45rem .35rem; }

/* checkbox */
.item-select { width:18px; height:18px; }

/* summary */
.cart-summary .card { 
    padding:1.25rem; 
    border-radius:12px; 
    /* THAY ĐỔI: Bỏ nền và viền */
    border:none; 
    background:transparent;
    box-shadow:0 12px 40px rgba(0,0,0,.06); /* Giữ shadow nhẹ */
}
.summary-row{ display:flex; justify-content:space-between; align-items:center; margin-bottom:.5rem; }
.summary-total{ font-weight:800; font-size:1.25rem; }

/* responsive */
@media (max-width:991px){
  .container-cart{ flex-direction:column; padding:0 1rem; }
  .cart-summary{ position:static; width:100%; }
  #cartItems{ max-height:60vh; }
}
</style>

<main class="container-cart">
  <div class="cart-list-wrap">
    <h1 class="font-playfair display-6 mb-4 text-luxury-gold">Giỏ hàng của bạn</h1>

    <div style="display:flex; justify-content:space-between; align-items:center; margin: .75rem 0;">
      <label style="display:flex; align-items:center; gap:.5rem;">
        <input id="selectAll" type="checkbox"/> Chọn tất cả
      </label>
      <div>
        <a class="btn btn-outline-secondary" href="<c:url value='/shop'/>">Tiếp tục mua sắm</a>
      </div>
    </div>

    <div id="cartItems" role="list">
      <c:choose>
        <c:when test="${not empty sessionScope.cart}">
          <c:forEach var="ci" items="${sessionScope.cart}">
            <%-- ci: CartItem với ci.product và ci.quantity --%>
            <div class="cart-item" data-pid="${ci.product.productID}">
              <div style="display:flex; align-items:flex-start; gap:1rem;">
                <input class="item-select" type="checkbox" aria-label="Chọn sản phẩm"/>
              </div>

              <div class="thumb">
                <a href="<c:url value='/product-detail?pid=${ci.product.productID}'/>">
                  <img src="${ci.product.imageURL}"
                       onerror="this.src='<c:url value='/assets/images/placeholder.png' />'"
                       alt="${fn:escapeXml(ci.product.productName)}"/>
                </a>
              </div>

              <div class="info">
                <h5 title="${ci.product.productName}">${ci.product.productName}</h5>
                <div class="meta">${ci.product.brand} • ${ci.product.material}</div>

                <div style="margin-top:.75rem; display:flex; gap:1rem; align-items:center;">
                  <div class="qty-controls">
                    <button type="button" class="btn-decrease" title="Giảm">−</button>
                    <input type="number" name="quantity" min="1" value="${ci.quantity}" />
                    <button type="button" class="btn-increase" title="Tăng">+</button>
                    <form action="<c:url value='/cart'/>" method="post" style="display:inline;">
                      <input type="hidden" name="action" value="update"/>
                      <input type="hidden" name="pid" value="${ci.product.productID}"/>
                      <input type="hidden" name="quantityToUpdate" value="${ci.quantity}" class="hidden-qty" />
                       <button class="btn btn-sm btn-secondary" style="margin-left:.6rem">Cập nhật</button>
                    </form>
                  </div>

                  <form action="<c:url value='/cart'/>" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="remove"/>
                    <input type="hidden" name="pid" value="${ci.product.productID}"/>
                    <button class="btn btn-sm btn-outline-danger" title="Xóa">🗑️</button>
                  </form>
                </div>
              </div>

              <div class="price-block">
                <div class="price price-value" data-price="${ci.product.price}">
                  <fmt:formatNumber value="${ci.product.price}" type="currency" currencyCode="VND"/>
                </div>
                <div class="line-total">
                  (<fmt:formatNumber value="${ci.quantity}" type="number"/> × <fmt:formatNumber value="${ci.product.price}" type="currency" currencyCode="VND"/>)
                </div>
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="text-center py-5">
             <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
            <p class="mb-0 text-muted">Giỏ hàng trống — hãy thêm sản phẩm bạn thích.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <aside class="cart-summary">
    <div class="card">
      <h4 class="mb-3">Tổng kết đơn hàng</h4>

      <div class="summary-row">
        <div>Tạm tính (đã chọn)</div>
        <div id="selectedSubtotal">0 ₫</div>
      </div>

      <div class="summary-row">
        <div>Phí vận chuyển</div>
        <div><span class="badge bg-success">Miễn phí</span></div>
      </div>

      <hr/>

      <div class="summary-row summary-total">
        <div>Tổng cộng</div>
        <div id="finalTotal">0 ₫</div>
      </div>

      <div style="margin-top:1rem; display:flex; gap:.75rem; flex-direction:column;">
        <button id="checkoutSelectedBtn" class="btn btn-warning" disabled style="font-weight:700;">TIẾN HÀNH ĐẶT HÀNG</button>
        <a class="btn btn-outline-secondary" href="<c:url value='/shop'/>">Tiếp tục mua sắm</a>
      </div>
    </div>
  </aside>
</main>

<jsp:include page="/includes/footer.jsp"/>

<script>
(function(){
  function setFooterAndCartSizing(){
    try {
      const footerEl = document.querySelector('.footer-luxe') || document.querySelector('.footer') || document.querySelector('footer');
      const headerEl = document.querySelector('header') || document.querySelector('.nav-luxury');
      if(footerEl){
        const footerH = footerEl.getBoundingClientRect().height;
        document.documentElement.style.setProperty('--footer-height', footerH + 'px');
        document.body.style.paddingBottom = (footerH + 12) + 'px'; }
      const headerH = headerEl ? headerEl.getBoundingClientRect().height : 0;
      const cartItems = document.getElementById('cartItems');
      if(cartItems){
        let footerHeight = footerEl ? footerEl.getBoundingClientRect().height : 0;
        const available = window.innerHeight - headerH - footerHeight - 160;
        cartItems.style.maxHeight = Math.max(260, available) + 'px'; }
    } catch(e){
      console.warn('setFooterAndCartSizing error', e); }
  }
  window.addEventListener('load', ()=>{ setTimeout(setFooterAndCartSizing, 50); setTimeout(setFooterAndCartSizing, 350); });
  window.addEventListener('resize', setFooterAndCartSizing);
  
  function formatVND(num){
    try{
      return new Intl.NumberFormat('vi-VN', {style:'currency', currency:'VND'}).format(num);
    }catch(e){ return num + ' ₫'; }
  }

  function recalcSelection(){
    const rows = document.querySelectorAll('.cart-item');
    let subtotal = 0;
    let totalAll = 0;
    const selected = [];
    rows.forEach(row=>{
      const priceAttr = row.querySelector('.price-value')?.dataset?.price;
      const price = priceAttr ? parseFloat(priceAttr) : 0;
      const qtyInput = row.querySelector('input[name="quantity"]');
      const qty = qtyInput ? parseInt(qtyInput.value || '1') : 1;
      totalAll += price * qty;
      const checkbox = row.querySelector('.item-select');
      if(checkbox && checkbox.checked){
        subtotal += price * qty;
        selected.push({ pid: row.dataset.pid, qty: qty });
      }
    });

    document.getElementById('selectedSubtotal').innerText = formatVND(subtotal);
    document.getElementById('finalTotal').innerText = formatVND(subtotal); 
    const checkoutBtn = document.getElementById('checkoutSelectedBtn');
    checkoutBtn.disabled = selected.length === 0;
    window._cartSelected = selected;
  }

  setTimeout(recalcSelection, 120);
  document.addEventListener('change', (e)=>{
    if(e.target.matches('.item-select') || (e.target.matches('input[name="quantity"]'))){
      recalcSelection();
    }
  });
  document.addEventListener('click', (e)=>{
    if(e.target.classList.contains('btn-increase') || e.target.closest('.btn-increase')){
      const btn = e.target.closest('.btn-increase');
      const input = btn.parentElement.querySelector('input[name="quantity"]');
      input.value = Math.max(1, parseInt(input.value||'1') + 1);
      const hidden = btn.closest('.cart-item').querySelector('.hidden-qty');
      if(hidden) hidden.value = input.value;
      recalcSelection();
    }
    if(e.target.classList.contains('btn-decrease') || e.target.closest('.btn-decrease')){
      const btn = e.target.closest('.btn-decrease');
      const input = btn.parentElement.querySelector('input[name="quantity"]');
      input.value = Math.max(1, parseInt(input.value||'1') - 1);
      const hidden = btn.closest('.cart-item').querySelector('.hidden-qty');
      if(hidden) hidden.value = input.value;
      recalcSelection();
    }
    if(e.target.matches('form button') || e.target.closest('form button')){
    }
  });
  
  document.getElementById('selectAll').addEventListener('change', function(){
    const check = this.checked;
    document.querySelectorAll('.item-select').forEach(ch=> ch.checked = check);
    recalcSelection();
  });
  
  function checkoutSelected(){
    const selected = window._cartSelected || [];
    if(selected.length === 0) return;
    const form = document.createElement('form');
    form.method = 'post';
    form.action = '<c:url value="/checkout"/>';
    selected.forEach(s=>{
      const ip = document.createElement('input'); ip.type='hidden'; ip.name='pid[]'; ip.value = s.pid; form.appendChild(ip);
      const iq = document.createElement('input'); iq.type='hidden'; iq.name='qty[]'; iq.value = s.qty; form.appendChild(iq);
    });
    document.body.appendChild(form);
    form.submit();
  }

  document.getElementById('checkoutSelectedBtn').addEventListener('click', function(e){
    e.preventDefault();
    checkoutSelected();
  });

})();
</script>