i<%@ include file="/common/taglibs.jsp"%>

<body class="ecommerce">
	<div class="main">
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

						<form action="<c:url value="/order/saveOrder"/>" method="post">
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

									<div class="form-group">
										<label for="country-dd">Address <span class="require">*</span></label>
										<select class="form-control input-sm" id="country-dd">
											<option value="">--- Please Select ---</option>
											<option value="244">address 1</option>
											<option value="1">address 2</option>
											<option value="2">address 3</option>
										</select>
									</div>

								</div>

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
										<c:forEach var="i" items="${productList}">
    <tr>
        <td class="checkout-image"><a href="#"><img src="${i.image}" alt="${i.name}"></a></td>
        <td class="checkout-description">
            <h3><a href="#">${i.name}</a></h3>
            <input type="hidden" name="productIds[${status.index}]" value="${i.id}" />
        </td>
        <td class="checkout-quantity"><strong>1</strong>
            <input type="hidden" name="quantities[${status.index}]" value="1" />
        </td>
        <td class="checkout-price"><strong><span>$</span>${i.price}</strong>
            <input type="hidden" name="prices[${status.index}]" value="${i.price}" />
        </td>
        <td class="checkout-total"><strong><span>$</span>${i.price}</strong></td>
    </tr>
</c:forEach>



										</table>
										
									</div>


									<!-- phuong thuc thanh toan -->

									<div class="panel-body row">
										<div class="col-md-12">
											<p>Please select the preferred payment method to use on
												this order.</p>
											<div class="radio-list">
												<label> <input type="radio" name="CashOnDelivery"
													value="CashOnDelivery"> Cash On Delivery
												</label>
											</div>
											<div class="form-group">
												<label for="delivery-payment-method">Add Comments
													About Your Order</label>
												<textarea id="delivery-payment-method" rows="8"
													class="form-control"></textarea>
											</div>


										</div>
									</div>

									<!-- phuong thuc thanh toan -->


									<div class="checkout-total-block">
										<ul>
											<li><em>Sub total</em> <strong class="price"><span>$</span>47.00</strong>
											</li>
											<li><em>Shipping cost</em> <strong class="price"><span>$</span>3.00</strong>
											</li>
											<li><em>Eco Tax (-2.00)</em> <strong class="price"><span>$</span>3.00</strong>
											</li>
											<li><em>VAT (17.5%)</em> <strong class="price"><span>$</span>3.00</strong>
											</li>
											<li class="checkout-total-price"><em>Total</em> <strong
												class="price"><span>$</span>56.00</strong></li>
										</ul>
									</div>
									<div class="clearfix"></div>
									<button class="btn btn-primary pull-right" type="submit"
										id="button-confirm">Confirm Order</button>
									<button type="button"
										class="btn btn-default pull-right margin-right-20">Cancel</button>
								</div>
							</div>
					</div>
				</div>
				<!-- END CONFIRM -->
				</form>
			</div>
			<!-- END CHECKOUT PAGE -->
		</div>
		<!-- END CONTENT -->
	</div>
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

</body>
