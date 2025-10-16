<%-- shop.jsp --%>
<jsp:include page="includes/header.jsp" />
<div class="container my-5">
    <div class="row">
        <div class="col-md-3">
            <h4 class="mb-3">Danh m?c</h4>
            <div class="list-group">
                <a href="shop" class="list-group-item list-group-item-action">T?t c? s?n ph?m</a>
                <c:forEach items="${requestScope.categories}" var="c">
                    <a href="shop?cid=${c.categoryID}" class="list-group-item list-group-item-action">${c.categoryName}</a>
                </c:forEach>
            </div>
        </div>
        <div class="col-md-9">
            <h4 class="mb-3">S?n ph?m</h4>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach items="${requestScope.products}" var="p">
                    <div class="col">
                        <div class="card h-100">
                            <img src="${p.imageURL}" class="card-img-top" style="height: 200px; object-fit: cover;" alt="${p.productName}">
                            <div class="card-body">
                                <h5 class="card-title">${p.productName}</h5>
                                <p class="card-text text-danger fw-bold">${p.formattedPrice}</p>
                                <a href="product-detail?pid=${p.productID}" class="btn btn-primary stretched-link">Xem chi ti?t</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<jsp:include page="includes/footer.jsp" />
