<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>


<title>Tạo yêu cầu chuyển kho</title>

<body>
	<div class="page-content">
		<div class="container">
			<div class="row">



				<%-- <div class="col-md-6">
					<form class="search-form search-form-expanded" action="">
						<div class="input-group">
							<input type="text" id="searchProduct" class="form-control"
								placeholder="Branch..." name="search"> <span
								class="input-group-btn"> <a href="javascript:;"><i
									class="icon-magnifier"></i></a>
							</span>
						</div>
					</form>
					<!-- END HEADER SEARCH BOX -->
					<!-- Branch List -->
					<ul id="branch-list" style="display: none;" class="list-unstyled">
						<c:forEach var="branchProduct" items="${branchProducts }">
							<li class="product-item nav-item"><a class="product-name"
								href="<c:url value="/manager/transfer/chooseBranch?branchId=${branchProduct.branch.id }"/>">${branchProduct.branch.name }</a>
							</li>
						</c:forEach>
					</ul>
				</div> --%>
			</div>


			<div class="portlet-body px-5 py-3">
				<h3>Tạo yêu cầu chuyển kho</h3>
				<c:choose>
					<c:when test="${step == 1 }">
						<c:set var="tab1Status" value="active" />
					</c:when>
					<c:when test="${step == 2 }">
						<c:set var="tab2Status" value="active" />
					</c:when>
					<c:otherwise>
						<c:set var="tab3Status" value="active" />
					</c:otherwise>
				</c:choose>
				<div class="tabbable-line">
					<ul class="nav nav-tabs ">
						<li class="${tab1Status }"><a href="javascript:;"
							<c:if test="${not empty tab1Status}">data-toggle="tab"</c:if>>
								Chọn sản phẩm </a></li>
						<li class="${tab2Status }"><a href="javascript:;"
							<c:if test="${not empty tab2Status}">data-toggle="tab"</c:if>>
								Chọn chi nhánh </a></li>
								
						<c:if test="${not empty tab3Status}">
							<li class="${tab3Status }"><a href="javascript:;" data-toggle="tab">
									Thêm sản phẩm khác </a></li>						
						</c:if>
					</ul>

					<div class="tab-content">
						<c:if test="${not empty tab1Status }">
							<div class="tab-pane active" id="tab_15_1">
								<div class="container">
									<div class="row mb-5">
										<div class="container">
											<p>
												Vui lòng <strong>nhấn chọn một sản phẩm</strong> bạn cần,
												bạn có thể thêm sản phẩm khác ở các bước sau.
											</p>

										</div>
										<div class="col-md-6 col-sm-12">
											<!-- BEGIN HEADER SEARCH BOX -->
											<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
											<form class="search-form search-form-expanded"
												id="searchProductForm" action="javascript:void(0);">
												<div class="input-group">
													<input type="text" id="searchProduct" class="form-control"
														placeholder="Product..." name="search"> <span
														class="input-group-btn">
														<button type="submit" id="submitProduct"
															class="btn submit">
															<i class="icon-magnifier"></i>
														</button>
													</span>
												</div>
											</form>
											<!-- END HEADER SEARCH BOX -->
											<!-- Product List -->
											<ul id="product-list" style="display: none;"
												class="list-unstyled">
												<c:forEach var="product" items="${products }">
													<li class="product-item nav-item"><a
														class="product-name"
														href="<c:url value="/manager/transfer/new?productId=${product.id }"/>">${product.name }</a>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<!-- END TAB 1 -->
						</c:if>
						<c:if test="${not empty tab2Status }">
							<div class="tab-pane active" id="tab_15_2">
								<div class="container">
									<div class="row mb-5">
										<div class="container">
											<p>
												Vui lòng <strong>nhập số lượng bạn cần sau đó nhấn
													chọn một chi nhánh xuất hàng</strong>.
											</p>
											<p>Lưu ý:</p>
											<p>Số lượng bạn nhập phải nhỏ hơn số sản phẩm đang
												có tại chi nhánh bạn chọn.</p>
											<p>Sau khi xác nhận bạn vẫn có thể yêu cầu chuyển thêm sản phẩm khác nhưng phải cùng một chi nhánh, nếu khác chi nhánh, vui lòng tạo phiếu yêu cầu khác.</p>
										</div>
										<div class="col-md-6 col-sm-12">
											<form class="search-form search-form-expanded"
												id="searchProductForm" method="post"
												action="<c:url value="/manager/transfer/request" />">
												<input type="text" readonly value="${product.name }"
													class="form-control" /> 
												<input type="hidden" readonly
													name="productId" value="${product.id }" /> 
												<input
													type="number" name="quantity" value=1 class="form-control" />
												<select name="branchId" class="form-control">
													<c:forEach var="branchProduct" items="${branchProducts }">
														<option value="${branchProduct.branch.id }">${branchProduct.branch.name }
															(${branchProduct.quantity })</option>
													</c:forEach>
												</select> 
												<label>
												<input type="checkbox" name="moreProduct" value="true"> Bạn cần chuyển thêm sản phẩm khác? </label>
												<input type="submit" value="Xác nhận"
													class="btn btn-primary">
											</form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${not empty tab3Status }">
							<div class="tab-pane active" id="tab_15_3">
								<div class="container">
									<div class="row mb-5">
										<div class="container">
											<p>
												Vui lòng <strong>chọn một sản phẩm và nhập số lượng cần chuyển về.</strong>.
											</p>
											<p>Lưu ý:</p>
											<p>Số lượng bạn nhập phải nhỏ hơn số sản phẩm đang
												có tại chi nhánh bạn chọn.</p>
											<p>Sau khi xác nhận bạn vẫn có thể yêu cầu chuyển thêm sản phẩm khác nhưng phải cùng một chi nhánh, nếu khác chi nhánh, vui lòng tạo phiếu yêu cầu khác.</p>
										</div>
										<div class="col-md-6 col-sm-12">
											<form class="search-form search-form-expanded"
												id="searchProductForm" method="post"
												action="<c:url value="/manager/transfer/add-transfer-product" />">
					 							<input type="hidden" name="transferNoteId" value="${transferNoteId }" />
												<input
													type="number" name="quantity" value=1 class="form-control" />
													
												<select name="productId" class="form-control">
													<c:forEach var="branchProduct" items="${products }">
														<option value="${branchProduct.product.id }">${branchProduct.product.name }
															(${branchProduct.quantity })</option>
													</c:forEach>
												</select> 
												<label>
												<input type="checkbox" name="moreProduct" value="true"> Bạn cần chuyển thêm sản phẩm khác? </label>
												<input type="submit" value="Xác nhận"
													class="btn btn-primary">
											</form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>

		<script>
    document.addEventListener('DOMContentLoaded', () => {
        const productList = document.getElementById('product-list');
        const searchInput = document.getElementById('searchProduct');

        // Show product list on focus
        searchInput.addEventListener('focus', () => {
            productList.style.display = 'block';
        });

        // Hide product list on blur (delay to allow clicking items)
        searchInput.addEventListener('blur', () => {
            setTimeout(() => productList.style.display = 'none', 1500);
        });
        
     // Search logic
	    searchInput.addEventListener('keyup', function () {
	        const query = this.value.toLowerCase();
	        const products = document.querySelectorAll('.product-item');
	
	        products.forEach(product => {
	            const productName = product.querySelector('.product-name').textContent.toLowerCase();
	            if (productName.includes(query)) {
	                product.style.display = ''; // Show the product
	            } else {
	                product.style.display = 'none'; // Hide the product
	            }
	        });
	    });
    });
</script>
</body>
