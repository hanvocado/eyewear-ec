<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manager home</title>
</head>
<body>
TEST HOME MANAGER
</body>
<script>
    fetch('http://localhost:8080/manager', {
        method: 'GET',
        headers: {
            'Authorization': 'Bearer ' + token // Thêm token vào header
        }
    })
        .then(response => response.json())
        .then(data => console.log(data))
        .catch(error => console.error('Error:', error));
</script>
</html>