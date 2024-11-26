<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<title>Kết quả tìm kiếm</title>

<body>
	<div class="main">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="index.html">Home</a></li>
				<li><a href="">Store</a></li>
				<li class="active">Search result</li>
			</ul>
			<!-- LỌC VÀ SẢN PHẨM -->
			<div class="row margin-bottom-40">
				<!-- LỌC SẢN PHẨM -->
				<div class="sidebar col-md-3 col-sm-5">
					<div class="sidebar-filter margin-bottom-25">
						<h2>LỌC SẢN PHẨM</h2>
						<!-- Lọc theo Danh mục -->
						<form method="get" action="/common/products/filter">
							<h3>Loại sản phẩm</h3>
							<div class="checkbox-list">
								<!-- Lặp qua tất cả các danh mục -->
								<c:forEach var="category" items="${categories}">
									<label> <input type="checkbox" name="categoryName"
										value="${category.name}"> ${category.name}
									</label>
								</c:forEach>
							</div>
							<!-- Lọc theo thương hiệu -->
							<h3>Thương hiệu</h3>
							<div class="checkbox-list">
								<c:forEach var="brand" items="${brands }">
									<label><input type="checkbox" name="brand"
										value="${brand }" /> ${brand } </label>
								</c:forEach>
							</div>
							<!-- Lọc theo Khoảng giá -->
							<h3>Giá</h3>
							<p>
								<label for="amount">Range:</label> <input type="text"
									id="amount"
									style="border: 0; color: #f6931f; font-weight: bold;">
							</p>
							<div id="slider-range"></div>
							
							<div class="filter-button-container text-center">
								<button type="submit" class="btn btn-primary">Lọc</button>
							</div>
							<input type="hidden" name="name" value="${name}">
							
						</form>
					</div>
				</div>
				<!-- KẾT THÚC LỌC -->

				<!-- NỘI DUNG -->
				<div class="col-md-9 col-sm-7">
					<div class="content-search margin-bottom-20">
						<div class="row">
							<div class="col-md-6">
								<h1>
									Kết quả tìm kiếm: <em>${name}</em>
								</h1>
							</div>
							<div class="col-md-6">
								<form action="/common/products/search" method="get">
									<div class="input-group">
										<input type="text" name="name" id="name"
											placeholder="Nhập tên sản phẩm" class="form-control"
											value="${name}"> <span class="input-group-btn">
											<button class="btn btn-primary" type="submit">Tìm
												kiếm</button>
										</span>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="row list-view-sorting clearfix">
						<div class="col-md-2 col-sm-2 list-view">
							<a href="#"><i class="fa fa-th-large"></i></a> <a href="#"><i
								class="fa fa-th-list"></i></a>
						</div>
						<div class="col-md-10 col-sm-10">
							<div class="pull-right">
								<form action="/common/products/searchpaginated" method="get">
									<div class="pull-right">
										<label class="control-label">Show:</label> <select name="size"
											id="size" onchange="this.form.submit()">
											<option ${productPage.size == 3 ? 'selected' : ''} value="3">3</option>
											<option ${productPage.size == 5 ? 'selected' : ''} value="5">5</option>
											<option ${productPage.size == 10 ? 'selected' : ''}
												value="10">10</option>
											<option ${productPage.size == 15 ? 'selected' : ''}
												value="15">15</option>
											<option ${productPage.size == 20 ? 'selected' : ''}
												value="20">20</option>
										</select> 
										<!-- Lấy tham số name và số trang -->
										<input type="hidden" name="name" value="${name}"> 
										<input type="hidden" name="page" value="${productPage.number+1}">	
									</div>
								</form>
							</div>
							<div class="pull-right">
								<label class="control-label">Sort&nbsp;By:</label> <select
									class="form-control input-sm">
									<option value="#?sort=p.sort_order&amp;order=ASC"
										selected="selected">Default</option>
									<option value="#?sort=pd.name&amp;order=ASC">Name (A -
										Z)</option>
									<option value="#?sort=pd.name&amp;order=DESC">Name (Z
										- A)</option>
									<option value="#?sort=p.price&amp;order=ASC">Price
										(Low &gt; High)</option>
									<option value="#?sort=p.price&amp;order=DESC">Price
										(High &gt; Low)</option>
								</select>
							</div>
						</div>
					</div>
					<!-- BEGIN PRODUCT LIST -->
					<div class="row product-list">
						<!-- PRODUCT ITEM START -->
						<c:if test="${not empty message}">
							<div class="alert alert-info">
								<p>${message}</p>
							</div>
						</c:if>
						<div class="row product-list">
                        <c:forEach var="product" items="${productPage.content}">
                            <!-- PRODUCT ITEM START -->
                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <div class="product-item">
                                    <div class="pi-img-wrapper">
                                        <img src="${product.imageUrl}" class="img-responsive" alt="${product.name}">
                                        <div>
                                            <a href="${product.imageUrl}" class="btn btn-default fancybox-button">Zoom</a>
                                            <a href="/common/products/detail" class="btn btn-default fancybox-fast-view">View</a>
                                        </div>
                                    </div>
                                    <h3><a href="shop-item.html">${product.name}</a></h3>
                                    <h4> ${product.brand}</h4>
									<div class="pi-price">
										<fmt:formatNumber value="${product.price}" type="number"
											minFractionDigits="0" maxFractionDigits="1" />
									</div>
									<a href="#" class="btn btn-default add2cart">Thêm vào giỏ hàng</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
						<!-- PRODUCT ITEM END -->
					</div>
					<!-- END PRODUCT LIST -->
					<!-- BEGIN PAGINATOR -->
					<div class="col-md-8 col-sm-8">
						<ul class="pagination pull-right">
							<!-- Previous page link -->
							<c:if test="${productPage.number > 0}">
								<li><a
									href="<c:url value='/common/products/searchpaginated?name=${name}&size=${productPage.size}&page=${productPage.number}'/>"
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
									href="<c:url value='/common/products/searchpaginated?name=${name}&size=${productPage.size}&page=${pageNumber}'/>">
										${pageNumber} </a>
								</li>
							</c:forEach>

							<!-- Next page link -->
							<c:if test="${productPage.number < productPage.totalPages - 1}">
								<li><a
									href="<c:url value='/common/products/searchpaginated?name=${name}&size=${productPage.size}&page=${productPage.number + 2}'/>"
									class="next-page">&raquo;</a></li>
							</c:if>
							<c:if test="${productPage.number == productPage.totalPages - 1}">
								<li class="disabled"><a href="javascript:void(0)"
									class="next-page">&raquo;</a></li>
							</c:if>
						</ul>
					</div>

					<!-- END PAGINATOR -->
				</div>
				<!-- END CONTENT -->
			</div>
			<!-- END SIDEBAR & CONTENT -->
		</div>
	</div>
</body>

