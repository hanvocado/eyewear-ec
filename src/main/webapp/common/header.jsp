<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
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

<!-- BEGIN TOP BAR -->
<div class="pre-header">
	<div class="container">
		<div class="row">
			<!-- BEGIN TOP BAR LEFT PART -->
			<div class="col-md-6 col-sm-6 additional-shop-info">
				<ul class="list-unstyled list-inline">
					<li><i class="fa fa-phone"></i><span>+1 456 6717</span></li>
					<li><i class="fa fa-envelope-o"></i><span>info@keenthemes.com</span></li>
				</ul>
			</div>
			<!-- END TOP BAR LEFT PART -->
			<!-- BEGIN TOP BAR MENU -->
			<div class="col-md-6 col-sm-6 additional-nav">
				<ul class="list-unstyled list-inline pull-right">
					<li><a href="page-login.html">Log In</a></li>
					<li><a href="page-reg-page.html">Registration</a></li>
				</ul>
			</div>
			<!-- END TOP BAR MENU -->
		</div>
	</div>
</div>
<!-- END TOP BAR -->
<!-- BEGIN HEADER -->
<div class="header">
	<div class="container">
		<a class="site-logo" href="shop-index.html"><img
			src="/frontend/layout/img/logos/logo-shop-red.png"
			alt="Metronic Shop UI"></a> <a href="javascript:void(0);"
			class="mobi-toggler"><i class="fa fa-bars"></i></a>

		<!-- BEGIN CART -->
<%-- 		<%-- Header block for the cart --%> 
<!-- 		<div class="top-cart-block"> -->
<!-- 			<div class="top-cart-info"> -->
<!-- 				<a href="javascript:void(0);" class="top-cart-info-count"> -->
<%-- 					${cartItemsForCartIcon.size()} items </a> <a href="javascript:void(0);" --%>
<!-- 					class="top-cart-info-value"> $${cartTotalValue} </a> -->
<!-- 			</div> -->
<!-- 			<i class="fa fa-shopping-cart"></i> -->

<!-- 			<div class="top-cart-content-wrapper"> -->
<!-- 				<div class="top-cart-content"> -->
<!-- 					<ul class="scroller" style="height: 250px;"> -->
<%-- 						<c:forEach var="item" items="${cartItemsForCartIcon}"> --%>
<!-- 							<li><a href="shop-item.html"> <img -->
<%-- 									src="${item.product.imageUrl}" alt="${item.product.name}" --%>
<!-- 									width="37" height="34"> -->
<%-- 							</a> <span class="cart-content-count">x ${item.quantity}</span> <strong><a --%>
<%-- 									href="shop-item.html">${item.product.name}</a></strong> <em>$${item.product.price}</em> --%>
<!-- 								<a href="javascript:void(0);" class="del-goods">&nbsp;</a></li> -->
<%-- 						</c:forEach> --%>
<!-- 					</ul> -->
<!-- 					<div class="text-right"> -->
<%-- 					<p>${item.shoppingCart.cartId} aaaaaaaaaaaaaaaa"</p> --%>
<%-- 						<a href="${pageContext.request.contextPath}/buyer/cart?cartID=${item.shoppingCart.cartId}" --%>
<!-- 							class="btn btn-default">View Cart</a> <a -->
<!-- 							href="shop-checkout.html" class="btn btn-primary">Checkout</a> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->

		<!--END CART -->
<!-- BEGIN CART -->
        <div class="top-cart-block">
          <div class="top-cart-info">
            <a href="javascript:void(0);" class="top-cart-info-count">3 items</a>
            <a href="javascript:void(0);" class="top-cart-info-value">$1260</a>
          </div>
          <i class="fa fa-shopping-cart"></i>
                        
          <div class="top-cart-content-wrapper">
            <div class="top-cart-content">
              <ul class="scroller" style="height: 250px;">
              
                 <c:forEach var="cartItem" items="${cartItemsForCartIcon}">
                <li>
                    <a href="shop-item.html">
                        <img src="/frontend/pages/img/cart-img.jpg" alt="${cartItem.product.name}" width="37" height="34">
                    </a>
                    <span class="cart-content-count">x ${cartItem.quantity}</span>
                    <strong>
                        <a href="shop-item.html">${cartItem.product.name}</a>
                    </strong>
                    <em>$${cartItem.product.price}</em>
                    <a href="javascript:void(0);" class="del-goods">&nbsp;</a>
                </li>
            </c:forEach>
            
              </ul>
              <div class="text-right">
              
            
