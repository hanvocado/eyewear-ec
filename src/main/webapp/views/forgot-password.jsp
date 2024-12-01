<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        .forgot-password-container {
            min-height: calc(100vh - 180px);
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body class="login">
    <div class="forgot-password-container">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title text-center">
                                <i class="fa fa-lock"></i> FORGOT PASSWORD
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center" style="margin-bottom: 20px;">
                                <p>Enter your email and we'll send you instructions to reset your password.</p>
                            </div>

                            <form action="<c:url value='/forgot-password'/>" method="post" class="form">
                                <div class="form-group">
                                    <label for="email" class="sr-only">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fa fa-envelope"></i>
                                        </span>
                                        <input type="email" 
                                               class="form-control input-lg" 
                                               id="email" 
                                               name="email" 
                                               placeholder="Email Address" 
                                               style="height: 46px; font-size: 14px;"
                                               required>
                                    </div>
                                </div>

                                <c:if test="${not empty message}">
                                    <div class="alert alert-success">
                                        <i class="fa fa-check"></i> ${message}
                                    </div>
                                </c:if>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        <i class="fa fa-exclamation-circle"></i> ${error}
                                    </div>
                                </c:if>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary btn-block">
                                        <i class="fa fa-envelope"></i> Send Reset Link
                                    </button>
                                    
                                    <a href="<c:url value='/login'/>" class="btn btn-default btn-block">
                                        <i class="fa fa-arrow-left"></i> Back To Login
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>