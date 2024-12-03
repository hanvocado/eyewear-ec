<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<body>
	<div class="main">
		<div class="container">
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">

				<!-- BEGIN SIDEBAR -->
				<div class="sidebar col-md-3 col-sm-5">
					<ul class="list-group margin-bottom-25 sidebar-menu">
						<!-- Lặp qua danh sách các danh mục -->
						<c:forEach var="category" items="${categories}">
							<li class="list-group-item clearfix">
								<!-- Tạo link để hiển thị sản phẩm theo danh mục --> <a
								href="javascript:void(0)" class="collapsed"> <i
									class="fa fa-angle-right"></i> <span>${category.name}</span>
							</a> <!-- Nếu category có sản phẩm --> <c:if
									test="${not empty category.products}">
									<ul class="dropdown-menu" style="display: none;">
										<!-- Lặp qua các sản phẩm trong danh mục -->
										<c:forEach var="product" items="${category.products}">
											<li class="list-group-item clearfix"><a
												href="/common/products/detail/${product.id}"> <i
													class="fa fa-angle-right"></i> ${product.name}
											</a></li>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- END SIDEBAR -->
				<!-- BEGIN CONTENT -->
                <div class="col-md-9 col-sm-7">
                    <div class="row list-view-sorting clearfix">
                        <div class="col-md-10 col-sm-10">
                            <form action="/common/products" method="get">
                                <div class="pull-right">
                                    <label class="control-label">Show:</label>
                                    <select name="size" id="size" onchange="this.form.submit()">
                                        <option ${productPage.size == 3 ? 'selected' : ''} value="3">3</option>
                                        <option ${productPage.size == 5 ? 'selected' : ''} value="5">5</option>
                                        <option ${productPage.size == 10 ? 'selected' : ''} value="10">10</option>
                                        <option ${productPage.size == 15 ? 'selected' : ''} value="15">15</option>
                                        <option ${productPage.size == 20 ? 'selected' : ''} value="20">20</option>
                                    </select>
                                </div>
                            </form>
                            <div class="pull-right">
                                <label class="control-label">Sort&nbsp;By:</label>
                                <select class="form-control input-sm">
                                    <option value="#?sort=p.sort_order&amp;order=ASC" selected="selected">Default</option>
                                    <option value="#?sort=pd.name&amp;order=ASC">Name (A - Z)</option>
                                    <option value="#?sort=pd.name&amp;order=DESC">Name (Z - A)</option>
                                    <option value="#?sort=p.price&amp;order=ASC">Price (Low &gt; High)</option>
                                    <option value="#?sort=p.price&amp;order=DESC">Price (High &gt; Low)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <!-- Toast Notification -->
                    <c:if test="${not empty successMessage}">
                      <div class="flash-message alert alert-success">
                          <strong>${successMessage}</strong> 
                      </div>
                  </c:if>
                  
                  <c:if test="${not empty errorMessage}">
                      <div class="flash-message alert alert-danger">
                          <strong>Lỗi:</strong> ${errorMessage}
                      </div>
                  </c:if>
                  <!-- Toast Notification -->
                    <!-- BEGIN PRODUCT LIST -->
                    <div class="row product-list">
                        <c:forEach var="product" items="${productPage.content}">
                            <!-- PRODUCT ITEM START -->
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <div class="product-item">
                                    <div class="pi-img-wrapper">
                                        <img src="${product.imageUrl}" class="img-responsive" alt="${product.name}">
                                        <div>
                                            <a href="${product.imageUrl}" class="btn btn-default fancybox-button">Zoom</a>
                                            <a href="/common/products/detail/${product.id}" class="btn btn-default fancybox-fast-view">View</a>
                                        </div>
                                    </div>
                                    <h3><a href="shop-item.html">${product.name}</a></h3>

                                    <h4> ${product.brand}</h4>
									<div class="pi-price">
										<fmt:formatNumber value="${product.price}" type="number"
											minFractionDigits="0" maxFractionDigits="1" />
									</div>
									<a href="<c:url value='/buyer/cart/addCartItem?productID=${product.id}'/>" class="btn btn-default add2cart">Add to cart</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- END PRODUCT ITEM LIST -->
                    
                    <!-- PHÂN TRANG -->
					<div class="row">
						<!-- Display information about the current items -->
						<div class="col-md-4 col-sm-4 items-info">Sản phẩm 
							${productPage.number * productPage.size + 1}-
							${productPage.number * productPage.size + productPage.numberOfElements}
							trong tổng số ${productPage.totalElements} sản phẩm</div>
						<!-- Pagination -->
						<div class="col-md-8 col-sm-8">
							<ul class="pagination pull-right">
								<!-- Previous page link -->
								<c:if test="${productPage.number > 0}">
									<li><a
										href="<c:url value='/common/products?size=${productPage.size}&page=${productPage.number}'/>"
										class="prev-page">&laquo;</a></li>
								</c:if>
								<c:if test="${productPage.number == 0}">
									<li class="disabled"><a href="javascript:void(0)"
										class="prev-page">&laquo;</a></li>
								</c:if>

								<!-- Page numbers -->
								<c:forEach items="${pageNumbers}" var="pageNumber">
									<li
										class="${pageNumber == productPage.number + 1 ? 'page-item active' : 'page-item'}">
										<a
										href="<c:url value='/common/products?size=${productPage.size}&page=${pageNumber}'/>">
											${pageNumber} </a>
									</li>
								</c:forEach>

								<!-- Next page link -->
								<c:if test="${productPage.number < productPage.totalPages - 1}">
									<li><a
										href="<c:url value='/common/products?size=${productPage.size}&page=${productPage.number+2}'/>"
										class="next-page">&raquo;</a></li>
								</c:if>
								<c:if test="${productPage.number == productPage.totalPages - 1}">
									<li class="disabled"><a href="javascript:void(0)"
										class="next-page">&raquo;</a></li>
								</c:if>
							</ul>
						</div>
					</div>
					<!-- END PAGINATOR -->
				</div>
				<!-- END CONTENT -->
			</div>
			<!-- END SIDEBAR & CONTENT -->
		</div>
	</div>
</body>