<%--              <a href="<c:url value='/buyer/cart' />" class="btn btn-default">View Cart</a> --%>
 				<a href="${pageContext.request.contextPath}/buyer/cart?cartID=1" class="btn btn-default">View Cart</a>
		
  				<p>${cartItemsForCartIcon}dsfsdf</p>
                <a href="shop-checkout.html" class="btn btn-primary">Checkout</a>
              </div>
            </div>
          </div>            
        </div>
        <!--END CART -->




		<!-- BEGIN NAVIGATION -->
		<div class="header-navigation">
			<ul>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" data-target="#" href="#"> Woman </a> <!-- BEGIN DROPDOWN MENU -->
					<ul class="dropdown-menu">
						<li class="dropdown-submenu"><a href="shop-product-list.html">Hi
								Tops <i class="fa fa-angle-right"></i>
						</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="shop-product-list.html">Second Level Link</a></li>
								<li><a href="shop-product-list.html">Second Level Link</a></li>
								<li class="dropdown-submenu"><a class="dropdown-toggle"
									data-toggle="dropdown" data-target="#" href="#"> Second
										Level Link <i class="fa fa-angle-right"></i>
								</a>
									<ul class="dropdown-menu">
										<li><a href="shop-product-list.html">Third Level Link</a></li>
										<li><a href="shop-product-list.html">Third Level Link</a></li>
										<li><a href="shop-product-list.html">Third Level Link</a></li>
									</ul></li>
							</ul></li>
						<li><a href="shop-product-list.html">Running Shoes</a></li>
						<li><a href="shop-product-list.html">Jackets and Coats</a></li>
					</ul> <!-- END DROPDOWN MENU --></li>
				<li class="dropdown dropdown-megamenu"><a
					class="dropdown-toggle" data-toggle="dropdown" data-target="#"
					href="#"> Man </a>
					<ul class="dropdown-menu">
						<li>
							<div class="header-navigation-content">
								<div class="row">
									<div class="col-md-4 header-navigation-col">
										<h4>Footwear</h4>
										<ul>
											<li><a href="shop-product-list.html">Astro Trainers</a></li>
											<li><a href="shop-product-list.html">Basketball
													Shoes</a></li>
											<li><a href="shop-product-list.html">Boots</a></li>
											<li><a href="shop-product-list.html">Canvas Shoes</a></li>
											<li><a href="shop-product-list.html">Football Boots</a></li>
											<li><a href="shop-product-list.html">Golf Shoes</a></li>
											<li><a href="shop-product-list.html">Hi Tops</a></li>
											<li><a href="shop-product-list.html">Indoor and
													Court Trainers</a></li>
										</ul>
									</div>
									<div class="col-md-4 header-navigation-col">
										<h4>Clothing</h4>
										<ul>
											<li><a href="shop-product-list.html">Base Layer</a></li>
											<li><a href="shop-product-list.html">Character</a></li>
											<li><a href="shop-product-list.html">Chinos</a></li>
											<li><a href="shop-product-list.html">Combats</a></li>
											<li><a href="shop-product-list.html">Cricket
													Clothing</a></li>
											<li><a href="shop-product-list.html">Fleeces</a></li>
											<li><a href="shop-product-list.html">Gilets</a></li>
											<li><a href="shop-product-list.html">Golf Tops</a></li>
										</ul>
									</div>
									<div class="col-md-4 header-navigation-col">
										<h4>Accessories</h4>
										<ul>
											<li><a href="shop-product-list.html">Belts</a></li>
											<li><a href="shop-product-list.html">Caps</a></li>
											<li><a href="shop-product-list.html">Gloves, Hats
													and Scarves</a></li>
										</ul>

										<h4>Clearance</h4>
										<ul>
											<li><a href="shop-product-list.html">Jackets</a></li>
											<li><a href="shop-product-list.html">Bottoms</a></li>
										</ul>
									</div>
									<div class="col-md-12 nav-brands">
										<ul>
											<li><a href="shop-product-list.html"><img
													title="esprit" alt="esprit"
													src="/frontend/pages/img/brands/esprit.jpg"></a></li>
											<li><a href="shop-product-list.html"><img
													title="gap" alt="gap"
													src="/frontend/pages/img/brands/gap.jpg"></a></li>
											<li><a href="shop-product-list.html"><img
													title="next" alt="next"
													src="/frontend/pages/img/brands/next.jpg"></a></li>
											<li><a href="shop-product-list.html"><img
													title="puma" alt="puma"
													src="/frontend/pages/img/brands/puma.jpg"></a></li>
											<li><a href="shop-product-list.html"><img
													title="zara" alt="zara"
													src="/frontend/pages/img/brands/zara.jpg"></a></li>
										</ul>
									</div>
								</div>
							</div>
						</li>
					</ul></li>
				<li><a href="shop-item.html">Kids</a></li>
				<li class="dropdown dropdown100 nav-catalogue"><a
					class="dropdown-toggle" data-toggle="dropdown" data-target="#"
					href="#"> New </a>
					<ul class="dropdown-menu">
						<li>
							<div class="header-navigation-content">
								<div class="row">
									<div class="col-md-3 col-sm-4 col-xs-6">
										<div class="product-item">
											<div class="pi-img-wrapper">
												<a href="shop-item.html"><img
													src="/frontend/pages/img/products/model4.jpg"
													class="img-responsive" alt="Berry Lace Dress"></a>
											</div>
											<h3>
												<a href="shop-item.html">Berry Lace Dress</a>
											</h3>
											<div class="pi-price">$29.00</div>
											<a href="#" class="btn btn-default add2cart">Add to cart</a>
										</div>
									</div>
									<div class="col-md-3 col-sm-4 col-xs-6">
										<div class="product-item">
											<div class="pi-img-wrapper">
												<a href="shop-item.html"><img
													src="/frontend/pages/img/products/model3.jpg"
													class="img-responsive" alt="Berry Lace Dress"></a>
											</div>
											<h3>
												<a href="shop-item.html">Berry Lace Dress</a>
											</h3>
											<div class="pi-price">$29.00</div>
											<a href="#" class="btn btn-default add2cart">Add to cart</a>
										</div>
									</div>
									<div class="col-md-3 col-sm-4 col-xs-6">
										<div class="product-item">
											<div class="pi-img-wrapper">
												<a href="shop-item.html"><img
													src="/frontend/pages/img/products/model7.jpg"
													class="img-responsive" alt="Berry Lace Dress"></a>
											</div>
											<h3>
												<a href="shop-item.html">Berry Lace Dress</a>
											</h3>
											<div class="pi-price">$29.00</div>
											<a href="#" class="btn btn-default add2cart">Add to cart</a>
										</div>
									</div>
									<div class="col-md-3 col-sm-4 col-xs-6">
										<div class="product-item">
											<div class="pi-img-wrapper">
												<a href="shop-item.html"><img
													src="/frontend/pages/img/products/model4.jpg"
													class="img-responsive" alt="Berry Lace Dress"></a>
											</div>
											<h3>
												<a href="shop-item.html">Berry Lace Dress</a>
											</h3>
											<div class="pi-price">$29.00</div>
											<a href="#" class="btn btn-default add2cart">Add to cart</a>
										</div>
									</div>
								</div>
							</div>
						</li>
					</ul></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" data-target="#" href="#"> Pages </a>

					<ul class="dropdown-menu">
						<li class="active"><a href="shop-index.html">Home Default</a></li>
						<li><a href="shop-index-header-fix.html">Home Header
								Fixed</a></li>
						<li><a href="shop-index-light-footer.html">Home Light
								Footer</a></li>
						<li><a href="shop-product-list.html">Product List</a></li>
						<li><a href="shop-search-result.html">Search Result</a></li>
						<li><a href="shop-item.html">Product Page</a></li>
						<li><a href="shop-shopping-cart-null.html">Shopping Cart
								(Null Cart)</a></li>
						<li><a href="shop-shopping-cart.html">Shopping Cart</a></li>
						<li><a href="shop-checkout.html">Checkout</a></li>
						<li><a href="shop-about.html">About</a></li>
						<li><a href="shop-contacts.html">Contacts</a></li>
						<li><a href="shop-account.html">My account</a></li>
						<li><a href="shop-wishlist.html">My Wish List</a></li>
						<li><a href="shop-goods-compare.html">Product Comparison</a></li>
						<li><a href="shop-standart-forms.html">Standart Forms</a></li>
						<li><a href="shop-faq.html">FAQ</a></li>
						<li><a href="shop-privacy-policy.html">Privacy Policy</a></li>
						<li><a href="shop-terms-conditions-page.html">Terms &amp;
								Conditions</a></li>
					</ul></li>
				<li><a href="index.html" target="_blank">Corporate</a></li>
				<li><a href="onepage-index.html" target="_blank">One Page</a></li>
				<li><a
					href="http://keenthemes.com/preview/metronic/theme/templates/admin&amp;page=ecommerce_index.html"
					target="_blank">Admin theme</a></li>

				<!-- BEGIN TOP SEARCH -->
				<li class="menu-search"><span class="sep"></span> <i
					class="fa fa-search search-btn"></i>
					<div class="search-box">
						<form action="#">
							<div class="input-group">
								<input type="text" placeholder="Search" class="form-control">
								<span class="input-group-btn">
									<button class="btn btn-primary" type="submit">Search</button>
								</span>
							</div>
						</form>
					</div></li>
				<!-- END TOP SEARCH -->
			</ul>
		</div>
		<!-- END NAVIGATION -->
	</div>
