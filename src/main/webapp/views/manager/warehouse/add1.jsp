<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Product</title>
    <!-- Thêm link đến Bootstrap CSS -->
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
        .custom-file-label {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="text-center mb-5">Insert Product</h1>

    <form action="/insertProduct" method="post" enctype="multipart/form-data">

        <!-- General Information Section -->
        <div class="form-section">
            <h4>GENERAL</h4>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter product name" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" placeholder="Enter product description" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <select class="form-control" id="category" name="category" required>
                    <option>Select Category</option>
                    <option>Category 1</option>
                    <option>Category 2</option>
                </select>
            </div>
            <div class="form-group">
                <label for="brand">Brand:</label>
                <select class="form-control" id="brand" name="brand" required>
                    <option>Select Brand</option>
                    <option>Brand 1</option>
                    <option>Brand 2</option>
                </select>
            </div>
        </div>

        <!-- Image Section -->
        <div class="form-section">
            <h4>IMAGE</h4>
            <div class="form-group">
                <label for="image">Image:</label>
                <input type="file" class="form-control-file" id="image" name="image">
            </div>
        </div>

        <!-- Inventory Section -->
        <div class="form-section">
            <h4>INVENTORY</h4>
            <div class="form-group">
                <label for="qty">Quantity:</label>
                <input type="number" class="form-control" id="qty" name="qty" placeholder="Enter quantity" required>
            </div>
        </div>


        <div class="text-center">
            <button type="submit" class="btn btn-purple">Insert Product</button>
            <a href="/manager/warehouse">Cancel</a>
        </div>

    </form>
</div>

<!-- Thêm link đến Bootstrap JS và Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>