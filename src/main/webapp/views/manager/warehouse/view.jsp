<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Details</title>
<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">
<style>
body {
    background-color: #f8f9fa;
    font-family: Arial, sans-serif;
}

.card {
    border: none;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    margin-top: 20px;
}

.card-header {
    background-color: #007bff;
    color: #fff;
    padding: 20px;
    text-align: center;
}

.card-header h2 {
    margin: 0;
}

.product-image {
    max-width: 100%;
    border-radius: 12px;
    object-fit: cover;
    height: auto;
}

.card-body {
    padding: 20px;
}

.row {
    align-items: center;
}

.image-column {
    text-align: center;
    padding-right: 20px;
}

.table th, .table td {
    vertical-align: middle;
}

.card-footer {
    background-color: #f1f1f1;
    padding: 15px;
    text-align: center;
}

.btn-back {
    background-color: #6c757d;
    color: #fff;
    text-transform: uppercase;
    font-weight: bold;
    border-radius: 8px;
    padding: 10px 20px;
    text-decoration: none;
}

.btn-back:hover {
    background-color: #5a6268;
    color: #fff;
}
</style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2>Product Details</h2>
            </div>
            <div class="card-body">
                <c:if test="${not empty product}">
                    <div class="row">
                        <!-- Cột hình ảnh sản phẩm -->
                        <div class="col-md-6 image-column">
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img src="/image?fname=${fn:escapeXml(product.image)}"
                                        class="product-image" alt="${fn:escapeXml(product.name)}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/image?fname=no-image.png" class="product-image"
                                        alt="No Image">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <!-- Cột bảng thông tin sản phẩm -->
                        <div class="col-md-6">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th>Name</th>
                                        <td>${product.name}</td>
                                    </tr>
                                    <tr>
                                        <th>Price</th>
                                        <td>${product.price} USD</td>
                                    </tr>
                                    <tr>
                                        <th>Description</th>
                                        <td>${product.description}</td>
                                    </tr>
                                    <tr>
                                        <th>Brand</th>
                                        <td>${product.brand}</td>
                                    </tr>
                                    <tr>
                                        <th>Quantity</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty branchProduct}">${branchProduct.quantity}</c:when>
                                                <c:otherwise>Not available</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Category</th>
                                        <td>${product.category.name}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty product}">
                    <div class="alert alert-warning text-center mt-4">
                        <strong>Product not found.</strong>
                    </div>
                </c:if>
            </div>
            <div class="card-footer">
                <a href="/manager/warehouse/searchpaginated" class="btn btn-back">Back to Product List</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