</div>
<!-- Header END -->



<!--     BEGIN HEADER -->
<!--     <div class="header"> -->
<!--       <div class="container"> -->
<!--         <a class="site-logo" href="index.html"><img src="/frontend/layout/img/logos/logo-corp-red.png" alt="Metronic FrontEnd"></a> -->

<!--         <a href="javascript:void(0);" class="mobi-toggler"><i class="fa fa-bars"></i></a> -->

<!--         BEGIN NAVIGATION -->
<!--         <div class="header-navigation pull-right font-transform-inherit"> -->
<!--           <ul> -->
<!--             <li class="dropdown active"> -->
<!--               <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                 Home  -->

<!--               </a> -->

<!--               <ul class="dropdown-menu"> -->
<!--                 <li><a href="index.html">Home Default</a></li> -->
<!--                 <li class="active"><a href="index-header-fix.html">Home with Header Fixed</a></li> -->
<!--                 <li><a href="index-without-topbar.html">Home without Top Bar</a></li> -->
<!--               </ul> -->
<!--             </li> -->
<!--             <li class="dropdown dropdown-megamenu"> -->
<!--               <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                 Mega Menu -->

<!--               </a> -->
<!--               <ul class="dropdown-menu"> -->
<!--                 <li> -->
<!--                   <div class="header-navigation-content"> -->
<!--                     <div class="row"> -->
<!--                       <div class="col-md-4 header-navigation-col"> -->
<!--                         <h4>Footwear</h4> -->
<!--                         <ul> -->
<!--                           <li><a href="index.html">Astro Trainers</a></li> -->
<!--                           <li><a href="index.html">Basketball Shoes</a></li> -->
<!--                           <li><a href="index.html">Boots</a></li> -->
<!--                           <li><a href="index.html">Canvas Shoes</a></li> -->
<!--                           <li><a href="index.html">Football Boots</a></li> -->
<!--                           <li><a href="index.html">Golf Shoes</a></li> -->
<!--                           <li><a href="index.html">Hi Tops</a></li> -->
<!--                           <li><a href="index.html">Indoor Trainers</a></li> -->
<!--                         </ul> -->
<!--                       </div> -->
<!--                       <div class="col-md-4 header-navigation-col"> -->
<!--                         <h4>Clothing</h4> -->
<!--                         <ul> -->
<!--                           <li><a href="index.html">Base Layer</a></li> -->
<!--                           <li><a href="index.html">Character</a></li> -->
<!--                           <li><a href="index.html">Chinos</a></li> -->
<!--                           <li><a href="index.html">Combats</a></li> -->
<!--                           <li><a href="index.html">Cricket Clothing</a></li> -->
<!--                           <li><a href="index.html">Fleeces</a></li> -->
<!--                           <li><a href="index.html">Gilets</a></li> -->
<!--                           <li><a href="index.html">Golf Tops</a></li> -->
<!--                         </ul> -->
<!--                       </div> -->
<!--                       <div class="col-md-4 header-navigation-col"> -->
<!--                         <h4>Accessories</h4> -->
<!--                         <ul> -->
<!--                           <li><a href="index.html">Belts</a></li> -->
<!--                           <li><a href="index.html">Caps</a></li> -->
<!--                           <li><a href="index.html">Gloves</a></li> -->
<!--                         </ul> -->

