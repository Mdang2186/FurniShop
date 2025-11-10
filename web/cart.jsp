<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<c:set var="pageTitle" value="Giỏ hàng - LUXE INTERIORS" scope="request"/>
<jsp:include page="/includes/header.jsp" />

<main class="container my-5">
  <h1 class="display-5 font-playfair mb-4">Giỏ hàng của bạn</h1>

  <c:choose>
    <c:when test="${empty sessionScope.cart}">
      <div class="card-luxury p-5 text-center">
        <div class="mb-3" style="font-size:60px;">🧺</div>
        <h3 class="mb-2">Giỏ hàng đang trống</h3>
        <p class="text-muted mb-4">Tiếp tục mua sắm để tìm món phù hợp không gian của bạn.</p>
        <a class="btn-luxury ripple px-5" href="<c:url value='/shop'/>">MUA SẮM NGAY</a>
      </div>
    </c:when>

    <c:otherwise>
      <div class="row g-4">
        <!-- LIST -->
        <div class="col-lg-8">
          <div class="d-flex align-items-center gap-2 mb-3">
            <input id="checkAll" type="checkbox" class="form-check-input" checked>
            <label for="checkAll" class="form-check-label fw-semibold">Chọn tất cả</label>
          </div>

          <c:forEach items="${sessionScope.cart}" var="ci">
            <c:set var="p" value="${ci.product}"/>
            <div class="card-luxury p-3 mb-3 cart-row" data-pid="${p.productID}" data-price="${p.price}" data-qty="${ci.quantity}">
              <div class="d-flex align-items-center gap-3 flex-wrap">
                <input type="checkbox" class="form-check-input selItem" value="${p.productID}" checked>

                <img src="${p.imageURL}" alt="${p.productName}"
                     onerror="this.src='<c:url value="/assets/images/placeholder.png"/>'"
                     class="rounded-3" style="width:120px;height:90px;object-fit:cover">

                <div class="flex-grow-1">
                  <div class="h5 m-0 font-playfair">${p.productName}</div>
                  <div class="text-muted small">${p.brand}</div>
                </div>

                <div class="d-flex align-items-center gap-2">
                  <button class="btn btn-light rounded-circle btnDec" style="width:42px;height:42px;">−</button>
                  <input type="number" min="1" class="form-control text-center qtyInput" value="${ci.quantity}" style="width:78px;">
                  <button class="btn btn-light rounded-circle btnInc" style="width:42px;height:42px;">+</button>
                </div>

                <div class="ms-auto fw-bold lineTotal" data-line>
                  <fmt:formatNumber value="${ci.totalPrice}" type="currency" currencyCode="VND"/>
                </div>

                <button class="btn btn-link text-danger ms-2 btnRemove" title="Xóa">
                  <i class="fa-solid fa-trash"></i>
                </button>
              </div>
            </div>
          </c:forEach>
        </div>

        <!-- SUMMARY -->
        <div class="col-lg-4">
          <div class="card-luxury g-gold p-4 position-sticky" style="top:84px;">
            <h5 class="font-playfair mb-3">Tổng kết đơn hàng</h5>
            <div class="d-flex justify-content-between py-2 border-bottom">
              <span class="text-muted">Tạm tính (đã chọn)</span>
              <span id="sumSelected" class="fw-semibold">
                <fmt:formatNumber value="${sessionScope.totalAmount}" type="currency" currencyCode="VND"/>
              </span>
            </div>
            <div class="d-flex justify-content-between py-2 border-bottom">
              <span class="text-muted">Phí vận chuyển</span><span class="badge bg-success">Miễn phí</span>
            </div>
            <div class="d-flex justify-content-between py-2">
              <span class="fw-bold">Tổng cộng</span>
              <span id="sumGrand" class="fw-bold">
                <fmt:formatNumber value="${sessionScope.totalAmount}" type="currency" currencyCode="VND"/>
              </span>
            </div>

            <!-- Fallback form GET /checkout -->
            <form id="goCheckoutForm" action="<c:url value='/checkout'/>" method="get" class="mt-3">
              <input type="hidden" name="sel" id="selInput" value="">
              <button type="submit" class="btn-luxury ripple w-100">TIẾN HÀNH ĐẶT HÀNG</button>
            </form>

            <a class="btn btn-outline-secondary rounded-pill w-100 mt-2" href="<c:url value='/shop'/>">Tiếp tục mua sắm</a>
          </div>
        </div>
      </div>
    </c:otherwise>
  </c:choose>
