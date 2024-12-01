<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<body>
<div class="container">
    <div class="col-md-9 col-sm-9">
        <h1>Login</h1>
        <div class="content-form-page">
            <div class="row">
                <div class="col-md-7 col-sm-7">
                    <form id="loginForm" class="form-horizontal form-without-legend" role="form">
                        <div class="form-group">
                            <label for="email" class="col-lg-4 control-label">Email <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" id="email" name="email">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-lg-4 control-label">Password <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" id="password" name="password">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-4 padding-left-0">
                                <a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                                <button id="loginButton" type="submit" class="btn btn-primary">Login</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-4 col-sm-4 pull-right">
                    <div class="form-info">
                        <h2><em>Important</em> Information</h2>
                        <p>Duis autem vel eum iriure at dolor vulputate velit esse vel molestie at dolore.</p>
                        <button type="button" class="btn btn-default">More details</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', function (event) {
        event.preventDefault(); // Ngăn form gửi thông thường

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        fetch('/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ email, password }),
        })
            .then(response => response.json())
            .then(data => {
                if (data.result.authenticated) {
                    const token = data.result.token;
                    localStorage.setItem('authToken', token); // Lưu token vào localStorage
                    alert('Đăng nhập thành công!');
                    window.location.href = '/'; // Điều hướng đến trang hồ sơ
                } else {
                    alert('Đăng nhập thất bại: ' + (data.message || 'Unknown error'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while logging in.');
            });
    });
</script>
</body>
</html>
