<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

	
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${not empty message}">
    <script>
        Swal.fire({
            title: 'Thông báo',
            text: "<c:out value='${message}' />",
            icon: 'success',
            confirmButtonText: 'OK'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới controller
                window.location.href = '<c:url value="/buyer/orders/my-orders" />';
            }
        });
    </script>
</c:if>

<c:if test="${not empty message2}">
    <script>
        Swal.fire({
            title: 'Thông báo',
            text: "<c:out value='${message2}' />",
            icon: 'warning',
            confirmButtonText: 'OK'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới controller
                window.location.href = '<c:url value="/buyer/cart" />';
            }
        });
    </script>
</c:if>



	


		<div class="container">
			<ul class="breadcrumb">
				<li><a href="index.html">Home</a></li>
				<li><a href="">Store</a></li>
				<li class="active">Checkout</li>
			</ul>
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN CONTENT -->
				<div class="col-md-12 col-sm-12">
					<h1>Checkout</h1>
					<!-- BEGIN CHECKOUT PAGE -->
					<div class="panel-group checkout-page accordion scrollable"
						id="checkout-page">

						<form id="orderForm" action="<c:url value="/buyer/orders/saveOrder"/>" method="post">
							<!-- BEGIN CONFIRM -->
							<div id="confirm" class="panel panel-default">

								<div class="panel-heading">
									<h2 class="panel-title">
										<a data-toggle="collapse" data-parent="#checkout-page"
											href="#confirm-content" class="accordion-toggle"> Confirm
											Order </a>
									</h2>
								</div>
								<div id="confirm-content" class="panel-collapse collapse">
								</div>

								<!-- thong tin -->
								<div class="panel-body row">

								

   <!-- BEGIN SHIPPING ADDRESS -->
              <div id="shipping-address" class="panel panel-default">
              
               
                  <div class="panel-body row">
                    <div class="col-md-6 col-sm-6">
                      <div class="form-group">
                        <label for="firstname-dd">First Name <span class="require"></span></label>

                        <input type="text" id="firstname-dd" class="form-control" value="${buyer.firstName }" readonly>
                      </div>
                      <div class="form-group">
                        <label for="lastname-dd">Last Name <span class="require"></span></label>
                        <input type="text" id="lastname-dd" class="form-control" value="${buyer.lastName }" readonly>

                      </div>
                      <div class="form-group">
                        <label for="email-dd">Email <span class="require"></span></label>
                        <input type="text" id="email-dd" class="form-control" value="${buyer.email }" readonly>
                      </div>
                      <div class="form-group">
                        <label for="telephone-dd">Phone <span class="require"></span></label>

                        <input type="text" id="telephone-dd" class="form-control" value="${buyer.phone }" readonly>

                      </div>
                     
                     
                    </div>
                  </div>
                  
                   
                  </div>
               
              </div></div>
              <!-- END SHIPPING ADDRESS -->




									<div class="form-group">
										<label for="country-dd">Address  <span class="require" ></span></label>
										
										<select class="form-control input-sm" id="address-dd" name="address" placeholder="Chọn địa chỉ" required>
    
    <c:forEach var="address" items="${buyer.listaddress}">
        <option value="${address.id}">
            ${address.streetNumber} ${address.streetName}, ${address.commue}, ${address.district}, ${address.province}
        </option>
    </c:forEach>
</select>

									</div>





							<!-- thong tin -->


							<div class="panel-body row">
								<div class="col-md-12 clearfix">
									<div class="table-wrapper-responsive">

										<input type="hidden" name="buyerid" value="${buyerId}"></input>
										<table>
											<tr>
												<th class="checkout-image">Image</th>
												<th class="checkout-description">Description</th>

												<th class="checkout-quantity">Quantity</th>
												<th class="checkout-price">Price</th>
												<th class="checkout-total">Total</th>
											</tr>
											<c:forEach var="i" items="${cartList}">
												<tr>
													<td class="checkout-image"><a href="#"><img
															src="${i.product.image}" alt="hinhanh"></a></td>
													<td class="checkout-description">
														<h3>
															<a href="#">${i.product.name}</a>
														</h3> <input type="hidden" name="productIds[${status.index}]"
														value="${i.product.id}" />
														<strong><span>${i.product.description }</span></strong>
													</td>
													<td class="checkout-quantity"><strong><span>x${i.quantity }</span></strong> <input
														type="hidden" name="quantities[${status.index}]" value="${i.quantity }" />
													</td>
													<td class="checkout-price"><strong><span>₫</span>${i.product.price}</strong>
														<input type="hidden" name="prices[${status.index}]"
														value="${i.product.price}" /></td>
													<td class="checkout-total"><strong><span>₫</span>${i.product.price * i.quantity}</strong></td>
												</tr>
												
												<c:set var="totalPrice"
													value="${totalPrice + i.product.price * i.quantity}" />
											</c:forEach>



										</table>

									</div>


									<!-- phuong thuc thanh toan -->

									
<br><br>
									<div class="panel-body row">
										<div class="col-md-12">
											<p>Please select the preferred payment method to use on
												this order.</p>
												
											<div class="radio-list">
												<label> <input type="radio" id="CashOnDelivery" name="CashOnDelivery"
													value="CashOnDelivery" placeholder="Enter Payment Method" required> Cash On Delivery
												</label>
												
											</div>
											


										</div>
									</div>

									<!-- phuong thuc thanh toan -->


									<div class="checkout-total-block">
										<ul>
											<li><em>Sub total</em> <strong class="price"><span>₫</span>${totalPrice}</strong>
											</li>
											<li><em>Shipping cost</em> <strong class="price"><span>₫</span>3.00</strong>
											</li>
											<li><em>Eco Tax (-2.00)</em> <strong class="price"><span>₫</span>3.00</strong>
											</li>
											<li><em>VAT (17.5%)</em> <strong class="price"><span>₫</span>3.00</strong>
											</li>
											<li class="checkout-total-price"><em>Total</em> <strong
												class="price" ><span>₫</span>${totalPrice+9}</strong></li>
												
										</ul>
									</div>
									<div class="clearfix"></div>
									<input name="totalPrice" type="hidden" value="${totalPrice+9}">
									<button class="btn btn-primary pull-right" type="submit" > Confirm Order</button>

									
									<button type="button" class="btn btn-default pull-right margin-right-20" 
        								onclick="window.history.back()">Cancel</button>


								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- END CONFIRM -->
				
			</div>
			<!-- END CHECKOUT PAGE -->
		</div>
		<!-- END CONTENT -->
	
	<!-- END SIDEBAR & CONTENT -->



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



