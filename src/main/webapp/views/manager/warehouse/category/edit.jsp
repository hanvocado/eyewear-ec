<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category</title>
    <!-- Add Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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
    <h1 class="text-center mb-5">Edit Category</h1>
    
    <!-- Form to submit data to the controller -->
    <form:form method="post" action="/manager/warehouse/category/update" modelAttribute="category">
        <!-- General Information Section -->
        <div class="form-section">
            <h4>GENERAL INFORMATION</h4>
            <div class="form-group">
                <label for="name">Category Name:</label>
                <form:input path="name" id="name" class="form-control" required="true" placeholder="Enter category name"/>
            </div>
        </div>

        <!-- Actions Section -->
        <div class="text-center">
            <button type="submit" class="btn btn-purple">Update Category</button>
            <a href="/manager/warehouse/category/searchpaginated" class="btn btn-secondary">Cancel</a>
        </div>
    </form:form>
</div>

<!-- Add Bootstrap JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
