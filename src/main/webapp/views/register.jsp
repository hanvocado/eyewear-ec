<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<body>
<div class="container">
    <div class="col-md-9 col-sm-9">
        <h1>Register</h1>
        <div class="content-form-page">
            <div class="row">
                <div class="col-md-7 col-sm-7">
                    <form id="registerForm" class="form-horizontal" role="form">
                        <fieldset>
                            <legend>Your personal details</legend>
                            <div class="form-group">
                                <label for="firstname" class="col-lg-4 control-label">First Name <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="text" class="form-control" id="firstname" name="firstname" placeholder="Enter your first name" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="lastname" class="col-lg-4 control-label">Last Name <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Enter your last name" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email" class="col-lg-4 control-label">Email <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="phone" class="col-lg-4 control-label">Phone Number <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter your phone number" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="address" class="col-lg-4 control-label">Address <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="text" class="form-control" id="address" name="address" placeholder="Enter your address" required>
                                </div>
                            </div>
                        </fieldset>
                        <fieldset>
                            <legend>Your password</legend>
                            <div class="form-group">
                                <label for="password" class="col-lg-4 control-label">Password <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="confirm-password" class="col-lg-4 control-label">Confirm password <span class="require">*</span></label>
                                <div class="col-lg-8">
                                    <input type="password" class="form-control" id="confirm-password" name="confirm_password" placeholder="Re-enter your password" required>
                                </div>
                            </div>
                        </fieldset>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                                <button type="submit" class="btn btn-primary">Create an account</button>
                                <button type="reset" class="btn btn-default">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById('registerForm').addEventListener('submit', function (event) {
        event.preventDefault(); // Ngăn form gửi thông thường

        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;
        const firstName = document.getElementById('firstname').value;
        const lastName = document.getElementById('lastname').value;
        const phone = document.getElementById('phone').value;
        const address = document.getElementById('address').value;

        // Kiểm tra mật khẩu trùng khớp
        if (password !== confirmPassword) {
            alert('Passwords do not match!');
            return;
        }
        else {

            fetch('/users/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({email, password, phone, firstName, lastName, address}),
            })
                .then(response => response.json())
                .then(data => {
                    if (data.code == 1000) {
                        const token = data.result.token;
                        localStorage.setItem('authToken', token); // Lưu token vào localStorage
                        alert('Registration successful!');
                        window.location.href = "/login"; // Điều hướng đến trang hồ sơ
                    } else {
                        alert('Registration failed: ' + (data.message || 'Unknown error'));
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred while registering.');
                });
        }
    });
</script>
</body>

</html>
