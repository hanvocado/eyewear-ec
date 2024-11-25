<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-section {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .form-section h1 {
            color: #6f42c1;
            margin-bottom: 20px;
        }
        .btn-purple {
            background-color: #6f42c1;
            color: white;
        }
        .btn-purple:hover {
            background-color: #5a31a1;
        }
        label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="form-section">
            <h1>Edit Product</h1>
            <!-- Form để cập nhật thông tin sản phẩm -->
            <form:form method="post"
                        action="/manager/warehouse/update/${product.id}"
                        modelAttribute="product">
                <!-- Ẩn ID của sản phẩm (không cho người dùng chỉnh sửa) -->
                <form:hidden path="id" />

                <div class="form-group">
                    <label for="name">Product Name:</label>
                    <form:input class="form-control" path="name" id="name" required="true"
                        placeholder="Enter product name" />
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <form:input class="form-control" path="price" id="price" type="number" step="0.01"
                        required="true" placeholder="Enter product price" />
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <form:textarea class="form-control" path="description" id="description"
                        placeholder="Enter product description" rows="4" />
                </div>
                <div class="form-group">
                    <label for="brand">Brand:</label>
                    <form:input class="form-control" path="brand" id="brand"
                        placeholder="Enter product brand" />
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-purple">Update Product</button>
                    <!-- Nút submit gửi form -->
                    <a href="/manager/warehouse/searchpaginated" class="btn btn-secondary">Cancel</a>
                    <!-- Link quay lại danh sách sản phẩm -->
                </div>
            </form:form>
        </div>
    </div>

    <!-- Bootstrap JS và Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
