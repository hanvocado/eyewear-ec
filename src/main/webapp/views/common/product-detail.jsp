<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>Chi tiết sản phẩm</title>
<body>
	<div class="main">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="index.html">Home</a></li>
				<li><a href="">Store</a></li>
				<li class="active">Cool green dress with red bell</li>
			</ul>
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN SIDEBAR -->
				<div class="sidebar col-md-3 col-sm-5">
					<ul class="list-group margin-bottom-25 sidebar-menu">
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Ladies</a></li>
						<li class="list-group-item clearfix dropdown active"><a
							href="shop-product-list.html" class="collapsed"> <i
								class="fa fa-angle-right"></i> Mens

						</a>
							<ul class="dropdown-menu" style="display: block;">
								<li class="list-group-item dropdown clearfix active"><a
									href="shop-product-list.html" class="collapsed"><i
										class="fa fa-angle-right"></i> Shoes </a>
									<ul class="dropdown-menu" style="display: block;">
										<li class="list-group-item dropdown clearfix"><a
											href="shop-product-list.html"><i
												class="fa fa-angle-right"></i> Classic </a>
											<ul class="dropdown-menu">
												<li><a href="shop-product-list.html"><i
														class="fa fa-angle-right"></i> Classic 1</a></li>
												<li><a href="shop-product-list.html"><i
														class="fa fa-angle-right"></i> Classic 2</a></li>
											</ul></li>
										<li class="list-group-item dropdown clearfix active"><a
											href="shop-product-list.html" class="collapsed"><i
												class="fa fa-angle-right"></i> Sport </a>
											<ul class="dropdown-menu" style="display: block;">
												<li class="active"><a href="shop-product-list.html"><i
														class="fa fa-angle-right"></i> Sport 1</a></li>
												<li><a href="shop-product-list.html"><i
														class="fa fa-angle-right"></i> Sport 2</a></li>
											</ul></li>
									</ul></li>
								<li><a href="shop-product-list.html"><i
										class="fa fa-angle-right"></i> Trainers</a></li>
								<li><a href="shop-product-list.html"><i
										class="fa fa-angle-right"></i> Jeans</a></li>
								<li><a href="shop-product-list.html"><i
										class="fa fa-angle-right"></i> Chinos</a></li>
								<li><a href="shop-product-list.html"><i
										class="fa fa-angle-right"></i> T-Shirts</a></li>
							</ul></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Kids</a></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Accessories</a></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Sports</a></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Brands</a></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Electronics</a></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Home &amp; Garden</a></li>
						<li class="list-group-item clearfix"><a
							href="shop-product-list.html"><i class="fa fa-angle-right"></i>
								Custom Link</a></li>
					</ul>
				</div>
				<!-- END SIDEBAR -->

				<!-- BEGIN CONTENT -->
				<div class="col-md-9 col-sm-7">
					<div class="product-page">
						<div class="row">
							<div class="col-md-6 col-sm-6">
								<div class="product-main-image">
									<img src="${product.imageUrl}" alt="${product.name}"
										class="img-responsive" data-BigImgsrc="${product.imageUrl}">
								</div>
								<div class="product-other-images">
									<a href="/assets/frontend/pages/img/products/model3.jpg"
										class="fancybox-button" rel="photos-lib"><img
										alt="Berry Lace Dress"
										src="/assets/frontend/pages/img/products/model3.jpg"></a> <a
										href="/assets/frontend/pages/img/products/model4.jpg"
										class="fancybox-button" rel="photos-lib"><img
										alt="Berry Lace Dress"
										src="/assets/frontend/pages/img/products/model4.jpg"></a> <a
										href="/assets/frontend/pages/img/products/model5.jpg"
										class="fancybox-button" rel="photos-lib"><img
										alt="Berry Lace Dress"
										src="/assets/frontend/pages/img/products/model5.jpg"></a>
								</div>
							</div>
							<div class="col-md-6 col-sm-6">
								<h1>${product.name }</h1>
								<div class="price-availability-block clearfix">
									<div class="price">
										<strong><span> <fmt:formatNumber
													value="${product.price}" type="number"
													minFractionDigits="0" maxFractionDigits="1" /></span></strong> <em>$<span>62.00</span></em>
									</div>
									<div class="availability">
										Thương hiệu: <strong>${product.brand }</strong>
									</div>
								</div>
								<div class="description">
									<p>${product.description}</p>
								</div>
								<div class="product-page-options">
									<div class="pull-left">
										<label class="control-label">Size:</label> <select
											class="form-control input-sm">
											<option>L</option>
											<option>M</option>
											<option>XL</option>
										</select>
									</div>
									<div class="pull-left">
										<label class="control-label">Color:</label> <select
											class="form-control input-sm">
											<option>Red</option>
											<option>Blue</option>
											<option>Black</option>
										</select>
									</div>
								</div>
								<div class="product-page-cart">
									<div class="product-quantity">
										<input id="product-quantity" type="text" value="1" readonly
											class="form-control input-sm">
									</div>
									<button class="btn btn-primary" type="submit">Add to
										cart</button>
								</div>
								<div class="review">
									<input type="range" value="4" step="0.25" id="backing4">
									<div class="rateit" data-rateit-backingfld="#backing4"
										data-rateit-resetable="false" data-rateit-ispreset="true"
										data-rateit-min="0" data-rateit-max="5"></div>
									<a href="#">7 reviews</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">Write
										a review</a>
								</div>
								<ul class="social-icons">
									<li><a class="facebook" data-original-title="facebook"
										href="#"></a></li>
									<li><a class="twitter" data-original-title="twitter"
										href="#"></a></li>
									<li><a class="googleplus" data-original-title="googleplus"
										href="#"></a></li>
									<li><a class="evernote" data-original-title="evernote"
										href="#"></a></li>
									<li><a class="tumblr" data-original-title="tumblr"
										href="#"></a></li>
								</ul>
							</div>

							<div class="product-page-content">
								<ul id="myTab" class="nav nav-tabs">
									<li><a href="#Description" data-toggle="tab">Mô tả</a></li>
									<li><a href="#Information" data-toggle="tab">Thông tin
											sản phẩm</a></li>
									<li class="active"><a href="#Reviews" data-toggle="tab">Đánh
											giá (2)</a></li>
								</ul>
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade" id="Description">
										<p>${product.description }</p>
									</div>
									<div class="tab-pane fade" id="Information">
										<table class="datasheet">
											<tr>
												<th colspan="2">Thông số sản phẩm</th>
											</tr>
											<tr>
												<td class="datasheet-features-type">Danh mục</td>
												<td>${product.category.name}</td>
												<!-- Danh mục của sản phẩm -->
											</tr>
											<tr>
												<td class="datasheet-features-type">Thương hiệu</td>
												<td>${product.brand}</td>
												<!-- Thương hiệu của sản phẩm -->
											</tr>
											
											<!-- Kiểm tra loại sản phẩm từ danh mục để hiển thị thông tin phù hợp -->
											<tr>
												<td class="datasheet-features-type">Thông số</td>
												<%-- <td>
													<!-- Nếu là gọng kính --> <c:if
														test="${productType == 'Gọng Kính'}">
            											Ngang kính: ${product.width} mm<br>
            											Ngang mắt: ${product.eyeWidth} mm<br>
            											Dọc mắt: ${product.eyeHeight} mm<br>
            											Ngang mũi: ${product.noseBridge} mm<br>
            											Dài càng: ${product.templeLength} mm
        												</c:if> 
        												<!-- Nếu là tròng kính --> 
        												<c:if test="${productType == 'Tròng Kính'}">
            											Loại tròng: ${product.lensType}<br>
            											Màu tròng: ${product.lensColor}<br>
            											Độ cận: ${product.lensDegree} diop
        												</c:if> 
        												<!-- Nếu là phụ kiện --> 
        												<c:if test="${productType == 'Khác'}">
            											Loại phụ kiện: ${product.accessoryType}<br>
            											Kích thước: ${product.accessorySize}<br>
            											Màu sắc: ${product.accessoryColor}
       													</c:if>
												</td> --%>
											</tr>
										</table>
									</div>

									<div class="tab-pane fade in active" id="Reviews">
										<!--<p>There are no reviews for this product.</p>-->
										<c:forEach var="reviews" items="${reviews}">
										<div class="review-item clearfix">
											<div class="review-item-submitted">
												<strong>${reviews.buyer.name }</strong> <em>${reviews.reviewDate }</em>
												<div class="rateit" data-rateit-value="${reviews.rating }"
													data-rateit-ispreset="true" data-rateit-readonly="true"></div>
											</div>
											<div class="review-item-content">
												<p>${reviews.reviewContent}</p>
											</div>
										</div>
										</c:forEach>
									</div>
								</div>
							</div>

							<div class="sticker sticker-sale"></div>
						</div>
					</div>
				</div>
				<!-- END CONTENT -->
			</div>
			<!-- END SIDEBAR & CONTENT -->

			<!-- BEGIN SIMILAR PRODUCTS -->
			<div class="row margin-bottom-40">
				<div class="col-md-12 col-sm-12">
					<h2>Sản phẩm tương tự</h2>
					<div class="owl-carousel owl-carousel4">
						<c:forEach var="similarProduct" items="${similarProducts}">
							<div>
								<div class="product-item">
									<div class="pi-img-wrapper">
										<img src="${similarProduct.imageUrl}" class="img-responsive"
											alt="${similarProduct.name}">
										<div>
											<a href="${similarProduct.imageUrl}"
												class="btn btn-default fancybox-button">Zoom</a> <a
												href="/common/products/detail/${similarProduct.id}"
												class="btn btn-default fancybox-fast-view">View</a>
										</div>
									</div>
									<h3>
										<a href="/common/products/detail/${similarProduct.id}">${similarProduct.name}</a>
									</h3>
									<div class="pi-price">
										<fmt:formatNumber value="${similarProduct.price}"
											type="number" />
									</div>
									<a href="/cart/add/${similarProduct.id}"
										class="btn btn-default add2cart">Add to cart</a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!-- END SIMILAR PRODUCTS -->
		</div>
	</div>

</body>
