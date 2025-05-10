<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">

<head>
  <jsp:include page="_meta.jsp"/>
  <title>Trang chủ</title>
  <style>
      /* --- CSS cho phần Danh mục sản phẩm --- */
      .category-section-wrapper {
          position: relative;
          width: 1000px;
          max-width: 100%;
          margin-left: auto;
          margin-right: auto;
          margin-bottom: 2rem;
      }

      #category-container {
          display: flex;
          overflow-x: auto;
          scroll-behavior: smooth;
          padding-bottom: 5px;

          width: 900px;

          margin-left: auto;
          margin-right: auto;

          -ms-overflow-style: none;
          scrollbar-width: none;
      }

      #category-container::-webkit-scrollbar {
          display: none;
      }

      .category-item-styled {
          flex: 0 0 auto;
          width: 210px;
          height: 130px;
          margin-right: 20px;
          border-radius: 15px;
          background-size: cover;
          background-position: center;
          position: relative;
          display: flex;
          align-items: flex-end;
          justify-content: center;
          text-decoration: none;
          color: white;
          box-shadow: 0 4px 8px rgba(0,0,0,0.15);
          transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
          overflow: hidden;
      }

      .category-item-styled:hover {
          transform: translateY(-5px);
          box-shadow: 0 6px 12px rgba(0,0,0,0.2);
      }

      .category-item-styled:last-child {
          margin-right: 0;
      }

      .category-item-text-styled {
          width: 100%;
          padding: 10px;
          font-size: 16px;
          font-weight: 500;
          text-align: center;
          background-color: rgba(0, 0, 0, 0.5);
          border-bottom-left-radius: 14px;
          border-bottom-right-radius: 14px;
          box-sizing: border-box;
      }

      /* --- CSS cho nút cuộn --- */
      .category-scroll-button {
          background-color: #ffffff;
          color: #333;
          border: 1px solid #e0e0e0;
          padding: 0;
          cursor: pointer;
          position: absolute;
          top: 50%;
          transform: translateY(-50%);
          z-index: 10;
          width: 40px;
          height: 40px;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 20px;
          box-shadow: 0 2px 5px rgba(0,0,0,0.1);
          transition: background-color 0.2s ease, box-shadow 0.2s ease;
      }

      .category-scroll-button:hover {
          background-color: #f5f5f5;
          box-shadow: 0 3px 7px rgba(0,0,0,0.15);
      }

      #scroll-left {
          left: 5px;
      }

      #scroll-right {
          right: 5px;
      }
      .item-grid .img-wrap {
          height: 180px; /* Điều chỉnh giá trị này cho phù hợp với chiều cao mong muốn, ví dụ như chiều cao của ảnh "Long Nhãn Ecovisu" */
          width: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
          overflow: hidden; /* Ẩn phần ảnh bị tràn ra ngoài vùng chứa */
      }
      .item-grid .card {
          padding: 15px; /* Có thể điều chỉnh giá trị này */
          margin-bottom: 20px; /* Có thể điều chỉnh giá trị này */
          border: 4px solid #f0f0f0; /* Thêm viền nếu muốn */
          border-radius: 20px; /* Giá trị này quyết định độ bo tròn góc */
          min-height: 400px; /* Đặt chiều cao tối thiểu */
          display: flex; /* Để các phần tử bên trong card có thể sắp xếp theo flexbox */
          flex-direction: column; /* Sắp xếp các phần tử bên trong theo chiều dọc */
          justify-content: space-between;
      }
      .item-grid .img-wrap img {
          max-width: 100%;
          max-height: 100%;
          object-fit: scale-down; /* Đảm bảo toàn bộ ảnh hiển thị bên trong khung */
      }
      .banner-column {
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          height: auto;
      }
      .banner-container {
          height: 50%;
      }
      @media (max-width: 991.98px) {
          .banner-column {
              display: none;
          }
          .product-column {
              width: 100%;
          }

      }
      /* CSS cho phần Thực phẩm và đặc sản (giao diện lưới) */
      .section-content.mb-5:nth-child(4) .item-grid { /* Nhắm mục tiêu đúng section */
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Tạo các cột tự động điều chỉnh kích thước */
          gap: 15px; /* Khoảng cách giữa các item */
      }

      .section-content.mb-5:nth-child(4) .card {
          display: flex;
          flex-direction: column;
          border: 1px solid #f0f0f0;
          border-radius: 8px;
          overflow: hidden;
          transition: transform 0.3s ease-in-out;
      }

      .section-content.mb-5:nth-child(4) .card:hover {
          transform: scale(1.02);
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .section-content.mb-5:nth-child(4) .img-wrap {
          height: 150px; /* Chiều cao cố định cho ảnh */
          display: flex;
          justify-content: center;
          align-items: center;
          overflow: hidden;
          background-color: #f9f9f9; /* Màu nền cho vùng ảnh nếu cần */
      }

      .section-content.mb-5:nth-child(4) .img-wrap img {
          max-width: 100%;
          max-height: 100%;
          object-fit: contain; /* Đảm bảo ảnh hiển thị đầy đủ trong khung */
      }

      .section-content.mb-5:nth-child(4) .info-wrap {
          padding: 15px;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          flex-grow: 1;
      }

      .section-content.mb-5:nth-child(4) .title {
          margin-bottom: 5px;
          font-size: 1rem;
          color: #333;
          text-decoration: none;
      }

      .section-content.mb-5:nth-child(4) .price {
          font-weight: bold;
          color: #0c4128;
          font-size: 1.1rem;
      }

      .section-content.mb-5:nth-child(4) .badge {
          font-size: 0.8rem;
      }
      .banner-with-text {
          width: 100%; /* Kéo dài hết chiều ngang của phần cha */
          border-radius: 10px;
          overflow: hidden;
          margin-bottom: 1.5rem; /* Điều chỉnh khoảng cách với sản phẩm bên dưới */
      }
  </style>
</head>

<body>
<jsp:include page="_header.jsp"/>

<section class="banner-section" style="margin-top: 5px;">
  <div class="container">
    <div class="row align-items-center justify-content-center">
      <div class="col-md-8">
        <img src="${pageContext.request.contextPath}/img/banner.png" class="img-fluid rounded" alt="Freeship Banner" style="max-width: 100%; max-height: 421px; border-radius: 20px; object-fit: cover;"/>
      </div>
    </div>
  </div>
</section>
<section class="section-content">
    <div class="container">
        <header class="section-heading py-4 d-flex justify-content-between">
            <h3 class="section-title" style="color: #0c4128;">Danh mục</h3>
        </header>

        <div class="category-section-wrapper">
            <button id="scroll-left" class="category-scroll-button">
                &#8592;
            </button>

            <div id="category-container">
                <c:forEach var="category" items="${requestScope.categories}" varStatus="loop">
                    <c:set var="defaultImage" value="${pageContext.request.contextPath}/img/placeholder-category.png" />
                    <c:set var="categoryImage" value="${not empty category.imageName ? pageContext.request.contextPath.concat('/image/').concat(category.imageName) : defaultImage}" />

                    <c:set var="bgColors" value="${['#D4EFDF', '#FAD7A0', '#F9E79F', '#A9DFBF', '#AED6F1', '#F5B7B1', '#D2B4DE']}" />
                    <c:set var="bgColorIndex" value="${loop.index % bgColors.size()}" />
                    <c:set var="fallbackBgColor" value="${bgColors[bgColorIndex]}" />

                    <a href="${pageContext.request.contextPath}/category?id=${category.id}"
                       class="category-item-styled"
                       style="background-image: url('${categoryImage}'); background-color: ${fallbackBgColor};">
                        <div class="category-item-text-styled">${category.name}</div>
                    </a>
                </c:forEach>
            </div>

            <button id="scroll-right" class="category-scroll-button">
                &#8594;
            </button>
        </div>
    </div>
</section>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const container = document.getElementById('category-container');
        const scrollLeftBtn = document.getElementById('scroll-left');
        const scrollRightBtn = document.getElementById('scroll-right');

        if (container && scrollLeftBtn && scrollRightBtn) {
            const itemWidthActual = 210;
            const itemMarginRightActual = 20;
            const itemsToScroll = 2;
            const scrollAmount = (itemWidthActual + itemMarginRightActual) * itemsToScroll;

            scrollLeftBtn.addEventListener('click', function() {
                container.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
            });

            scrollRightBtn.addEventListener('click', function() {
                container.scrollBy({ left: scrollAmount, behavior: 'smooth' });
            });

            function updateScrollButtons() {
                if (!container) return;
                const maxScrollLeft = container.scrollWidth - container.clientWidth;
                const tolerance = 5;

                scrollLeftBtn.style.display = container.scrollLeft > tolerance ? 'flex' : 'none';
                scrollRightBtn.style.display = container.scrollLeft < (maxScrollLeft - tolerance) ? 'flex' : 'none';
            }

            container.addEventListener('scroll', updateScrollButtons);
            window.addEventListener('resize', function() {
                updateScrollButtons();
            });
            updateScrollButtons();
        }
    });
