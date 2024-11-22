<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<title>Kết quả tìm kiếm</title>

<body class="ecommerce">
	<!-- BEGIN STYLE CUSTOMIZER -->
	<div class="color-panel hidden-sm">
		<div class="color-mode-icons icon-color"></div>
		<div class="color-mode-icons icon-color-close"></div>
		<div class="color-mode">
			<p>THEME COLOR</p>
			<ul class="inline">
				<li class="color-red current color-default" data-style="red"></li>
				<li class="color-blue" data-style="blue"></li>
				<li class="color-green" data-style="green"></li>
				<li class="color-orange" data-style="orange"></li>
				<li class="color-gray" data-style="gray"></li>
				<li class="color-turquoise" data-style="turquoise"></li>
			</ul>
		</div>
	</div>
	<!-- END BEGIN STYLE CUSTOMIZER -->

	<div class="main">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="index.html">Home</a></li>
				<li><a href="">Store</a></li>
				<li class="active">Search result</li>
			</ul>
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN SIDEBAR -->
				<div class="sidebar col-md-3 col-sm-5">
					<div class="sidebar-filter margin-bottom-25">
						<h2>Search categories</h2>
						<h3>Availability</h3>
						<div class="checkbox-list">
							<label><input type="checkbox"> Not Available (3)</label>
							<label><input type="checkbox"> In Stock (26)</label>
						</div>

						<h3>Price</h3>
						<p>
							<label for="amount">Range:</label> <input type="text" id="amount"
								style="border: 0; color: #f6931f; font-weight: bold;">
						</p>
						<div id="slider-range"></div>
					</div>

					<div class="sidebar-products clearfix">
						<h2>Bestsellers</h2>
						<div class="item">
							<a href="shop-item.html"><img
								src="${URL}/assets/frontend/pages/img/products/k1.jpg"
								alt="Some Shoes in Animal with Cut Out"></a>
							<h3>
								<a href="shop-item.html">Some Shoes in Animal with Cut Out</a>
							</h3>
							<div class="price">$31.00</div>
						</div>
						<div class="item">
							<a href="shop-item.html"><img
								src="${URL}/assets/frontend/pages/img/products/k4.jpg"
								alt="Some Shoes in Animal with Cut Out"></a>
							<h3>
								<a href="shop-item.html">Some Shoes in Animal with Cut Out</a>
							</h3>
							<div class="price">$23.00</div>
						</div>
						<div class="item">
							<a href="shop-item.html"><img
								src="${URL}/assets/frontend/pages/img/products/k3.jpg"
								alt="Some Shoes in Animal with Cut Out"></a>
							<h3>
								<a href="shop-item.html">Some Shoes in Animal with Cut Out</a>
							</h3>
							<div class="price">$86.00</div>
						</div>
					</div>
				</div>
				<!-- END SIDEBAR -->
				<!-- BEGIN CONTENT -->
				
				<!-- Thêm -->
				<%-- <c:if test="${message != null}">
					<i>${message}</i>
				</c:if>
				<!-- Hết thông báo --> --%>
				<form action="/common/products/search" method="get">
					<input type="text" name="name" id="name"
						placeholder="Nhập tên sản phẩm" />
					<button>Search</button>
				</form>
				<table>
					<tr>
						<th>STT</th>
						<th>Brand</th>
						<th>Name</th>
						<th>Description</th>
						<th>Price</th>
					</tr>
					<c:forEach items="${productPage.content}" var="product" varStatus="STT">
						<tr>
							<td>${STT.index + 1}</td>
							<td>${product.brand}</td>
							<td>${product.name}</td>
							<td>${product.description}</td>
							<td>${product.price}</td>
					</c:forEach>
				</table>

				<form action="/common/products/search" method="get">
					Page size: <select name="size" id="size"
						onchange="this.form.submit()">
						<option ${productPage.size == 3 ? 'selected' : ''} value="3">3</option>
						<option ${productPage.size == 5 ? 'selected' : ''} value="5">5</option>
						<option ${productPage.size == 10 ? 'selected' : ''} value="10">10</option>
						<option ${productPage.size == 15 ? 'selected' : ''} value="15">15</option>
						<option ${productPage.size == 20 ? 'selected' : ''} value="20">20</option>
					</select>
				</form>
				<c:if test="${productPage.totalPages > 0}">
					<ul>
						<c:forEach items="${pageNumbers}" var="pageNumber">
							<c:if test="${product.totalPages > 1}">
								<li
									class="${pageNumber == product.number + 1 ? 'page-item active' : 'page-item'}">
									<a
									href="<c:url value='/common/products/search?name=${name}&size=${product.size}&page=${pageNumber}'/>">${pageNumber}</a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</c:if>
				<!-- -- Thêm -- -->
				
				<div class="col-md-9 col-sm-7">
					<div class="content-search margin-bottom-20">
						<div class="row">
							<div class="col-md-6">
								<h1>
									Search result for <em>shoes</em>
								</h1>
							</div>
							<div class="col-md-6">
								<form action="#">
									<div class="input-group">
										<input type="text" placeholder="Search again"
											class="form-control"> <span class="input-group-btn">
											<button class="btn btn-primary" type="submit">Search</button>
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
								<label class="control-label">Show:</label> <select
									class="form-control input-sm">
									<option value="#?limit=24" selected="selected">24</option>
									<option value="#?limit=25">25</option>
									<option value="#?limit=50">50</option>
									<option value="#?limit=75">75</option>
									<option value="#?limit=100">100</option>
								</select>
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
									<option value="#?sort=rating&amp;order=DESC">Rating
										(Highest)</option>
									<option value="#?sort=rating&amp;order=ASC">Rating
										(Lowest)</option>
									<option value="#?sort=p.model&amp;order=ASC">Model (A
										- Z)</option>
									<option value="#?sort=p.model&amp;order=DESC">Model (Z
										- A)</option>
								</select>
							</div>
						</div>
					</div>
					<!-- BEGIN PRODUCT LIST -->
					<div class="row product-list">
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model1.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model1.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model2.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model2.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model6.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model6.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress 2</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
					</div>
					<div class="row product-list">
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model4.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model4.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model5.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model5.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
								<div class="sticker sticker-new"></div>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model3.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model3.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
					</div>
					<div class="row product-list">
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model7.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model7.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model1.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href=="${URL}assets/frontend/pages/img/products/model1.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
						<!-- PRODUCT ITEM START -->
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="product-item">
								<div class="pi-img-wrapper">
									<img src="${URL}/assets/frontend/pages/img/products/model2.jpg"
										class="img-responsive" alt="Berry Lace Dress">
									<div>
										<a href="${URL}/assets/frontend/pages/img/products/model2.jpg"
											class="btn btn-default fancybox-button">Zoom</a> <a
											href="#product-pop-up"
											class="btn btn-default fancybox-fast-view">View</a>
									</div>
								</div>
								<h3>
									<a href="shop-item.html">Berry Lace Dress</a>
								</h3>
								<div class="pi-price">$29.00</div>
								<a href="#" class="btn btn-default add2cart">Add to cart</a>
								<div class="sticker sticker-sale"></div>
							</div>
						</div>
						<!-- PRODUCT ITEM END -->
					</div>
					<!-- END PRODUCT LIST -->
					<!-- BEGIN PAGINATOR -->
					<div class="row">
						<div class="col-md-4 col-sm-4 items-info">Items 1 to 9 of 10
							total</div>
						<div class="col-md-8 col-sm-8">
							<ul class="pagination pull-right">
								<li><a href="#">&laquo;</a></li>
								<li><a href="#">1</a></li>
								<li><span>2</span></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">&raquo;</a></li>
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

	<!-- BEGIN BRANDS -->
	<div class="brands">
		<div class="container">
			<div class="owl-carousel owl-carousel6-brands">
				<a href="shop-product-list.html"><img
					src/assets/frontend/pages/img/brands/canon.jpg" alt="canon"
					title="canon"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/esprit.jpg"
					alt="esprit" title="esprit"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/gap.jpg" alt="gap"
					title="gap"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/next.jpg" alt="next"
					title="next"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/puma.jpg" alt="puma"
					title="puma"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/zara.jpg" alt="zara"
					title="zara"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/canon.jpg" alt="canon"
					title="canon"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/esprit.jpg"
					alt="esprit" title="esprit"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/gap.jpg" alt="gap"
					title="gap"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/next.jpg" alt="next"
					title="next"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/puma.jpg" alt="puma"
					title="puma"></a> <a href="shop-product-list.html"><img
					src="${URL}/assets/frontend/pages/img/brands/zara.jpg" alt="zara"
					title="zara"></a>
			</div>
		</div>
	</div>
	<!-- END BRANDS -->

	<!-- BEGIN STEPS -->
	<div class="steps-block steps-block-red">
		<div class="container">
			<div class="row">
				<div class="col-md-4 steps-block-col">
					<i class="fa fa-truck"></i>
					<div>
						<h2>Free shipping</h2>
						<em>Express delivery withing 3 days</em>
					</div>
					<span>&nbsp;</span>
				</div>
				<div class="col-md-4 steps-block-col">
					<i class="fa fa-gift"></i>
					<div>
						<h2>Daily Gifts</h2>
						<em>3 Gifts daily for lucky customers</em>
					</div>
					<span>&nbsp;</span>
				</div>
				<div class="col-md-4 steps-block-col">
					<i class="fa fa-phone"></i>
					<div>
						<h2>477 505 8877</h2>
						<em>24/7 customer care available</em>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END STEPS -->

	<!-- BEGIN PRE-FOOTER -->
	<div class="pre-footer">
		<div class="container">
			<div class="row">
				<!-- BEGIN BOTTOM ABOUT BLOCK -->
				<div class="col-md-3 col-sm-6 pre-footer-col">
					<h2>About us</h2>
					<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit,
						sed diam sit nonummy nibh euismod tincidunt ut laoreet dolore
						magna aliquarm erat sit volutpat. Nostrud exerci tation
						ullamcorper suscipit lobortis nisl aliquip commodo consequat.</p>
					<p>Duis autem vel eum iriure dolor vulputate velit esse
						molestie at dolore.</p>
				</div>
				<!-- END BOTTOM ABOUT BLOCK -->
				<!-- BEGIN BOTTOM INFO BLOCK -->
				<div class="col-md-3 col-sm-6 pre-footer-col">
					<h2>Information</h2>
					<ul class="list-unstyled">
						<li><i class="fa fa-angle-right"></i> <a href="#">Delivery
								Information</a></li>
						<li><i class="fa fa-angle-right"></i> <a href="#">Customer
								Service</a></li>
						<li><i class="fa fa-angle-right"></i> <a href="#">Order
								Tracking</a></li>
						<li><i class="fa fa-angle-right"></i> <a href="#">Shipping
								& Returns</a></li>
						<li><i class="fa fa-angle-right"></i> <a href="contacts.html">Contact
								Us</a></li>
						<li><i class="fa fa-angle-right"></i> <a href="#">Careers</a></li>
						<li><i class="fa fa-angle-right"></i> <a href="#">Payment
								Methods</a></li>
					</ul>
				</div>
				<!-- END INFO BLOCK -->

				<!-- BEGIN TWITTER BLOCK -->
				<div class="col-md-3 col-sm-6 pre-footer-col">
					<h2 class="margin-bottom-0">Latest Tweets</h2>
					<a class="twitter-timeline" href="https://twitter.com/twitterapi"
						data-tweet-limit="2" data-theme="dark" data-link-color="#57C8EB"
						data-widget-id="455411516829736961"
						data-chrome="noheader nofooter noscrollbar noborders transparent">Loading
						tweets by @keenthemes...</a>
				</div>
				<!-- END TWITTER BLOCK -->

				<!-- BEGIN BOTTOM CONTACTS -->
				<div class="col-md-3 col-sm-6 pre-footer-col">
					<h2>Our Contacts</h2>
					<address class="margin-bottom-40">
						35, Lorem Lis Street, Park Ave<br> California, US<br>
						Phone: 300 323 3456<br> Fax: 300 323 1456<br> Email: <a
							href="mailto:info@metronic.com">info@metronic.com</a><br>
						Skype: <a href="skype:metronic">metronic</a>
					</address>
				</div>
				<!-- END BOTTOM CONTACTS -->
			</div>
			<hr>
			<div class="row">
				<!-- BEGIN SOCIAL ICONS -->
				<div class="col-md-6 col-sm-6">
					<ul class="social-icons">
						<li><a class="rss" data-original-title="rss" href="#"></a></li>
						<li><a class="facebook" data-original-title="facebook"
							href="#"></a></li>
						<li><a class="twitter" data-original-title="twitter" href="#"></a></li>
						<li><a class="googleplus" data-original-title="googleplus"
							href="#"></a></li>
						<li><a class="linkedin" data-original-title="linkedin"
							href="#"></a></li>
						<li><a class="youtube" data-original-title="youtube" href="#"></a></li>
						<li><a class="vimeo" data-original-title="vimeo" href="#"></a></li>
						<li><a class="skype" data-original-title="skype" href="#"></a></li>
					</ul>
				</div>
				<!-- END SOCIAL ICONS -->
				<!-- BEGIN NEWLETTER -->
				<div class="col-md-6 col-sm-6">
					<div class="pre-footer-subscribe-box pull-right">
						<h2>Newsletter</h2>
						<form action="#">
							<div class="input-group">
								<input type="text" placeholder="youremail@mail.com"
									class="form-control"> <span class="input-group-btn">
									<button class="btn btn-primary" type="submit">Subscribe</button>
								</span>
							</div>
						</form>
					</div>
				</div>
				<!-- END NEWLETTER -->
			</div>
		</div>
	</div>
	<!-- END PRE-FOOTER -->

	<!-- BEGIN FOOTER -->
	<div class="footer">
		<div class="container">
			<div class="row">
				<!-- BEGIN COPYRIGHT -->
				<div class="col-md-6 col-sm-6 padding-top-10">2014 © Metronic
					Shop UI. ALL Rights Reserved.</div>
				<!-- END COPYRIGHT -->
				<!-- BEGIN PAYMENTS -->
				<div class="col-md-6 col-sm-6">
					<ul class="list-unstyled list-inline pull-right">
						<li><img
							src="${URL}/assets/frontend/layout/img/payments/western-union.jpg"
							alt="We accept Western Union" title="We accept Western Union"></li>
						<li><img
							src="${URL}/assets/frontend/layout/img/payments/american-express.jpg"
							alt="We accept American Express"
							title="We accept American Express"></li>
						<li><img
							src="${URL}/assets/frontend/layout/img/payments/MasterCard.jpg"
							alt="We accept MasterCard" title="We accept MasterCard"></li>
						<li><img
							src="${URL}/assets/frontend/layout/img/payments/PayPal.jpg"
							alt="We accept PayPal" title="We accept PayPal"></li>
						<li><img
							src="${URL}/assets/frontend/layout/img/payments/visa.jpg"
							alt="We accept Visa" title="We accept Visa"></li>
					</ul>
				</div>
				<!-- END PAYMENTS -->
			</div>
		</div>
	</div>
	<!-- END FOOTER -->

	<!-- BEGIN fast view of a product -->
	<div id="product-pop-up" style="display: none; width: 700px;">
		<div class="product-page product-pop-up">
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-3">
					<div class="product-main-image">
						<img src="${URL}/assets/frontend/pages/img/products/model7.jpg"
							alt="Cool green dress with red bell" class="img-responsive">
					</div>
					<div class="product-other-images">
						<a href="#" class="active"><img alt="Berry Lace Dress"
							src="${URL}/assets/frontend/pages/img/products/model3.jpg"></a>
						<a href="#"><img alt="Berry Lace Dress"
							src="${URL}/assets/frontend/pages/img/products/model4.jpg"></a>
						<a href="#"><img alt="Berry Lace Dress"
							src="${URL}/assets/frontend/pages/img/products/model5.jpg"></a>
					</div>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-9">
					<h1>Cool green dress with red bell</h1>
					<div class="price-availability-block clearfix">
						<div class="price">
							<strong><span>$</span>47.00</strong> <em>$<span>62.00</span></em>
						</div>
						<div class="availability">
							Availability: <strong>In Stock</strong>
						</div>
					</div>
					<div class="description">
						<p>Lorem ipsum dolor ut sit ame dolore adipiscing elit, sed
							nonumy nibh sed euismod laoreet dolore magna aliquarm erat
							volutpat Nostrud duis molestie at dolore.</p>
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
								name="product-quantity" class="form-control input-sm">
						</div>
						<button class="btn btn-primary" type="submit">Add to cart</button>
						<a href="shop-item.html" class="btn btn-default">More details</a>
					</div>
				</div>

				<div class="sticker sticker-sale"></div>
			</div>
		</div>
	</div>
	<!-- END fast view of a product -->

	<!-- Load javascripts at bottom, this will reduce page load time -->
	<!-- BEGIN CORE PLUGINS(REQUIRED FOR ALL PAGES) -->
	<!--[if lt IE 9]>
    <script src="${URL}/assets/global/plugins/respond.min.js"></script>  
    <![endif]-->
	<script src="${URL}/assets/global/plugins/jquery.min.js"
		type="text/javascript"></script>
	<script src="${URL}/assets/global/plugins/jquery-migrate.min.js"
		type="text/javascript"></script>
	<script src="${URL}/assets/global/plugins/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="${URL}/assets/frontend/layout/scripts/back-to-top.js"
		type="text/javascript"></script>
	<script
		src="${URL}/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
	<script
		src="${URL}/assets/global/plugins/fancybox/source/jquery.fancybox.pack.js"
		type="text/javascript"></script>
	<!-- pop up -->
	<script
		src="${URL}/assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel-rtl.js"
		type="text/javascript"></script>
	<!-- slider for products -->
	<script src='../../assets/global/plugins/zoom/jquery.zoom.min.js'
		type="text/javascript"></script>
	<!-- product zoom -->
	<script
		src="${URL}/assets/global/plugins/bootstrap-touchspin/bootstrap.touchspin.js"
		type="text/javascript"></script>
	<!-- Quantity -->
	<script src="${URL}/assets/global/plugins/uniform/jquery.uniform.min.js"
		type="text/javascript"></script>
	<script src="${URL}/assets/global/plugins/rateit/src/jquery.rateit.js"
		type="text/javascript"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"
		type="text/javascript"></script>
	<!-- for slider-range -->

	<script src="${URL}/assets/frontend/layout/scripts/layout.js"
		type="text/javascript"></script>
	<script type="text/javascript">
        jQuery(document).ready(function() {
            Layout.init();    
            Layout.initOWL();
            Layout.initTwitter();
            Layout.initImageZoom();
            Layout.initTouchspin();
            Layout.initUniform();
            Layout.initSliderRange();
        });
    </script>
	<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
