<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core"%>

<title>Kết quả tìm kiếm</title>

<body>
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

						<!-- Lọc theo Danh mục -->
						<h3>Category</h3>
						<form method="get" action="/common/products/filter">
							<div class="checkbox-list">
								<label><input type="checkbox" name="categoryIds"
									value="1"> Category 1</label> <label><input
									type="checkbox" name="categoryIds" value="2"> Category
									2</label> <label><input type="checkbox" name="categoryIds"
									value="3"> Category 3</label>
							</div>

							<!-- Lọc theo Tình trạng (Availability) -->
							<h3>Availability</h3>
							<div class="checkbox-list">
								<label><input type="checkbox" name="availability"
									value="in_stock" /> In Stock</label> <label><input
									type="checkbox" name="availability" value="not_available" />
									Not Available</label>
							</div>

							<!-- Lọc theo Khoảng giá -->
							<h3>Price</h3>
							<p>
								<label for="amount">Range:</label> <input type="text"
									id="amount" name="priceRange"
									style="border: 0; color: #f6931f; font-weight: bold;" readonly />
							</p>
							<div id="slider-range"></div>

							<!-- Thêm nút Tìm kiếm -->
							<button type="submit" class="btn btn-primary">Filter</button>
						</form>
					</div>
				</div>
				<!-- END SIDEBAR -->
				
				<!-- BEGIN CONTENT -->
				<!-- Thêm -->
				<!-- Hết thông báo -->			
				<!-- -- Thêm -- -->
				
				<div class="col-md-9 col-sm-7">
					<div class="content-search margin-bottom-20">
						<div class="row">
							<div class="col-md-6">
								<h1>
									Search results: <em>${name}</em>
								</h1>
							</div>
							<div class="col-md-6">
								<form action="/common/products/search" method="get">
									<div class="input-group">
										<input type="text" name="name" id="name"
											placeholder="Nhập tên sản phẩm" class="form-control">
										<span class="input-group-btn">
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
								<form action="/common/products/search" method="get">
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
						<c:if test="${not empty message}">
									<div class="alert alert-info">
										<p>${message}</p>
									</div>
								</c:if>
						<c:forEach var="product" items="${productPage.content}">
							<div class="col-md-4 col-sm-6 col-xs-12">
								
								<div class="product-item">
									<div class="pi-img-wrapper">
									
										<img src="${product.imageUrl}" class="img-responsive"
											alt="${product.name}">
										<div> 
											<a href="${product.imageUrl}"
												class="btn btn-default fancybox-button">Zoom</a> <a
												href="#product-pop-up"
												class="btn btn-default fancybox-fast-view">View</a>
										</div>
									</div>
									<h3>
										<a href="shop-item.html">${product.name}</a>
									</h3>
									<div class="pi-price">${product.price}<span> Brand: ${product.brand}</span></div>
									<a
										href="#" class="btn btn-default add2cart">Add to cart</a>
								</div>
							</div>
						</c:forEach>
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
</body>