<!--                         <h4>Clearance</h4> -->
<!--                         <ul> -->
<!--                           <li><a href="index.html">Jackets</a></li> -->
<!--                           <li><a href="index.html">Bottoms</a></li> -->
<!--                         </ul> -->
<!--                       </div> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </li> -->
<!--               </ul> -->
<!--             </li> -->
<!--             <li class="dropdown"> -->
<!--               <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                 Pages  -->

<!--               </a> -->

<!--               <ul class="dropdown-menu"> -->
<!--                 <li><a href="page-about.html">About Us</a></li> -->
<!--                 <li><a href="page-services.html">Services</a></li> -->
<!--                 <li><a href="page-prices.html">Prices</a></li> -->
<!--                 <li><a href="page-faq.html">FAQ</a></li> -->
<!--                 <li><a href="page-gallery.html">Gallery</a></li> -->
<!--                 Vào products thì hiện trang sản phẩm có phân trang -->
<!--                 <li><a href="/common/products">Products</a></li> -->
<!--                 // -->
<!--                 <li><a href="page-404.html">404</a></li> -->
<!--                 <li><a href="page-500.html">500</a></li> -->
<!--                 <li><a href="page-login.html">Login Page</a></li> -->
<!--                 <li><a href="page-forgotton-password.html">Forget Password</a></li> -->
<!--                 <li><a href="page-reg-page.html">Signup Page</a></li> -->
<!--                 <li><a href="page-careers.html">Careers</a></li> -->
<!--                 <li><a href="page-site-map.html">Site Map</a></li> -->
<!--                 <li><a href="page-contacts.html">Contact</a></li>                 -->
<!--               </ul> -->
<!--             </li> -->
<!--             <li class="dropdown"> -->
<!--               <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                 Features  -->

