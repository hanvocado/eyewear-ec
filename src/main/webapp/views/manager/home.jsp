<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script>
    const token = localStorage.getItem("token");
    const url = 'http://localhost:8080/manager'; // Thay thế bằng /** để khớp tất cả các endpoint con của /manager/

    if (token) {
        fetch(url, {
            method: 'GET',  // Hoặc 'POST', 'PUT', v.v...
            headers: {
                'Authorization': `Bearer ${token}`,  // Đưa token vào header Authorization
                'Content-Type': 'application/json'  // Nếu bạn đang gửi JSON, cần đặt Content-Type là application/json
            }
        })
            .then(response => {
                if (response.ok) {
                    return response.json();  // Lấy dữ liệu khi phản hồi thành công
                }
                throw new Error('Authorization failed');
            })
            .then(data => {
                console.log('Response Data:', data);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    } else {
        console.log("No token found!");
    }
</script>
<head>
    <meta charset="UTF-8">
<title>Manager home</title>
</head>
<body>
TEST HOME MANAGER
</body>
</html>