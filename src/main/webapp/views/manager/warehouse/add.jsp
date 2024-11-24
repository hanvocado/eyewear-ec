<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
</head>
<body>
    <h1>Add Product</h1>
    <!-- Form để gửi dữ liệu về controller -->
    <form:form method="post" action="/manager/warehouse/save" modelAttribute="product">
        <div>
            <label for="name">Product Name:</label>
            <form:input path="name" id="name" required="true" placeholder="Enter product name"/>
        </div>
        <div>
            <label for="price">Price:</label>
            <form:input path="price" id="price" type="number" step="0.01" required="true" placeholder="Enter product price"/>
        </div>
        <div>
            <label for="description">Description:</label>
            <form:textarea path="description" id="description" placeholder="Enter product description"/>
        </div>
        <div>
            <label for="brand">Brand:</label>
            <form:input path="brand" id="brand" placeholder="Enter product brand"/>
        </div>
        <div>
            <button type="submit">Save Product</button>
        </div>
    </form:form>
</body>
</html>