</script>
<!-- Sản phẩm OCOP -->
<section class="section-content mb-5">
    <div class="container">
        <header class="section-heading py-4 d-flex justify-content-between">
            <h3 class="section-title">Sản phẩm OCOP</h3>
        </header>
        <div class="row" style="display: flex;">
            <div class="col-md-3 banner-column" style="flex-shrink: 0;">
                <div class="mb-4 banner-container">
                    <img src="${pageContext.request.contextPath}/img/banner_left1.png" alt="Banner bên trái 1" class="img-fluid rounded" style="width: 100%; height: 100%; object-fit: cover; border-radius: 30px;">
                </div>
                <div class="mb-4 banner-container">
                    <img src="${pageContext.request.contextPath}/img/banner_left2.png" alt="Banner bên trái 2" class="img-fluid rounded" style="width: 100%; height: 100%; object-fit: cover; border-radius: 30px;">
                </div>
            </div>
            <div class="col-md-9 product-column">
                <div class="row item-grid" style="display: flex; flex-wrap: wrap;">
                    <c:forEach var="cat" items="${requestScope.categories}">
                        <c:if test="${cat.id == 2}">
                            <c:forEach var="product" items="${requestScope.productsByCategory[cat]}" varStatus="loop">
                                <c:if test="${loop.index < 9}">
                                    <div style="width: 33.33%; padding-left: 10px; padding-right: 10px; box-sizing: border-box;">
                                        <div class="card p-3 mb-4" style="display: flex; flex-direction: column; justify-content: space-between; min-height: 400px;">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="img-wrap text-center" style="height: 150px; width: 100%; display: flex; justify-content: center; align-items: center; overflow: hidden;">
                                                <c:choose>
                                                    <c:when test="${empty product.imageName}">
                                                        <img width="200" height="200" class="img-fluid" src="${pageContext.request.contextPath}/img/280px.png" alt="280px.png" style="max-width: 100%; max-height: 100%; object-fit: scale-down;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img width="200" height="200" class="img-fluid" src="${pageContext.request.contextPath}/image/${product.imageName}" alt="${product.imageName}" style="max-width: 100%; max-height: 100%; object-fit: scale-down;">
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <figcaption class="info-wrap mt-2">
                                                <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="title">${product.name}</a>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${product.discount == 0}">
                                                          <span class="price mt-1 fw-bold">
                                                             <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                                                          </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                          <span class="price mt-1 fw-bold">
                                                             <fmt:formatNumber pattern="#,##0" value="${product.price * (100 - product.discount) / 100}"/>₫
                                                          </span>
                                                            <span class="ms-2 text-muted text-decoration-line-through">
                                                             <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                                                          </span>
                                                            <span class="ms-2 badge bg-info">
                                                             -<fmt:formatNumber pattern="#,##0" value="${product.discount}"/>%
                                                          </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </figcaption>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="pt-3 text-center" style="margin-top: 20px;"> <a class="btn btn-secondary" href="${pageContext.request.contextPath}/category?id=2" role="button" style="height: fit-content;">Xem thêm sản phẩm</a>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section-content mb-5">
    <div class="banner-with-text position-relative mb-3" style="border-radius: 10px; overflow: hidden; margin-left: -15px; margin-right: -15px;">
        <img src="${pageContext.request.contextPath}/img/banner_thucpham.jpg" alt="Banner Thực phẩm và đặc sản" class="img-fluid" style="width: 100%; object-fit: cover; display: block;">
        <h3 class="section-title banner-text position-absolute top-50 text-white" style="font-size: 2rem; font-weight: bold; text-shadow: 2px 2px 4px rgba(0,0,0,0.6); left: 20vw; transform: translateY(-50%);">Thực phẩm và đặc sản</h3>
    </div>
    <div class="container">
        <div class="row item-grid">
            <c:forEach var="cat" items="${requestScope.categories}">
                <c:if test="${cat.id == 3}">
                    <c:forEach var="product" items="${requestScope.productsByCategory[cat]}" varStatus="loop">
                        <c:if test="${loop.index < 9}">
                            <div style="width: 33.33%; padding-left: 10px; padding-right: 10px; box-sizing: border-box;">
                                <div class="card p-3 mb-4" style="display: flex; flex-direction: column; justify-content: space-between; min-height: 400px;">
                                    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="img-wrap text-center" style="height: 150px; width: 100%; display: flex; justify-content: center; align-items: center; overflow: hidden;">
                                        <c:choose>
                                            <c:when test="${empty product.imageName}">
                                                <img width="200" height="200" class="img-fluid" src="${pageContext.request.contextPath}/img/280px.png" alt="280px.png" style="max-width: 100%; max-height: 100%; object-fit: scale-down;">
                                            </c:when>
                                            <c:otherwise>
                                                <img width="200" height="200" class="img-fluid" src="${pageContext.request.contextPath}/image/${product.imageName}" alt="${product.imageName}" style="max-width: 100%; max-height: 100%; object-fit: scale-down;">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <figcaption class="info-wrap mt-2">
                                        <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="title">${product.name}</a>
                                        <div>
                                            <c:choose>
                                                <c:when test="${product.discount == 0}">
                                        <span class="price mt-1 fw-bold">
                                            <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                                        </span>
                                                </c:when>
                                                <c:otherwise>
                                        <span class="price mt-1 fw-bold">
                                            <fmt:formatNumber pattern="#,##0" value="${product.price * (100 - product.discount) / 100}"/>₫
                                        </span>
                                                    <span class="ms-2 text-muted text-decoration-line-through">
                                            <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                                        </span>
                                                    <span class="ms-2 badge bg-info">
                                            -<fmt:formatNumber pattern="#,##0" value="${product.discount}"/>%
                                        </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </figcaption>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <header class="section-heading py-4 d-flex justify-content-end">
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/category?id=3" role="button" style="height: fit-content;text-align: center;">Xem thêm sản phẩm</a>
        </header>
    </div>
