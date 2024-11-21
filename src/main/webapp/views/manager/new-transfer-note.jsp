<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>


<title>Tạo yêu cầu chuyển kho</title>

<body>
	<div class="row">
		<div class="col-md-6">
			<!-- BEGIN HEADER SEARCH BOX -->
			<!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
			<form class="search-form search-form-expanded" id="searchProductForm" action="javascript:void(0);">
				<div class="input-group">
					<input type="text" id="searchProduct" class="form-control"
						placeholder="Product..." name="search"> <span
						class="input-group-btn">
						<button type="submit" id="submitProduct" class="btn submit">
							<i class="icon-magnifier"></i>
						</button>
					</span>
				</div>
			</form>
			<!-- END HEADER SEARCH BOX -->
			<!-- Product List -->
			<ul id="product-list" style="display: none;" class="list-unstyled">
				<c:forEach var="product" items="${products }">
					<li class="product-item nav-item"><a class="product-name"
						href="<c:url value="/manager/transfer/new?productId=${product.id }"/>">${product.name }</a>
					</li>
				</c:forEach>
			</ul>
		</div>


		<div class="col-md-6">
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
