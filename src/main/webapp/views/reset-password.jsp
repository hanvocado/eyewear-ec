<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <style>
        .reset-password-container {
            min-height: calc(100vh - 180px);
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body class="login">
    <div class="reset-password-container">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title text-center">
                                <i class="fa fa-lock"></i> RESET PASSWORD
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="text-center" style="margin-bottom: 20px;">
                                <p>Please enter your new password below</p>
                            </div>

                            <form action="<c:url value='/reset-password'/>" method="post" class="form">
                                <input type="hidden" name="token" value="${token}">
                                
                                <div class="form-group">
                                    <label for="password" class="sr-only">New Password</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fa fa-lock"></i>
                                        </span>
                                        <input type="password" 
                                               class="form-control input-lg" 
                                               id="password" 
                                               name="password" 
                                               placeholder="New Password"
                                               style="height: 46px; font-size: 14px;"
                                               required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPassword" class="sr-only">Confirm Password</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fa fa-lock"></i>
                                        </span>
                                        <input type="password" 
                                               class="form-control input-lg" 
                                               id="confirmPassword" 
                                               name="confirmPassword" 
                                               placeholder="Confirm Password"
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
                                        <i class="fa fa-check"></i> Reset Password
                                    </button>
                                    
                                    <a href="<c:url value='/login_page'/>" class="btn btn-default btn-block">
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