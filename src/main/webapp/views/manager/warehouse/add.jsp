<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Product</title>
<!-- Thêm link đến Bootstrap CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.container {
	margin-top: 30px;
}

.form-section {
	background-color: #f7f7f7;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 20px;
}

.form-section h4 {
	color: #6f42c1;
}

.form-group label {
	font-weight: bold;
}

.btn-purple {
	background-color: #6f42c1;
	color: white;
}

.btn-purple:hover {
	background-color: #5a31a1;
}
</style>
</head>
<body>
	<div class="container">
		<h1 class="text-center mb-5">Add Product</h1>

		<!-- Form để gửi dữ liệu về controller -->
		<form:form method="post" action="/manager/warehouse/save"
			modelAttribute="product" enctype="multipart/form-data">
			<!-- General Information Section -->
			<div class="form-section">
				<h4>GENERAL INFORMATION</h4>
				<div class="form-group">
					<label for="name">Product Name:</label>
					<form:input path="name" id="name" class="form-control"
						required="true" placeholder="Enter product name" />
				</div>
				<div class="form-group">
					<label for="price">Price:</label>
					<form:input path="price" id="price" class="form-control"
						type="number" step="0.01" required="true"
						placeholder="Enter product price" />
				</div>
				<div class="form-group">
					<label for="description">Description:</label>
					<form:textarea path="description" id="description"
						class="form-control" placeholder="Enter product description"
						rows="4" />
				</div>
				<div class="form-group">
					<label for="brand">Brand:</label>
					<form:input path="brand" id="brand" class="form-control"
						placeholder="Enter product brand" />
				</div>
				<div class="form-group">
					<label for="image">Image Upload:</label>
					<input type="file" id="image" name="imageFile"
						class="form-control" accept="image/*" />
				</div>
			</div>

			<!-- Branch Information Section -->
			<div class="form-section">
				<h4>BRANCH INFORMATION</h4>

				<label for="quantity">Quantity:</label> <input type="number"
					id="quantity" name="quantity" min="1" required>

				<c:forEach var="branchProduct" items="${product.branches}">
					<div class="form-group">
						<label for="quantity-${branchProduct.id}">Quantity for
							Branch ${branchProduct.id}:</label>
						<form:input path="branchProducts[${branchProduct.index}].quantity"
							id="quantity-${branchProduct.id}" class="form-control"
							type="number" step="1" required="true"
							placeholder="Enter quantity" value="${branchProduct.quantity}" />
					</div>
				</c:forEach>
			</div>

			<!-- Category Section -->
			<div class="form-section">
				<h4>CATEGORY</h4>
				<div class="form-group">
					<label for="category">Select Category:</label>
					<form:select path="category" id="category" class="form-control">
						<form:options items="${categories}" itemValue="id"
							itemLabel="name" />
					</form:select>
				</div>
			</div>

			<!-- Branches Section -->
			<div class="form-section">
				<h4>BRANCHES</h4>
				<p>Note: Branches and quantities will be managed separately.</p>
			</div>

			<!-- Actions Section -->
			<div class="text-center">
				<button type="submit" class="btn btn-purple">Save Product</button>
				<a href="/manager/warehouse/searchpaginated"
					class="btn btn-secondary">Cancel</a>
			</div>
		</form:form>
	</div>

	<!-- Thêm link đến Bootstrap JS và Popper.js -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