</main>

<jsp:include page="/includes/footer.jsp" />

<script>
(() => {
  const PATH = '<c:url value="/" />'.replace(/\/$/, '');
  const fmtVND = n => new Intl.NumberFormat('vi-VN',{style:'currency',currency:'VND'}).format(n);

  // --- helpers ---
  const recalcCard = row => {
    const price = parseFloat(row.dataset.price);
    const qtyEl  = row.querySelector('.qtyInput');
    const qty = Math.max(1, parseInt(qtyEl.value||'1',10));
    row.dataset.qty = qty;
    row.querySelector('[data-line]').textContent = fmtVND(price*qty);
  };
  const recalcSummary = () => {
    let sum = 0;
    document.querySelectorAll('.cart-row').forEach(row=>{
      if (!row.querySelector('.selItem').checked) return;
      sum += parseFloat(row.dataset.price) * parseInt(row.dataset.qty,10);
    });
    document.getElementById('sumSelected').textContent = fmtVND(sum);
    document.getElementById('sumGrand').textContent    = fmtVND(sum);
  };
  const updateBadge = size => {
    const b = document.querySelector('[data-cart-badge]');
    if (b){ b.textContent = size; b.classList.toggle('d-none', size<=0); }
  };
  const toast = msg => {
    const t=document.createElement('div');
    t.textContent=msg; t.style.cssText='position:fixed;right:16px;bottom:16px;background:#2b1e08;color:#fff;padding:10px 14px;border-radius:10px;z-index:9999';
    document.body.appendChild(t); setTimeout(()=>t.remove(),1700);
  };

  // bind rows
  document.querySelectorAll('.cart-row').forEach(row=>{
    const pid = row.dataset.pid;
    row.querySelector('.btnInc').addEventListener('click', async ()=>{
      const q=row.querySelector('.qtyInput'); q.value=(parseInt(q.value||'1',10)+1);
      await sendUpdate(pid, q.value, row);
    });
    row.querySelector('.btnDec').addEventListener('click', async ()=>{
      const q=row.querySelector('.qtyInput'); q.value=Math.max(1, parseInt(q.value||'1',10)-1);
      await sendUpdate(pid, q.value, row);
    });
    row.querySelector('.qtyInput').addEventListener('change', async (e)=>{
      const v=Math.max(1, parseInt(e.target.value||'1',10)); e.target.value=v;
      await sendUpdate(pid, v, row);
    });
    row.querySelector('.selItem').addEventListener('change', recalcSummary);
    row.querySelector('.btnRemove').addEventListener('click', async ()=>{
      if(!confirm('Xóa sản phẩm này khỏi giỏ?')) return;
      try{
        const r=await fetch(`${PATH}/cart?action=remove&pid=${pid}&ajax=1`,{method:'POST'});
        const j=await r.json(); row.remove(); updateBadge(j.cartSize??0); recalcSummary();
        if(document.querySelectorAll('.cart-row').length===0) location.reload();
      }catch{ location.href=`${PATH}/cart?action=remove&pid=${pid}`; }
    });
  });

  // select all
  const checkAll=document.getElementById('checkAll');
  if(checkAll){
    checkAll.addEventListener('change', ()=>{
      document.querySelectorAll('.selItem').forEach(c=>c.checked=checkAll.checked);
      recalcSummary();
    });
  }

  // init
  document.querySelectorAll('.cart-row').forEach(recalcCard);
  recalcSummary();

  // submit checkout form (nhét danh sách đã chọn vào input hidden)
  document.getElementById('goCheckoutForm')?.addEventListener('submit', (e)=>{
    const ids = [...document.querySelectorAll('.selItem:checked')].map(x=>x.value);
    if(ids.length===0){ e.preventDefault(); toast('Hãy chọn ít nhất 1 sản phẩm.'); return; }
    document.getElementById('selInput').value = ids.join(',');
  });

  async function sendUpdate(pid, qty, row){
    try{
      const r=await fetch(`${PATH}/cart?action=update&pid=${pid}&quantity=${qty}&ajax=1`,{method:'POST'});
      const j=await r.json(); recalcCard(row); recalcSummary(); updateBadge(j.cartSize??0);
    }catch{
      location.href=`${PATH}/cart?action=update&pid=${pid}&quantity=${qty}`;
    }
  }
})();
</script>
