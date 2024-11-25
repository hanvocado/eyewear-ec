<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Màu nền sáng nhẹ */
        }
        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .product-image {
            max-width: 100%;
            border-radius: 10px;
        }
        .card-header {
            background-color: #007bff;
            color: #fff;
            padding: 20px;
        }
        .btn-back {
            background-color: #6c757d;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header text-center">
                <h2>Product Details</h2>
            </div>
            <div class="card-body">
                <c:if test="${not empty product}">
                    <div class="row g-4">
                        <!-- Cột hình ảnh -->
                          <div class="col-md-6 d-flex align-items-center">
                            <img src="/images/sample-product.jpg" alt="Product Image" class="product-image mx-auto">
                        </div>
                       
                        <!-- Cột thông tin sản phẩm -->
                        <div class="col-md-6">
                            <h4 class="mb-4">${product.name}</h4>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong>ID:</strong> ${product.id}</li>
                                <li class="list-group-item"><strong>Price:</strong> ${product.price} USD</li>
                                <li class="list-group-item"><strong>Description:</strong> ${product.description}</li>
                                <li class="list-group-item"><strong>Brand:</strong> ${product.brand}</li>
                            </ul>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty product}">
                    <div class="alert alert-warning text-center mt-4">
                        <strong>Product not found.</strong>
                    </div>
                </c:if>
            </div>
            <div class="card-footer text-center">
                <a href="/manager/warehouse/searchpaginated" class="btn btn-back">Back to Product List</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
