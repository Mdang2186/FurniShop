<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<main class="container" style="max-width: 600px; margin-top: 5rem; margin-bottom: 5rem;">
  <div class="card">
    <div class="card-body p-5">
      <h2 class="text-center mb-4">Xác thực tài khoản</h2>
      <c:if test="${not empty requestScope.info}">
        <div class="alert alert-info">${requestScope.info}</div>
      </c:if>
      <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">${requestScope.error}</div>
      </c:if>

      <form action="register" method="post">
        <input type="hidden" name="action" value="verify" />
        <div class="mb-3">
          <label for="code" class="form-label">Mã OTP</label>
          <input type="text" id="code" name="code" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-primary w-100 mt-3">Xác thực</button>
      </form>

      <div class="text-muted mt-3" style="font-size: 0.9rem">
        Nếu không nhận được email, hãy kiểm tra hộp <b>Spam</b>/<b>Junk</b>.
      </div>
    </div>
  </div>
</main>

<jsp:include page="includes/footer.jsp" />
