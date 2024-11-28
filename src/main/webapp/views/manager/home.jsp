<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const token = localStorage.getItem('token');
            if (!token) {
                console.error("Token not found");
                return;
            }

            fetch('/manager', {
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer ${token.trim()}',
                }
            })
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    }
                    throw new Error('Unauthorized');
                })
                .then(data => console.log(data))
                .catch(error => console.error(error));
        });
    </script>
    <meta charset="UTF-8">
<title>Manager home</title>
</head>
<body>
TEST HOME MANAGER
</body>
</html>