</section>

<section class="section-content mb-5">
    <div class="banner-with-text position-relative mb-3" style="border-radius: 10px; overflow: hidden; margin-left: -15px; margin-right: -15px;">
        <img src="${pageContext.request.contextPath}/img/banner_douong.jpg" alt="Banner Đồ uống" class="img-fluid" style="width: 100%; object-fit: cover; display: block;">
        <h3 class="section-title banner-text position-absolute top-50 text-white" style="font-size: 2rem; font-weight: bold; text-shadow: 2px 2px 4px rgba(0,0,0,0.6); left: 20vw; transform: translateY(-50%);">Đồ uống</h3>
    </div>
    <div class="container">
        <div class="row item-grid">
            <c:forEach var="cat" items="${requestScope.categories}">
                <c:if test="${cat.id == 5}">
                    <c:forEach var="product" items="${requestScope.productsByCategory[cat]}" varStatus="loop">
                        <c:if test="${loop.index < 8}">
                            <div class="col-xl-3 col-lg-4 col-md-6">
                                <div class="card p-3 mb-4">
                                    <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="img-wrap text-center">
                                        <c:choose>
                                            <c:when test="${empty product.imageName}">
                                                <img width="200" height="200" class="img-fluid" src="${pageContext.request.contextPath}/img/280px.png" alt="280px.png">
                                            </c:when>
                                            <c:otherwise>
                                                <img width="200" height="200" class="img-fluid" src="${pageContext.request.contextPath}/image/${product.imageName}" alt="${product.imageName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                    <figcaption class="info-wrap mt-2">
                                        <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="title">${product.name}</a>
                                        <div>
                                            <c:choose>
                                                <c:when test="${product.discount == 0}">
                                          <span class="price mt-1 fw-bold">
                                             <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                                          </span>
                                                </c:when>
                                                <c:otherwise>
                                          <span class="price mt-1 fw-bold">
                                             <fmt:formatNumber pattern="#,##0" value="${product.price * (100 - product.discount) / 100}"/>₫
                                          </span>
                                                    <span class="ms-2 text-muted text-decoration-line-through">
                                             <fmt:formatNumber pattern="#,##0" value="${product.price}"/>₫
                                          </span>
                                                    <span class="ms-2 badge bg-info">
                                             -<fmt:formatNumber pattern="#,##0" value="${product.discount}"/>%
                                          </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </figcaption>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
        <header class="section-heading py-4 d-flex justify-content-end">
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/category?id=5" role="button" style="height: fit-content;text-align: center;">Xem thêm sản phẩm</a>
        </header>
    </div>
</section>

<jsp:include page="_footer.jsp"/>
</body>

</html>