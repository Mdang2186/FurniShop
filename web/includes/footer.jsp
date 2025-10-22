<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<footer class="footer-dark text-white pt-5 pb-4 mt-auto">
    <div class="container text-center text-md-start">
        <div class="row">
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold">
                    <i class="fas fa-couch me-2"></i>Furni Shop
                </h5>
                <p>
                    Mang đến những sản phẩm nội thất cao cấp, kết hợp giữa thẩm mỹ và công năng, tạo nên không gian sống đẳng cấp và tinh tế.
                </p>
            </div>
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold">Thông tin Nhóm 4</h5>
                <p class="mb-1">Đỗ Công Minh (29/10/2004)</p>
                <p class="mb-1">Đặng Đình Thế Hiếu (17/10/2004)</p>
                <p class="mb-1">Lý Ngọc Long (14/02/2003)</p>
                <p class="mb-1">Nguyễn Hữu Lương (28/03/2004)</p>
            </div>
            <div class="col-md-4 col-lg-4 col-xl-4 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 fw-bold">Liên kết</h5>
                <p><a href="${path}/shop" class="footer-link text-decoration-none">Sản phẩm</a></p>
                <p><a href="${path}/account" class="footer-link text-decoration-none">Tài khoản</a></p>
                <p><a href="${path}/orders" class="footer-link text-decoration-none">Đơn hàng</a></p>
            </div>
        </div>
        <hr class="my-4">
        <div class="row align-items-center">
            <div class="col-12 text-center">
                <p>© 2025 Furni Shop. Đồ án thực tập Java Web.</p>
            </div>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>