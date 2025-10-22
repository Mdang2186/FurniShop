<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<main class="container" style="max-width: 600px; margin-top: 5rem; margin-bottom: 5rem;">
  <div class="card">
    <div class="card-body p-5">
      <h2 class="text-center mb-4">Đăng Ký Tài Khoản Mới</h2>

      <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
      </c:if>
      <c:if test="${not empty requestScope.message}">
        <div class="alert alert-success">${requestScope.message}</div>
      </c:if>

      <form action="register" method="post" novalidate>
        <input type="hidden" name="action" value="submit" />

        <div class="mb-3">
          <label for="fullName" class="form-label">Họ và Tên</label>
          <input type="text" id="fullName" name="fullName" class="form-control"
                 value="${fn:escapeXml(fullName)}" required />
        </div>

        <div class="mb-3">
          <label for="email" class="form-label">Địa chỉ Email</label>
          <input type="email" id="email" name="email" class="form-control"
                 value="${fn:escapeXml(email)}" required />
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Mật khẩu</label>
          <input type="password" id="password" name="password" class="form-control" required />
        </div>

        <div class="mb-3">
          <label for="re_password" class="form-label">Xác nhận mật khẩu</label>
          <input type="password" id="re_password" name="re_password" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-primary w-100 mt-3">Đăng Ký</button>
      </form>

      <div class="text-center mt-3">
        <p>Bạn đã có tài khoản? <a href="login">Đăng nhập tại đây</a></p>
      </div>
    </div>
  </div>
</main>

<jsp:include page="includes/footer.jsp" />
