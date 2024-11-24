<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Product</title>
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN EXAMPLE TABLE PORTLET-->
			<div class="portlet box blue">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-edit"></i>Editable Table
					</div>
					<div class="tools">
						<a href="javascript:;" class="collapse"> </a> <a
							href="#portlet-config" data-toggle="modal" class="config"> </a> <a
							href="javascript:;" class="reload"> </a> <a href="javascript:;"
							class="remove"> </a>
					</div>
				</div>
				<div class="portlet-body">
					<div class="table-toolbar">
						<div class="row">
							<div class="col-md-6">
								<div class="btn-group">
								</div>
							</div>
						</div>
					</div>

					<h1>Edit Product</h1>
					<!-- Form để cập nhật thông tin sản phẩm -->
					<form:form method="post"
						action="/manager/warehouse/update/${product.id}"
						modelAttribute="product">
						<!-- Ẩn ID của sản phẩm (không cho người dùng chỉnh sửa) -->
						<form:hidden path="id" />

						<div>
							<label for="name">Product Name:</label>
							<form:input path="name" id="name" required="true"
								placeholder="Enter product name" />
						</div>
						<div>
							<label for="price">Price:</label>
							<form:input path="price" id="price" type="number" step="0.01"
								required="true" placeholder="Enter product price" />
						</div>
						<div>
							<label for="description">Description:</label>
							<form:textarea path="description" id="description"
								placeholder="Enter product description" />
						</div>
						<div>
							<label for="brand">Brand:</label>
							<form:input path="brand" id="brand"
								placeholder="Enter product brand" />
						</div>
						<div>
							<button type="submit">Update Product</button>
							<!-- Nút submit gửi form -->
							<a href="/manager/warehouse">Cancel</a>
							<!-- Link quay lại danh sách sản phẩm -->
						</div>
					</form:form>

				</div>
			</div>
			<!-- END EXAMPLE TABLE PORTLET-->
		</div>
	</div>
</body>
</html>
