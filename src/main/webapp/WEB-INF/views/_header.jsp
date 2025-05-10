<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
  .section-header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    background-color: white; /* Đặt màu nền nếu cần */
  }

  /* Nếu bạn có một phần tử body hoặc content chính, hãy thêm padding-top */
  body {
    padding-top: 93px; /* Điều chỉnh giá trị này dựa trên chiều cao header của bạn */
  }
</style>
<header class="section-header">
  <section class="header-main border-bottom">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-3 py-3">
          <!-- Thay logo chữ bằng logo ảnh -->
          <a class="text-body" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/img/logoheader.png" alt="Logo" style="width: 150px;"/>
          </a>
        </div> <!-- col.// -->
        <div class="col-lg-4 col-xl-5 ${empty sessionScope.currentUser ? 'mb-3 mb-lg-0' : ''}">
          <form action="${pageContext.request.contextPath}/search" method="post" class="search">
            <div class="input-group w-100">
              <input type="text"
                     class="form-control"
                     placeholder="Nhập từ khóa cần tìm ..."
                     name="q"
                     value="${requestScope.query}">
              <button class="btn btn-primary" type="submit">
                <i class="bi bi-search"></i>
              </button>
            </div>
          </form>
        </div> <!-- col.// -->
        <div class="col-lg-5 col-xl-4">
          <c:if test="${not empty sessionScope.currentUser}">
            <ul class="nav col-12 col-lg-auto my-2 my-lg-0 justify-content-center justify-content-lg-end text-small">
              <li>
                <a href="${pageContext.request.contextPath}/user" class="nav-link text-body">
                  <i class="bi bi-person d-block text-center fs-3"></i>
                  Tài khoản
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/order" class="nav-link text-body">
                  <i class="bi bi-list-check d-block text-center fs-3"></i>
                  Đơn hàng
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/cart" class="nav-link text-body position-relative">
                  <span id="total-cart-items-quantity" class="position-absolute top-0 end-0 mt-2 badge rounded-pill bg-primary">
                    ...
                  </span>
                  <i class="bi bi-cart d-block text-center fs-3 position-relative"></i>
                  Giỏ hàng
                </a>
              </li>
            </ul>
          </c:if>
        </div> <!-- col.// -->
      </div> <!-- row.// -->
    </div> <!-- container.// -->
  </section> <!-- header-main.// -->
</header> <!-- section-header.// -->