<!--               </a> -->

<!--               <ul class="dropdown-menu"> -->
<!--                 <li><a href="feature-typography.html">Typography</a></li> -->
<!--                 <li><a href="feature-buttons.html">Buttons</a></li> -->
<!--                 <li><a href="feature-forms.html">Forms</a></li> -->

<!--                 <li class="dropdown-submenu"> -->
<!--                   <a href="index.html">Multi level <i class="fa fa-angle-right"></i></a> -->
<!--                   <ul class="dropdown-menu" role="menu"> -->
<!--                     <li><a href="index.html">Second Level Link</a></li> -->
<!--                     <li><a href="index.html">Second Level Link</a></li> -->
<!--                     <li class="dropdown-submenu"> -->
<!--                       <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                         Second Level Link  -->
<!--                         <i class="fa fa-angle-right"></i> -->
<!--                       </a> -->
<!--                       <ul class="dropdown-menu"> -->
<!--                         <li><a href="index.html">Third Level Link</a></li> -->
<!--                         <li><a href="index.html">Third Level Link</a></li> -->
<!--                         <li><a href="index.html">Third Level Link</a></li> -->
<!--                       </ul> -->
<!--                     </li> -->
<!--                   </ul> -->
<!--                 </li> -->
<!--               </ul> -->
<!--             </li> -->
<!--             <li class="dropdown"> -->
<!--               <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                 Portfolio  -->

<!--               </a> -->

<!--               <ul class="dropdown-menu"> -->
<!--                 <li><a href="portfolio-4.html">Portfolio 4</a></li> -->
<!--                 <li><a href="portfolio-3.html">Portfolio 3</a></li> -->
<!--                 <li><a href="portfolio-2.html">Portfolio 2</a></li> -->
<!--                 <li><a href="portfolio-item.html">Portfolio Item</a></li> -->
<!--               </ul> -->
<!--             </li> -->
<!--             <li class="dropdown"> -->
<!--               <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#"> -->
<!--                 Blog  -->

<!--               </a> -->

<!--               <ul class="dropdown-menu"> -->
<!--                 <li><a href="blog.html">Blog Page</a></li> -->
<!--                 <li><a href="blog-item.html">Blog Item</a></li> -->
<!--               </ul> -->
<!--             </li> -->
<!--             <li><a href="shop-index.html" target="_blank">E-Commerce</a></li> -->
<!--             <li><a href="onepage-index.html" target="_blank">One Page</a></li> -->
<!--             <li><a href="http://keenthemes.com/preview/metronic/theme/templates/admin" target="_blank">Admin theme</a></li> -->

<!--             BEGIN TOP SEARCH -->
<!--             <li class="menu-search"> -->
<!--               <span class="sep"></span> -->
<!--               <i class="fa fa-search search-btn"></i> -->
<!--               <div class="search-box"> -->
<!-- 						<form action="/common/products/search" method="get"> -->
<!-- 							<div class="input-group"> -->
<!-- 								<input type="text" name="name" id="name" -->
<!-- 									placeholder="Nhập tên sản phẩm" class="form-control"> <span -->
<!-- 									class="input-group-btn"> -->
<!-- 									<button class="btn btn-primary" type="submit">Search</button> -->
<!-- 								</span> -->
<!-- 							</div> -->
<!-- 						</form> -->
<!-- 					</div> -->
<!-- 				</li> -->
<!--             END TOP SEARCH -->
<!--           </ul> -->
<!--         </div> -->
<!--         END NAVIGATION -->
<!--       </div> -->
<!--     </div> -->
<!--     Header END -->